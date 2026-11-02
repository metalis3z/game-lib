-- Cash shop purchases are mapped by button name in Data.ProductConfig.
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ProductConfig = require(ReplicatedStorage.Data.ProductConfig)
local LocalPlayer = Players.LocalPlayer
local cash = script.Parent
local ROBUX = string.char(238, 128, 130)

local wired = {}

local function connectBuy(guiButton, product)
	if wired[guiButton] then
		return
	end

	wired[guiButton] = true
	guiButton.Active = true
	guiButton.Activated:Connect(function()
		if product.enabled then
			MarketplaceService:PromptProductPurchase(LocalPlayer, product.id)
		end
	end)
end

local function wire(button, productKey)
	local product = ProductConfig.Products[productKey]
	if not product then
		warn(("[CashShop] Unknown product key '%s' for %s"):format(tostring(productKey), button:GetFullName()))
		return
	end

	button:SetAttribute("ProductKey", productKey)
	button:SetAttribute("ProductId", product.id)

	connectBuy(button, product)
	for _, descendant in ipairs(button:GetDescendants()) do
		if descendant:IsA("GuiButton") then
			connectBuy(descendant, product)
		end
	end

	task.spawn(function()
		local ok, info = pcall(function()
			return MarketplaceService:GetProductInfo(product.id, Enum.InfoType.Product)
		end)
		if not (ok and info) then
			return
		end

		local price = button:FindFirstChild("unlockrs")
		if price and (price:IsA("TextButton") or price:IsA("TextLabel")) then
			price.Text = ROBUX .. tostring(info.PriceInRobux or 0)
		end

		local icon = button:FindFirstChild("ImageLabel")
		if icon and icon:IsA("ImageLabel") and info.IconImageAssetId and info.IconImageAssetId > 0 then
			icon.Image = "rbxassetid://" .. tostring(info.IconImageAssetId)
		end
	end)
end

local function wireByName(button)
	local productKey = ProductConfig.ShopButtons[button.Name] or button:GetAttribute("ProductKey")
	if productKey then
		wire(button, productKey)
	end
end

for buttonName, productKey in pairs(ProductConfig.ShopButtons) do
	local button = cash:FindFirstChild(buttonName)
	if button and button:IsA("ImageButton") then
		wire(button, productKey)
	else
		warn(("[CashShop] Missing ImageButton '%s'"):format(buttonName))
	end
end

cash.ChildAdded:Connect(function(child)
	if child:IsA("ImageButton") then
		wireByName(child)
	end
end)
