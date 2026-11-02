--!strict
-- LOCATION: ServerScriptService/Handlers/AdminHandler
-- Handles all admin panel RemoteEvents

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local DataManager = require(ServerScriptService.Handlers.DataManager)
local ItemManager = require(ServerScriptService.Modules.ItemManager)
local Events = ReplicatedStorage:WaitForChild("Events")

-- ── Admin Configuration ──────────────────────────────────────────────────
local ADMIN_USER_IDS = {9580214278} -- Add your UserId here, e.g. {12345, 67890}
-- Set this to true to allow ALL players to use admin (for testing)
local ALLOW_ALL = true

local function isAdmin(player: Player): boolean
	if ALLOW_ALL then return true end
	for _, id in ADMIN_USER_IDS do
		if player.UserId == id then return true end
	end
	return false
end

-- ── Create RemoteEvents ──────────────────────────────────────────────────
local remoteNames = {
	"AddMoneyRemote", "SetMoneyRemote",
	"AddRebirthRemote", "SetRebirthRemote",
	"SetSpeedRemote", "AddSpeedRemote",
	"GiveBrainrotRemote",
	"AdminRunEvent", "AdminStopEvent",
	"GiveGearRemote",
	-- Player Management
	"KickRemote", "BanRemote", "UnbanRemote", "TempBanRemote",
	"WarnRemote", "MuteRemote",
	-- Teleportation
	"TeleportToPlayerRemote", "TeleportHereRemote",
	-- Player Info
	"PlayerInfoRemote", "BrainrotInfoRemote",
	-- Messaging
	"SendGlobalMessageRemote", "SendServerMessageRemote",
}

for _, name in remoteNames do
	if not Events:FindFirstChild(name) then
		local re = Instance.new("RemoteEvent")
		re.Name = name
		re.Parent = Events
	end
end

local AddMoneyRemote = Events.AddMoneyRemote
local SetMoneyRemote = Events.SetMoneyRemote
local AddRebirthRemote = Events.AddRebirthRemote
local SetRebirthRemote = Events.SetRebirthRemote
local SetSpeedRemote = Events.SetSpeedRemote
local AddSpeedRemote = Events.AddSpeedRemote
local GiveBrainrotRemote = Events.GiveBrainrotRemote
local AdminRunEvent = Events.AdminRunEvent
local AdminStopEvent = Events.AdminStopEvent
local GiveGearRemote = Events.GiveGearRemote
local KickRemote = Events.KickRemote
local BanRemote = Events.BanRemote
local UnbanRemote = Events.UnbanRemote
local TempBanRemote = Events.TempBanRemote
local WarnRemote = Events.WarnRemote
local MuteRemote = Events.MuteRemote
local TeleportToPlayerRemote = Events.TeleportToPlayerRemote
local TeleportHereRemote = Events.TeleportHereRemote
local PlayerInfoRemote = Events.PlayerInfoRemote
local BrainrotInfoRemote = Events.BrainrotInfoRemote
local SendGlobalMessageRemote = Events.SendGlobalMessageRemote
local SendServerMessageRemote = Events.SendServerMessageRemote

-- ── Helper ────────────────────────────────────────────────────────────────
local bannedPlayers = {}
local mutedPlayers = {}
local warnCount = {}
local tempBans = {}

local function findPlayer(name: string): Player?
	for _, p in Players:GetPlayers() do
		if string.lower(p.Name) == string.lower(name) or string.lower(p.DisplayName) == string.lower(name) then
			return p
		end
	end
	return nil
end

-- ── Money Commands ───────────────────────────────────────────────────────
AddMoneyRemote.OnServerEvent:Connect(function(player: Player, amount: number)
	if not isAdmin(player) then return end
	if typeof(amount) ~= "number" then return end
	DataManager.addMoney(player, amount)
end)

SetMoneyRemote.OnServerEvent:Connect(function(player: Player, amount: number)
	if not isAdmin(player) then return end
	if typeof(amount) ~= "number" then return end
	local data = DataManager.get(player)
	if not data then return end
	data.Money = math.max(0, amount)
	local ls = player:FindFirstChild("leaderstats")
	if ls then
		local mv = ls:FindFirstChild("Money")
		if mv then mv.Value = data.Money end
	end
end)

-- ── Rebirth Commands ─────────────────────────────────────────────────────
AddRebirthRemote.OnServerEvent:Connect(function(player: Player, amount: number)
	if not isAdmin(player) then return end
	if typeof(amount) ~= "number" then return end
	local data = DataManager.get(player)
	if not data then return end
	data.Rebirths = (data.Rebirths or 0) + math.floor(amount)
	local ls = player:FindFirstChild("leaderstats")
	if ls then
		local rv = ls:FindFirstChild("Rebirths")
		if rv then rv.Value = data.Rebirths end
	end
end)

SetRebirthRemote.OnServerEvent:Connect(function(player: Player, amount: number)
	if not isAdmin(player) then return end
	if typeof(amount) ~= "number" then return end
	local data = DataManager.get(player)
	if not data then return end
	data.Rebirths = math.max(0, math.floor(amount))
	local ls = player:FindFirstChild("leaderstats")
	if ls then
		local rv = ls:FindFirstChild("Rebirths")
		if rv then rv.Value = data.Rebirths end
	end
end)

-- ── Speed Commands ───────────────────────────────────────────────────────
SetSpeedRemote.OnServerEvent:Connect(function(player: Player, amount: number)
	if not isAdmin(player) then return end
	if typeof(amount) ~= "number" then return end
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = math.max(1, amount)
	end
end)

AddSpeedRemote.OnServerEvent:Connect(function(player: Player, amount: number)
	if not isAdmin(player) then return end
	if typeof(amount) ~= "number" then return end
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = humanoid.WalkSpeed + amount
	end
end)

-- ── Give Brainrot (Item) Command ─────────────────────────────────────────
GiveBrainrotRemote.OnServerEvent:Connect(function(player: Player, itemName: string, mutation: string, level: number)
	if not isAdmin(player) then return end
	if typeof(itemName) ~= "string" or typeof(mutation) ~= "string" then return end
	if typeof(level) ~= "number" then level = 1 end
	level = math.clamp(math.floor(level), 1, 175)

	-- Determine rarity from ItemConfigurations
	local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
	local itemData = ItemConfigurations.GetItemData(itemName)
	local rarity = itemData and itemData.Rarity or "Common"

	ItemManager.GiveItemToPlayer(player, itemName, mutation, rarity, level)
end)

-- ── Event Runner Commands ────────────────────────────────────────────────
AdminRunEvent.OnServerEvent:Connect(function(player: Player, weatherName: string)
	if not isAdmin(player) then return end
	if typeof(weatherName) ~= "string" then return end
	local WeatherService = require(ReplicatedStorage.Modules.WeatherService)
	WeatherService.StartWeather(weatherName, nil, true)
end)

AdminStopEvent.OnServerEvent:Connect(function(player: Player)
	if not isAdmin(player) then return end
	-- Stop current weather by calling OnEnd on the current module
	local WeatherService = require(ReplicatedStorage.Modules.WeatherService)
	-- We need to force-stop the current weather
	-- Access the internal state through the module
	if WeatherService.StopCurrentWeather then
		WeatherService.StopCurrentWeather()
	end
end)

-- ── Gear Giver Command ───────────────────────────────────────────────────
local VALID_GEARS = {
	["GalaxyBat"] = "GalaxyBat",
	["Carpet"] = "Carpet",
	["InvisibleCarpet"] = "InvisibleCarpet",
}

GiveGearRemote.OnServerEvent:Connect(function(player: Player, gearKey: string)
	if not isAdmin(player) then return end
	if typeof(gearKey) ~= "string" then return end
	if not VALID_GEARS[gearKey] then return end

	local backpack = player:FindFirstChild("Backpack")
	if not backpack then return end

	if gearKey == "Carpet" then
		-- Create a Carpet tool
		local tool = Instance.new("Tool")
		tool.Name = "Carpet"
		tool.CanBeDropped = false
		tool.RequiresHandle = true

		local handle = Instance.new("Part")
		handle.Name = "Handle"
		handle.Size = Vector3.new(6, 0.2, 6)
		handle.Color = Color3.fromRGB(139, 69, 19)
		handle.Material = Enum.Material.Fabric
		handle.Anchored = false
		handle.CanCollide = false
		handle.Massless = true
		handle.Parent = tool

		tool.Grip = CFrame.new(0, -1.5, 0)
		tool.Parent = backpack

	elseif gearKey == "InvisibleCarpet" then
		-- Create an Invisible Carpet tool
		local tool = Instance.new("Tool")
		tool.Name = "Invisible Carpet"
		tool.CanBeDropped = false
		tool.RequiresHandle = true

		local handle = Instance.new("Part")
		handle.Name = "Handle"
		handle.Size = Vector3.new(6, 0.2, 6)
		handle.Transparency = 1
		handle.Anchored = false
		handle.CanCollide = false
		handle.Massless = true
		handle.Parent = tool

		tool.Grip = CFrame.new(0, -1.5, 0)
		tool.Parent = backpack

	elseif gearKey == "GalaxyBat" then
		-- Create a Galaxy Bat tool
		local tool = Instance.new("Tool")
		tool.Name = "Galaxy Bat"
		tool.CanBeDropped = false
		tool.RequiresHandle = true

		local handle = Instance.new("Part")
		handle.Name = "Handle"
		handle.Size = Vector3.new(1, 1, 5)
		handle.Color = Color3.fromRGB(100, 50, 200)
		handle.Material = Enum.Material.Neon
		handle.Anchored = false
		handle.CanCollide = false
		handle.Massless = true
		handle.Parent = tool

		-- Add sparkle effect
		local sparkle = Instance.new("Sparkles")
		sparkle.SparkleColor = Color3.fromRGB(150, 100, 255)
		sparkle.Parent = handle

		tool.Grip = CFrame.new(0, 0, -1.5) * CFrame.Angles(0, 0, math.rad(-45))
		tool.Parent = backpack
	end
end)

-- ── Player Management Commands ────────────────────────────────────────────
KickRemote.OnServerEvent:Connect(function(player: Player, targetName: string)
	if not isAdmin(player) then return end
	if typeof(targetName) ~= "string" then return end
	local target = findPlayer(targetName)
	if target then
		target:Kick("You have been kicked by an admin.")
	end
end)

BanRemote.OnServerEvent:Connect(function(player: Player, targetName: string)
	if not isAdmin(player) then return end
	if typeof(targetName) ~= "string" then return end
	local target = findPlayer(targetName)
	if target then
		bannedPlayers[target.UserId] = true
		target:Kick("You have been banned.")
	end
end)

UnbanRemote.OnServerEvent:Connect(function(player: Player, targetName: string)
	if not isAdmin(player) then return end
	if typeof(targetName) ~= "string" then return end
	for userId, _ in pairs(bannedPlayers) do
		local success, pName = pcall(function()
			return Players:GetNameFromUserIdAsync(userId)
		end)
		if success and string.lower(pName) == string.lower(targetName) then
			bannedPlayers[userId] = nil
			break
		end
	end
end)

TempBanRemote.OnServerEvent:Connect(function(player: Player, targetName: string, duration: number)
	if not isAdmin(player) then return end
	if typeof(targetName) ~= "string" then return end
	if typeof(duration) ~= "number" or duration <= 0 then duration = 300 end
	local target = findPlayer(targetName)
	if target then
		tempBans[target.UserId] = tick() + duration
		target:Kick("You have been temp-banned for " .. math.floor(duration) .. " seconds.")
	end
end)

WarnRemote.OnServerEvent:Connect(function(player: Player, targetName: string)
	if not isAdmin(player) then return end
	if typeof(targetName) ~= "string" then return end
	local target = findPlayer(targetName)
	if target then
		warnCount[target.UserId] = (warnCount[target.UserId] or 0) + 1
		local notifEvent = Events:FindFirstChild("ShowNotification")
		if notifEvent then
			notifEvent:FireClient(target, "Warning #" .. warnCount[target.UserId], "You have been warned by an admin.")
		end
	end
end)

MuteRemote.OnServerEvent:Connect(function(player: Player, targetName: string)
	if not isAdmin(player) then return end
	if typeof(targetName) ~= "string" then return end
	local target = findPlayer(targetName)
	if target then
		mutedPlayers[target.UserId] = true
		local notifEvent = Events:FindFirstChild("ShowNotification")
		if notifEvent then
			notifEvent:FireClient(target, "Muted", "You have been muted by an admin.")
		end
	end
end)

-- ── Teleportation Commands ────────────────────────────────────────────────
TeleportToPlayerRemote.OnServerEvent:Connect(function(player: Player, targetName: string)
	if not isAdmin(player) then return end
	if typeof(targetName) ~= "string" then return end
	local target = findPlayer(targetName)
	if target and target.Character and player.Character then
		local targetHrp = target.Character:FindFirstChild("HumanoidRootPart")
		local myHrp = player.Character:FindFirstChild("HumanoidRootPart")
		if targetHrp and myHrp then
			myHrp.CFrame = targetHrp.CFrame * CFrame.new(3, 0, 0)
		end
	end
end)

TeleportHereRemote.OnServerEvent:Connect(function(player: Player, targetName: string)
	if not isAdmin(player) then return end
	if typeof(targetName) ~= "string" then return end
	local target = findPlayer(targetName)
	if target and target.Character and player.Character then
		local targetHrp = target.Character:FindFirstChild("HumanoidRootPart")
		local myHrp = player.Character:FindFirstChild("HumanoidRootPart")
		if targetHrp and myHrp then
			targetHrp.CFrame = myHrp.CFrame * CFrame.new(3, 0, 0)
		end
	end
end)

-- ── Player Info Command ──────────────────────────────────────────────────
PlayerInfoRemote.OnServerEvent:Connect(function(player: Player, targetName: string)
	if not isAdmin(player) then return end
	if typeof(targetName) ~= "string" then return end
	local target = findPlayer(targetName)
	if not target then return end

	local data = DataManager.get(target)
	local ls = target:FindFirstChild("leaderstats")
	local info = {
		Money = (ls and ls:FindFirstChild("Money")) and ls.Money.Value or 0,
		Rebirths = (ls and ls:FindFirstChild("Rebirths")) and ls.Rebirths.Value or 0,
		WalkSpeed = 16,
		Warns = warnCount[target.UserId] or 0,
		IsMuted = mutedPlayers[target.UserId] == true,
		IsBanned = bannedPlayers[target.UserId] == true,
	}
	if target.Character then
		local hum = target.Character:FindFirstChildOfClass("Humanoid")
		if hum then info.WalkSpeed = hum.WalkSpeed end
	end

	local notifEvent = Events:FindFirstChild("ShowNotification")
	if notifEvent then
		local infoText = string.format(
			"Money: %s | Rebirths: %d | Speed: %d | Warns: %d | Muted: %s | Banned: %s",
			tostring(info.Money), info.Rebirths, info.WalkSpeed, info.Warns,
			info.IsMuted and "Yes" or "No", info.IsBanned and "Yes" or "No"
		)
		notifEvent:FireClient(player, "Player Info: " .. target.Name, infoText)
	end
end)

-- ── Brainrot Info Command ────────────────────────────────────────────────
BrainrotInfoRemote.OnServerEvent:Connect(function(player: Player, targetName: string)
	if not isAdmin(player) then return end
	if typeof(targetName) ~= "string" then return end
	local target = findPlayer(targetName)
	if not target then return end

	local data = DataManager.get(target)
	local discovered = data and data.DiscoveredItems or {}
	local count = 0
	if discovered then
		for _ in pairs(discovered) do count = count + 1 end
	end

	local notifEvent = Events:FindFirstChild("ShowNotification")
	if notifEvent then
		notifEvent:FireClient(player, "Brainrot Info: " .. target.Name, "Discovered: " .. count .. " items")
	end
end)

-- ── Messaging Commands ──────────────────────────────────────────────────
SendGlobalMessageRemote.OnServerEvent:Connect(function(player: Player, message: string)
	if not isAdmin(player) then return end
	if typeof(message) ~= "string" or message == "" then return end
	local notifEvent = Events:FindFirstChild("ShowNotification")
	if notifEvent then
		for _, p in Players:GetPlayers() do
			notifEvent:FireClient(p, "Announcement", message)
		end
	end
end)

SendServerMessageRemote.OnServerEvent:Connect(function(player: Player, message: string)
	if not isAdmin(player) then return end
	if typeof(message) ~= "string" or message == "" then return end
	local notifEvent = Events:FindFirstChild("ShowNotification")
	if notifEvent then
		notifEvent:FireClient(player, "Server Message", message)
	end
end)

-- ── Re-apply speed on respawn & check bans ────────────────────────────────
Players.PlayerAdded:Connect(function(player: Player)
	-- Check bans
	if bannedPlayers[player.UserId] then
		player:Kick("You are banned from this server.")
		return
	end
	if tempBans[player.UserId] and tick() < tempBans[player.UserId] then
		local remaining = math.ceil(tempBans[player.UserId] - tick())
		player:Kick("You are temp-banned. " .. remaining .. " seconds remaining.")
		return
	end
	tempBans[player.UserId] = nil

	player.CharacterAdded:Connect(function(character: Model)
		task.wait(0.5)
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = 16
		end
	end)
end)

for _, player in Players:GetPlayers() do
	player.CharacterAdded:Connect(function(character: Model)
		task.wait(0.5)
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = 16
		end
	end)
end

print("[AdminHandler] Active")
local AdminHandler = {}
return AdminHandler