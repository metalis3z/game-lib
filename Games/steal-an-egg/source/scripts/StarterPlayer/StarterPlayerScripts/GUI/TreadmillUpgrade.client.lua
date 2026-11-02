local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local MonetizationGamepassUtil = require(ReplicatedStorage.Library.Util.MonetizationGamepassUtil)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local Products = require(ReplicatedStorage.Directory.Products)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Client = require(script.Client)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)

require(ReplicatedStorage.Library.Types.GUI)

local UNAFFORDABLE_COLOR = Color3.new(0.760784, 0, 0)
local AFFORDABLE_COLOR = Color3.fromRGB(40, 200, 40)
local activeTrove = nil
local bindCount = 0

local function bindLocalPlot()
	bindCount += 1
	local currentBindId = bindCount

	if activeTrove ~= nil then
		activeTrove:Destroy()
		activeTrove = nil
	end

	local plotData = PlotCmds.GetPlotData()
	if plotData == nil then
		return
	end

	local PlotFolder = plotData.PlotFolder
	assert(PlotFolder:IsA("Model"), "Local plot folder must be a Model")

	local TreadmillUpgrade = PlotFolder:WaitForChild("TreadmillUpgrade")
	assert(TreadmillUpgrade:IsA("Model"), "TreadmillUpgrade must be a Model")

	local Sign = TreadmillUpgrade.Sign
	assert(Sign:IsA("BasePart"), "TreadmillUpgrade.Sign must be a BasePart")

	local CanUpgradeIndicator = Sign.CanUpgrade
	assert(CanUpgradeIndicator:IsA("BillboardGui"), "TreadmillUpgrade.Sign.CanUpgrade must be a BillboardGui")

	local SurfaceGui = Sign.SurfaceGui
	assert(SurfaceGui:IsA("SurfaceGui"), "TreadmillUpgrade.Sign.SurfaceGui must be a SurfaceGui")

	local LevelLabel = SurfaceGui.Level
	assert(LevelLabel:IsA("TextLabel"), "TreadmillUpgrade.Sign.SurfaceGui.Level must be a TextLabel")

	local Frame = SurfaceGui.Frame
	assert(Frame:IsA("GuiObject"), "TreadmillUpgrade.Sign.SurfaceGui.Frame must be a GuiObject")

	local UpgradeBtn = Frame.Upgrade
	assert(UpgradeBtn:IsA("GuiButton"), "Treadmill Upgrade must be a GuiButton")

	local RobuxUpgradeBtn = Frame.RobuxUpgrade
	assert(RobuxUpgradeBtn:IsA("GuiButton"), "Treadmill RobuxUpgrade must be a GuiButton")

	local UpgradeCostLabel = UpgradeBtn.Cost
	assert(UpgradeCostLabel:IsA("TextLabel"), "Treadmill Upgrade.Cost must be a TextLabel")

	local RobuxCostLabel = RobuxUpgradeBtn.Cost
	assert(RobuxCostLabel:IsA("TextLabel"), "Treadmill RobuxUpgrade.Cost must be a TextLabel")

	local UpgradeGradient = UpgradeBtn:FindFirstChildOfClass("UIGradient")
	-- We assume the gradient should always be enabled if they can afford it
	local defaultGradientEnabled = UpgradeGradient ~= nil 

	local newTrove = Trove.new()
	activeTrove = newTrove

	newTrove:Add(function()
		UpgradeBtn.BackgroundColor3 = AFFORDABLE_COLOR
		if UpgradeGradient ~= nil then
			UpgradeGradient.Enabled = defaultGradientEnabled
		end
	end)

	local function refresh()
		local playerData = Save.Get()
		assert(playerData ~= nil, "Treadmill upgrade UI requires loaded data")

		local nextLevel, nextConfig = Client.GetNextConfig(playerData)
		local canAfford = Client.CanAffordNext(playerData)

		CanUpgradeIndicator.Enabled = playerData.BaseUpgradeLevel > 0 and canAfford
		UpgradeBtn.BackgroundColor3 = if canAfford then AFFORDABLE_COLOR else UNAFFORDABLE_COLOR

		if UpgradeGradient ~= nil then
			UpgradeGradient.Enabled = if canAfford then defaultGradientEnabled else false
		end

		if nextConfig == nil then
			LevelLabel.Text = "Level MAX"
			UpgradeCostLabel.Text = "MAX"
			RobuxUpgradeBtn.Visible = false
			return
		end

		LevelLabel.Text = ("Level %d > Level %d"):format(playerData.TreadmillUpgradeLevel, nextLevel)
		UpgradeCostLabel.Text = "$" .. Simple.FormatCompact(nextConfig.Price, ".#")

		local productId = nextConfig.ProductId
		local hasProduct = productId ~= nil and Products.DataByProductId[productId] ~= nil

		RobuxUpgradeBtn.Visible = hasProduct
		RobuxCostLabel.Text = "\238\128\130"

		if not hasProduct then
			return
		end

		task.spawn(function()
			local priceInRobux = MonetizationGamepassUtil.GetProductPriceInRobux(productId)

			-- Cancel update if bind count changed, trove changed, or price is invalid
			if currentBindId ~= bindCount or activeTrove ~= newTrove or priceInRobux <= 0 then
				return
			end

			RobuxCostLabel.Text = ("\238\128\130 %s"):format(Simple.FormatCompact(priceInRobux, ".#"))
		end)
	end

	newTrove:Add(ButtonFX(UpgradeBtn, 1.05, Client.RequestCashUpgrade))
	newTrove:Add(ButtonFX(RobuxUpgradeBtn, 1.05, Client.PromptRobuxUpgrade))

	newTrove:Add(Save.GetStatChangedSignal("TreadmillUpgradeLevel"):Connect(refresh))
	newTrove:Add(Save.GetStatChangedSignal("BaseUpgradeLevel"):Connect(refresh))
	newTrove:Add(Save.GetStatChangedSignal("Money"):Connect(refresh))

	refresh()
end

-- Initialization
if Save.IsLocalDataLoaded() then
	bindLocalPlot()
	PlotCmds.OnLocalPlotUpdated:Connect(bindLocalPlot)
else
	Save.LoadedStats:Wait()
	bindLocalPlot()
	PlotCmds.OnLocalPlotUpdated:Connect(bindLocalPlot)
end