--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local Network = require(script.Parent.Core_Network)
local AssetDirectory = require(ReplicatedStorage.Directory.Assets)
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)
local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)
local AssetDnaProductResolver = require(ReplicatedStorage.AssetDnaProductResolver)

local ActiveAssets = {}
local Data
local Plots
local runtimeByOwner: {[number]: {[string]: any}} = {}
local rng = Random.new()
local selectedStealTarget: {[Player]: {OwnerUserId: number, UID: string}} = {}

local function requestStealTarget(player: Player, request)
	if typeof(request) ~= "table" or typeof(request.OwnerUserId) ~= "number" or typeof(request.UID) ~= "string" then
		return false, "Invalid steal request."
	end
	if request.OwnerUserId == player.UserId then
		return false, "You cannot steal your own pet's DNA."
	end
	local targetRecords = runtimeByOwner[request.OwnerUserId]
	local record = targetRecords and targetRecords[request.UID]
	if not record then
		return false, "That pet is no longer available."
	end
	if record.ItemData.IsStolenDNA == true then
		return false, "This pet's DNA was already stolen from someone else."
	end
	local expectedProductId = AssetDnaProductResolver.GetProductId(record.ItemData)
	if expectedProductId == nil or expectedProductId ~= request.ProductId then
		return false, "That DNA steal product is not configured correctly."
	end
	selectedStealTarget[player] = {OwnerUserId = request.OwnerUserId, UID = request.UID}
	return true
end

local function copy(value)
	if typeof(value) ~= "table" then
		return value
	end
	local result = {}
	for key, child in pairs(value) do
		result[key] = copy(child)
	end
	return result
end

local function normalizedPersonality(raw): string
	local value = raw.Personality
	if typeof(value) == "string" and Personalities.IsPersonality(value) then
		return value
	end
	return Personalities.Personalities.Normal
end

local function itemData(raw)
	return {
		Category = tostring(raw.Category or "Chicken"),
		Mutations = if typeof(raw.Mutations) == "table" then copy(raw.Mutations) else {},
		BaseMutation = if typeof(raw.BaseMutation) == "string" then raw.BaseMutation else nil,
		Scale = math.max(0.1, tonumber(raw.Scale) or 1),
		Gender = if raw.Gender == "Male" or raw.Gender == "Female" then raw.Gender else nil,
		EyeColor = if typeof(raw.EyeColor) == "string" then raw.EyeColor else nil,
		ColorSeed = tonumber(raw.ColorSeed),
		ColorIndex = tonumber(raw.ColorIndex),
		IsFavorite = raw.IsFavorite == true,
		-- The wander simulator requires a valid personality. Older/custom hatch
		-- records may not contain one, so repair them at the runtime boundary.
		Personality = normalizedPersonality(raw),
		HasBeenFirstPlaced = raw.HasBeenFirstPlaced == true,
		IsStolenDNA = raw.IsStolenDNA == true,
	}
end

local REBIRTH_MULTIPLIERS = {1.5, 2, 2.5, 3, 3.5, 4, 5, 6, 7.5, 10, 12, 15, 20, 35, 50, 75, 100, 200}

local function baseRate(raw, includeMutations: boolean): number
	local config = AssetDirectory.Directory[tostring(raw.Category or raw.AssetCategory or "Chicken")]
	local configuredRate = math.max(0, if config then tonumber(config.EarningRate) or 0 else 0)
	local scale = math.max(0.1, tonumber(raw.Scale or raw.AssetScale) or 1)
	local scaleMultiplier = if scale <= 5 then scale ^ 1.85 else (scale / 5) ^ 1.2 * 19.637875755794113
	local mutationMultiplier = 1
	if includeMutations then
		local mutations = if typeof(raw.Mutations) == "table" then raw.Mutations else {}
		mutationMultiplier = math.max(0, Mutations.GetTotalMutationsEarningMulti(mutations))
	end
	return math.max(1, math.round(configuredRate * scaleMultiplier * mutationMultiplier))
end

local function earningRate(raw, profile)
	-- Income always starts from the configured EarningRate. Pet size affects
	-- inventory/sale value, but must never reduce a pet's advertised income.
	local config = AssetDirectory.Directory[tostring(raw.Category or raw.AssetCategory or "Chicken")]
	local configuredRate = math.max(0, if config then tonumber(config.EarningRate) or 0 else 0)
	local mutations = if typeof(raw.Mutations) == "table" then raw.Mutations else {}
	local mutationMultiplier = math.max(0, Mutations.GetTotalMutationsEarningMulti(mutations))
	local rebirth = math.max(0, math.floor(tonumber(profile.Rebirth) or 0))
	local rebirthMultiplier = REBIRTH_MULTIPLIERS[rebirth] or 1
	local moneyMultiplier = if profile.Gamepasses and profile.Gamepasses.X2Money == true then 2 else 1
	return math.max(1, math.round(configuredRate * mutationMultiplier * rebirthMultiplier * moneyMultiplier))
end

local function ownerUpdate(userId: number)
	return {
		OwnerUserId = userId,
		Records = copy(runtimeByOwner[userId] or {}),
	}
end

local function publish(player: Player)
	Network.FireAll("ActiveAssets: RuntimeOwnerUpdated", ownerUpdate(player.UserId))
end

local function destroyToolWithUid(player: Player, uid: string)
	for _, container in ipairs({player:FindFirstChild("Backpack"), player.Character}) do
		if container then
			for _, child in ipairs(container:GetChildren()) do
				if child:IsA("Tool") and child:GetAttribute("UID") == uid then
					child:Destroy()
				end
			end
		end
	end
end

local function makeAssetTool(player: Player, uid: string, raw)
	local AssetItemModule = require(ReplicatedStorage.Library.Modules.ItemDisplay)
	print("makeAssetTool called for", uid)
	local backpack = player:FindFirstChildOfClass("Backpack")
	if not backpack or not player.Parent then
		print("makeAssetTool bailed: no backpack or player.Parent")
		return
	end
	for _, container in ipairs({backpack, player.Character}) do
		if container then
			for _, child in ipairs(container:GetChildren()) do
				if child:IsA("Tool") and child:GetAttribute("UID") == uid then
					print("makeAssetTool bailed: tool already exists for", uid)
					return
				end
			end
		end
	end

	print("about to call CreateTool")
	local tool = AssetItemModule.CreateTool(itemData(raw), uid, player)
	print("CreateTool returned", tool)

	tool:SetAttribute("Category", tostring(raw.Category or "Chicken"))
	tool:SetAttribute("Mutations", if typeof(raw.Mutations) == "table" then table.concat(raw.Mutations, ",") else "")
	tool:SetAttribute("MoneyPerSecond", earningRate(raw, Data.Get(player) or {}))
	tool:SetAttribute("Personality", normalizedPersonality(raw))
end

function ActiveAssets.SyncTools(player: Player)
	local profile = Data.Get(player)
	if not profile then
		print("SyncTools bailed: no profile")
		return
	end
	print("SyncTools running, Inventory count:", profile.Inventory and next(profile.Inventory) ~= nil, "Equipped count:", #(profile.EquippedAssets or {}))
	local equipped = {}
	for _, uid in ipairs(profile.EquippedAssets or {}) do
		equipped[uid] = true
	end
	for uid, raw in pairs(profile.Inventory or {}) do
		if not equipped[uid] and not raw.InFuse then
			makeAssetTool(player, uid, raw)
		else
			destroyToolWithUid(player, uid)
		end
	end
end

function ActiveAssets.Rebuild(player: Player)
	print("Rebuild called for", player.Name)
	local profile = Data.Get(player)
	if not profile then
		return
	end
	local records = {}
	local cleanEquipped = {}
	local totalIncome = 0
	for _, uid in ipairs(profile.EquippedAssets or {}) do
		local raw = profile.Inventory and profile.Inventory[uid]
		if typeof(uid) == "string" and typeof(raw) == "table" then
			table.insert(cleanEquipped, uid)
			local rate = earningRate(raw, profile)
			totalIncome += rate
			records[uid] = {
				OwnerUserId = player.UserId,
				UID = uid,
				ItemData = itemData(raw),
				MoneyPerSecond = rate,
				Seed = tonumber(raw.Seed) or rng:NextInteger(1, 1_000_000_000),
				IsFirstPlacement = raw.HasBeenFirstPlaced ~= true,
			}
		end
	end
	if #cleanEquipped ~= #(profile.EquippedAssets or {}) then
		Data.Update(player, {EquippedAssets = cleanEquipped})
	end
	runtimeByOwner[player.UserId] = records
	player:SetAttribute("PetIncomePerSecond", totalIncome)
	publish(player)
	task.defer(ActiveAssets.SyncTools, player)
end

function ActiveAssets.ApplyStealSelected(player: Player): boolean
	local target = selectedStealTarget[player]
	if not target then
		return false
	end
	selectedStealTarget[player] = nil

	local thiefProfile = Data.Get(player)
	local targetPlayer = Players:GetPlayerByUserId(target.OwnerUserId)
	local targetProfile = targetPlayer and Data.Get(targetPlayer)
	if not thiefProfile or not targetPlayer or not targetProfile then
		return false
	end

	local targetInventory = copy(targetProfile.Inventory or {})
	local sourceRaw = targetInventory[target.UID]
	if typeof(sourceRaw) ~= "table" or sourceRaw.IsStolenDNA == true then
		return false
	end
	sourceRaw.IsStolenDNA = true
	Data.Update(targetPlayer, {Inventory = targetInventory})

	local newUid = HttpService:GenerateGUID(false)
	local thiefInventory = copy(thiefProfile.Inventory or {})
	thiefInventory[newUid] = {
		Category = sourceRaw.Category,
		Mutations = copy(sourceRaw.Mutations or {}),
		BaseMutation = sourceRaw.BaseMutation,
		Scale = sourceRaw.Scale,
		Gender = sourceRaw.Gender,
		EyeColor = sourceRaw.EyeColor,
		ColorSeed = sourceRaw.ColorSeed,
		ColorIndex = sourceRaw.ColorIndex,
		Personality = sourceRaw.Personality,
		IsStolenDNA = true,
		HasBeenFirstPlaced = false,
		Seed = rng:NextInteger(1, 1_000_000_000),
	}
	Data.Update(player, {Inventory = thiefInventory})
	ActiveAssets.Rebuild(player)
	return true
end

local function equip(player: Player, uid: string)
	if typeof(uid) ~= "string" then
		return false, "Invalid pet."
	end
	local profile = Data.Get(player)
	if not profile then
		return false, "Your data is still loading."
	end
	local raw = profile.Inventory and profile.Inventory[uid]
	if typeof(raw) ~= "table" then
		return false, "That pet is not in your inventory."
	end
	local equipped = copy(profile.EquippedAssets or {})
	if table.find(equipped, uid) then
		return true
	end
	if #equipped >= Plots.GetCapacity(player) then
		return false, "Your pet area is full."
	end
	table.insert(equipped, uid)
	raw.HasBeenFirstPlaced = true
	destroyToolWithUid(player, uid)
	Data.Update(player, {
		Inventory = profile.Inventory,
		EquippedAssets = equipped,
	})
	ActiveAssets.Rebuild(player)
	return true
end

local function unequip(player: Player, uid: string)
	local profile = Data.Get(player)
	if not profile then
		return false, "Your data is still loading."
	end
	local equipped = copy(profile.EquippedAssets or {})
	local index = table.find(equipped, uid)
	if not index then
		return false, "That pet is not equipped."
	end
	table.remove(equipped, index)
	Data.Update(player, {EquippedAssets = equipped})
	ActiveAssets.Rebuild(player)
	return true
end

local function hasVip(player: Player, profile): boolean
	return player:GetAttribute("VIP") == true or (profile.Gamepasses and profile.Gamepasses.VIP == true)
end

local function petSalePrice(player: Player, profile, raw): number
	local price = baseRate(raw, true) * 100
	return math.max(1, math.floor(price * (if hasVip(player, profile) then 2 else 1)))
end

local function eggSalePrice(player: Player, profile, raw): number
	-- Eggs sell for 80% of the same pet's unmutated inventory value.
	local price = baseRate(raw, false) * 80
	return math.max(1, math.floor(price * (if hasVip(player, profile) then 2 else 1)))
end

local function sellMany(player: Player, requested): (boolean, any, number?)
	local profile = Data.Get(player)
	if not profile then
		return false, "Your data is still loading."
	end
	if typeof(requested) ~= "table" then
		return false, "Invalid sell request."
	end

	local inventory = copy(profile.Inventory or {})
	local eggInventory = copy(profile.EggInventory or {})
	local equipped = {}
	for _, uid in ipairs(profile.EquippedAssets or {}) do
		equipped[uid] = true
	end

	local seen = {}
	local soldCount = 0
	local totalPrice = 0
	for _, uid in ipairs(requested) do
		if typeof(uid) ~= "string" or seen[uid] then
			continue
		end
		seen[uid] = true

		local raw = inventory[uid]
		if typeof(raw) == "table" then
			if raw.IsFavorite == true or raw.InFuse == true or equipped[uid] then
				continue
			end
			totalPrice += petSalePrice(player, profile, raw)
			inventory[uid] = nil
			soldCount += 1
			destroyToolWithUid(player, uid)
			continue
		end

		local egg = eggInventory[uid]
		if typeof(egg) == "table" and egg.Placement == nil then
			totalPrice += eggSalePrice(player, profile, egg)
			eggInventory[uid] = nil
			soldCount += 1
			destroyToolWithUid(player, uid)
		end
	end

	if soldCount == 0 then
		return false, "No eligible pets or eggs were selected."
	end

	Data.Update(player, {
		Inventory = inventory,
		EggInventory = eggInventory,
		Money = (tonumber(profile.Money) or 0) + totalPrice,
	})
	return true, totalPrice, soldCount
end

local function sell(player: Player, request)
	local uid = if typeof(request) == "table" then request.UID or request.Uid else request
	if typeof(uid) ~= "string" then
		return false, "Invalid pet."
	end
	return sellMany(player, {uid})
end

local function canEquipAny(player: Player): boolean
	local profile = Data.Get(player)
	if not profile or #(profile.EquippedAssets or {}) >= Plots.GetCapacity(player) then
		return false
	end
	local equipped = {}
	for _, uid in ipairs(profile.EquippedAssets or {}) do
		equipped[uid] = true
	end
	for uid, raw in pairs(profile.Inventory or {}) do
		if not equipped[uid] and typeof(raw) == "table" and not raw.InFuse then
			return true
		end
	end
	return false
end

local function equipBest(player: Player)
	local profile = Data.Get(player)
	if not profile then
		return false, "Your data is still loading."
	end
	local equipped = copy(profile.EquippedAssets or {})
	local equippedSet = {}
	for _, uid in ipairs(equipped) do
		equippedSet[uid] = true
	end
	local candidates = {}
	for uid, raw in pairs(profile.Inventory or {}) do
		if not equippedSet[uid] and typeof(raw) == "table" and not raw.InFuse then
			table.insert(candidates, {
				Uid = uid,
				Rate = earningRate(raw, profile),
			})
		end
	end
	table.sort(candidates, function(a, b)
		return a.Rate > b.Rate
	end)
	local capacity = Plots.GetCapacity(player)
	for _, candidate in ipairs(candidates) do
		if #equipped >= capacity then
			break
		end
		table.insert(equipped, candidate.Uid)
		destroyToolWithUid(player, candidate.Uid)
	end
	if #equipped == #(profile.EquippedAssets or {}) then
		return false, "There are no pets to equip."
	end
	Data.Update(player, {EquippedAssets = equipped})
	ActiveAssets.Rebuild(player)
	return true
end

function ActiveAssets.Init(dataService, plotService)
	Data = dataService
	Plots = plotService

	Network.BindFunction("Backpack: GetEquipBestStatus", function(player)
		return canEquipAny(player)
	end)
	Network.BindFunction("Backpack: EquipBest", equipBest)
	Network.BindFunction("Backpack: GetAutoSellState", function(player)
		local profile = Data.Get(player)
		return copy(if profile then profile.AutoSellState or {} else {})
	end)
	Network.BindFunction("Backpack: SetAutoSellState", function(player, requested)
		if typeof(requested) ~= "table" then
			return false
		end
		local clean = {}
		for key, value in pairs(requested) do
			if typeof(key) == "string" and value == true then
				clean[key] = true
			end
		end
		Data.Update(player, {AutoSellState = clean})
		return true, clean
	end)

	Network.BindFunction("ActiveAssets: RequestRuntimeSnapshot", function()
		local snapshot = {}
		for userId in pairs(runtimeByOwner) do
			table.insert(snapshot, ownerUpdate(userId))
		end
		return snapshot
	end)
	Network.BindFunction("ActiveAssets: RequestEquip", equip)
	Network.BindFunction("ActiveAssets: RequestUnequip", unequip)
	Network.BindFunction("ActiveAssets: RequestEquipLimit", function(player)
		return Plots.GetCapacity(player)
	end)
	Network.BindFunction("ActiveAssets: RequestSell", sell)
	Network.BindEvent("AssetInventory: SellAsset", function(player, requested)
		sellMany(player, requested)
	end)
	Network.BindEvent("AssetInventory: SellAllAssets", function(player, requested)
		sellMany(player, requested)
	end)
	Network.BindFunction("ActiveAssets: AcknowledgePenFullPetsBadge", function()
		return true
	end)
	Network.BindFunction("ActiveAssets: AcknowledgePenFullEquipBestBadge", function()
		return true
	end)
	Network.BindFunction("ActiveAssets: RequestStealTarget", requestStealTarget)
	Network.BindFunction("ActiveAssets: RequestDnaStealAnimationComplete", function()
		return true
	end)

	Data.Loaded.Event:Connect(function(player, profile)
		local lastLogout = Data.GetLoadedLogout(player)
		ActiveAssets.Rebuild(player)
		local elapsed = math.clamp(os.time() - lastLogout, 0, 4 * 60 * 60)
		if lastLogout > 0 and elapsed >= 30 then
			local rate = 0
			for _, record in pairs(runtimeByOwner[player.UserId] or {}) do
				rate += record.MoneyPerSecond
			end
			if rate > 0 then
				Data.AddMoney(player, math.floor(rate * elapsed * 0.5))
			end
		end
	end)
	Data.Changed.Event:Connect(function(player, changes)
		if changes.Inventory ~= nil or changes.EquippedAssets ~= nil or changes.Rebirth ~= nil or changes.Gamepasses ~= nil or changes.Products ~= nil then
			ActiveAssets.Rebuild(player)
		end
	end)
	Players.PlayerRemoving:Connect(function(player)
		runtimeByOwner[player.UserId] = nil
		selectedStealTarget[player] = nil
		Network.FireAll("ActiveAssets: RuntimeOwnerCleared", {OwnerUserId = player.UserId})
	end)

	task.spawn(function()
		while task.wait(1) do
			for _, player in ipairs(Players:GetPlayers()) do
				local records = runtimeByOwner[player.UserId]
				if records then
					local total = 0
					local collections = {}
					for uid, record in pairs(records) do
						local amount = math.max(0, tonumber(record.MoneyPerSecond) or 0)
						if amount > 0 then
							total += amount
							table.insert(collections, {uid = uid, amount = amount})
						end
					end
					if total > 0 and Data.AddMoney(player, total) then
						Network.FireClient("ActiveAssets: MoneyCollected", player, collections)
					end
				end
			end
		end
	end)
end

return ActiveAssets
