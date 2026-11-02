local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
local LeaderboardService = require(ServerScriptService.Source.Services.LeaderboardService)
local MutationService = require(ServerScriptService.Source.Services.MutationService)
local InventoryService = require(ServerScriptService.Source.Services.InventoryService)
local GameConfig = require(ReplicatedStorage.Source.Configs.GameConfig)

local SellService = {}

local CPS_BONUS_PERCENT = 0.5

local function getCashPerSec(baseCashPerSec, level)
	if level <= 1 then return baseCashPerSec end
	local levelIndex = level - 1
	return baseCashPerSec + (baseCashPerSec * CPS_BONUS_PERCENT * levelIndex)
end

local function getBestNonPercentOwnedCps(brainrotInventory, placedBrainrot)
	local best = 0
	local function consider(entry)
		local cfg = entry and entry.BrainrotId and GameConfig.Items[entry.BrainrotId]
		if not cfg or cfg.IsPercentBrainrot then return end
		local baseCps = cfg.CashPerSec or 0
		local mutation = entry.Mutation
		if mutation and MutationService.IsValidMutation(mutation) then
			baseCps = MutationService.GetMutatedCashPerSec(entry.BrainrotId, mutation)
		end
		local actual = getCashPerSec(baseCps, entry.Level or 1)
		if actual > best then best = actual end
	end
	for _, e in pairs(brainrotInventory or {}) do consider(e) end
	for _, e in pairs(placedBrainrot or {}) do consider(e) end
	return best
end

local function computeSellPrice(playerData, entry)
	local cfg = entry and entry.BrainrotId and GameConfig.Items[entry.BrainrotId]
	if not cfg then return 0 end
	local baseCps = cfg.CashPerSec or 0
	if cfg.IsPercentBrainrot then
		local best = getBestNonPercentOwnedCps(playerData.BrainrotInventory, playerData.PlacedBrainrot)
		baseCps = (cfg.PercentBoost or 0) * best
	end
	if entry.Mutation and MutationService.IsValidMutation(entry.Mutation) then
		baseCps = baseCps * MutationService.GetCashBoost(entry.Mutation)
	end
	local actualCps = getCashPerSec(baseCps, entry.Level or 1)
	return math.floor(actualCps * 10)
end

local function ensureRemote()
	local remotes = ReplicatedStorage:WaitForChild("Remotes")
	local invRemotes = remotes:WaitForChild("InventoryService")
	local rf = invRemotes:FindFirstChild("SellBrainrot")
	if not rf then
		rf = Instance.new("RemoteFunction")
		rf.Name = "SellBrainrot"
		rf.Parent = invRemotes
	end
	return rf
end

local function onSellBrainrot(player, uniqueId)
	if type(uniqueId) ~= "string" or uniqueId == "" then
		return { Success = false, Reason = "BadId" }
	end
	local playerData = PlayerDataService.GetPlayerData(player)
	if not playerData then
		return { Success = false, Reason = "NoData" }
	end
	local brainrotInv = playerData.BrainrotInventory or {}
	local entry = brainrotInv[uniqueId]
	if not entry then
		return { Success = false, Reason = "NotOwned" }
	end

	local placed = playerData.PlacedBrainrot or {}
	for _, p in pairs(placed) do
		if p.UniqueId == uniqueId then
			return { Success = false, Reason = "Placed" }
		end
	end

	local price = computeSellPrice(playerData, entry)

	brainrotInv[uniqueId] = nil
	if playerData.EquippedItem == uniqueId then
		playerData.EquippedItem = ""
		PlayerDataService.DataChanged:Fire(player, "EquippedItem", "")
	end
	-- SetStat (not DataChanged) so DataUpdateEvent fires to the client and the
	-- island inventory slot in IslandBrainrotClient actually disappears.
	PlayerDataService.SetStat(player, "BrainrotInventory", brainrotInv)

	if price > 0 then
		PlayerDataService.AddStat(player, "Cash", price)
		pcall(function() LeaderboardService.AddTotalCash(player, price) end)
	end

	InventoryService.PushUpdateForPlayer(player)
	PlayerDataService.ScheduleSave(player)

	return { Success = true, Amount = price }
end

function SellService.Init()
	local rf = ensureRemote()
	rf.OnServerInvoke = onSellBrainrot
end

return SellService
