--!strict
-- LOCATION: StarterPlayerScripts/OfflineUIController

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")

local NumberFormatter = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("NumberFormatter"))
local ProductConfigurations = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ProductConfigurations"))
local FrameManager = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("FrameManager"))

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Events = ReplicatedStorage:WaitForChild("Events")
local ShowOfflineEarnings = Events:WaitForChild("ShowOfflineEarnings")
local ClaimOfflineEarnings = Events:WaitForChild("ClaimOfflineEarnings")
local HideOfflineUI = Events:WaitForChild("HideOfflineUI")

local gui = playerGui:WaitForChild("GUI")
local frames = gui:WaitForChild("Frames")
local offlineFrame = frames:WaitForChild("Offline")

local imageFrame = offlineFrame:WaitForChild("Image")
local amountLabel = imageFrame:WaitForChild("Amount") :: TextLabel

local buttonsFrame = offlineFrame:WaitForChild("Buttons")
local claimBtn = buttonsFrame:WaitForChild("Claim") :: TextButton
local doubleBtn = buttonsFrame:WaitForChild("Double") :: TextButton

local doubleText = doubleBtn:WaitForChild("Text") :: TextLabel
local doublePrice = doubleBtn:WaitForChild("Price") :: TextLabel

local DOUBLE_PRODUCT_ID = ProductConfigurations.Products["DoubleOffline"] or 0

local function setupButtonAnimation(button: GuiButton)
	local uiScale = button:FindFirstChildOfClass("UIScale")
	if not uiScale then
		uiScale = Instance.new("UIScale")
		uiScale.Name = "AnimationScale"
		uiScale.Parent = button
	end

	local TWEEN_INFO = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	button.MouseEnter:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = 1.05}):Play() end)
	button.MouseLeave:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = 1}):Play() end)
	button.MouseButton1Down:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = 0.95}):Play() end)
	button.MouseButton1Up:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = 1.05}):Play() end)
end

setupButtonAnimation(claimBtn)
setupButtonAnimation(doubleBtn)

ShowOfflineEarnings.OnClientEvent:Connect(function(amount: number)
	amountLabel.Text = "$" .. NumberFormatter.Format(amount)
	doubleText.Text = "X2 ($" .. NumberFormatter.Format(amount * 2) .. ")"

	if DOUBLE_PRODUCT_ID > 0 then
		task.spawn(function()
			local success, info = pcall(function()
				return MarketplaceService:GetProductInfo(DOUBLE_PRODUCT_ID, Enum.InfoType.Product)
			end)
			if success and info then
				doublePrice.Text = "Only " .. tostring(info.PriceInRobux)
			else
				doublePrice.Text = "Only ?"
			end
		end)
	else
		doublePrice.Text = "Only ?"
	end

	if FrameManager.open then
		FrameManager.open("Offline")
	else
		offlineFrame.Visible = true
	end
end)

claimBtn.MouseButton1Click:Connect(function()
	ClaimOfflineEarnings:FireServer()

	if FrameManager.close then
		FrameManager.close("Offline")
	else
		offlineFrame.Visible = false
	end
end)

doubleBtn.MouseButton1Click:Connect(function()
	if DOUBLE_PRODUCT_ID > 0 then
		MarketplaceService:PromptProductPurchase(player, DOUBLE_PRODUCT_ID)
	end
end)

HideOfflineUI.OnClientEvent:Connect(function()
	if FrameManager.close then
		FrameManager.close("Offline")
	else
		offlineFrame.Visible = false
	end
end)