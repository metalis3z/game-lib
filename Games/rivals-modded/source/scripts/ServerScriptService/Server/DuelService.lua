-- Duels: the players a queue pad (or a global queue) matched vote for a map, then fight
-- rounds on it until a team has won SCORE_TO_WIN of them, and go back to the hub.
--
-- One replicated "Duel" object per duel (Remotes.Replication.Duel), built on the client as
-- ClientDuel:
--
--   serial   ClientReplicatedClassType = "ClientDuel", Data, Duelers = { duelerSerial },
--            Map = mapSerial (once chosen)
--   duelerSerial   ClientReplicatedClassType = <enum "ClientDueler">, Data = { DuelerID, TeamID,
--                  LastVote, Eliminations, Deaths, Assists, Damage, DamageTaken }, Player
--   mapSerial      Name, Model (the clone in the Workspace), Seed, Data = {}
--
--   data     Status  "Voting" -> "RoundStarting" -> "RoundStarted" -> "RoundFinished" ... "GameOver"
--            RoundNum, Scores = { [TeamID] = rounds won }, ScoresBehavior = "Teams", NumTeams,
--            VoteOptionsType = "Maps", VoteOptions = { { Name, Votes } } (nil hides the vote),
--            VoteSelectionMode = "Chance", EnvironmentID, DuelSeed, QueueName...
--
--   changes  ("DuelerAdded", duelerSerial) / ("DuelerRemoved", duelerObjectID)
--            ("DuelerChanged", duelerObjectID, <enum changeType>, ...)   a dueler's own changes,
--                  its data and ("EliminationFeed", eliminator, assister, viewModel, critical)
--            ("Countdown", seconds)                   the vote timer
--            ("ChosenMapEffect", { Name = map })
--            ("MapAdded", mapSerial)
--            ("RoundStarting", seconds, <enum "MatchPoint"> | nil)
--            ("RoundStart", seconds)  ("RoundFinish", winnerTeamID | nil, secondsLeft)
--            ("FinalResults", seed, { winner DuelerIDs }, { loser DuelerIDs })
--
-- A dueler's client asks to watch its duel (Fighter.SpectateDuel -> SpectatingDuelObjectID);
-- that is what shows the map and the duel interface. Duels.Vote(mapName) votes, Duels.LeaveDuel
-- leaves. The vote offers every map MapService has for the number of teams, plus "Random"
-- (the client's MapSlot draws it as the shuffle card), whose votes go to a map picked at random.
--
-- Map hazards the client leaves to the server: KillBrick parts eliminate, OnyxLava (the Onyx maps)
-- eliminates with the client's Functions.OnyxLavaSplash, FireDamage parts (Village's bonfire)
-- burn whoever touches them, during a round.
--
-- Each duel is its own environment: the fighters' EnvironmentID, the map's whitelist tags and
-- every hit check use it, so duels never touch the hub, the range or each other.
--
-- A finished duel counts in the players' statistics: duels played / won / lost, eliminations,
-- deaths, damage, and the win streak (StatisticDuelsWinStreak, also the player attribute the
-- nametags read, and its record StatisticDuelsWinStreakHighest). Losing or leaving a duel
-- before it ends resets the streak. Solo (Studio) duels count for nothing.
--
-- In Studio, ServerStorage.DuelDebug (BindableFunction) starts a solo duel to try the maps
-- alone: Invoke("Solo", playerName, voteSeconds?) - the rounds only end by dying or on time;
-- "SoloRecorded" is the same but its result counts in the statistics.
-- Invoke("EndRound") ends the running rounds as if time ran out, Invoke("SetScore", team, n)
-- sets a team's rounds won, Invoke("Hurt", playerName, damage) hits a dueler through the same
-- path as a weapon, Invoke("State") describes every duel.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerStorage = game:GetService("ServerStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local DuelLibrary = require(Modules:WaitForChild("DuelLibrary"))
local EnumLibrary = require(Modules:WaitForChild("EnumLibrary"))
local ReplicatedClass = require(Modules:WaitForChild("ReplicatedClass"))

local FighterService = require(script.Parent.FighterService)
local ItemService = require(script.Parent.ItemService)
local LeaderboardService = require(script.Parent.LeaderboardService)
local MapService = require(script.Parent.MapService)
local PlayerDataService = require(script.Parent.PlayerDataService)
local PlayerService = require(script.Parent.PlayerService)
local ReplicatedCollection = require(script.Parent.ReplicatedCollection)

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local DuelRemotes = Remotes:WaitForChild("Duels")
local FighterRemotes = Remotes:WaitForChild("Replication"):WaitForChild("Fighter")

local SETTLE_SECONDS = 1
local VOTE_SECONDS = 12
local VOTE_ALL_IN_SECONDS = 1.5
local MAP_CHOSEN_SECONDS = 2.25
local FIRST_ROUND_STARTING_SECONDS = 10
local ROUND_STARTING_SECONDS = 4
local ROUND_SECONDS = 120
local ROUND_FINISHED_SECONDS = 4
-- The winners scene: its animations run 14.1 s and the stats cards come up after ~10 s. The
-- scene's Leave button (Duels.LeaveDuel) takes a player back to the hub earlier.
local FINAL_RESULTS_SECONDS = 25
local SCORE_TO_WIN = 5
local SPAWN_TIMEOUT = 8
local RANDOM_MAP = "Random"
local FIRE_DAMAGE = 15
local FIRE_INTERVAL = 0.5
-- A hit this long before a death still gets the elimination.
local ELIMINATION_CREDIT_SECONDS = 10
-- Duel environments: one utf8 char each, away from the range's (2047).
local FIRST_ENVIRONMENT = 3000

local DuelService = {}

local collection = nil
local duels: { [string]: any } = {}
local duelOf: { [Player]: any } = {}
local nextEnvironment = FIRST_ENVIRONMENT
local freeEnvironments: { string } = {}

local function enum(name: string): string
	return EnumLibrary:ToEnum(name)
end

--------------------------------------------------------------------------------
-- Objects
--------------------------------------------------------------------------------

-- ClientDuel decodes a dueler's class name with a strict FromEnum: it travels as its enum.
local function serializeDueler(dueler)
	return dueler:_EncodeSerial({
		ClientReplicatedClassType = enum("ClientDueler"),
		Data = dueler:_SerializeData(),
		Player = dueler._player,
	})
end

local function serializeDuel(duel)
	local duelers = {}
	for _, dueler in duel._duelers do
		table.insert(duelers, serializeDueler(dueler))
	end
	return duel:_EncodeSerial({
		ClientReplicatedClassType = "ClientDuel",
		Data = duel:_SerializeData(),
		Duelers = duelers,
		Map = duel._map_serial,
	})
end

local function newDueler(duel, player: Player, team: number, duelerID: number)
	local dueler = ReplicatedClass.new()
	dueler.Serialize = serializeDueler
	dueler._player = player
	dueler._team = team
	dueler:Set("DuelerID", duelerID)
	dueler:Set("TeamID", DuelLibrary.Teams[team].TeamID)
	for _, stat in { "Eliminations", "Deaths", "Assists", "Damage", "DamageTaken" } do
		dueler:Set(stat, 0)
	end
	-- DuelInterface.Buttons subtracts it from SwitchItemsMax (nil = no limit) even when switching
	-- is off.
	dueler:Set("SwitchItemsCount", 0)
	-- The dueler's own changes ride on the duel's channel.
	dueler._connection = dueler.ReplicateToClient:Connect(function(changeType: string, ...)
		duel.ReplicateToClient:Fire("DuelerChanged", dueler:Get("ObjectID"), enum(changeType), ...)
	end)
	return dueler
end

local function duelerOf(duel, player: Player)
	for _, dueler in duel._duelers do
		if dueler._player == player then
			return dueler
		end
	end
	return nil
end

local function claimEnvironment(): string
	local environmentID = table.remove(freeEnvironments)
	if not environmentID then
		environmentID = utf8.char(nextEnvironment)
		nextEnvironment += 1
	end
	return environmentID
end

function DuelService.IsInDuel(player: Player): boolean
	return duelOf[player] ~= nil
end

--------------------------------------------------------------------------------
-- Characters
--------------------------------------------------------------------------------

local function humanoidOf(player: Player): Humanoid?
	local character = player.Character
	return character and character:FindFirstChildOfClass("Humanoid")
end

local function isAlive(dueler): boolean
	local humanoid = humanoidOf(dueler._player)
	return humanoid ~= nil and humanoid.Health > 0 and dueler._character == dueler._player.Character
end

local function setFrozen(player: Player, frozen: boolean)
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if root then
		(root :: BasePart).Anchored = frozen
	end
end

local function waitForEntity(player: Player, character: Model): boolean
	local deadline = os.clock() + SPAWN_TIMEOUT
	while os.clock() < deadline do
		local fighter = FighterService.Get(player)
		if not fighter or player.Character ~= character then
			return false
		end
		if fighter.Entity and fighter.Entity.Model == character then
			return true
		end
		task.wait(0.1)
	end
	return false
end

local onDied

-- A fresh character on the dueler's team spawn, frozen until the round starts.
local function spawnDueler(duel, dueler, spot: CFrame)
	local player = dueler._player
	if player.Parent ~= Players or duelOf[player] ~= duel then
		return
	end

	PlayerService.LoadCharacter(player)
	local character = player.Character
	if not character then
		return
	end
	local root = character:WaitForChild("HumanoidRootPart", 5) :: BasePart?
	local humanoid = character:WaitForChild("Humanoid", 5) :: Humanoid?
	if not root or not humanoid then
		return
	end
	character:PivotTo(spot)
	root.Anchored = true
	dueler._character = character
	dueler._last_attacker = nil

	humanoid.Died:Connect(function()
		onDied(duel, dueler, character)
	end)

	if not waitForEntity(player, character) then
		return
	end
	local fighter = FighterService.Get(player)
	fighter:SetReplicate("ItemsLocked", true)
	if duel:Get("RoundNum") == 1 then
		-- The PickWeapons page opens on the client.
		ItemService.AllowPicking(fighter, true)
	else
		ItemService.GiveLoadout(player, fighter:Get("LastPickedWeapons"))
	end
end

local function teamMembers(duel): { [number]: { any } }
	local teams = {}
	for _, dueler in duel._duelers do
		teams[dueler._team] = teams[dueler._team] or {}
		table.insert(teams[dueler._team], dueler)
	end
	return teams
end

local function teamsLeft(duel): { number }
	local list = {}
	for team in teamMembers(duel) do
		table.insert(list, team)
	end
	return list
end

local function aliveByTeam(duel): { [number]: number }
	local alive = {}
	for _, dueler in duel._duelers do
		if isAlive(dueler) then
			alive[dueler._team] = (alive[dueler._team] or 0) + 1
		end
	end
	return alive
end

--------------------------------------------------------------------------------
-- Damage and eliminations
--------------------------------------------------------------------------------

local function damageFighter(attacker: Player, _attackerFighter, entity, amount: number, critical: boolean, weapon: string?): (number, boolean)
	local victim = entity and entity._player
	local duel = duelOf[attacker]
	if not victim or not duel or duelOf[victim] ~= duel or duel:Get("Status") ~= "RoundStarted" then
		return 0, false
	end
	local attackerDueler, victimDueler = duelerOf(duel, attacker), duelerOf(duel, victim)
	if not attackerDueler or not victimDueler or (attacker ~= victim and attackerDueler._team == victimDueler._team) then
		return 0, false
	end
	local humanoid = entity._humanoid :: Humanoid?
	if not humanoid or humanoid.Health <= 0 or humanoid.Parent ~= victim.Character then
		return 0, false
	end

	local dealt = math.min(amount, humanoid.Health)
	if attacker ~= victim then
		victimDueler._last_attacker = attacker
		victimDueler._last_hit = os.clock()
		victimDueler._last_weapon = weapon
		victimDueler._last_critical = critical == true
		attackerDueler:IncrementReplicate("Damage", dealt)
	end
	victimDueler:IncrementReplicate("DamageTaken", dealt)
	-- ClientEntity._HurtEffect: { ["\0"] = damage, ["\1"] = headshot }.
	entity.ReplicateToClient:Fire("HurtEffect", { [utf8.char(0)] = dealt, [utf8.char(1)] = critical == true })
	humanoid.Health -= dealt
	return dealt, humanoid.Health <= 0
end

function onDied(duel, dueler, character: Model)
	if dueler._dead_character == character or duelOf[dueler._player] ~= duel then
		return
	end
	dueler._dead_character = character
	local player = dueler._player

	-- ClientEntity marks itself dead on "Died" (spectating moves on, the feed plays...).
	local fighter = FighterService.Get(player)
	if fighter and fighter.Entity and fighter.Entity.Model == character then
		fighter.Entity.ReplicateToClient:Fire("Died")
	end
	dueler:IncrementReplicate("Deaths", 1)

	local eliminator = player
	if dueler._last_attacker and os.clock() - (dueler._last_hit or 0) <= ELIMINATION_CREDIT_SECONDS then
		local attackerDueler = duelerOf(duel, dueler._last_attacker)
		if attackerDueler then
			eliminator = dueler._last_attacker
			attackerDueler:IncrementReplicate("Eliminations", 1)
		end
	end
	-- EliminationFeed:Play(victim, eliminator, assister, viewModelName, critical, blinded, noscope)
	dueler.ReplicateToClient:Fire("EliminationFeed", eliminator, nil, dueler._last_weapon, dueler._last_critical == true, false, false)
	-- The victim's "eliminated you with ..." card (Functions.EliminatedEffect ->
	-- EliminatedEffect:Play(eliminator, their controls, slot scale, weapon)).
	local eliminatorFighter = FighterService.Get(eliminator)
	Remotes.Misc.Functions:FireClient(player, enum("EliminatedEffect"), eliminator, eliminatorFighter and eliminatorFighter:Get("Controls") or "MouseKeyboard", 1, eliminator ~= player and dueler._last_weapon or nil)
end

--------------------------------------------------------------------------------
-- Statistics
--------------------------------------------------------------------------------

local function setStreak(player: Player, streak: number)
	PlayerDataService.Set(player, "StatisticDuelsWinStreak", streak)
	player:SetAttribute("StatisticDuelsWinStreak", streak)
	if streak > (tonumber(PlayerDataService.Get(player, "StatisticDuelsWinStreakHighest")) or 0) then
		PlayerDataService.Set(player, "StatisticDuelsWinStreakHighest", streak)
	end
end

-- One player's result, once per duel.
local function recordResult(duel, dueler, won: boolean)
	local player = dueler._player
	if (duel._solo and not duel._record_solo) or dueler._recorded or not PlayerDataService.IsLoaded(player) then
		return
	end
	dueler._recorded = true

	PlayerDataService.Increment(player, "StatisticDuelsPlayed", 1)
	PlayerDataService.Increment(player, won and "StatisticDuelsWon" or "StatisticDuelsLost", 1)
	PlayerDataService.Increment(player, "StatisticEliminations", dueler:Get("Eliminations") or 0)
	PlayerDataService.Increment(player, "StatisticDeaths", dueler:Get("Deaths") or 0)
	PlayerDataService.Increment(player, "StatisticDamageDealt", math.floor(dueler:Get("Damage") or 0))
	PlayerDataService.Increment(player, "StatisticDamageReceived", math.floor(dueler:Get("DamageTaken") or 0))
	local streak = tonumber(PlayerDataService.Get(player, "StatisticDuelsWinStreak")) or 0
	setStreak(player, won and streak + 1 or 0)
	LeaderboardService.PlayerChanged(player)
end

--------------------------------------------------------------------------------
-- Leaving
--------------------------------------------------------------------------------

local function releasePlayer(player: Player, duelObjectID: string?)
	local fighter = FighterService.Get(player)
	if not fighter then
		return
	end
	ItemService.AllowPicking(fighter, false)
	if fighter:Get("ItemsLocked") then
		fighter:SetReplicate("ItemsLocked", false)
	end
	if fighter:Get("IsInDuel") then
		fighter:SetReplicate("IsInDuel", false)
	end
	FighterService.SetTeam(player, nil)
	FighterService.SetEnvironment(player, nil)
	if duelObjectID and fighter:Get("SpectatingDuelObjectID") == duelObjectID then
		fighter:SetReplicate("SpectatingDuelObjectID", nil)
	end
end

local function removeDueler(duel, dueler, respawn: boolean)
	local index = table.find(duel._duelers, dueler)
	if not index then
		return
	end
	table.remove(duel._duelers, index)
	duel.ReplicateToClient:Fire("DuelerRemoved", dueler:Get("ObjectID"))
	dueler._connection:Disconnect()
	dueler:Destroy()

	local player = dueler._player
	if duelOf[player] == duel then
		duelOf[player] = nil
	end
	if player.Parent == Players then
		releasePlayer(player, duel:Get("ObjectID"))
		if respawn then
			task.spawn(PlayerService.Spawn, player)
		end
	end
end

local function endDuel(duel)
	if duel._closed then
		return
	end
	duel._closed = true
	duel._ended = true

	for _, dueler in table.clone(duel._duelers) do
		removeDueler(duel, dueler, true)
	end
	local objectID = duel:Get("ObjectID")
	-- Anyone else who was watching.
	for _, player in Players:GetPlayers() do
		local fighter = FighterService.Get(player)
		if fighter and fighter:Get("SpectatingDuelObjectID") == objectID then
			fighter:SetReplicate("SpectatingDuelObjectID", nil)
		end
	end

	duels[objectID] = nil
	collection:Remove(duel)
	MapService.Unload(duel._map)
	table.insert(freeEnvironments, duel:Get("EnvironmentID"))
	duel:Destroy()
end

-- respawn: put the player back in the hub (not when they are leaving the game: during
-- PlayerRemoving they are still under Players, but can no longer get a character).
function DuelService.Leave(player: Player, respawn: boolean)
	local duel = duelOf[player]
	local dueler = duel and duelerOf(duel, player)
	if not dueler then
		return
	end
	-- Walking out of a duel that is still being played is a loss.
	if duel:Get("Status") ~= "GameOver" then
		recordResult(duel, dueler, false)
	end
	removeDueler(duel, dueler, respawn and player.Parent == Players)
	if #duel._duelers == 0 then
		endDuel(duel)
	end
end

-- A duel is decided once only one team has players left in it (a solo one, once it is empty).
local function forfeited(duel): boolean
	if duel._ended then
		return true
	end
	if duel._solo then
		return #duel._duelers == 0
	end
	return #teamsLeft(duel) <= 1
end

-- Waits `seconds`, stopping early if the duel is over; false when it is.
local function waitDuel(duel, seconds: number): boolean
	local deadline = os.clock() + seconds
	while os.clock() < deadline do
		if forfeited(duel) then
			return false
		end
		task.wait(0.1)
	end
	return not forfeited(duel)
end

--------------------------------------------------------------------------------
-- Voting
--------------------------------------------------------------------------------

local function updateVotes(duel)
	local votes = {}
	for _, dueler in duel._duelers do
		local vote = dueler:Get("LastVote")
		if vote then
			votes[vote] = (votes[vote] or 0) + 1
		end
	end
	-- Random first: the vote screen lays the cards out in this order.
	local options = {}
	if #duel._pool > 1 then
		table.insert(options, { Name = RANDOM_MAP, Votes = votes[RANDOM_MAP] or 0 })
	end
	for _, name in duel._pool do
		table.insert(options, { Name = name, Votes = votes[name] or 0 })
	end
	duel:SetReplicate("VoteOptions", options)
end

local function allVoted(duel): boolean
	for _, dueler in duel._duelers do
		if not dueler:Get("LastVote") then
			return false
		end
	end
	return true
end

-- "Chance": every vote is a ticket; no votes at all (or the Random ticket drawn), any map.
local function pickMap(duel): string
	local random = duel._random
	local tickets = {}
	for _, option in duel:Get("VoteOptions") or {} do
		for _ = 1, option.Votes do
			table.insert(tickets, option.Name)
		end
	end
	local ticket = #tickets > 0 and tickets[random:NextInteger(1, #tickets)] or RANDOM_MAP
	if ticket == RANDOM_MAP then
		return duel._pool[random:NextInteger(1, #duel._pool)]
	end
	return ticket
end

local function vote(duel): string?
	if not waitDuel(duel, SETTLE_SECONDS) then
		return nil
	end
	local voteSeconds = duel._vote_seconds or VOTE_SECONDS
	duel.ReplicateToClient:Fire("Countdown", voteSeconds)
	local deadline = os.clock() + voteSeconds
	local shortened = false
	while os.clock() < deadline do
		if forfeited(duel) then
			return nil
		end
		if not shortened and allVoted(duel) then
			shortened = true
			if deadline - os.clock() > VOTE_ALL_IN_SECONDS then
				deadline = os.clock() + VOTE_ALL_IN_SECONDS
				duel.ReplicateToClient:Fire("Countdown", VOTE_ALL_IN_SECONDS)
			end
		end
		task.wait(0.1)
	end

	local chosen = pickMap(duel)
	duel.ReplicateToClient:Fire("ChosenMapEffect", { Name = chosen })
	if not waitDuel(duel, MAP_CHOSEN_SECONDS) then
		return nil
	end
	duel:SetReplicate("VoteOptions", nil)
	duel:SetReplicate("VoteOptionsType", nil)
	return chosen
end

--------------------------------------------------------------------------------
-- Rounds
--------------------------------------------------------------------------------

local function duelerTouching(duel, part: BasePart)
	local character = part:FindFirstAncestorOfClass("Model")
	local player = character and Players:GetPlayerFromCharacter(character)
	local dueler = player and duelOf[player] == duel and duelerOf(duel, player)
	if dueler and duel:Get("Status") == "RoundStarted" and isAlive(dueler) then
		return dueler
	end
	return nil
end

-- Everyone in a round touching a fire part burns, every FIRE_INTERVAL. Bonfires are solid, so
-- "touching" is a box a little larger than the part.
local function burnLoop(duel, model: Model, fires: { BasePart })
	local params = OverlapParams.new()
	params.FilterType = Enum.RaycastFilterType.Include
	while model.Parent and not duel._closed do
		task.wait(FIRE_INTERVAL)
		if duel:Get("Status") ~= "RoundStarted" then
			continue
		end
		local characters = {}
		for _, dueler in duel._duelers do
			if dueler._character then
				table.insert(characters, dueler._character)
			end
		end
		params.FilterDescendantsInstances = characters
		local burned = {}
		for _, fire in fires do
			for _, hit in workspace:GetPartBoundsInBox(fire.CFrame, fire.Size + Vector3.one * 2, params) do
				local dueler = duelerTouching(duel, hit)
				if dueler and not burned[dueler] then
					burned[dueler] = true
					local fighter = FighterService.Get(dueler._player)
					if fighter and fighter.Entity then
						damageFighter(dueler._player, fighter, fighter.Entity, FIRE_DAMAGE, false, nil)
					end
				end
			end
		end
	end
end

local function hookHazards(duel, model: Model)
	local fires = {}
	for _, part in model:GetDescendants() do
		if not part:IsA("BasePart") then
			continue
		end
		if part:HasTag("KillBrick") or part:HasTag("OnyxLava") then
			local lava = part:HasTag("OnyxLava")
			part.Touched:Connect(function(hit)
				local dueler = duelerTouching(duel, hit)
				local humanoid = dueler and humanoidOf(dueler._player)
				if not humanoid then
					return
				end
				humanoid.Health = 0
				if lava then
					-- OnyxLavaSplash(lavaPart, position, soundId?)
					local root = dueler._character and dueler._character:FindFirstChild("HumanoidRootPart")
					Remotes.Misc.Functions:FireAllClients(enum("OnyxLavaSplash"), part, root and root.Position or hit.Position, nil)
				end
			end)
		elseif part:HasTag("FireDamage") then
			table.insert(fires, part)
		end
	end
	if #fires > 0 then
		task.spawn(burnLoop, duel, model, fires)
	end
end

local function loadMap(duel, name: string): boolean
	local model = MapService.Load(name, duel:Get("EnvironmentID"))
	if not model then
		warn("[Duels] map " .. name .. " could not be loaded")
		return false
	end
	hookHazards(duel, model)
	duel._map = model
	duel._map_serial = duel:_EncodeSerial({
		Name = name,
		Model = model,
		Seed = duel:Get("DuelSeed"),
		Data = {},
	})
	duel.ReplicateToClient:Fire("MapAdded", duel._map_serial)
	return true
end

local function scoreOf(duel, team: number): number
	return duel:Get("Scores")[DuelLibrary.Teams[team].TeamID] or 0
end

local function isMatchPoint(duel): boolean
	for team = 1, duel:Get("NumTeams") do
		if scoreOf(duel, team) == SCORE_TO_WIN - 1 then
			return true
		end
	end
	return false
end

local function spawnAll(duel)
	MapService.PickSpawnBatch(duel._map, duel._random)
	local pending = 0
	for team, members in teamMembers(duel) do
		local spots = MapService.GetTeamSpawns(duel._map, team, #members)
		for index, dueler in members do
			pending += 1
			task.spawn(function()
				local ok, err = pcall(spawnDueler, duel, dueler, spots[index])
				if not ok then
					warn("[Duels] spawn failed for " .. dueler._player.Name .. ": " .. tostring(err))
				end
				pending -= 1
			end)
		end
	end
	local deadline = os.clock() + SPAWN_TIMEOUT + 2
	while pending > 0 and os.clock() < deadline do
		task.wait(0.1)
	end
end

-- Plays one round; returns false if the duel ended on the way.
local function playRound(duel): boolean
	local round = duel:Get("RoundNum") + 1
	duel:SetReplicate("RoundNum", round)
	spawnAll(duel)
	if forfeited(duel) then
		return false
	end

	local countdown = round == 1 and FIRST_ROUND_STARTING_SECONDS or ROUND_STARTING_SECONDS
	duel:SetReplicate("Status", "RoundStarting")
	duel.ReplicateToClient:Fire("RoundStarting", countdown, isMatchPoint(duel) and enum("MatchPoint") or nil)
	if not waitDuel(duel, countdown) then
		return false
	end

	for _, dueler in duel._duelers do
		local player = dueler._player
		local fighter = FighterService.Get(player)
		if fighter then
			-- Whoever did not pick in time gets their last loadout (or the defaults).
			if not ItemService.HasItems(fighter) then
				ItemService.GiveLoadout(player, fighter:Get("LastPickedWeapons"))
			end
			if fighter:Get("CanPickWeapons") then
				fighter:SetReplicate("CanPickWeapons", false)
			end
			if fighter:Get("ItemsLocked") then
				fighter:SetReplicate("ItemsLocked", false)
			end
		end
		setFrozen(player, false)
	end

	duel:SetReplicate("Status", "RoundStarted")
	duel.ReplicateToClient:Fire("RoundStart", ROUND_SECONDS)
	local deadline = os.clock() + ROUND_SECONDS
	local alive = aliveByTeam(duel)
	while os.clock() < deadline do
		if forfeited(duel) then
			return false
		end
		alive = aliveByTeam(duel)
		local standing = 0
		for _ in alive do
			standing += 1
		end
		if standing <= (duel._solo and 0 or 1) or duel._force_end_round then
			duel._force_end_round = nil
			break
		end
		task.wait(0.1)
	end

	-- The team still standing wins; on time out, the one with the most players alive.
	local winner, best, tied = nil, 0, false
	for team, count in alive do
		if count > best then
			winner, best, tied = team, count, false
		elseif count == best then
			tied = true
		end
	end
	if tied then
		winner = nil
	end
	local winnerID = winner and DuelLibrary.Teams[winner].TeamID or nil
	if winnerID then
		local scores = table.clone(duel:Get("Scores"))
		scores[winnerID] = (scores[winnerID] or 0) + 1
		duel:SetReplicate("Scores", scores)
	end
	for _, dueler in duel._duelers do
		local fighter = FighterService.Get(dueler._player)
		if fighter then
			fighter:SetReplicate("ItemsLocked", true)
		end
	end
	duel:SetReplicate("Status", "RoundFinished")
	duel.ReplicateToClient:Fire("RoundFinish", winnerID, math.max(0, deadline - os.clock()))
	return waitDuel(duel, ROUND_FINISHED_SECONDS)
end

local function bestTeam(duel): number?
	local left = teamsLeft(duel)
	if #left == 1 then
		return left[1]
	end
	local best, bestScore = nil, -1
	for _, team in left do
		local score = scoreOf(duel, team)
		if score > bestScore then
			best, bestScore = team, score
		end
	end
	return best
end

local function finish(duel)
	if #duel._duelers == 0 then
		return
	end
	local winner = bestTeam(duel)
	local winners, losers = {}, {}
	for _, dueler in duel._all_duelers do
		table.insert(dueler._team == winner and winners or losers, dueler._duelerID)
	end
	for _, dueler in duel._duelers do
		recordResult(duel, dueler, dueler._team == winner)
	end
	-- The winners scene takes over the camera: no weapons in front of it.
	for _, dueler in duel._duelers do
		setFrozen(dueler._player, true)
		local fighter = FighterService.Get(dueler._player)
		if fighter then
			ItemService.AllowPicking(fighter, false)
		end
	end
	duel:SetReplicate("Status", "GameOver")
	duel.ReplicateToClient:Fire("FinalResults", duel:Get("DuelSeed"), winners, losers)

	local deadline = os.clock() + FINAL_RESULTS_SECONDS
	while os.clock() < deadline and #duel._duelers > 0 do
		task.wait(0.1)
	end
end

local function run(duel)
	local chosen = vote(duel)
	if chosen and loadMap(duel, chosen) then
		while playRound(duel) do
			local winner = bestTeam(duel)
			if winner and scoreOf(duel, winner) >= SCORE_TO_WIN then
				break
			end
		end
	end
	if not duel._closed then
		finish(duel)
	end
end

--------------------------------------------------------------------------------
-- Creating
--------------------------------------------------------------------------------

-- Starts a duel. teams[i] = the players on team i (2 or 3 teams). Returns the duel, or nil
-- and why not. options.Solo: the other teams may be empty (Studio tests).
function DuelService.Create(teams: { { Player } }, queueName: string?, options: { Solo: boolean? }?): (any?, string?)
	local numTeams = #teams
	if numTeams < 2 or numTeams > DuelLibrary.MAX_TEAMS then
		return nil, "A duel needs 2 to " .. DuelLibrary.MAX_TEAMS .. " teams"
	end
	local teamSize = 1
	for _, members in teams do
		teamSize = math.max(teamSize, #members)
	end
	local pool = MapService.GetPool(numTeams, teamSize)
	if #pool == 0 then
		return nil, "No map supports " .. numTeams .. " teams yet"
	end
	for _, members in teams do
		for _, player in members do
			if duelOf[player] or not FighterService.Get(player) then
				return nil, player.Name .. " can't join a duel right now"
			end
		end
	end

	local duel = ReplicatedClass.new()
	duel.Serialize = serializeDuel
	duel._duelers = {}
	duel._all_duelers = {}
	duel._pool = pool
	duel._random = Random.new()
	duel._solo = options ~= nil and options.Solo == true

	local scores = {}
	for team = 1, numTeams do
		scores[DuelLibrary.Teams[team].TeamID] = 0
	end
	duel:Set("QueueName", queueName or "1v1")
	duel:Set("PlaySourceName", queueName or "1v1")
	duel:Set("NumTeams", numTeams)
	duel:Set("Status", "Voting")
	duel:Set("RoundNum", 0)
	duel:Set("Scores", scores)
	duel:Set("ScoresBehavior", "Teams")
	duel:Set("DuelSeed", duel._random:NextInteger(1, 2 ^ 30))
	duel:Set("EnvironmentID", claimEnvironment())
	duel:Set("CanSwitchItems", false)
	duel:Set("WasSelfQueued", false)
	duel:Set("CanTrackStatistics", false)
	duel:Set("IsCurrentArcadeDuel", false)
	duel:Set("RematchAvailable", false)
	duel:Set("RematchCount", 0)
	duel:Set("RematchGoal", 0)
	duel:Set("RematchSuccess", false)
	duel:Set("VoteOptionsType", "Maps")
	duel:Set("VoteSelectionMode", "Chance")
	duel:Set("MaxMapBansPerTeam", 0)
	duel:Set("VoteBansRemaining", {})

	local duelerID = 0
	for team, members in teams do
		for _, player in members do
			duelerID += 1
			local dueler = newDueler(duel, player, team, duelerID)
			dueler._duelerID = duelerID
			table.insert(duel._duelers, dueler)
			table.insert(duel._all_duelers, dueler)
			duelOf[player] = duel
		end
	end
	updateVotes(duel)

	duels[duel:Get("ObjectID")] = duel
	for _, dueler in duel._duelers do
		local player = dueler._player
		local fighter = FighterService.Get(player)
		ItemService.AllowPicking(fighter, false)
		fighter:SetReplicate("IsInDuel", true)
		FighterService.SetTeam(player, dueler:Get("TeamID"))
		FighterService.SetEnvironment(player, duel:Get("EnvironmentID"))
		-- Voting happens where they stand.
		setFrozen(player, true)
	end
	collection:Add(duel)

	task.spawn(function()
		local ok, err = pcall(run, duel)
		if not ok then
			warn("[Duels] duel stopped: " .. tostring(err))
		end
		endDuel(duel)
	end)
	return duel
end

function DuelService.Start()
	collection = ReplicatedCollection.new("Duel")
	DuelService.Collection = collection

	ItemService.DamageFighter = damageFighter
	PlayerService.HoldRespawn = function(player: Player): boolean
		return duelOf[player] ~= nil
	end
	FighterService.CanSpectateDuel = function(_player: Player, duelObjectID: string): boolean
		return duels[duelObjectID] ~= nil
	end

	DuelRemotes.Vote.OnServerEvent:Connect(function(player: Player, name: any)
		local duel = duelOf[player]
		local dueler = duel and duelerOf(duel, player)
		if not dueler or duel:Get("VoteOptionsType") ~= "Maps" or type(name) ~= "string" or not (table.find(duel._pool, name) or (name == RANDOM_MAP and #duel._pool > 1)) then
			return
		end
		if dueler:Get("LastVote") ~= name then
			dueler:SetReplicate("LastVote", name)
			updateVotes(duel)
		end
	end)
	DuelRemotes.LeaveDuel.OnServerEvent:Connect(function(player: Player)
		DuelService.Leave(player, true)
	end)
	-- Falling out of the map during a round eliminates.
	FighterRemotes.OutOfBounds.OnServerEvent:Connect(function(player: Player)
		local duel = duelOf[player]
		if duel and duel:Get("Status") == "RoundStarted" then
			local humanoid = humanoidOf(player)
			if humanoid and humanoid.Health > 0 then
				humanoid.Health = 0
			end
		end
	end)
	-- Duel options this server does not offer (switching loadouts or teams mid-duel, respawning
	-- early, rematches).
	for _, name in { "SwitchItems", "RespawnNow", "Rematch", "PickWeaponsAheadOfTime" } do
		DuelRemotes[name].OnServerEvent:Connect(function() end)
	end
	DuelRemotes.SwitchTeam.OnServerInvoke = function()
		return false
	end

	Players.PlayerRemoving:Connect(function(player: Player)
		DuelService.Leave(player, false)
	end)

	if RunService:IsStudio() then
		local debug = Instance.new("BindableFunction")
		debug.Name = "DuelDebug"
		debug.OnInvoke = function(action: string, name: any, value: any)
			if action == "Solo" or action == "SoloRecorded" then
				local player = name and Players:FindFirstChild(name) or Players:GetPlayers()[1]
				if not player then
					return "no player"
				end
				local duel, reason = DuelService.Create({ { player :: Player }, {} }, "1v1", { Solo = true })
				if duel then
					duel._vote_seconds = tonumber(value)
					duel._record_solo = action == "SoloRecorded"
				end
				return duel and duel:Get("ObjectID") or reason
			elseif action == "Hurt" then
				local player = name and Players:FindFirstChild(name) or Players:GetPlayers()[1]
				local fighter = player and FighterService.Get(player :: Player)
				if not fighter or not fighter.Entity then
					return "no fighter"
				end
				local dealt, killed = damageFighter(player :: Player, fighter, fighter.Entity, tonumber(value) or 10, false, nil)
				return string.format("dealt=%s killed=%s", tostring(dealt), tostring(killed))
			elseif action == "EndRound" then
				for _, duel in duels do
					duel._force_end_round = true
				end
				return "ok"
			elseif action == "SetScore" then
				for _, duel in duels do
					local scores = table.clone(duel:Get("Scores"))
					scores[DuelLibrary.Teams[tonumber(name) or 1].TeamID] = tonumber(value) or 0
					duel:SetReplicate("Scores", scores)
				end
				return "ok"
			elseif action == "State" then
				local lines = {}
				for _, duel in duels do
					local votes = {}
					for _, option in duel:Get("VoteOptions") or {} do
						table.insert(votes, option.Name .. ":" .. option.Votes)
					end
					table.insert(lines, string.format("%s round=%s scores=%s map=%s duelers=%d votes=%s", tostring(duel:Get("Status")), tostring(duel:Get("RoundNum")), game:GetService("HttpService"):JSONEncode(duel:Get("Scores")), duel._map and duel._map.Name or "-", #duel._duelers, table.concat(votes, ",")))
				end
				return table.concat(lines, "\n")
			end
			return "unknown action"
		end
		debug.Parent = ServerStorage
	end
end

DuelService.Remotes = {
	DuelRemotes.Vote,
	DuelRemotes.LeaveDuel,
	DuelRemotes.SwitchItems,
	DuelRemotes.RespawnNow,
	DuelRemotes.Rematch,
	DuelRemotes.PickWeaponsAheadOfTime,
	DuelRemotes.SwitchTeam,
	FighterRemotes.OutOfBounds,
}

return DuelService
