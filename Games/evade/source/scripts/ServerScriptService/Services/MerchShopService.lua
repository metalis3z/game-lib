local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local FFlags = require(ReplicatedStorage.Packages.FFlags)
local Updates = require(ReplicatedStorage.Shared.Updates)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local Net = require(ReplicatedStorage.Packages.Net)

local NotificationEvent = Net:RemoteEvent("NotificationService/Notify")
local RedeemCode = Net:RemoteFunction("MerchShop/RedeemCode")
local StockUpdateEvent = Net:RemoteEvent("StockEventService/Update")

local MerchShopStockStore = DataStoreService:GetDataStore("MerchShopStock_v1")
local UsedCodesStore = DataStoreService:GetDataStore("UsedCodes_v1")

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

local FIREBASE_URL = "https://merch-codes-6f044-default-rtdb.firebaseio.com/"
local FIREBASE_SECRET = "mvlTGzZPgtuky94TmKoBObMfoM9ChUiVphouRMjT"

local Firebase = {}
function Firebase:Request(method, path, body)
	local url = FIREBASE_URL .. path .. ".json?auth=" .. FIREBASE_SECRET
	local success, response = pcall(function()
		return HttpService:RequestAsync({
			Url = url,
			Method = method,
			Headers = { ["Content-Type"] = "application/json" },
			Body = body and HttpService:JSONEncode(body) or nil
		})
	end)

	if not success or not response.Success then
		warn("[Firebase Error]", response and response.StatusCode or "Request failed")
		return nil
	end

	if response.Body and response.Body ~= "" and response.Body ~= "null" then
		return HttpService:JSONDecode(response.Body)
	end
	return nil
end

function Firebase:Get(path)
	return self:Request("GET", path)
end

function Firebase:Set(path, value)
	return self:Request("PUT", path, value)
end

function Firebase:Delete(path)
	return self:Request("DELETE", path)
end

local used_codes = {}
local success, data = pcall(function()
	return UsedCodesStore:GetAsync("AllUsed")
end)
if success and data then
	used_codes = HttpService:JSONDecode(data)
end

local function logRedeem(player, code, success)
	local status = success and "SUCCESS" or "FAILED"
	local logMsg = string.format(
		"[%s] Redeem Code - Player: %s (%d) | Date: %s",
		status,
		player.Name,
		player.UserId,
		os.date("%Y-%m-%d %H:%M:%S UTC")
	)
	print(logMsg)
end
local function saveUsedCodes()
	pcall(function()
		UsedCodesStore:SetAsync("AllUsed", HttpService:JSONEncode(used_codes))
	end)
end

function MerchShopService:GetStock(itemName)
	local stock = Firebase:Get("/stock/" .. itemName)
	if stock ~= nil then
		return stock
	end
	return Config.Items[itemName] and Config.Items[itemName].InitialStock or 0
end

function MerchShopService:SetStock(itemName, amount)
	Firebase:Set("/stock/" .. itemName, amount)
	StockUpdateEvent:FireAllClients(itemName, amount)
end

function MerchShopService:DecrementStock(itemName)
	local current = self:GetStock(itemName)
	if current > 0 then
		local newStock = current - 1
		self:SetStock(itemName, newStock)
		return true, newStock
	end
	return false, 0
end

function MerchShopService:AwardItem(player, itemName)
	if not Config.IsEnabled() then
		return false, "Shop disabled"
	end

	local item = Config.Items[itemName]
	if not item then
		return false, "Item not found"
	end

	if not item.IsEnabled() then
		return false, "Item unavailable"
	end

	local playerChannel = Synchronizer:Get(player)
	if not playerChannel then
		return false, "Profile not loaded"
	end

	local success, newStock = self:DecrementStock(itemName)
	if not success then
		return false, "Out of stock"
	end

	if item.RewardType == "Brainrot" then
		AnimalService.spawnAnimalInBase(player, item.RewardId, nil, nil)
	end

	return true, "Success", newStock
end

RedeemCode.OnServerInvoke = function(player, code)
	if not player or not code or typeof(code) ~= "string" then
		return {success = false}
	end

	local cleaned = code:lower():gsub("%s+", "")
	local checkUrl = "/codes/" .. cleaned

	local codeValue = Firebase:Get(checkUrl)
	if codeValue == nil then
		NotificationEvent:FireClient(player, "<font color='rgb(255,0,0)'>DLC Not Found</font>", 5, nil, "Bottom")
		return {success = false}
	end

	if codeValue == false then
		NotificationEvent:FireClient(player, "<font color='rgb(255,0,0)'>This code has already been used</font>", 5, nil, "Bottom")
		return {success = false}
	end

	local success, msg, newStock = MerchShopService:AwardItem(player, Config.CurrentShopItem)
	logRedeem(player, cleaned, Config.CurrentShopItem, success, msg)

	if success then
		Firebase:Set(checkUrl, false)
		NotificationEvent:FireClient(player, "<font color='rgb(0,255,0)'>Successfully Redeemed!</font>", 5, nil, "Bottom")
		return {success = true}
	else
		NotificationEvent:FireClient(player, "<font color='rgb(255,0,0)'>" .. (msg or "Failed to award item") .. "</font>", 5, nil, "Bottom")
		return {success = false}
	end
end

Players.PlayerAdded:Connect(function(player)
	task.delay(2, function()
		if player.Parent then
			local stock = MerchShopService:GetStock("Festive 67")
			StockUpdateEvent:FireClient(player, "Festive 67", stock)
		end
	end)
end)

function MerchShopService:Start()
	game:GetService("MarketplaceService").ProcessReceipt = function(receiptInfo)
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
end

return MerchShopService