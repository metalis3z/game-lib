local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Updates = require(ReplicatedStorage.Shared.Updates)
local PlotService = require(ServerScriptService.Services.PlotService)

local MerchShopStockStore = DataStoreService:GetDataStore("MerchShopStock_v1")

local MerchShopService = {}

local Config = {
	CodeLength = 12,
	CurrentShopItem = "Festive 67",
	Items = {
		["Festive 67"] = {
			CommerceProductId = "COM-7003089990728810945",
			DevProductId = 3477983793,
			RewardType = "Brainrot",
			RewardId = "Festive 67",
			StockKey = "Festive 67",
			InitialStock = 50000
		}
	},
	TestProductInfo = {
		Description = "Test description",
		DisplayPrice = "$29.98",
		IconImageAssetId = 0,
		IsPurchasable = true
	}
}

Config.IsEnabled = function()
	local enabled = FFlags:GetInstant("MerchShopEnabled", true)
	if enabled then
		enabled = Updates.Methods.IsEnabled("Update-12/13/2025")
	end
	return enabled
end

Config.Items["Festive 67"].IsEnabled = function()
	local enabled = FFlags:GetInstant("MerchShopEnabled", true)
	if enabled then
		enabled = Updates.Methods.IsEnabled("Update-12/13/2025")
	end
	if enabled then
		enabled = not FFlags:GetInstant("MechShopSoldOut", false)
	end
	return enabled
end

for itemName, itemData in pairs(Config.Items) do
	itemData.Name = itemName
end

Config.CurrentItem = Config.Items[Config.CurrentShopItem]

function MerchShopService:GetStock(itemName)
	local success, stock = pcall(function()
		return MerchShopStockStore:GetAsync(itemName)
	end)

	if success and stock then
		return stock
	else
		local itemConfig = Config.Items[itemName]
		if itemConfig then
			return itemConfig.InitialStock
		end
		return 0
	end
end

function MerchShopService:SetStock(itemName, amount)
	local success = pcall(function()
		MerchShopStockStore:SetAsync(itemName, amount)
	end)
	return success
end

function MerchShopService:DecrementStock(itemName)
	local currentStock = self:GetStock(itemName)
	if currentStock > 0 then
		local newStock = currentStock - 1
		self:SetStock(itemName, newStock)
		return true, newStock
	end
	return false, 0
end

function MerchShopService:AwardItem(player, itemName)
	if not Config.IsEnabled() then
		return false, "Merch shop is currently disabled"
	end

	local itemConfig = Config.Items[itemName]
	if not itemConfig then
		return false, "Item does not exist"
	end

	if not itemConfig.IsEnabled() then
		return false, "Item is not available for purchase"
	end

	local currentStock = self:GetStock(itemName)
	if currentStock <= 0 then
		return false, "Item is out of stock"
	end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return false, "Profile not loaded"
	end

	local success, newStock = self:DecrementStock(itemName)
	if not success then
		return false, "Failed to decrement stock"
	end

	if itemConfig.RewardType == "Brainrot" then
		PlotService.AddAnimalOnPlotOrQueue(player, itemConfig.RewardId, nil, nil)
	end

	return true, "Item purchased successfully"
end

function MerchShopService:ProcessReceipt(receiptInfo)
	local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	for itemName, itemConfig in pairs(Config.Items) do
		if itemConfig.DevProductId == receiptInfo.ProductId then
			local success, message = self:AwardItem(player, itemName)
			if success then
				return Enum.ProductPurchaseDecision.PurchaseGranted
			else
				warn("Failed to award merch shop item:", message)
				return Enum.ProductPurchaseDecision.NotProcessedYet
			end
		end
	end

	return Enum.ProductPurchaseDecision.NotProcessedYet
end
function MerchShopService:Start()
	-- ProcessReceipt géré par ShopService
end
return MerchShopService