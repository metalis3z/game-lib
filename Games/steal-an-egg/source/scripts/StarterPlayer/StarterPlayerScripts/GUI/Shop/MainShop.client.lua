local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local GUI = require(ReplicatedStorage.Library.Client.GUI)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local Products = require(ReplicatedStorage.Directory.Products)
local Gamepasses = require(ReplicatedStorage.Directory.Gamepasses)
local GetPrice = require(ReplicatedStorage.Library.Functions.GetPrice)
local Lock = require(ReplicatedStorage.Library.Functions.Lock)
local ClientProducts = require(ReplicatedStorage.Library.Client.Products)
local ClientGamepasses = require(ReplicatedStorage.Library.Client.Gamepasses)
local Message = require(ReplicatedStorage.Library.Client.Message)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Network = require(ReplicatedStorage.Library.Client.Network)
local Asserts = require(ReplicatedStorage.Library.Asserts)

local LocalPlayer = Players.LocalPlayer
local ScrollingFrame = GUI.Shop().Frame.Main.ScrollingFrame
local MoneyTop = ScrollingFrame.MoneyTop
local MoneyBottom = ScrollingFrame.MoneyBottom
local GamePassesContainer = ScrollingFrame.GamePasses
local ShopToggleButton = GUI.SideButtonTools().Shop.Button
local actionLock = Lock()

local function mapProductEntry(frame, productData)
	Asserts.table(productData)
	Asserts.number(productData.ProductId)

	local buyButton = frame.Buy
	local priceLabel = buyButton.Price

	assert(if buyButton then buyButton:IsA("GuiButton") else buyButton, "Expected Buy to be a GuiButton")
	assert(if priceLabel then priceLabel:IsA("TextLabel") else priceLabel, "Expected Price to be a TextLabel")

	return {
		frame = frame,
		button = buyButton,
		priceLabel = priceLabel,
		productId = productData.ProductId
	}
end

local moneyProductEntries = {
	mapProductEntry(MoneyTop["1"], Products.Directory.Money_24000),
	mapProductEntry(MoneyTop["2"], Products.Directory.Money_200000),
	mapProductEntry(MoneyTop["3"], Products.Directory.Money_800000),
	mapProductEntry(MoneyBottom["1"], Products.Directory.Money_4000000),
	mapProductEntry(MoneyBottom["2"], Products.Directory.Money_8000000)
}

local function mapGamepassEntry(frame, gamepassData)
	local mainButton = frame.Main
	local priceFrame = mainButton.Price
	local priceText = priceFrame.PriceText

	assert(if mainButton then mainButton:IsA("GuiButton") else mainButton, "Expected Main to be a GuiButton")
	assert(if priceFrame then priceFrame:IsA("Frame") else priceFrame, "Expected Price to be a Frame")
	assert(if priceText then priceText:IsA("TextLabel") else priceText, "Expected PriceText to be a TextLabel")
	Asserts.table(gamepassData)
	Asserts.string(gamepassData._id)
	Asserts.number(gamepassData.ProductId)

	return {
		button = mainButton,
		priceLabel = priceText,
		gamepassId = gamepassData._id,
		productId = gamepassData.ProductId
	}
end

local gamepassEntries = {
	mapGamepassEntry(GamePassesContainer.x2Money, Gamepasses.Directory.X2Money),
	mapGamepassEntry(GamePassesContainer.x2Growth, Gamepasses.Directory.X2Growth)
}

local function updateGamepassPrice(entry)
	local price, success = GetPrice(entry.productId, false)

	if not success then
		entry.priceLabel.Text = "Loading..."
		return
	end

	entry.priceLabel.Text = if ClientGamepasses.Owns(entry.gamepassId) then "OWNED" else "\238\128\130" .. tostring(price)
end

local function bindGamepassButton(entry)
	ButtonFX(entry.button, 1.08, function()
		actionLock(function()
			if ClientGamepasses.Owns(entry.gamepassId) then
				Message.New("You already own this!")
			else
				PromptPurchase.Prompt(entry.productId, false)
			end
		end)
	end)
end

local function updateProductPrice(entry)
	local price, success = GetPrice(entry.productId, true)

	if not success then
		entry.priceLabel.Text = "Loading..."
		return
	end

	entry.priceLabel.Text = if ClientProducts.Owns(entry.productId) then "OWNED" else "\238\128\130" .. tostring(price)
end

local function bindProductButton(entry)
	ButtonFX(entry.button, nil, function()
		actionLock(function()
			if ClientProducts.Owns(entry.productId) then
				Message.New("You already own this item!")
			else
				PromptPurchase.Prompt(entry.productId, true)
			end
		end)
	end)
end

local function updateAllProducts()
	for _, entry in moneyProductEntries do
		task.spawn(updateProductPrice, entry)
	end
end

local function updateAllGamepasses()
	for _, entry in gamepassEntries do
		task.spawn(updateGamepassPrice, entry)
	end
end

-- Initialize Products
for _, entry in moneyProductEntries do
	task.spawn(updateProductPrice, entry)
	bindProductButton(entry)
end

-- Initialize Gamepasses
for _, entry in gamepassEntries do
	task.spawn(updateGamepassPrice, entry)
	bindGamepassButton(entry)
end

-- UI Events
ButtonFX(ShopToggleButton, nil, function()
	TabController.ToggleTab("Shop")
end)

TabController.Opened:Connect(function(tabName)
	if tabName ~= "Shop" then
		return
	end

	updateAllProducts()
	updateAllGamepasses()
end)

-- Data Loading Events
if Save.IsLocalDataLoaded() then
	task.spawn(function()
		updateAllProducts()
		updateAllGamepasses()
	end)
end

Save.LoadedStats:Connect(function(player)
	if player ~= LocalPlayer then
		return
	end

	updateAllProducts()
end)

Save.ConnectForDataChanged("Products", updateAllProducts)
Save.ConnectForDataChanged("Gamepasses", updateAllGamepasses)
Network.Fired(Network.NET_MAP.Gamepasses.GRANTED):Connect(updateAllGamepasses)