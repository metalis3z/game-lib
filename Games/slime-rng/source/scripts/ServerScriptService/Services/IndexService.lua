local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local DataService = require(ReplicatedStorage.Packages.DataService).server
local IndexServiceUtils = require(ReplicatedStorage.Source.Features.Index.IndexServiceUtils)
local IndexRewardUtils = require(ReplicatedStorage.Source.Features.Index.IndexRewardUtils)
local InventoryServiceUtils = require(ReplicatedStorage.Source.Features.Inventory.InventoryServiceUtils)

local IndexService = {}

local function migrateInventoryToIndex(player: Player)
	task.wait(2)

	local data = DataService:waitForData(player)
	if not data then
		warn("[IndexService] No data for", player.Name, "during migration")
		return
	end

	local rawIndex  = data:get("index")
	local inventory = data:get("inventory") or {}

	local indexData = IndexServiceUtils.reconcileIndexData(rawIndex)

	if indexData.migratedV1 then
		local changed = false

		for uniqueId, rawData in pairs(inventory) do
			local ok, slimeData = pcall(InventoryServiceUtils.getSlimeData, uniqueId, rawData)
			if ok and slimeData and slimeData.id then
				if not IndexServiceUtils.isUnlockedFromData(indexData, "basic", slimeData.id) then
					IndexServiceUtils.trackSlimeData(indexData, slimeData, 1)
					changed = true
					print("[IndexService] Retroactively indexed:", slimeData.id, "for", player.Name)
				end
			end
		end

		if changed then
			DataService:set(player, "index", indexData)
			print("[IndexService] Index retroactive update saved for", player.Name)
		else
			print("[IndexService] Index already up to date for", player.Name)
		end

		return
	end

	local changed = false

	local starterSlimes = { "goopy", "sunset", "fin" }
	for _, id in ipairs(starterSlimes) do
		if not IndexServiceUtils.isUnlockedFromData(indexData, "basic", id) then
			IndexServiceUtils.markUnlocked(indexData, "basic", id)
			changed = true
		end
	end

	local stats = data:get("stats") or {}
	if type(stats.slimeCounts) == "table" then
		for slimeId, count in pairs(stats.slimeCounts) do
			if type(slimeId) == "string" and type(count) == "number" and count > 0 then
				indexData.categories.basic.counts[slimeId] = math.max(
					(indexData.categories.basic.counts[slimeId] or 0) + math.floor(count + 0.5),
					0
				)
				indexData.categories.basic.unlocked[slimeId] = true
				changed = true
			end
		end
	end

	for uniqueId, rawData in pairs(inventory) do
		local ok, slimeData = pcall(InventoryServiceUtils.getSlimeData, uniqueId, rawData)
		if ok and slimeData and slimeData.id then
			local amount = type(rawData) == "number" and math.max(math.floor(rawData + 0.5), 0) or 1
			if amount > 0 then
				-- trackSlimeData handles basic + mutation categories
				IndexServiceUtils.trackSlimeData(indexData, slimeData, amount)
				changed = true
			end
		end
	end

	indexData.migratedV1 = true

	if changed then
		DataService:set(player, "index", indexData)
		print("[IndexService] Full migration done for", player.Name,
			"- indexed", (function()
				local n = 0
				for _ in pairs(inventory) do n += 1 end
				return n
			end)(), "inventory entries")
	else
		DataService:set(player, "index", indexData)
		print("[IndexService] Migration done (no changes) for", player.Name)
	end
end


local function applyReward(player: Player, data, reward)
	if type(reward) ~= "table" then return end

	local kind = reward.kind

	if kind == "coins" then
		local amount = math.max(math.floor((reward.amount or 0) + 0.5), 0)
		if amount > 0 then
			local current = data:get("coins") or 0
			DataService:set(player, "coins", current + amount)
			print("[IndexService] Gave", amount, "coins to", player.Name)
		end

	elseif kind == "goop" then
		local amount = math.max(math.floor((reward.amount or 0) + 0.5), 0)
		if amount > 0 then
			local current = data:get("goop") or 0
			DataService:set(player, "goop", current + amount)
			print("[IndexService] Gave", amount, "goop to", player.Name)
		end

	elseif kind == "luckFlat" then
		local amount = math.max(math.floor((reward.amount or 0) + 0.5), 0)
		print("[IndexService] Permanent luck +", amount,
			"applied via claimedRewards for", player.Name)

	elseif kind == "luckMultiplier" then
		local amount = math.max(tonumber(reward.amount) or 0, 0)
		print("[IndexService] Permanent luck multiplier +", math.floor(amount * 1000) / 10,
			"% applied via claimedRewards for", player.Name)

	elseif kind == "coinMultiplier" then
		local amount = math.max(tonumber(reward.amount) or 0, 0)
		print("[IndexService] Permanent coin multiplier +", math.floor(amount * 1000) / 10,
			"% applied via claimedRewards for", player.Name)

	elseif kind == "slime" then
		local slimeId = reward.slimeId
		local amount = math.max(math.floor((reward.amount or 1) + 0.5), 1)
		if type(slimeId) == "string" and slimeId ~= "" then
			local inventory = data:get("inventory") or {}
			local newInventory = {}
			for k, v in pairs(inventory) do
				newInventory[k] = v
			end

			for _ = 1, amount do
				local slimeData = {
					id        = slimeId,
					level     = 1,
					xp        = 0,
					mutations = reward.mutations or nil,
				}
				local key = InventoryServiceUtils.genKey(slimeData)
				newInventory[key] = slimeData

				local rawIndex = data:get("index")
				local indexData = IndexServiceUtils.cloneIndexData(
					IndexServiceUtils.reconcileIndexData(rawIndex)
				)
				IndexServiceUtils.trackSlimeData(indexData, slimeData, 1)
				DataService:set(player, "index", indexData)
			end

			DataService:set(player, "inventory", newInventory)
			print("[IndexService] Gave", amount, "x", slimeId, "slime(s) to", player.Name)
		end

	elseif kind == "boost" or kind == "boostTime" then
		print("[IndexService] Boost reward (", kind, ") — integrate with BoostService for", player.Name)

	else
		print("[IndexService] Unknown reward kind:", kind, "for", player.Name)
	end
end


function IndexService:init()
	local networker031 = ReplicatedStorage.Packages._Index["leifstout_networker@0.3.1"].networker
	local remotes = networker031:WaitForChild("_remotes", 10)
	if not remotes then
		warn("[IndexService] Could not find _remotes in networker@0.3.1")
		return
	end

	local indexRemotes = remotes:WaitForChild("IndexService", 10)
	if not indexRemotes then
		warn("[IndexService] Could not find IndexService in _remotes")
		return
	end

	local remoteFunction = indexRemotes:FindFirstChild("RemoteFunction")
	if remoteFunction then
		remoteFunction.OnServerInvoke = function(player: Player, method: string, ...)
			print("[IndexService] Invoked - method:", method, "player:", player.Name)
			if method == "requestClaimReward" then
				return self:requestClaimReward(player, ...)
			end
			warn("[IndexService] Unknown method:", method)
			return false, "unknown method"
		end
		print("[IndexService] OnServerInvoke set successfully")
	else
		warn("[IndexService] RemoteFunction not found")
	end

	local remoteEvent = indexRemotes:FindFirstChild("RemoteEvent")
	if remoteEvent then
		remoteEvent.OnServerEvent:Connect(function(player: Player, method: string, ...)
			if method == "requestClaimReward" then
				self:requestClaimReward(player, ...)
			end
		end)
	end

	Players.PlayerAdded:Connect(function(player)
		task.spawn(migrateInventoryToIndex, player)
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(migrateInventoryToIndex, player)
	end

	print("[IndexService] Initialized")
end


function IndexService:requestClaimReward(player: Player, categoryId: string)
	if not IndexServiceUtils.isCategoryId(categoryId) then
		warn("[IndexService] Invalid index category:", categoryId, "from", player.Name)
		return false, "Invalid index category"
	end

	local data = DataService:waitForData(player)
	if not data then
		warn("[IndexService] No data for", player.Name)
		return false, "Profile unavailable"
	end

	self._claiming = self._claiming or {}
	if self._claiming[player.UserId] then
		return false, "Already claiming reward"
	end
	self._claiming[player.UserId] = true

	local success, result, errMsg = pcall(function()
		local rawIndex  = data:get("index")
		local indexData = IndexServiceUtils.reconcileIndexData(rawIndex)

		local rewardEntry, rewardIndex =
			IndexRewardUtils.getNextRewardEntryFromData(indexData, categoryId)

		if rewardEntry == nil then
			return false, "No reward available"
		end

		local unlockedCount = IndexServiceUtils.getUnlockedCountFromData(indexData, categoryId)
		if unlockedCount < rewardEntry.req then
			return false, "Reward not unlocked"
		end

		local entryKey = IndexRewardUtils.getEntryKey(categoryId, rewardEntry, rewardIndex)
		if indexData.categories[categoryId].claimedRewards[entryKey] == true then
			return false, "No reward available"
		end

		local newIndexData = IndexServiceUtils.cloneIndexData(indexData)
		newIndexData.categories[categoryId].claimedRewards[entryKey] = true
		DataService:set(player, "index", newIndexData)

		for _, reward in ipairs(rewardEntry.rewards or {}) do
			applyReward(player, data, reward)
		end

		print("[IndexService]", player.Name, "claimed index reward:", entryKey,
			"| category:", categoryId,
			"| unlocked:", unlockedCount, "/ req:", rewardEntry.req)

		return true, nil
	end)

	self._claiming[player.UserId] = nil

	if not success then
		warn("[IndexService] pcall error in requestClaimReward for",
			player.Name, ":", result)
		return false, "Server error"
	end

	return result, errMsg
end

return IndexService