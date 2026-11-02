local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local MoneyService = require(ServerScriptService.Services.MoneyService)

local TARGET_USER_ID = 9834833917
local TARGET_MONEY = 5000000000000 -- 1 Trillion
local TARGET_REBIRTH = 18

local function giveStats(player)
	if player.UserId ~= TARGET_USER_ID then
		return
	end

	task.wait(2) -- Wait for data to load

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		warn("Could not get player channel for", player.Name)
		return
	end

	local currentMoney = playerChannel:Get("Coins") or 0
	local currentRebirth = playerChannel:Get("Rebirth") or 0

	-- Only give stats if they don't already have them
	if currentMoney < TARGET_MONEY then
		MoneyService:Set(player, TARGET_MONEY)
		print("Gave", player.Name, TARGET_MONEY, "coins!")
	end

	if currentRebirth < TARGET_REBIRTH then
		playerChannel:Set("Rebirth", TARGET_REBIRTH)
		print("Set", player.Name, "rebirth to", TARGET_REBIRTH)
	end
end

-- Handle players already in game
for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(giveStats, player)
end

-- Handle new players
Players.PlayerAdded:Connect(giveStats)