local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)
local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)

local DataUpdateEvent = ReplicatedStorage:WaitForChild("Remotes")
	:WaitForChild("PlayerDataService")
	:WaitForChild("DataUpdate")

local IndexRewardService = {}

local function getUnlockKey(brainrotId, mutationId)
	if mutationId and mutationId ~= "" then
		return mutationId .. "_" .. brainrotId
	end
	return brainrotId
end

local function countUnlockedForCategory(brainrotUnlocked, mutationId)
	local count = 0
	for key, cfg in pairs(GameConfig.Items) do
		if cfg.Rarity == "Exclusive" then continue end
		local unlockKey = getUnlockKey(key, mutationId)
		if brainrotUnlocked[unlockKey] then
			count += 1
		end
	end
	return count
end

local function getCategories()
	if GameConfig.IndexCategories then
		return GameConfig.IndexCategories
	end
	return {
		{ name = "Normal",  mutationId = nil       },
		{ name = "Gold",    mutationId = "Gold"    },
		{ name = "Diamond", mutationId = "Diamond" },
	}
end

local CashBoostService = nil
local function getCashBoostService()
	if CashBoostService then return CashBoostService end
	local ok, mod = pcall(function()
		return require(ServerScriptService.Source.Services.CashBoostService)
	end)
	if ok then
		CashBoostService = mod
	end
	return CashBoostService
end

local function checkAndGrantRewards(player, brainrotUnlocked)
	local data = PlayerDataService.GetPlayerData(player)
	if not data then return end

	if not data.IndexRewardsClaimed then data.IndexRewardsClaimed = {} end
	if not data.IndexCashBoost then data.IndexCashBoost = 0 end

	local changed = false

	for _, cat in ipairs(getCategories()) do
		if data.IndexRewardsClaimed[cat.name] then continue end

		local rewardCfg = GameConfig.IndexRewards[cat.name]
		if not rewardCfg then continue end

		local count = countUnlockedForCategory(brainrotUnlocked, cat.mutationId)
		if count >= rewardCfg.Required then
			data.IndexRewardsClaimed[cat.name] = true
			data.IndexCashBoost = data.IndexCashBoost + rewardCfg.CashBoostPercent
			changed = true
		end
	end

	if not changed then return end

	PlayerDataService.ScheduleSave(player)
	DataUpdateEvent:FireClient(player, "IndexCashBoost", data.IndexCashBoost)
	DataUpdateEvent:FireClient(player, "IndexRewardsClaimed", data.IndexRewardsClaimed)

	local cbs = getCashBoostService()
	if cbs then
		cbs.PushUpdate(player)
	end
end

function IndexRewardService.Init()
	if not GameConfig.IndexRewards then
		return
	end

	PlayerDataService.DataChanged.Event:Connect(function(player, statName, value)
		if statName == "BrainrotUnlocked" then
			checkAndGrantRewards(player, value)
		elseif statName == "BrainrotInventory" then
			local data = PlayerDataService.GetPlayerData(player)
			if data then
				checkAndGrantRewards(player, data.BrainrotUnlocked or {})
			end
		end
	end)

	PlayerDataService.ProfileLoaded.Event:Connect(function(player, data)
		task.defer(function()
			checkAndGrantRewards(player, data.BrainrotUnlocked or {})
		end)
	end)
end

return IndexRewardService