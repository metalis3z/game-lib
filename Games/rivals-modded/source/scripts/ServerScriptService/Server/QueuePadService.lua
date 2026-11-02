-- The duel queue pads in the hub, as the client's QueuePadController / ClientQueuePad expect
-- them: one replicated object per pad (Model tag QueuePad) over Remotes.Replication.QueuePad.
--
--   data   Model, QueueName, NumTeams, PlayersPerTeam, InfinitePlayersPerTeam, CanSelfQueue,
--          IsStarting, IsLocked, PlayersWaiting = { [team] = { [tostring(userId)] = ready } }
--
-- The client draws everything from that data (QueuePadVisuals: the rings rising in the team
-- colour, the Board<i> screens with the players' avatars, the name; UserInterface.Queue: the
-- slots, the Ready button and the 3-2-1 countdown):
--
--   Misc.QueueJoin(objectID, team)   RemoteFunction, sent while standing in Important.Team<i>
--   Misc.QueueLeave()                RemoteFunction, sent when stepping off
--   Misc.QueueReady()                start with uneven teams (every team has someone)
--
-- A pad starts when every team is full, or when every team has someone and the players on
-- the smaller teams are ready. After the countdown the pad empties and its players go into a
-- duel (DuelService); if the duel can't start (no map for that many teams) they get a notice
-- and stay queued until the pad changes.
--
-- Also the global queues (Play button -> Matchmaking page):
--   Matchmaking.JoinQueue(queueName) -> "Success"; UpdateQueueStatus(queueName | nil) shows the
--   "Searching for players" banner; TryLeaveQueue cancels it. Fighter.IsMatchmaking shows the
--   icon over the nametag. As soon as a queue has enough players for its NumTeams x
--   PlayersPerTeam, the first ones to join are put in a duel together.

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local DuelLibrary = require(Modules:WaitForChild("DuelLibrary"))
local ReplicatedClass = require(Modules:WaitForChild("ReplicatedClass"))

local DuelService = require(script.Parent.DuelService)
local FighterService = require(script.Parent.FighterService)
local ReplicatedCollection = require(script.Parent.ReplicatedCollection)

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Misc = Remotes:WaitForChild("Misc")
local Data = Remotes:WaitForChild("Data")
local Matchmaking = Remotes:WaitForChild("Matchmaking")

local COUNTDOWN = 3.2
-- Standing checks run on the server's copy of the character, which lags the client's.
local ZONE_TOLERANCE = 4

local QueuePadService = {}

local collection = nil
local pads: { [string]: any } = {}

local function serializePad(pad)
	return pad:_EncodeSerial({
		ClientReplicatedClassType = "ClientQueuePad",
		Data = pad:_SerializeData(),
	})
end

-- ClientQueuePad builds a QueuePadTerminal that waits (forever) for Visuals.Terminal.Prompt's
-- ProximityPrompt. Only private-server pads have one; the client deletes it for everyone but
-- the owner, so here it is an invisible, disabled stand-in.
local function ensureTerminal(model: Model)
	local visuals = model:FindFirstChild("Visuals")
	if not visuals or visuals:FindFirstChild("Terminal") then
		return
	end
	local terminal = Instance.new("Model")
	terminal.Name = "Terminal"
	local part = Instance.new("Part")
	part.Name = "Prompt"
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Transparency = 1
	part.Size = Vector3.new(1, 1, 1)
	part.CFrame = model:GetPivot()
	local prompt = Instance.new("ProximityPrompt")
	prompt.Enabled = false
	prompt.Parent = part
	part.Parent = terminal
	terminal.Parent = visuals
end

local function copyWaiting(pad)
	local copy = {}
	for team, members in pad:Get("PlayersWaiting") do
		copy[team] = table.clone(members)
	end
	return copy
end

local function count(members): number
	local n = 0
	for _ in members do
		n += 1
	end
	return n
end

local function register(model: Instance)
	if not model:IsA("Model") or not model:FindFirstChild("Important") then
		return
	end
	for _, pad in pads do
		if pad:Get("Model") == model then
			return
		end
	end
	ensureTerminal(model)

	local numTeams = model:GetAttribute("NumTeams") or 2
	local pad = ReplicatedClass.new()
	pad.Serialize = serializePad
	pad:Set("Model", model)
	pad:Set("QueueName", model:GetAttribute("QueueName") or model.Name)
	pad:Set("NumTeams", numTeams)
	pad:Set("PlayersPerTeam", model:GetAttribute("PlayersPerTeam") or 1)
	pad:Set("InfinitePlayersPerTeam", false)
	pad:Set("CanSelfQueue", false)
	pad:Set("IsStarting", false)
	pad:Set("IsLocked", false)
	local waiting = {}
	for team = 1, numTeams do
		waiting[team] = {}
	end
	pad:Set("PlayersWaiting", waiting)
	pad._held = nil

	pads[pad:Get("ObjectID")] = pad
	collection:Add(pad)
end

local function findPlayer(player: Player)
	local key = tostring(player.UserId)
	for _, pad in pads do
		for team, members in pad:Get("PlayersWaiting") do
			if members[key] ~= nil then
				return pad, team
			end
		end
	end
	return nil
end

-- Who is on the pad, as a string: a started pad waits for this to change before it counts
-- down again.
local function composition(pad): string
	local parts = {}
	for team, members in pad:Get("PlayersWaiting") do
		local keys = {}
		for key in members do
			table.insert(keys, key)
		end
		table.sort(keys)
		table.insert(parts, team .. ":" .. table.concat(keys, ","))
	end
	return table.concat(parts, "|")
end

local function shouldStart(pad): boolean
	local waiting = pad:Get("PlayersWaiting")
	local perTeam = pad:Get("PlayersPerTeam")
	local biggest, full = 0, true
	for _, members in waiting do
		local n = count(members)
		if n == 0 then
			return false
		end
		biggest = math.max(biggest, n)
		if n < perTeam then
			full = false
		end
	end
	if full then
		return true
	end
	-- Uneven: everyone on a smaller team has pressed Ready.
	for _, members in waiting do
		if count(members) < biggest then
			for _, ready in members do
				if not ready then
					return false
				end
			end
		end
	end
	return true
end

local function playersOn(pad): { Player }
	local list = {}
	for _, members in pad:Get("PlayersWaiting") do
		for key in members do
			local player = Players:GetPlayerByUserId(tonumber(key))
			if player then
				table.insert(list, player)
			end
		end
	end
	return list
end

local function refresh(pad)
	if pad:Get("IsStarting") then
		return
	end
	local current = composition(pad)
	if pad._held and pad._held ~= current then
		pad._held = nil
	end
	if pad._held or not shouldStart(pad) then
		return
	end

	pad:SetReplicate("IsStarting", true)
	task.delay(COUNTDOWN, function()
		if not pads[pad:Get("ObjectID")] then
			return
		end
		pad:SetReplicate("IsStarting", false)
		if composition(pad) ~= current or not shouldStart(pad) then
			return refresh(pad)
		end

		local teams = {}
		for team, members in pad:Get("PlayersWaiting") do
			teams[team] = {}
			for key in members do
				local player = Players:GetPlayerByUserId(tonumber(key))
				if player then
					table.insert(teams[team], player)
				end
			end
		end
		local duel, reason = DuelService.Create(teams, pad:Get("QueueName"))
		if duel then
			local empty = {}
			for team = 1, pad:Get("NumTeams") do
				empty[team] = {}
			end
			pad:SetReplicate("PlayersWaiting", empty)
			return
		end

		pad._held = current
		for _, player in playersOn(pad) do
			Data.PlayNotification:FireClient(player, "Can't start the duel", reason or "Try again later", nil, nil)
		end
	end)
end

local function setWaiting(pad, waiting)
	pad:SetReplicate("PlayersWaiting", waiting)
	refresh(pad)
end

local function leave(player: Player)
	local pad, team = findPlayer(player)
	if not pad then
		return
	end
	local waiting = copyWaiting(pad)
	waiting[team][tostring(player.UserId)] = nil
	setWaiting(pad, waiting)
end

local function standingIn(pad, player: Player, team: number): boolean
	local model = pad:Get("Model")
	local zone = model and model.Important:FindFirstChild("Team" .. team)
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not zone or not root then
		return false
	end
	local offset = zone.CFrame:PointToObjectSpace(root.Position)
	local half = zone.Size / 2 + Vector3.one * ZONE_TOLERANCE
	return math.abs(offset.X) <= half.X and math.abs(offset.Y) <= half.Y and math.abs(offset.Z) <= half.Z
end

local function canQueue(player: Player): boolean
	local fighter = FighterService.Get(player)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	return fighter ~= nil and humanoid ~= nil and humanoid.Health > 0
		and not fighter:Get("IsInDuel") and not fighter:Get("IsInShootingRange")
end

local function join(player: Player, objectID: any, team: any)
	local pad = typeof(objectID) == "string" and pads[objectID]
	team = tonumber(team)
	if not pad or not team or team % 1 ~= 0 or team < 1 or team > pad:Get("NumTeams") then
		return false
	end
	if pad:Get("IsLocked") or pad:Get("IsStarting") or not canQueue(player) or not standingIn(pad, player, team) then
		return false
	end
	local waiting = pad:Get("PlayersWaiting")
	if not pad:Get("InfinitePlayersPerTeam") and count(waiting[team]) >= pad:Get("PlayersPerTeam") then
		return false
	end

	local current, currentTeam = findPlayer(player)
	if current == pad and currentTeam == team then
		return true
	end
	leave(player)
	waiting = copyWaiting(pad)
	waiting[team][tostring(player.UserId)] = false
	setWaiting(pad, waiting)
	return true
end

local function ready(player: Player)
	local pad, team = findPlayer(player)
	if not pad then
		return
	end
	local waiting = copyWaiting(pad)
	waiting[team][tostring(player.UserId)] = true
	setWaiting(pad, waiting)
end

--------------------------------------------------------------------------------
-- Global queues (Matchmaking page)
--------------------------------------------------------------------------------

local queued: { [Player]: string } = {}

local function setMatchmaking(player: Player, queueName: string?)
	queued[player] = queueName
	local fighter = FighterService.Get(player)
	if fighter and fighter:Get("IsMatchmaking") ~= (queueName ~= nil) then
		fighter:SetReplicate("IsMatchmaking", queueName ~= nil)
	end
	Matchmaking.UpdateQueueStatus:FireClient(player, queueName)
end

-- Queues whose players are matched in order of joining.
local joinedAt: { [Player]: number } = {}

local function matchQueues()
	local byQueue: { [string]: { Player } } = {}
	for player, queueName in queued do
		byQueue[queueName] = byQueue[queueName] or {}
		table.insert(byQueue[queueName], player)
	end
	for queueName, waiting in byQueue do
		local info = DuelLibrary.MatchmakingQueues[queueName]
		local needed = info.NumTeams * info.PlayersPerTeam
		if #waiting >= needed then
			table.sort(waiting, function(a, b)
				return (joinedAt[a] or 0) < (joinedAt[b] or 0)
			end)
			local teams = {}
			for team = 1, info.NumTeams do
				teams[team] = {}
			end
			for index = 1, needed do
				table.insert(teams[(index - 1) % info.NumTeams + 1], waiting[index])
			end
			for index = 1, needed do
				setMatchmaking(waiting[index], nil)
			end
			local duel, reason = DuelService.Create(teams, queueName)
			if not duel then
				for index = 1, needed do
					Data.PlayNotification:FireClient(waiting[index], "Can't start the duel", reason or "Try again later", nil, nil)
				end
			end
		end
	end
end

local function joinQueue(player: Player, queueName: any): string
	if typeof(queueName) ~= "string" or not DuelLibrary.MatchmakingQueues[queueName] then
		return "That gamemode is not available"
	end
	if not canQueue(player) then
		return "You can't queue right now"
	end
	leave(player)
	setMatchmaking(player, queueName)
	joinedAt[player] = os.clock()
	task.defer(matchQueues)
	return "Success"
end

function QueuePadService.Start()
	collection = ReplicatedCollection.new("QueuePad")
	QueuePadService.Collection = collection

	CollectionService:GetInstanceAddedSignal("QueuePad"):Connect(register)
	for _, model in CollectionService:GetTagged("QueuePad") do
		register(model)
	end

	Misc.QueueJoin.OnServerInvoke = join
	Misc.QueueLeave.OnServerInvoke = function(player: Player)
		leave(player)
		return true
	end
	Misc.QueueReady.OnServerEvent:Connect(ready)

	Matchmaking.JoinQueue.OnServerInvoke = joinQueue
	Matchmaking.TryLeaveQueue.OnServerEvent:Connect(function(player: Player)
		if queued[player] then
			setMatchmaking(player, nil)
		end
	end)

	Players.PlayerRemoving:Connect(function(player: Player)
		leave(player)
		queued[player] = nil
		joinedAt[player] = nil
	end)

	-- Dying, entering the range or a duel takes a player off their pad and out of the queues.
	task.spawn(function()
		while true do
			task.wait(0.5)
			for _, player in Players:GetPlayers() do
				if not canQueue(player) then
					if findPlayer(player) then
						leave(player)
					end
					if queued[player] then
						setMatchmaking(player, nil)
					end
				end
			end
		end
	end)
end

QueuePadService.Remotes = { Misc.QueueJoin, Misc.QueueLeave, Misc.QueueReady, Matchmaking.JoinQueue, Matchmaking.TryLeaveQueue }

return QueuePadService
