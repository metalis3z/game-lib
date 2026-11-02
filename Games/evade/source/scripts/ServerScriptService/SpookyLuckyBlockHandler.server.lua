--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local CandyService = require(ServerScriptService.Services.CandyService)

local REQUIRED_CANDIES = 500
local COOLDOWN_SECONDS = 1

local SCRIPT_NAME = "Spooky Lucky Block"
local SPAWN_REMOTE = Net:RemoteEvent(("EventService/%s/Spawn"):format(SCRIPT_NAME))
local CLIENT_SPAWN_REMOTE = Net:RemoteEvent(("EventService/%s/ClientSpawn"):format(SCRIPT_NAME))
local NOTIFY_REMOTE = Net:RemoteEvent("NotificationService/Notify")

local lastAttempt = {} :: { [number]: number }

local function getChannel(player: Player)
	local channel = Synchronizer:Get(player)
	if channel then
		return channel
	end
	repeat
		task.wait(0.05)
		channel = Synchronizer:Get(player)
	until channel
	return channel
end

local function canAttemptSpawn(player: Player): boolean
	local now = time()
	local id = player.UserId
	local last = lastAttempt[id] or 0
	if now - last < COOLDOWN_SECONDS then
		return false
	end
	lastAttempt[id] = now
	return true
end

local function notify(player: Player, message: string, duration: number?, sound: string?)
	pcall(function()
		NOTIFY_REMOTE:FireClient(player, message or "", duration or 5, sound or "")
	end)
end

local function spawnSpookyLuckyBlock(player: Player)
	if typeof(player) ~= "Instance" or not player:IsA("Player") then
		return
	end

	if not canAttemptSpawn(player) then
		return
	end

	local channel = getChannel(player)
	if not channel then
		notify(player, "<font color='#ff6b6b'>Unable to access player data.</font>", 5, "Sounds.Sfx.Failure")
		warn("[Spooky] Failed to get channel for player:", player.Name)
		return
	end

	local candies = tonumber(channel:Get("Candies")) or 0
	if candies < REQUIRED_CANDIES then
		notify(player, string.format("<font color='#ffcc66'>You need %d candies to spawn a %s. (%d/%d)</font>", REQUIRED_CANDIES, SCRIPT_NAME, candies, REQUIRED_CANDIES), 5, "Sounds.Sfx.Failure")
		warn(("[Spooky] %s attempted spawn with insufficient candies (%d/%d)"):format(player.Name, candies, REQUIRED_CANDIES))
		return
	end

	local success, err = pcall(function()
		CandyService:Set(player, candies - REQUIRED_CANDIES)
	end)
	if not success then
		notify(player, "<font color='#ff6b6b'>Failed to deduct candies. Try again later.</font>", 5, "Sounds.Sfx.Failure")
		warn("[Spooky] Failed to deduct candies for", player.Name, "-", tostring(err))
		return
	end

	notify(player, ("<font color='#92FF67'>%s spawned!</font>"):format(SCRIPT_NAME), 5, "Sounds.Sfx.Success")
	CLIENT_SPAWN_REMOTE:FireClient(player, "Spooky Lucky Block")
end

SPAWN_REMOTE.OnServerEvent:Connect(function(player: Player)
	spawnSpookyLuckyBlock(player)
end)
