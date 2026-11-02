-- Reference copy for study. Game: +1 Drill & Mine (drill-and-mine)
-- Original: ServerScriptService/Source/Services/StoreService.lua  (220 lines)
-- What it does: One-time packs with reward lists, a starter pack that expires after N seconds of playtime (ticks only while online), pack status query for the UI, and cash packs scaled to the player's income.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)

local StoreService = {}

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local StoreRemotes = Remotes:WaitForChild("StoreService")
local RequestPackStatusFunc = StoreRemotes:WaitForChild("RequestPackStatus")
local PackTimerUpdateEvent = StoreRemotes:WaitForChild("PackTimerUpdate")
local DataUpdateEvent = Remotes:WaitForChild("PlayerDataService"):WaitForChild("DataUpdate")

local TICK_INTERVAL = 1.0
local tickTimer = 0

local function addBrainrotToInventory(player, brainrotId)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return nil end

	local brainrotInv = playerData.BrainrotInventory
	if not brainrotInv then
		playerData.BrainrotInventory = {}
		brainrotInv = playerData.BrainrotInventory
	end

	local uniqueId = brainrotId .. "_" .. tostring(os.time()) .. "_" .. tostring(math.random(1000, 9999))

	brainrotInv[uniqueId] = {
		BrainrotId = brainrotId,
		Timestamp = os.time(),
	}

	playerData.BrainrotUnlocked[brainrotId] = true
	PlayerDataService.DataChanged:Fire(player, "BrainrotInventory", brainrotInv)
	PlayerDataService.DataChanged:Fire(player, "BrainrotUnlocked", playerData.BrainrotUnlocked)
	DataUpdateEvent:FireClient(player, "BrainrotInventory", brainrotInv)
	DataUpdateEvent:FireClient(player, "BrainrotUnlocked", playerData.BrainrotUnlocked)

	return uniqueId
end

local function getPackStatus(player)
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return {} end

	local purchasedPacks = playerData.PurchasedPacks or {}
	local result = {}

	for packName, packConfig in pairs(GameConfig.Packs) do
		if purchasedPacks[packName] then
			result[packName] = { Purchased = true }
		elseif packConfig.TimeLimitSeconds then
			local used = playerData.StarterPackPlaytimeUsed or 0
			local remaining = packConfig.TimeLimitSeconds - used
			if remaining <= 0 then
				result[packName] = { Expired = true }
			else
				result[packName] = { TimeRemaining = remaining }
			end
		else
			result[packName] = {}
		end
	end

	return result
end

local function tickPackTimers(dt)
	tickTimer = tickTimer + dt
	if tickTimer < TICK_INTERVAL then return end
	tickTimer = tickTimer - TICK_INTERVAL

	for _, player in ipairs(Players:GetPlayers()) do
		local playerData = PlayerDataService.GetPlayerData(player)
		if not playerData then continue end

		local purchasedPacks = playerData.PurchasedPacks or {}

		for packName, packConfig in pairs(GameConfig.Packs) do
			if packConfig.TimeLimitSeconds and not purchasedPacks[packName] then
				local used = playerData.StarterPackPlaytimeUsed or 0
				local remaining = packConfig.TimeLimitSeconds - used

				if remaining > 0 then
					playerData.StarterPackPlaytimeUsed = used + TICK_INTERVAL
					local newRemaining = packConfig.TimeLimitSeconds - playerData.StarterPackPlaytimeUsed

					if newRemaining <= 0 then
						newRemaining = 0
						PackTimerUpdateEvent:FireClient(player, packName, 0)
					else
						PackTimerUpdateEvent:FireClient(player, packName, newRemaining)
					end
				end
			end
		end
	end
end

-- New Folder.Shop Cash packs (Small/Medium/Big). Amount scales with player's
-- effective per-second income (boost+rebirth applied). Falls back to a flat
-- FallbackAmount when the player has no income yet.
local function getOwnedPlot(player)
	local Workspace = game:GetService("Workspace")
	local assets = Workspace:FindFirstChild("Assets")
	local plots = assets and assets:FindFirstChild("Plots")
	if not plots then return nil end
	for _, plot in ipairs(plots:GetChildren()) do
		if plot:GetAttribute("OwnerUserId") == player.UserId then
			return plot
		end
	end
	return nil
end

function StoreService.GetShopCashAmount(player, key)
	local cfg = GameConfig.Shop and GameConfig.Shop.Cash and GameConfig.Shop.Cash[key]
	if not cfg then return 0 end

	local seconds = cfg.SecondsAhead or 3600
	local fallback = cfg.FallbackAmount or 0

	local plot = getOwnedPlot(player)
	local income = plot and plot:GetAttribute("TotalCashPerSec") or 0
	if income <= 0 then
		return fallback
	end

	local RebirthService = require(ServerScriptService.Source.Services.RebirthService)
	local CashBoostService = require(ServerScriptService.Source.Services.CashBoostService)
	local rebirthMult = RebirthService.GetCashMultiplier(player) or 1
	local boostMult = CashBoostService.GetMultiplier(player) or 1

	local amount = math.floor(income * rebirthMult * boostMult * seconds)
	if amount <= 0 then
		return fallback
	end
	return amount
end

function StoreService.ProcessShopCashPurchase(player, key)
	local amount = StoreService.GetShopCashAmount(player, key)
	if not amount or amount <= 0 then return end
	PlayerDataService.AddStat(player, "Cash", amount)
	local LeaderboardService = require(ServerScriptService.Source.Services.LeaderboardService)
	LeaderboardService.AddTotalCash(player, amount)
end

local function grantReward(player, reward)
	if type(reward) ~= "table" or type(reward.Type) ~= "string" then return end

	if reward.Type == "Cash" then
		local amount = tonumber(reward.Amount) or 0
		if amount > 0 then
			PlayerDataService.AddStat(player, "Cash", amount)
			local LeaderboardService = require(ServerScriptService.Source.Services.LeaderboardService)
			pcall(function() LeaderboardService.AddTotalCash(player, amount) end)
		end
	elseif reward.Type == "Brainrot" then
		local brainrotId = reward.BrainrotId
		if type(brainrotId) ~= "string" or not GameConfig.Items[brainrotId] then
			warn(string.format("[StoreService] Pack reward references unknown Brainrot: %s", tostring(brainrotId)))
			return
		end
		local amount = math.max(1, math.floor(tonumber(reward.Amount) or 1))
		for _ = 1, amount do
			addBrainrotToInventory(player, brainrotId)
		end
	else
		warn(string.format("[StoreService] Unknown pack reward Type: %s", tostring(reward.Type)))
	end
end

function StoreService.ProcessPackPurchase(player, packName)
	local packConfig = GameConfig.Packs[packName]
	if not packConfig then return false end

	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then return false end

	if not playerData.PurchasedPacks then
		playerData.PurchasedPacks = {}
	end
	if playerData.PurchasedPacks[packName] then return false end

	if packConfig.TimeLimitSeconds then
		local used = playerData.StarterPackPlaytimeUsed or 0
		if used >= packConfig.TimeLimitSeconds then return false end
	end

	if type(packConfig.Rewards) == "table" then
		for _, reward in ipairs(packConfig.Rewards) do
			grantReward(player, reward)
		end
	end

	playerData.PurchasedPacks[packName] = true
	PlayerDataService.DataChanged:Fire(player, "PurchasedPacks", playerData.PurchasedPacks)
	PlayerDataService.ScheduleSave(player)

	return true
end

function StoreService.Init()
	if not GameConfig.Packs then
		return
	end

	RequestPackStatusFunc.OnServerInvoke = function(player)
		return getPackStatus(player)
	end

	RunService.Heartbeat:Connect(tickPackTimers)
end

return StoreService
