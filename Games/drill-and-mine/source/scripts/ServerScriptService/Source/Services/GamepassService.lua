-- GamepassService
-- Owns per-player gamepass ownership for the Folder.Shop Passes. Sets a
-- replicated `OwnsGamepass_<configKey>` boolean attribute per player so other
-- systems (CashBoostService sources, PodiumService offline/auto-collect ticks,
-- LeaderboardController chat tag) can read ownership without round-tripping.
--
-- Boost-percent gamepasses (x2Cash, Vip) register as CashBoostService sources
-- so the brainrot billboard, plot income label, HUD cash counter, and held
-- brainrot label all update through the existing BoostUpdate path.
--
-- AutoCollect and x5Offline are read directly off the attribute by
-- PodiumService.tickCashAccumulation / PodiumService.calcOfflineCash.

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local CashBoostService = require(ServerScriptService.Source.Services.CashBoostService)

local GamepassService = {}

local function getAttributeName(configKey)
	return "OwnsGamepass_" .. configKey
end

local function ownsAttribute(player, configKey)
	return player:GetAttribute(getAttributeName(configKey)) == true
end

local function setOwns(player, configKey, value)
	player:SetAttribute(getAttributeName(configKey), value and true or false)
end

function GamepassService.Owns(player, configKey)
	if not player or not configKey then return false end
	return ownsAttribute(player, configKey)
end

local function queryOwnership(player, gamepassId)
	if not gamepassId or gamepassId == 0 then return false end
	local ok, owns = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId)
	end)
	return ok and owns or false
end

local function refreshAllForPlayer(player)
	local passes = GameConfig.Shop and GameConfig.Shop.Passes
	if not passes then return end

	for configKey, entry in pairs(passes) do
		-- preserve already-true attributes (purchase fired mid-session) but query
		-- for absent attributes so initial join populates state from the platform.
		if player:GetAttribute(getAttributeName(configKey)) == nil then
			local owns = queryOwnership(player, entry.GamepassId)
			setOwns(player, configKey, owns)
		end
	end

	-- Push so the CashBoost HUD reflects the gamepass-derived boost immediately.
	CashBoostService.PushUpdate(player)
end

local function findConfigKeyByGamepassId(gamepassId)
	local passes = GameConfig.Shop and GameConfig.Shop.Passes
	if not passes then return nil end
	for configKey, entry in pairs(passes) do
		if entry.GamepassId == gamepassId and gamepassId ~= 0 then
			return configKey
		end
	end
	return nil
end

local function onPromptFinished(player, gamepassId, wasPurchased)
	if not wasPurchased then return end
	local configKey = findConfigKeyByGamepassId(gamepassId)
	if not configKey then return end
	setOwns(player, configKey, true)
	CashBoostService.PushUpdate(player)
end

local function registerBoostSource(configKey, entry)
	CashBoostService.RegisterSource(configKey, function(player, _)
		if ownsAttribute(player, configKey) then
			return entry.BoostPercent or 0
		end
		return 0
	end)
end

function GamepassService.Init()
	local passes = GameConfig.Shop and GameConfig.Shop.Passes
	if not passes then return end

	for configKey, entry in pairs(passes) do
		if entry.BoostPercent and entry.BoostPercent > 0 then
			registerBoostSource(configKey, entry)
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(refreshAllForPlayer, player)
	end

	Players.PlayerAdded:Connect(function(player)
		task.spawn(refreshAllForPlayer, player)
	end)

	MarketplaceService.PromptGamePassPurchaseFinished:Connect(onPromptFinished)
end

return GamepassService
