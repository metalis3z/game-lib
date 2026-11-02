local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Updates = require(ReplicatedStorage.Shared.Updates)

local MerchShopData = {
	["CodeLength"] = 12,
	["CurrentShopItem"] = "Festive 67",
}

function MerchShopData.IsEnabled()
	local Enabled = FFlags:GetInstant("MerchShopEnabled", true)

	if Enabled then
		Enabled = Updates.Methods.IsEnabled("Update-12/13/2025")
	end

	return Enabled
end

local ShopItems = {
	["Festive 67"] = {
		["CommerceProductId"] = "COM-7003089990728810945",
		["DevProductId"] = 3477983793,
		["RewardType"] = "Brainrot",
		["RewardId"] = "Festive 67",
		["StockKey"] = "Festive 67",
		["InitialStock"] = 50000,
	}
}

ShopItems["Festive 67"].IsEnabled = function()
	local Enabled = FFlags:GetInstant("MerchShopEnabled", true)

	if Enabled then
		Enabled = Updates.Methods.IsEnabled("Update-12/13/2025")
	end

	if Enabled then
		Enabled = not FFlags:Get("MechShopSoldOut", false)
	end

	return Enabled
end

MerchShopData.Items = ShopItems

MerchShopData.TestProductInfo = {
	["Description"] = "Test description",
	["DisplayPrice"] = "$29.98",
	["IconImageAssetId"] = 0,
	["IsPurchasable"] = true,
}

for ItemName, ItemData in pairs(MerchShopData.Items) do
	ItemData.Name = ItemName
end

MerchShopData.CurrentItem = MerchShopData.Items[MerchShopData.CurrentShopItem]

return MerchShopData