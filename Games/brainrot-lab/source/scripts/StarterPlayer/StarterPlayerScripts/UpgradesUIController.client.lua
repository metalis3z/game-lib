--!strict
-- LOCATION: StarterPlayerScripts/UpgradesUIController

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")

local NumberFormatter = require(ReplicatedStorage.Modules.NumberFormatter)
local UpgradesConfiguration = require(ReplicatedStorage.Modules.UpgradesConfiguration)

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Templates = ReplicatedStorage:WaitForChild("Templates")
local UpgradeTemplate = Templates:WaitForChild("UpgradeTemplate") 
local Events = ReplicatedStorage:WaitForChild("Events")

local PurchaseEvent = Events:WaitForChild("PurchaseUpgrade")
local UpdateEvent = Events:WaitForChild("UpdateUpgradesUI") 

local mainGui = playerGui:WaitForChild("GUI")
local upgradesFrame = mainGui:WaitForChild("Frames"):WaitForChild("Upgrades")
local scrolling = upgradesFrame:WaitForChild("Scrolling")

-- Animation Config
local HOVER_SCALE = 1.05
local CLICK_SCALE = 0.95
local TWEEN_INFO = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- State tracking
local uiReferences = {} 

print("[UpgradesUIController] Loaded (Simplified Configuration)")

local function setupButtonAnimation(button: GuiButton)
	local uiScale = button:FindFirstChildOfClass("UIScale")
	if not uiScale then
		uiScale = Instance.new("UIScale"); uiScale.Name = "AnimationScale"; uiScale.Parent = button
	end
	button.MouseEnter:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = HOVER_SCALE}):Play() end)
	button.MouseLeave:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = 1}):Play() end)
	button.MouseButton1Down:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = CLICK_SCALE}):Play() end)
	button.MouseButton1Up:Connect(function() TweenService:Create(uiScale, TWEEN_INFO, {Scale = HOVER_SCALE}):Play() end)
end

local function findTextLabel(parent: Instance): TextLabel?
	local label = parent:FindFirstChild("Text")
	if label and label:IsA("TextLabel") then return label end
	return parent:FindFirstChildWhichIsA("TextLabel", true)
end

local function createUpgradeOption(upgradeType: string, title: string, imageId: string, robuxProductId: number?)
	local template = UpgradeTemplate:Clone() 
	local refId = upgradeType
	template.Name = refId
	template.Parent = scrolling
	template.Visible = true

	local titleLabel = template:FindFirstChild("Text") :: TextLabel
	if titleLabel then titleLabel.Text = "+1 " .. title end

	-- Apply the custom image from the config
	local designFolder = template:FindFirstChild("Design")
	if designFolder then
		local imgLabel = designFolder:FindFirstChild("Image") or designFolder:FindFirstChild("image") :: ImageLabel
		if imgLabel and imgLabel:IsA("ImageLabel") then
			imgLabel.Image = imageId
		end
	end

	local btnContainer = template:FindFirstChild("Buttons")
	local moneyBtn = btnContainer and btnContainer:FindFirstChild("Money") :: TextButton
	local moneyPriceLabel = nil

	if moneyBtn then
		moneyPriceLabel = findTextLabel(moneyBtn)
		setupButtonAnimation(moneyBtn)
		moneyBtn.MouseButton1Click:Connect(function()
			PurchaseEvent:FireServer(upgradeType, 1) 
		end)
	end

	-- [[ ROBUX BUTTON LOGIC ]] --
	local robuxBtn = btnContainer and btnContainer:FindFirstChild("Robux") :: TextButton
	if robuxBtn then
		if robuxProductId then
			robuxBtn.Visible = true
			setupButtonAnimation(robuxBtn)

			local robuxPriceLabel = findTextLabel(robuxBtn)
			if robuxPriceLabel then
				task.spawn(function()
					local success, info = pcall(function()
						return MarketplaceService:GetProductInfo(robuxProductId, Enum.InfoType.Product)
					end)
					if success and info then
						robuxPriceLabel.Text = "" .. tostring(info.PriceInRobux)
					end
				end)
			end

			robuxBtn.MouseButton1Click:Connect(function()
				MarketplaceService:PromptProductPurchase(player, robuxProductId)
			end)
		else
			robuxBtn.Visible = false
		end
	end

	local statsFrame = template:FindFirstChild("Stats")
	local beforeLabel = statsFrame and findTextLabel(statsFrame:FindFirstChild("Before"))
	local afterLabel = statsFrame and findTextLabel(statsFrame:FindFirstChild("After"))

	uiReferences[refId] = {
		Type = upgradeType,
		MoneyPriceLabel = moneyPriceLabel,
		BeforeLabel = beforeLabel,
		AfterLabel = afterLabel
	}
end

local function onServerUpdate(data: any)
	-- Dynamically update all UI elements based on the data packet
	for upgradeType, upgradeData in pairs(data) do
		local ref = uiReferences[upgradeType]

		if ref then
			-- ## ADDED: UI Logic to visually cap CarryCapacity at 3
			if upgradeType == "CarryCapacity" and upgradeData.Current >= 3 then
				if ref.MoneyPriceLabel then ref.MoneyPriceLabel.Text = "MAX" end
				if ref.BeforeLabel then ref.BeforeLabel.Text = tostring(upgradeData.Current) end
				if ref.AfterLabel then ref.AfterLabel.Text = "MAX" end
			else
				if ref.MoneyPriceLabel then ref.MoneyPriceLabel.Text = "$" .. NumberFormatter.Format(upgradeData.Cost) end
				if ref.BeforeLabel then ref.BeforeLabel.Text = tostring(upgradeData.Current) end
				if ref.AfterLabel then ref.AfterLabel.Text = tostring(upgradeData.Current + 1) end
			end
		end
	end
end

-- 1. Clear template placeholders
for _, child in ipairs(scrolling:GetChildren()) do
	if child:IsA("Frame") then child:Destroy() end
end

-- 2. Dynamically Generate UI from Configuration
for upgradeType, config in pairs(UpgradesConfiguration.Upgrades) do
	createUpgradeOption(upgradeType, config.DisplayName, config.ImageId, config.RobuxProductId)
end

UpdateEvent.OnClientEvent:Connect(onServerUpdate)
UpdateEvent:FireServer()