local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")

local Monetization = require(ReplicatedStorage:WaitForChild("Monetization"))
local MathUtility = require(ReplicatedStorage:WaitForChild("Math Utility"))

local uiSounds = ReplicatedStorage.Assets.Sounds:WaitForChild("UI", 30)
local localPlayer = Players.LocalPlayer
local knitServices = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services")
local monetizationRF = knitServices:WaitForChild("MonetizationService"):WaitForChild("RF")
local claimFreeAuraBoostRF = monetizationRF:WaitForChild("ClaimFreeAuraBoost")

local button = localPlayer:WaitForChild("PlayerGui"):WaitForChild("Hud", 30):WaitForChild("RightSide", 30):WaitForChild("AuraBoost", 30)
local rays = button:WaitForChild("Rays", 30)
local defaultSize = button.Size
local hoverSize = UDim2.fromScale(defaultSize.X.Scale * 1.1, defaultSize.Y.Scale * 1.1)
local pressedSize = UDim2.fromScale(defaultSize.X.Scale * 0.9, defaultSize.Y.Scale * 0.9)
local multiplierLabel = button:WaitForChild("Multiplier")
local priceLabel = button:WaitForChild("Price")
local defaultTextColor = multiplierLabel.TextColor3
local stroke = multiplierLabel:FindFirstChildOfClass("UIStroke")
local defaultStrokeColor = stroke and stroke.Color or Color3.fromRGB(0, 0, 0)

local hoverInfo = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local clickInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local isHovering = false
local spinSpeed = 30
local priceCache = {}
local freeRequirements = Monetization.FreeAuraBoostPlaytimeRequirements or {
	[1] = 90 * 60,
	[2] = 180 * 60,
	[3] = 270 * 60,
}

local tweens = {
	hoverIn = TweenService:Create(button, hoverInfo, { Size = hoverSize }),
	hoverOut = TweenService:Create(button, hoverInfo, { Size = defaultSize }),
	clickDown = TweenService:Create(button, clickInfo, { Size = pressedSize }),
	clickUpHover = TweenService:Create(button, hoverInfo, { Size = hoverSize }),
	clickUpOut = TweenService:Create(button, hoverInfo, { Size = defaultSize }),
	raysIn = TweenService:Create(rays, hoverInfo, {
		ImageTransparency = 0,
		ImageColor3 = Color3.fromRGB(255, 255, 255),
	}),
	raysOut = TweenService:Create(rays, hoverInfo, {
		ImageTransparency = 0.3,
	}),
}

local function getMaxAuraBoostValue()
	local maxBoost = 1
	for _, product in ipairs(Monetization.Products.AuraBoosts) do
		if typeof(product.Boost) == "number" and product.Boost > maxBoost then
			maxBoost = product.Boost
		end
	end
	return maxBoost
end

local MAX_AURA_BOOST = getMaxAuraBoostValue()

local function getProductPriceText(productId)
	if priceCache[productId] then
		return priceCache[productId]
	end

	local ok, productInfo = pcall(function()
		return MarketplaceService:GetProductInfo(productId, Enum.InfoType.Product)
	end)
	if not ok or not productInfo or typeof(productInfo.PriceInRobux) ~= "number" then
		priceCache[productId] = "ONLY \238\128\130?!"
		return priceCache[productId]
	end

	priceCache[productId] = "ONLY \238\128\130" .. tostring(productInfo.PriceInRobux) .. "!"
	return priceCache[productId]
end

local function getCurrentAuraBoost()
	return math.max(1, tonumber(localPlayer:GetAttribute("AuraBoost")) or 1)
end

local function getTimePlayed()
	return math.max(0, tonumber(localPlayer:GetAttribute("TimePlayed")) or 0)
end

local function getNextAuraBoostProduct(currentBoost)
	local bestIndex
	local bestProduct
	for index, product in ipairs(Monetization.Products.AuraBoosts or {}) do
		local boostValue = type(product) == "table" and tonumber(product.Boost) or nil
		if boostValue and boostValue > currentBoost then
			if not bestProduct or boostValue < (tonumber(bestProduct.Boost) or math.huge) then
				bestIndex = index
				bestProduct = product
			end
		end
	end
	return bestIndex, bestProduct
end

local function formatTimeRemaining(seconds)
	seconds = math.max(0, math.floor(seconds or 0))
	local hours = math.floor(seconds / 3600)
	local minutes = math.floor((seconds % 3600) / 60)
	local secs = seconds % 60
	if hours > 0 then
		return string.format("%d:%02d:%02d", hours, minutes, secs)
	end
	return string.format("%02d:%02d", minutes, secs)
end

local function setStrokeColor(color)
	if stroke then
		stroke.Color = color
	end
end

local function applyMultiplierStyle(index, product)
	multiplierLabel.Text = tostring(product.Boost) .. "X AURA"
	multiplierLabel.TextColor3 = defaultTextColor
	setStrokeColor(defaultStrokeColor)

	if index == 5 then
		multiplierLabel.Text = tostring(product.Boost) .. "X AURA 👑"
		multiplierLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
		setStrokeColor(Color3.fromRGB(255, 255, 255))
	elseif index == 4 then
		multiplierLabel.Text = tostring(product.Boost) .. "X AURA 🔥"
		multiplierLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
		setStrokeColor(Color3.fromRGB(61, 0, 0))
	elseif index == 3 then
		multiplierLabel.Text = tostring(product.Boost) .. "X AURA 😈"
		multiplierLabel.TextColor3 = Color3.fromRGB(170, 0, 255)
		setStrokeColor(Color3.fromRGB(0, 0, 0))
	elseif index == 2 then
		multiplierLabel.Text = tostring(product.Boost) .. "X AURA 💎"
	end
end

local function updateAuraBoostUI()
	local currentBoost = getCurrentAuraBoost()
	if currentBoost >= MAX_AURA_BOOST then
		multiplierLabel.Text = "MAX BOOST 👑"
		priceLabel.Text = "UNSTOPPABLE"
		multiplierLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
		setStrokeColor(Color3.fromRGB(255, 255, 255))
		spinSpeed = 60
		return
	end

	spinSpeed = 30
	local nextIndex, nextProduct = getNextAuraBoostProduct(currentBoost)
	if not nextProduct then
		return
	end

	applyMultiplierStyle(nextIndex, nextProduct)
	local requirement = freeRequirements[nextIndex]
	if requirement then
		local remaining = math.max(0, requirement - getTimePlayed())
		if remaining <= 0 then
			priceLabel.Text = "FREE"
		else
			priceLabel.Text = formatTimeRemaining(remaining)
		end
	else
		priceLabel.Text = getProductPriceText(nextProduct.Id)
	end
end

task.spawn(function()
	for _ = 1, 30 do
		updateAuraBoostUI()
		if localPlayer:GetAttribute("AuraBoost") ~= nil then
			break
		end
		task.wait(0.1)
	end
	while true do
		updateAuraBoostUI()
		task.wait(1)
	end
end)

localPlayer:GetAttributeChangedSignal("AuraBoost"):Connect(updateAuraBoostUI)
localPlayer:GetAttributeChangedSignal("TimePlayed"):Connect(updateAuraBoostUI)

RunService.RenderStepped:Connect(function(dt)
	if not button.Visible then
		return
	end
	rays.Rotation += spinSpeed * (isHovering and 3 or 1) * dt
end)

button.MouseEnter:Connect(function()
	isHovering = true
	uiSounds["UI Hover"]:Play()
	tweens.hoverIn:Play()
	tweens.raysIn:Play()
end)

button.MouseLeave:Connect(function()
	isHovering = false
	tweens.hoverOut:Play()
	tweens.raysOut:Play()
end)

button.MouseButton1Down:Connect(function()
	uiSounds["UI Click"]:Play()
	tweens.clickDown:Play()
end)

button.MouseButton1Up:Connect(function()
	local releaseTween = isHovering and tweens.clickUpHover or tweens.clickUpOut
	releaseTween:Play()

	local currentBoost = getCurrentAuraBoost()
	if currentBoost >= MAX_AURA_BOOST then
		return
	end

	local nextIndex, nextProduct = getNextAuraBoostProduct(currentBoost)
	if not nextProduct then
		return
	end

	local requirement = freeRequirements[nextIndex]
	if requirement then
		if getTimePlayed() < requirement then
			return
		end
		local ok, result = pcall(function()
			return claimFreeAuraBoostRF:InvokeServer(nextProduct.Id)
		end)
		if ok and type(result) == "table" and result.ok then
			updateAuraBoostUI()
		end
		return
	end

	if nextProduct.Id then
		Monetization.PromptProduct(nextProduct.Id)
	end
end)

ReplicatedStorage.Communication.ProductPurchased.OnClientEvent:Connect(function()
	ReplicatedStorage.Assets.Sounds["Purchasing SFX"]:Play()
	ReplicatedStorage.Assets.Sounds.SuccessSfx:Play()
	local _, nextProduct = getNextAuraBoostProduct(getCurrentAuraBoost())
	if nextProduct and nextProduct.Id then
		priceCache[nextProduct.Id] = nil
	end
	updateAuraBoostUI()
end)

priceLabel.Rotation = -8.5
TweenService:Create(priceLabel, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
	Rotation = 8.5,
}):Play()