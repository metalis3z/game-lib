--!strict
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

local Network = require(script.Parent.Core_Network)
local PurchaseIds = require(ReplicatedStorage:WaitForChild("PurchaseIdConfig"))
local ProductDirectory = require(ReplicatedStorage.Directory.Products)
local TreadmillDirectory = require(ReplicatedStorage.Directory.Treadmills)
local RebirthDirectory = require(ReplicatedStorage.Directory.Rebirths)
local TreadmillUtil = require(ReplicatedStorage.Library.Util.TreadmillUtil)
local AssetDirectory = require(ReplicatedStorage.Directory.Assets)
local AssetColorUtil = require(ReplicatedStorage.Library.Util.AssetColorUtil)
local Personalities = require(ReplicatedStorage.Directory.Assets.Personalities)

local Purchases = {}
local Data
local Eggs
local Treadmills
local ActiveAssets

local productNameById: {[number]: string} = {}
local gamepassNameById: {[number]: string} = {}
local processingReceipts: {[string]: boolean} = {}
local lastPromptAt: {[Player]: number} = {}
local serverLuck = {
	Multiplier = 1,
	EndsAt = 0,
}
local rng = Random.new()
local CASHGRAB_ASSET_MAP: {[string]: string} = {
	StrawberryElephant = "Strawberry Elephant",
	Unicorn = "Unicorn",
	Phoenix = "Ascended Vermilion Phoenix",
	BestEgg = "Unicorn",
	Kitsune = "Kitsune",
	Dreadscale = "Dreadscale",
	MechaDreadscale = "Mecha Dreadscale",
	Krakenoid = "Mecha Krakenoid",
}

local function cloneDictionary(source)
	local result = {}
	for key, value in pairs(source or {}) do
		result[key] = value
	end
	return result
end

local function getProductConfig(productName: string)
	local ok, config = pcall(function()
		return ProductDirectory.Directory[productName]
	end)
	return if ok then config else nil
end

local function refreshServerLuck()
	if serverLuck.Multiplier > 1 and serverLuck.EndsAt <= Workspace:GetServerTimeNow() then
		serverLuck.Multiplier = 1
		serverLuck.EndsAt = 0
	end
	return {
		Multiplier = serverLuck.Multiplier,
		EndsAt = serverLuck.EndsAt,
	}
end

local function publishServerLuck()
	Network.FireAll("ServerLuck:StateUpdated", refreshServerLuck())
end

local function addServerLuck(multiplier: number, durationSeconds: number)
	local now = Workspace:GetServerTimeNow()
	refreshServerLuck()
	serverLuck.Multiplier = math.max(serverLuck.Multiplier, multiplier)
	serverLuck.EndsAt = math.max(serverLuck.EndsAt, now) + math.max(0, durationSeconds)
	publishServerLuck()
end

local function extendServerLuck(durationSeconds: number): boolean
	refreshServerLuck()
	if serverLuck.Multiplier <= 1 then
		return false
	end
	serverLuck.EndsAt = math.max(serverLuck.EndsAt, Workspace:GetServerTimeNow()) + math.max(0, durationSeconds)
	publishServerLuck()
	return true
end

local function grantGamepass(player: Player, gamepassName: string): boolean
	local profile = Data.Get(player)
	if not profile then
		return false
	end
	local owned = cloneDictionary(profile.Gamepasses)
	owned[gamepassName] = true
	Data.Update(player, {Gamepasses = owned})
	Network.FireClient("Gamepass Bought", player, PurchaseIds.GamepassIds[gamepassName])
	return true
end

local function grantTrail(player: Player, productName: string): boolean
	local trailName = string.match(productName, "^Trail_(.+)$")
	local profile = Data.Get(player)
	if not trailName or not profile then
		return false
	end
	local inventory = cloneDictionary(profile.TrailInventory)
	inventory[trailName] = true
	Data.Update(player, {TrailInventory = inventory})
	return true
end

local function grantTemporarySpeedBoost(player: Player, durationSeconds: number): boolean
	local profile = Data.Get(player)
	if not profile then
		return false
	end
	local now = Workspace:GetServerTimeNow()
	local remaining = math.max(0, tonumber(profile.TemporarySpeedBoostRemainingSeconds) or 0)
	local startedAt = tonumber(profile.TemporarySpeedBoostActiveStartedAt) or 0
	if startedAt > 0 then
		remaining = math.max(0, remaining - math.max(0, now - startedAt))
	end
	Data.Update(player, {
		TemporarySpeedBoostRemainingSeconds = remaining + durationSeconds,
		TemporarySpeedBoostActiveStartedAt = now,
	})
	return true
end

local function grantTreadmillEquivalent(player: Player, durationSeconds: number): boolean
	local profile = Data.Get(player)
	if not profile then
		return false
	end
	local config = TreadmillDirectory.GetByUpgradeLevel(math.max(1, tonumber(profile.TreadmillUpgradeLevel) or 1))
	if not config then
		return false
	end
	local current = math.max(10, tonumber(profile.SpeedPower) or 10)
	local boostMultiplier = TreadmillUtil.ResolveAdditiveSpeedStepMultiplier(
		TreadmillUtil.ResolveSpeedBoostSpeedStepMultiplier(profile),
		TreadmillUtil.ResolveTemporarySpeedBoostSpeedStepMultiplier(profile, Workspace:GetServerTimeNow())
	)
	local perTick = math.max(1, math.floor((1 + math.log10(current)) * math.max(1, tonumber(config.SpeedMultiplier) or 1) * boostMultiplier))
	local amount = math.max(1, math.floor(perTick * durationSeconds / 0.25))
	Data.Update(player, {SpeedPower = current + amount})
	return true
end

local function grantCashGrabPet(player: Player, cashGrabName: string): boolean
	local assetCategory = CASHGRAB_ASSET_MAP[cashGrabName]
	if not assetCategory or not AssetDirectory.Directory[assetCategory] then
		warn(("[Purchases] Unknown CashGrab product '%s'"):format(cashGrabName))
		return false
	end
	local profile = Data.Get(player)
	if not profile then
		return false
	end
	local colors = AssetColorUtil.RollFields(assetCategory, rng)
	local newUid = HttpService:GenerateGUID(false)
	local inventory = cloneDictionary(profile.Inventory or {})
	inventory[newUid] = {
		Category = assetCategory,
		Mutations = {},
		BaseMutation = nil,
		Scale = rng:NextNumber(0.9, 1.1),
		Gender = if rng:NextNumber() < 0.5 then "Male" else "Female",
		EyeColor = colors.EyeColor,
		ColorSeed = colors.ColorSeed,
		ColorIndex = colors.ColorIndex,
		Personality = Personalities.Personalities.Normal,
		HasBeenFirstPlaced = false,
		Seed = rng:NextInteger(1, 1_000_000_000),
	}
	local index = cloneDictionary(profile.Index or {})
	index[assetCategory] = true
	Data.Update(player, {
		Inventory = inventory,
		Index = index,
	})
	ActiveAssets.Rebuild(player)
	return true
end

local function grantProduct(player: Player, productName: string): boolean
	local profile = Data.Get(player)
	if not profile then
		return false
	end

	local amountText = string.match(productName, "^Money_(%d+)$")
	if amountText then
		Data.AddMoney(player, tonumber(amountText) or 0)
		return true
	end

	amountText = string.match(productName, "^SpeedPower_(%d+)$")
	if amountText then
		Data.Update(player, {SpeedPower = (tonumber(profile.SpeedPower) or 10) + (tonumber(amountText) or 0)})
		return true
	end

	local tierText = string.match(productName, "^SpeedBoostTier(%d+)$")
	if tierText then
		local tier = math.clamp(tonumber(tierText) or 0, 0, TreadmillUtil.MAX_SPEED_BOOST_TIER_INDEX)
		Data.Update(player, {SpeedBoostTierIndex = math.max(tonumber(profile.SpeedBoostTierIndex) or 0, tier)})
		return true
	end
	
	local rarity = string.match(productName, "^Steal(.+)$")
	if rarity then
		if ActiveAssets.ApplyStealSelected(player) then
			return true
		end
		warn(("[Purchases] DNA steal receipt for %s had no valid target; granting a %s egg instead"):format(player.Name, rarity))
		return select(1, Eggs.GrantEggsByRarity(player, 1, rarity))
	end

	local trailName = string.match(productName, "^Trail_(.+)$")
	if trailName then
		return grantTrail(player, productName)
	end

	local treadmillName = string.match(productName, "^Treadmill_(.+)$")
	if treadmillName then
		return select(1, Treadmills.UpgradeForProduct(player, treadmillName))
	end

	local config = getProductConfig(productName)
	if string.match(productName, "^TemporarySpeedBoost_") then
		local duration = config and tonumber(config.TemporarySpeedBoostDurationSeconds) or 0
		return duration > 0 and grantTemporarySpeedBoost(player, duration)
	end

	if string.match(productName, "^TreadmillSpeed_") then
		local duration = config and tonumber(config.TreadmillSpeedEquivalentDurationSeconds) or 0
		return duration > 0 and grantTreadmillEquivalent(player, duration)
	end

	if string.match(productName, "^Instant Hatch") then
		local maximum = config and tonumber(config.EggSkipGrowthMaxRemainingSeconds) or math.huge
		if not Eggs.ApplySkipGrowthSelected(player, maximum) then
			warn(("[Purchases] Instant hatch receipt for %s had no selected growing egg"):format(player.Name))
		end
		return true
	end

	if productName == "EggGrowAll" then
		Eggs.ReadyAllPlaced(player)
		return true
	end

	if productName == "Limited Egg" then
		return select(1, Eggs.GrantEggs(player, 1, true))
	end
	local limitedCount = string.match(productName, "^Limited Egg x(%d+)$")
	if limitedCount then
		return select(1, Eggs.GrantEggs(player, tonumber(limitedCount) or 1, true))
	end
	
	if productName == "RebirthSkip" then
		local current = math.max(0, tonumber(profile.Rebirth) or 0)
		if current >= #RebirthDirectory then
			return true
		end
		Data.Update(player, {Rebirth = current + 1})
		return true
	end

	local luckMultiplier = string.match(productName, "^ServerLuck_X(%d+)$")
	if luckMultiplier then
		addServerLuck(tonumber(luckMultiplier) or 1, 15 * 60)
		return true
	end

	local luckMinutes = string.match(productName, "^ServerLuck_Extend(%d+)$")
	if luckMinutes then
		return extendServerLuck((tonumber(luckMinutes) or 0) * 60)
	end

	if productName == "InfiniteCash" then
		Data.AddMoney(player, 100000000000)
		return true
	end

	if productName == "InfiniteLuck" then
		addServerLuck(100, 99999999)
		return true
	end

	if productName == "InfiniteSpeed" then
		Data.Update(player, {SpeedPower = (tonumber(profile.SpeedPower) or 10) + 1000000000})
		return true
	end

	if productName == "BestEgg" then
		return grantCashGrabPet(player, "BestEgg")
	end

	local cashGrabName = string.match(productName, "^CashGrab_(.+)$")
	if cashGrabName then
		return grantCashGrabPet(player, cashGrabName)
	end

	warn(("[Purchases] No grant implementation for configured product %s"):format(productName))
	return false
end

local function canPurchaseProduct(player: Player, productId: any)
	if typeof(productId) ~= "number" then
		return false, "Invalid product."
	end
	local productName = productNameById[productId]
	local profile = Data.Get(player)
	if not productName then
		return false, "This product is not configured for this experience."
	end
	if not profile then
		return false, "Your data is still loading."
	end

	local trailName = string.match(productName, "^Trail_(.+)$")
	if trailName and profile.TrailInventory and profile.TrailInventory[trailName] then
		return false, "You already own this trail."
	end

	local treadmillName = string.match(productName, "^Treadmill_(.+)$")
	if treadmillName then
		return Treadmills.CanPurchaseUpgrade(player, treadmillName)
	end

	local luckMultiplier = string.match(productName, "^ServerLuck_X(%d+)$")
	if luckMultiplier and refreshServerLuck().Multiplier >= (tonumber(luckMultiplier) or 1) then
		return false, "The server already has equal or better luck."
	end
	if string.match(productName, "^ServerLuck_Extend") and refreshServerLuck().Multiplier <= 1 then
		return false, "Activate server luck before extending it."
	end

	return true
end

local function markReceiptProcessed(player: Player, purchaseId: string)
	local profile = Data.Get(player)
	if not profile then
		return
	end
	local processed = cloneDictionary(profile.ProcessedReceipts)
	processed[purchaseId] = os.time()
	Data.Update(player, {ProcessedReceipts = processed})
	if Data.SaveNow then
		Data.SaveNow(player)
	end
end

local function isReceiptProcessed(player: Player, purchaseId: string): boolean
	local profile = Data.Get(player)
	return profile ~= nil and profile.ProcessedReceipts ~= nil and profile.ProcessedReceipts[purchaseId] ~= nil
end

local function processReceipt(receiptInfo)
	local purchaseId = tostring(receiptInfo.PurchaseId)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player or not Data.Get(player) then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
	if isReceiptProcessed(player, purchaseId) then
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
	if processingReceipts[purchaseId] then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	local productName = productNameById[receiptInfo.ProductId]
	if not productName then
		warn(("[Purchases] Receipt references unconfigured product ID %s"):format(tostring(receiptInfo.ProductId)))
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	processingReceipts[purchaseId] = true
	local ok, granted = xpcall(function()
		return grantProduct(player, productName)
	end, debug.traceback)
	if ok and granted then
		markReceiptProcessed(player, purchaseId)
		Network.FireClient("Products: Receipt Processed", player, receiptInfo.ProductId)
		Network.FireClient("Products: Granted", player, receiptInfo.ProductId)
	end
	processingReceipts[purchaseId] = nil
	if not ok then
		warn(("[Purchases] Receipt %s failed: %s"):format(purchaseId, tostring(granted)))
	elseif not granted then
		warn(("[Purchases] Product %s could not be granted to %s"):format(productName, player.Name))
	end
	return if ok and granted then Enum.ProductPurchaseDecision.PurchaseGranted else Enum.ProductPurchaseDecision.NotProcessedYet
end

local function buildMappings()
	table.clear(productNameById)
	table.clear(gamepassNameById)
	for productName, productId in pairs(PurchaseIds.ProductIds) do
		assert(typeof(productName) == "string", "Product mapping names must be strings")
		if typeof(productId) ~= "number" or productId <= 0 then
			warn(("[Purchases] Skipping product %s – ID %s is not a positive number"):format(productName, tostring(productId)))
			continue
		end
		assert(productNameById[productId] == nil, ("Duplicate configured product ID %d"):format(productId))
		productNameById[productId] = productName
	end
	for gamepassName, gamepassId in pairs(PurchaseIds.GamepassIds) do
		assert(typeof(gamepassName) == "string", "Gamepass mapping names must be strings")
		if typeof(gamepassId) ~= "number" or gamepassId <= 0 then
			warn(("[Purchases] Skipping gamepass %s – ID %s is not a positive number"):format(gamepassName, tostring(gamepassId)))
			continue
		end
		assert(gamepassNameById[gamepassId] == nil, ("Duplicate configured gamepass ID %d"):format(gamepassId))
		gamepassNameById[gamepassId] = gamepassName
	end
end

local function refreshOwnedGamepasses(player: Player)
	local profile = Data.Get(player)
	if not profile then
		return
	end
	for gamepassName, gamepassId in pairs(PurchaseIds.GamepassIds) do
		if typeof(gamepassId) ~= "number" or gamepassId <= 0 then
			continue
		end
		task.spawn(function()
			local ok, owns = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, player.UserId, gamepassId)
			if ok and owns and player.Parent == Players then
				grantGamepass(player, gamepassName)
			end
		end)
	end
end

function Purchases.Init(dataService, eggService, treadmillService, activeAssetService)
	Data = dataService
	Eggs = eggService
	Treadmills = treadmillService
	ActiveAssets = activeAssetService
	buildMappings()

	if PurchaseIds.UsingPlaceholderIds then
		warn("[Purchases] Placeholder IDs are active. Replace them in ReplicatedStorage.PurchaseIdConfig before publishing.")
	end

	Network.BindFunction("Products: Request Server Test", function(player, productId)
		return canPurchaseProduct(player, productId)
	end)
	Network.BindFunction("Products: Request Prompt Purchase", function(player, productId)
		local allowed, message = canPurchaseProduct(player, productId)
		if not allowed then
			return false, message
		end
		local now = os.clock()
		if now - (lastPromptAt[player] or 0) < 1 then
			return false, "Please wait before opening another purchase."
		end
		lastPromptAt[player] = now
		local ok, err = pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, player, productId)
		if not ok then
			warn(("[Purchases] Prompt failed for %s: %s"):format(player.Name, tostring(err)))
			return false, "Roblox could not open the purchase prompt."
		end
		return true
	end)
	Network.BindFunction("Products: Whitelist Purchase", function(player, purchaseId, isProduct)
		if not RunService:IsStudio() then
			return false, "Whitelist grants only work in Studio."
		end
		if isProduct then
			local allowed, message = canPurchaseProduct(player, purchaseId)
			if not allowed then
				return false, message
			end
			local name = productNameById[purchaseId]
			return grantProduct(player, name)
		end
		local gamepassName = gamepassNameById[purchaseId]
		if not gamepassName then
			return false, "That gamepass is not configured."
		end
		return grantGamepass(player, gamepassName)
	end)
	Network.BindFunction("ServerLuck:GetState", function()
		return refreshServerLuck()
	end)

	MarketplaceService.ProcessReceipt = processReceipt
	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamepassId, purchased)
		if purchased and gamepassNameById[gamepassId] then
			grantGamepass(player, gamepassNameById[gamepassId])
		end
	end)

	Data.Loaded.Event:Connect(refreshOwnedGamepasses)
	Players.PlayerRemoving:Connect(function(player)
		lastPromptAt[player] = nil
	end)
	for _, player in ipairs(Players:GetPlayers()) do
		if Data.Get(player) then
			task.spawn(refreshOwnedGamepasses, player)
		end
	end

	task.spawn(function()
		while task.wait(1) do
			if serverLuck.Multiplier > 1 and serverLuck.EndsAt <= Workspace:GetServerTimeNow() then
				refreshServerLuck()
				publishServerLuck()
			end
		end
	end)
end

return Purchases
