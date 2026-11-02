-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local BaseUpgradeClient = require(ReplicatedStorage.Library.Client.BaseUpgradeClient)
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)
local GetOrCreateUIScale = require(ReplicatedStorage.Library.Functions.GetOrCreateUIScale)

require(ReplicatedStorage.Library.Types.GUI)

local LocalPlotUpgradeVisibility = require(ReplicatedStorage.Library.Client.LocalPlotUpgradeVisibility)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local Products = require(ReplicatedStorage.Directory.Products)

require(ReplicatedStorage.Directory.Products.Types.Interface)

local PromptPurchase = require(ReplicatedStorage.Library.Shared.Functions.PromptPurchase)
local Save = require(ReplicatedStorage.Library.Client.Save)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v1 = Color3.new(0.760784, 0, 0)
local v2 = TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local PlotUpgrade = ReplicatedStorage.Assets.UI.PlotUpgrade
local FirstUpgradeInfo = PlotUpgrade.FirstUpgradeInfo

assert(FirstUpgradeInfo:IsA("Frame"), "PlotUpgrade.FirstUpgradeInfo template must be a Frame")

local FirstUpgrade = PlotUpgrade.FirstUpgrade

assert(FirstUpgrade:IsA("ImageButton"), "PlotUpgrade.FirstUpgrade template must be an ImageButton")

local v5 = nil
local v6 = nil
local v7 = nil

local function getProductForLevel(p1) --[[ getProductForLevel | Line: 43 | Upvalues: Products (copy) ]]
	local v1 = ("BaseUpgradeTier%*"):format(p1)

	if Products.Types.ProductNameExists(v1) then
		return Products.Directory[v1]
	end

	return nil
end

local function refreshPlotUpgradeVisibility() --[[ refreshPlotUpgradeVisibility | Line: 49 | Upvalues: LocalPlotUpgradeVisibility (copy) ]]
	LocalPlotUpgradeVisibility.Refresh("PlotUpgrade")
end

local function bindLocalPlot() --[[ bindLocalPlot | Line: 53 | Upvalues: v5 (ref), PlotCmds (copy), v6 (ref), v7 (ref), Trove (copy), FirstUpgradeInfo (copy), FirstUpgrade (copy), GetOrCreateUIScale (copy), TweenService (copy), v2 (copy), Save (copy), BaseUpgradeClient (copy), v1 (copy), Simple (copy), ButtonFX (copy), Products (copy), PromptPurchase (copy) ]]
	if v5 ~= nil then
		v5:Destroy()
		v5 = nil
	end

	local v12 = PlotCmds.GetPlotData()

	if v12 == nil then
		return
	end

	local PlotFolder = v12.PlotFolder

	assert(PlotFolder:IsA("Model"), "Local plot folder must be a Model")

	local PlotUpgrade = PlotFolder:WaitForChild("PlotUpgrade")

	assert(PlotUpgrade:IsA("Model"), "PlotUpgrade must be a Model")

	local Sign = PlotUpgrade.Sign

	assert(Sign:IsA("BasePart"), "PlotUpgrade.Sign must be a BasePart")

	local CanUpgrade = Sign.CanUpgrade

	assert(CanUpgrade:IsA("BillboardGui"), "PlotUpgrade.Sign.CanUpgrade must be a BillboardGui")

	local SurfaceGui = Sign.SurfaceGui

	assert(SurfaceGui:IsA("SurfaceGui"), "PlotUpgrade.Sign.SurfaceGui must be a SurfaceGui")

	local Info = SurfaceGui.Info

	assert(Info:IsA("TextLabel"), "PlotUpgrade.Sign.SurfaceGui.Info must be a TextLabel")

	local Level = SurfaceGui.Level

	assert(Level:IsA("TextLabel"), "PlotUpgrade.Sign.SurfaceGui.Level must be a TextLabel")

	local Frame = SurfaceGui.Frame

	assert(Frame:IsA("GuiObject"), "PlotUpgrade.Sign.SurfaceGui.Frame must be a GuiObject")

	local Upgrade = Frame.Upgrade

	assert(Upgrade:IsA("GuiButton"), "Plot Upgrade must be a GuiButton")

	local RobuxUpgrade = Frame.RobuxUpgrade

	assert(RobuxUpgrade:IsA("GuiButton"), "Plot RobuxUpgrade must be a GuiButton")

	local Cost = Upgrade.Cost

	assert(Cost:IsA("TextLabel"), "Plot Upgrade.Cost must be a TextLabel")

	local UIGradient = Upgrade:FindFirstChildOfClass("UIGradient")

	if v6 == nil then
		v6 = Upgrade.BackgroundColor3
	end

	if UIGradient ~= nil and v7 == nil then
		v7 = UIGradient.Enabled
	end

	local v14 = assert(v6, "Plot Upgrade authored background color must be initialized")

	Upgrade.AutoButtonColor = false

	local v15 = Trove.new()
	local v16 = FirstUpgradeInfo:Clone()
	local Icon = v16.Icon

	assert(Icon:IsA("ImageLabel"), "Plot FirstUpgradeInfo.Icon must be an ImageLabel")

	local v18 = FirstUpgrade:Clone()
	local Cost2 = v18.Cost

	assert(Cost2:IsA("TextLabel"), "Plot FirstUpgrade.Cost must be a TextLabel")

	local ProgressFill = v18.ProgressFill

	assert(ProgressFill:IsA("Frame"), "Plot FirstUpgrade.ProgressFill must be a Frame")

	local UIGradient2 = v18.UIGradient

	assert(UIGradient2:IsA("UIGradient"), "Plot FirstUpgrade button gradient must be a UIGradient")

	local BackgroundColor3 = v18.BackgroundColor3
	local Enabled = UIGradient2.Enabled
	local Size = ProgressFill.Size

	v16.Visible = false
	v16.Parent = SurfaceGui
	v15:Add(v16)

	local v222 = GetOrCreateUIScale(Icon)

	v222.Scale = 0.8

	local v23 = TweenService:Create(v222, v2, {
		Scale = 1.3
	})

	v15:Add(v23)
	v23:Play()
	v18.Visible = false
	v18.AutoButtonColor = false
	v18.Parent = Frame
	v15:Add(v18)
	v5 = v15

	local function refresh() --[[ refresh | Line: 128 | Upvalues: Save (ref), Info (copy), Level (copy), v16 (copy), Upgrade (copy), v18 (copy), BaseUpgradeClient (ref), CanUpgrade (copy), v14 (copy), v1 (ref), UIGradient (copy), v7 (ref), BackgroundColor3 (copy), UIGradient2 (copy), Enabled (copy), Cost (copy), RobuxUpgrade (copy), Simple (ref), Cost2 (copy), ProgressFill (copy), Size (copy) ]]
		local v12 = Save.Get()

		assert(v12 ~= nil, "Plot upgrade UI requires loaded data")

		local isBaseUpgradeLevel = v12.BaseUpgradeLevel == 0

		Info.Visible = not isBaseUpgradeLevel
		Level.Visible = not isBaseUpgradeLevel
		v16.Visible = isBaseUpgradeLevel
		Upgrade.Visible = not isBaseUpgradeLevel
		v18.Visible = isBaseUpgradeLevel

		local v3, v4 = BaseUpgradeClient.GetNextConfig(v12)
		local v5 = BaseUpgradeClient.CanAffordNext(v12)

		CanUpgrade.Enabled = v5
		Upgrade.BackgroundColor3 = if v5 then v14 else v1

		if UIGradient ~= nil then
			UIGradient.Enabled = if v5 then v7 == true else v5
		end

		v18.BackgroundColor3 = if v5 then BackgroundColor3 else v1
		UIGradient2.Enabled = if v5 then Enabled else v5

		if v3 == nil or v4 == nil then
			Level.Text = "Level MAX"
			Cost.Text = "MAX"
		else
			Level.Text = ("Level %* > Level %*"):format(v12.BaseUpgradeLevel, v3)

			local v142 = "$" .. Simple.FormatCompact(v4.Cost, ".#")

			Cost.Text = v142
			Cost2.Text = v142
			assert(v4.Cost > 0, "Plot upgrade cost must be positive")
			ProgressFill.Size = UDim2.new(math.clamp(v12.Money / v4.Cost, 0, 1), Size.X.Offset, Size.Y.Scale, Size.Y.Offset)
		end

		RobuxUpgrade.Visible = false
	end

	v15:Add(ButtonFX(Upgrade, 1.05, BaseUpgradeClient.RequestCashUpgrade))
	v15:Add(ButtonFX(v18, 1.05, BaseUpgradeClient.RequestCashUpgrade))
	v15:Add(ButtonFX(RobuxUpgrade, 1.05, function() --[[ Line: 186 | Upvalues: Save (ref), BaseUpgradeClient (ref), Products (ref), PromptPurchase (ref) ]]
		local v1 = Save.Get()

		assert(v1 ~= nil, "Plot Robux upgrade requires loaded data")

		local v3, v4 = BaseUpgradeClient.GetNextConfig(v1)

		if v3 == nil or v4 == nil then
			return
		end

		local v5 = ("BaseUpgradeTier%*"):format(v3)
		local v6 = if Products.Types.ProductNameExists(v5) then Products.Directory[v5] else nil

		if v6 == nil then
			return
		end

		PromptPurchase.Prompt(v6.ProductId, true)
	end))
	v15:Add(Save.GetStatChangedSignal("BaseUpgradeLevel"):Connect(refresh))
	v15:Add(Save.GetStatChangedSignal("Money"):Connect(refresh))
	refresh()
end

if Save.IsLocalDataLoaded() then
	bindLocalPlot()
	LocalPlotUpgradeVisibility.Refresh("PlotUpgrade")
	PlotCmds.OnLocalPlotUpdated:Connect(function() --[[ Line: 212 | Upvalues: bindLocalPlot (copy), LocalPlotUpgradeVisibility (copy) ]]
		bindLocalPlot()
		LocalPlotUpgradeVisibility.Refresh("PlotUpgrade")
	end)
	PlotCmds.OnAnyPlotUpdated:Connect(refreshPlotUpgradeVisibility)
	PlotCmds.OnPlotsFolderUpdated:Connect(refreshPlotUpgradeVisibility)

	return
end

Save.LoadedStats:Wait()
bindLocalPlot()
LocalPlotUpgradeVisibility.Refresh("PlotUpgrade")
PlotCmds.OnLocalPlotUpdated:Connect(function() --[[ Line: 212 | Upvalues: bindLocalPlot (copy), LocalPlotUpgradeVisibility (copy) ]]
	bindLocalPlot()
	LocalPlotUpgradeVisibility.Refresh("PlotUpgrade")
end)
PlotCmds.OnAnyPlotUpdated:Connect(refreshPlotUpgradeVisibility)
PlotCmds.OnPlotsFolderUpdated:Connect(refreshPlotUpgradeVisibility)