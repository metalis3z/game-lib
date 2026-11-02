local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)

require(ReplicatedStorage.Library.Modules.DefaultStats.Types.Interface)
require(ReplicatedStorage.Library.Types.GUI)

local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local GetPrice = require(ReplicatedStorage.Library.Functions.GetPrice)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Products = require(ReplicatedStorage.Directory.Products)
local Save = require(ReplicatedStorage.Library.Client.Save)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local Client = require(script.Parent.Parent.TreadmillUpgrade.Client)
local Treadmills = require(ReplicatedStorage.Directory.Treadmills)

local UNAFFORDABLE_COLOR = Color3.new(0.760784, 0, 0)
local ShopScrollingFrame = GUI.TreadmillSpeedShop().Frame.Main.ScrollingFrame
local ToggleShopButton = GUI.SideButtonTools().TreadmillSpeedShop.Button
local UpgradeTreadmillFrame = ShopScrollingFrame.UpgradeTreadmill
local PackFrame = UpgradeTreadmillFrame.Pack

-- Find the button container frame
local buttonFrame = nil
for _, child in ipairs(PackFrame:GetChildren()) do
	if child.Name == "Frame" and child:IsA("Frame") then
		assert(buttonFrame == nil, "Treadmill speed shop Pack must contain exactly one button Frame")
		buttonFrame = child
	end
end

assert(buttonFrame ~= nil, "Treadmill speed shop Pack.Frame button container is required")

local RobuxUpgradeBtn = buttonFrame.RobuxUpgrade
local UpgradeBtn = buttonFrame.Upgrade
local DefaultUpgradeColor = UpgradeBtn.BackgroundColor3
local UpgradeGradient = UpgradeBtn:FindFirstChildOfClass("UIGradient")
local defaultGradientEnabled = UpgradeGradient ~= nil and UpgradeGradient.Enabled or false

local updateCount = 0

local function getLoadedData()
	local playerData = Save.Get()
	assert(playerData ~= nil, "Treadmill speed shop requires loaded player data")
	return playerData
end

local function updateRobuxUpgradePrice(productId, currentCount)
	RobuxUpgradeBtn.Cost.Text = Constants.ROBUX_ICON_STR

	task.spawn(function()
		local price, success = GetPrice(productId, true)

		-- Ignore if a newer update request has been made
		if currentCount ~= updateCount then
			return
		end

		local priceText = if success then Simple.FormatCompact(price, ".#") else "???"
		RobuxUpgradeBtn.Cost.Text = ("%s %s"):format(Constants.ROBUX_ICON_STR, priceText)
	end)
end

local function refreshUpgrade(playerData, currentCount)
	local currentTreadmill = Treadmills.GetByUpgradeLevel(playerData.TreadmillUpgradeLevel)
	assert(currentTreadmill ~= nil, ("Invalid current treadmill level %d"):format(playerData.TreadmillUpgradeLevel))

	PackFrame.TreadmillIconCurrent.Image = currentTreadmill.Icon

	local _, nextTreadmillConfig = Client.GetNextConfig(playerData)

	if nextTreadmillConfig == nil then
		UpgradeTreadmillFrame.Visible = false
		return
	end

	UpgradeTreadmillFrame.Visible = true
	PackFrame.TreadmillIconNext.Image = nextTreadmillConfig.Icon
	UpgradeBtn.Cost.Text = "$" .. Simple.FormatCompact(nextTreadmillConfig.Price, ".#")

	local canAfford = Client.CanAffordNext(playerData)
	UpgradeBtn.BackgroundColor3 = if canAfford then DefaultUpgradeColor else UNAFFORDABLE_COLOR

	if UpgradeGradient ~= nil then
		UpgradeGradient.Enabled = if canAfford then defaultGradientEnabled else false
	end

	local productId = nextTreadmillConfig.ProductId
	local hasProduct = productId ~= nil and Products.DataByProductId[productId] ~= nil

	RobuxUpgradeBtn.Visible = hasProduct

	if hasProduct then
		updateRobuxUpgradePrice(productId, currentCount)
	end
end

local function refreshShop()
	updateCount += 1
	refreshUpgrade(getLoadedData(), updateCount)
end

-- Wait for data to load before initializing
if not Save.IsLocalDataLoaded() then
	Save.LoadedStats:Wait()
end

-- Button Connections
ButtonFX(ToggleShopButton, nil, function()
	TabController.ToggleTab("TreadmillSpeedShop")
end)
ButtonFX(UpgradeBtn, nil, Client.RequestCashUpgrade)
ButtonFX(RobuxUpgradeBtn, nil, Client.PromptRobuxUpgrade)

-- Event Connections
TabController.Opened:Connect(function(tabName)
	if tabName == "TreadmillSpeedShop" then
		refreshShop()
	end
end)

Save.GetStatChangedSignal("TreadmillUpgradeLevel"):Connect(function()
	if TabController.IsOpen("TreadmillSpeedShop") then
		refreshShop()
	end
end)

Save.GetStatChangedSignal("Money"):Connect(function()
	if TabController.IsOpen("TreadmillSpeedShop") then
		refreshShop()
	end
end)

refreshShop()