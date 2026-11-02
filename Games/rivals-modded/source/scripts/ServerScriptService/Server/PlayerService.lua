-- What the original server hung on every Player, read off the 25 players the dump caught
-- (ServerStorage.DumpedPlayers):
--
--   attributes  Level, GroupRank, GroupRoleIDs (JSON array), IsInfluencer, IsRobloxEmployee,
--               IsTrustworthy, StatisticDuelsWinStreak
--   CustomLeaderstats  IntValues "Win Streak", "Level", "Current ELO", each with StillLoading
--   ClientAlert        a RemoteEvent the loading screen fires
--
-- Players.CharacterAutoLoads is off, so characters are spawned from here: in the hub, once
-- the client says its loading screen is done.
--
-- Every character wears the blocky body RIVALS gives everyone (the same five parts
-- ClientDueler puts on the final results models) at the default scale, over the player's own
-- head, face, clothes and accessories.

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local CONSTANTS = require(Modules:WaitForChild("CONSTANTS"))

local PlayerDataService = require(script.Parent.PlayerDataService)

local DataRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Data")

local RESPAWN_SECONDS = 3
local BLOCKY_BODY = {
	Torso = 15365012259,
	LeftArm = 15365010034,
	RightArm = 15365012263,
	LeftLeg = 15365010038,
	RightLeg = 15365010030,
}
local DEFAULT_SCALES = {
	HeightScale = 1,
	WidthScale = 1,
	DepthScale = 1,
	HeadScale = 1,
	BodyTypeScale = 0,
	ProportionScale = 0,
}
-- Leaderstat name -> where its value comes from.
local LEADERSTATS = {
	{ Name = "Win Streak", Attribute = "StatisticDuelsWinStreak", Default = 0 },
	{ Name = "Level", Attribute = "Level", Default = 1 },
	{ Name = "Current ELO", Default = -1 },
}

local DEFAULT_ANIMATIONS = {
	"IdleAnimation",
	"WalkAnimation",
	"RunAnimation",
	"JumpAnimation",
	"FallAnimation",
	"ClimbAnimation",
	"SwimAnimation",
	"MoodAnimation",
}

local PlayerService = {}

local ready: { [Player]: boolean } = {}
local descriptions: { [Player]: HumanoidDescription } = {}

-- Set by DuelService: true while a dead player must stay dead (their duel decides).
PlayerService.HoldRespawn = function(_player: Player): boolean
	return false
end

local function blockyDescription(player: Player): HumanoidDescription
	local cached = descriptions[player]
	if cached then
		return cached:Clone()
	end

	local ok, description = pcall(Players.GetHumanoidDescriptionFromUserId, Players, math.max(player.UserId, 1))
	if not ok or not description then
		description = Instance.new("HumanoidDescription")
	end
	for property, id in BLOCKY_BODY do
		(description :: any)[property] = id
	end
	for property, value in DEFAULT_SCALES do
		(description :: any)[property] = value
	end
	-- Standard Roblox animations for everyone, like gun game: the avatar's own animation pack
	-- (idle, walk...) would otherwise overwrite the Animate script's ids. Body stays as above.
	for _, property in DEFAULT_ANIMATIONS do
		(description :: any)[property] = 0
	end
	descriptions[player] = description
	return description:Clone()
end

-- A new character with the blocky body; falls back to a plain one if the avatar fails to load.
function PlayerService.LoadCharacter(player: Player)
	if player.Parent ~= Players then
		return
	end
	local description = blockyDescription(player)
	local ok, err = pcall(player.LoadCharacterWithHumanoidDescription, player, description)
	-- A player on their way out of the game can't get a character any more; nothing to report.
	if ok or player.Parent ~= Players then
		return
	end
	warn("[PlayerService] blocky body failed for " .. player.Name .. ": " .. tostring(err))
	pcall(player.LoadCharacter, player)
end

local function hubSpawn(): BasePart?
	local lobby = workspace:FindFirstChild("Lobby")
	local spawnPart = lobby and lobby:FindFirstChild("Spawn", true)
	local hub = lobby and lobby:FindFirstChild("Hub")
	local center = hub and hub:FindFirstChild("Important") and hub.Important:FindFirstChild("Center")
	local preferred = center and center:FindFirstChild("Spawn")
	return (preferred or spawnPart) :: BasePart?
end

function PlayerService.Spawn(player: Player)
	if player.Parent ~= Players then
		return
	end

	PlayerService.LoadCharacter(player)

	local character = player.Character
	local spawnPart = hubSpawn()
	if character and spawnPart then
		local offset = Vector3.new(math.random(-6, 6), spawnPart.Size.Y / 2 + 4, math.random(-6, 6))
		character:PivotTo(CFrame.new(spawnPart.Position + offset))
	end
end

local function setupPlayer(player: Player, data: { [string]: any })
	local alert = Instance.new("RemoteEvent")
	alert.Name = "ClientAlert"
	alert.Parent = player

	local rank, roles = 0, {}
	pcall(function()
		rank = player:GetRankInGroup(CONSTANTS.GROUP_ID)
	end)

	player:SetAttribute("Level", data.Level or 1)
	player:SetAttribute("GroupRank", rank)
	player:SetAttribute("GroupRoleIDs", HttpService:JSONEncode(roles))
	player:SetAttribute("IsInfluencer", false)
	player:SetAttribute("IsRobloxEmployee", false)
	player:SetAttribute("IsTrustworthy", false)
	player:SetAttribute("StatisticDuelsWinStreak", data.StatisticDuelsWinStreak or 0)

	local folder = Instance.new("Folder")
	folder.Name = "CustomLeaderstats"
	for _, stat in LEADERSTATS do
		local value = Instance.new("IntValue")
		value.Name = stat.Name
		value.Value = stat.Attribute and player:GetAttribute(stat.Attribute) or stat.Default
		value:SetAttribute("StillLoading", false)
		value.Parent = folder

		if stat.Attribute then
			player:GetAttributeChangedSignal(stat.Attribute):Connect(function()
				value.Value = player:GetAttribute(stat.Attribute) or stat.Default
			end)
		end
	end
	folder.Parent = player
end

function PlayerService.Start()
	PlayerDataService.Loaded:Connect(setupPlayer)

	DataRemotes.LoadingScreenDone.OnServerEvent:Connect(function(player: Player)
		if ready[player] then
			return
		end
		ready[player] = true

		PlayerDataService.WaitForData(player)
		PlayerService.Spawn(player)
	end)

	local function addClientAlert(player: Player)
		-- LoadingScreen._ClientAlert fires Player.ClientAlert once the client has booted; the
		-- original server only listened. Without it the client waits on it forever.
		if player:FindFirstChild("ClientAlert") then
			return
		end
		local alert = Instance.new("RemoteEvent")
		alert.Name = "ClientAlert"
		alert.OnServerEvent:Connect(function() end)
		alert.Parent = player
	end
	for _, player in Players:GetPlayers() do
		addClientAlert(player)
	end

	Players.PlayerAdded:Connect(function(player: Player)
		addClientAlert(player)
		player.CharacterAdded:Connect(function(character: Model)
			local humanoid = character:WaitForChild("Humanoid") :: Humanoid
			-- Fighters have the game's health, not Roblox's 100 (the HUD reads it off the Humanoid).
			humanoid.MaxHealth = CONSTANTS.BASE_HEALTH
			humanoid.Health = CONSTANTS.BASE_HEALTH
			-- The game draws its own nametag (Modules.Nametag); Roblox's name and health bar
			-- would sit on top of it.
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
			humanoid.Died:Connect(function()
				task.wait(RESPAWN_SECONDS)
				if player.Character == character and not PlayerService.HoldRespawn(player) then
					PlayerService.Spawn(player)
				end
			end)
		end)
	end)

	Players.PlayerRemoving:Connect(function(player: Player)
		ready[player] = nil
		if descriptions[player] then
			descriptions[player]:Destroy()
			descriptions[player] = nil
		end
	end)
end

return PlayerService
