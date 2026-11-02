-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
require(ReplicatedStorage.Client.Types.GUI)
local MonetizationEntitlements = require(ReplicatedStorage.Shared.Util.MonetizationEntitlements)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Products = require(ReplicatedStorage.Data.Products)
local Save = require(ReplicatedStorage.Shared.Save)
local Client = require(script.Client)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = Color3.new(0.760784, 0, 0)
local v2
local v3 = 0
local bindLocalPlot

local function bindLocalPlot_2() -- line 19 | captures: v2, v3, ButtonFX, Simple, MonetizationEntitlements, PlotState, Products, Save, Client, Trove, v1, bindLocalPlot
    v3 += 1
    local v4 = v3
    if v2 ~= nil then
        v2:Destroy()
        v2 = nil
    end
    local v5 = PlotState.ResolvePlot()
    if v5 == nil then
        return
    end
    local PlotFolder = v5.PlotFolder
    local Model = PlotFolder:IsA("Model")
    assert(Model, "Local plot folder must be a Model")
    local TreadmillUpgrade = PlotFolder:WaitForChild("TreadmillUpgrade")
    local Model_2 = TreadmillUpgrade:IsA("Model")
    assert(Model_2, "TreadmillUpgrade must be a Model")
    local Sign = TreadmillUpgrade.Sign
    local BasePart = Sign:IsA("BasePart")
    assert(BasePart, "TreadmillUpgrade.Sign must be a BasePart")
    local CanUpgrade = Sign.CanUpgrade
    local BillboardGui = CanUpgrade:IsA("BillboardGui")
    assert(BillboardGui, "TreadmillUpgrade.Sign.CanUpgrade must be a BillboardGui")
    local SurfaceGui = Sign.SurfaceGui
    local SurfaceGui_2 = SurfaceGui:IsA("SurfaceGui")
    assert(SurfaceGui_2, "TreadmillUpgrade.Sign.SurfaceGui must be a SurfaceGui")
    local Level = SurfaceGui.Level
    local TextLabel = Level:IsA("TextLabel")
    assert(TextLabel, "TreadmillUpgrade.Sign.SurfaceGui.Level must be a TextLabel")
    local Frame = SurfaceGui.Frame
    local GuiObject = Frame:IsA("GuiObject")
    assert(GuiObject, "TreadmillUpgrade.Sign.SurfaceGui.Frame must be a GuiObject")
    local Upgrade = Frame.Upgrade
    local GuiButton = Upgrade:IsA("GuiButton")
    assert(GuiButton, "Treadmill Upgrade must be a GuiButton")
    local RobuxUpgrade = Frame.RobuxUpgrade
    local GuiButton_2 = RobuxUpgrade:IsA("GuiButton")
    assert(GuiButton_2, "Treadmill RobuxUpgrade must be a GuiButton")
    local Cost = Upgrade.Cost
    local TextLabel_2 = Cost:IsA("TextLabel")
    assert(TextLabel_2, "Treadmill Upgrade.Cost must be a TextLabel")
    local Cost_2 = RobuxUpgrade.Cost
    local TextLabel_3 = Cost_2:IsA("TextLabel")
    assert(TextLabel_3, "Treadmill RobuxUpgrade.Cost must be a TextLabel")
    local BackgroundColor3 = Upgrade.BackgroundColor3
    local UIGradient = Upgrade:FindFirstChildOfClass("UIGradient")
    local v6 = if UIGradient == nil then false else UIGradient.Enabled
    local v7 = Trove.new()
    local v8 = {}
    local v9 = utf8.char(57346)
    v2 = v7
    v7:Add(function() -- line 73 | captures: v6, Upgrade, BackgroundColor3, UIGradient
        Upgrade.BackgroundColor3 = BackgroundColor3
        if UIGradient ~= nil then
            UIGradient.Enabled = v6
        end
    end)

    local function refresh() -- line 79 | captures: v6, v4, CanUpgrade, Level, Upgrade, RobuxUpgrade, Cost, Cost_2, BackgroundColor3, UIGradient, v7, v8, v9, v2, v3, Simple, MonetizationEntitlements, Products, Save, Client, v1
        local v10 = Save.Get()
        local v11 = v10 ~= nil
        assert(v11, "Treadmill upgrade UI requires loaded data")
        local v12, v13 = Client.GetNextConfig(v10)
        local v14 = Client.CanAffordNext(v10)
        local v15 = if v10.BaseUpgradeLevel > 0 then v14 else false
        CanUpgrade.Enabled = v15
        local v16 = if v14 then BackgroundColor3 else v1
        Upgrade.BackgroundColor3 = v16
        if UIGradient ~= nil then
            local v17 = v14 and v6
            UIGradient.Enabled = v17
        end
        if v13 == nil then
            Level.Text = "Level MAX"
            Cost.Text = "MAX"
            RobuxUpgrade.Visible = false
        else
            Level.Text = ("Level %* > Level %*"):format(v10.TreadmillUpgradeLevel, v12)
            Cost.Text = "$" .. Simple.FormatCompact(v13.Price, ".#")
            local ProductId = v13.ProductId
            local v18 = if ProductId == nil then false else Products.DataByProductId[ProductId] ~= nil
            RobuxUpgrade.Visible = v18
            Cost_2.Text = "\238\128\130"
            local v19
            if ProductId == nil then
            else
                v19 = v8[ProductId]
            end
            if type(v19) == "number" and v19 > 0 then
                Cost_2.Text = ("%* %*"):format(v9, (Simple.FormatCompact(v19, ".#")))
            end
            if ProductId ~= nil and RobuxUpgrade.Visible and v19 == nil then
                v8[ProductId] = false
                task.spawn(function() -- line 119 | captures: ProductId, v4, Cost_2, v7, v8, v2, v3, Simple, MonetizationEntitlements
                    local v20 = MonetizationEntitlements.ProductPrice(ProductId)
                    v8[ProductId] = v20
                    if v4 == v3 and v2 == v7 and v20 > 0 then
                        Cost_2.Text = ("\238\128\130 %*"):format((Simple.FormatCompact(v20, ".#")))
                    end
                end)
            end
        end
    end

    v7:Add(PlotFolder.Destroying:Connect(function() -- line 131 | captures: bindLocalPlot
        task.defer(bindLocalPlot)
    end))
    v7:Add(ButtonFX(Upgrade, 1.05, Client.RequestCashUpgrade))
    v7:Add(ButtonFX(RobuxUpgrade, 1.05, Client.PromptRobuxUpgrade))
    v7:Add(Save.FieldSignal("TreadmillUpgradeLevel"):Connect(refresh))
    v7:Add(Save.FieldSignal("BaseUpgradeLevel"):Connect(refresh))
    v7:Add(Save.FieldSignal("Money"):Connect(refresh))
    refresh()
end

bindLocalPlot = bindLocalPlot_2

if not Save.IsLocalDataLoaded() then
    Save.ProfileReady:Wait()
end
bindLocalPlot_2()
PlotState.LocalPlotChanged:Connect(bindLocalPlot_2)
