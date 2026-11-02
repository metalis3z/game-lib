-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local BaseUpgrade = require(ReplicatedStorage.Client.BaseUpgrade)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
require(ReplicatedStorage.Client.Types.GUI)
local EnsureScale = require(ReplicatedStorage.Shared.Utils.Layout).EnsureScale
local MonetizationEntitlements = require(ReplicatedStorage.Shared.Util.MonetizationEntitlements)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local PlotUpgradeVisibility = require(ReplicatedStorage.Client.PlotUpgradeVisibility)
require(ReplicatedStorage.Data.Products)
local Products = require(ReplicatedStorage.Data.Products)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local Save = require(ReplicatedStorage.Shared.Save)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = utf8.char(57346)
local v2 = Color3.new(0.760784, 0, 0)
local v3 = TweenInfo.new(0.65, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local PlotUpgrade = ReplicatedStorage.Assets.UI.PlotUpgrade
local FirstUpgradeInfo = PlotUpgrade.FirstUpgradeInfo
local Frame = FirstUpgradeInfo:IsA("Frame")
assert(Frame, "PlotUpgrade.FirstUpgradeInfo template must be a Frame")
local FirstUpgrade = PlotUpgrade.FirstUpgrade
local ImageButton = FirstUpgrade:IsA("ImageButton")
assert(ImageButton, "PlotUpgrade.FirstUpgrade template must be an ImageButton")
local v4, BackgroundColor3, Enabled

local function getProductForLevel(v5, v6) -- line 37 | captures: Products
    local ProductId
    if v6 == nil then
    else
        ProductId = v6.ProductId
    end
    if ProductId == nil or Products.DataByProductId[ProductId] == nil then
        local v7 = ("BaseUpgradeTier%*"):format(v5)
        if Products.ProductNameExists(v7) then
            return Products.Directory[v7]
        end
        return nil
    end
    return Products.DataByProductId[ProductId]
end

local function refreshPlotUpgradeVisibility() -- line 50 | captures: PlotUpgradeVisibility
    PlotUpgradeVisibility.Apply("PlotUpgrade")
end

local bindLocalPlot

local function bindLocalPlot_2() -- line 53 | captures: v4, BackgroundColor3, Enabled, TweenService, BaseUpgrade, ButtonFX, Simple, EnsureScale, MonetizationEntitlements, PlotState, PlotUpgradeVisibility, Products, PromptPurchase, Save, Trove, v1, v2, v3, FirstUpgradeInfo, FirstUpgrade, bindLocalPlot
    if v4 ~= nil then
        v4:Destroy()
        v4 = nil
    end
    local v8 = PlotState.ResolvePlot()
    if v8 == nil then
        return
    end
    local PlotFolder = v8.PlotFolder
    local Model = PlotFolder:IsA("Model")
    assert(Model, "Local plot folder must be a Model")
    local PlotUpgrade = PlotFolder:WaitForChild("PlotUpgrade")
    local Model_2 = PlotUpgrade:IsA("Model")
    assert(Model_2, "PlotUpgrade must be a Model")
    local Sign = PlotUpgrade.Sign
    local BasePart = Sign:IsA("BasePart")
    assert(BasePart, "PlotUpgrade.Sign must be a BasePart")
    local CanUpgrade = Sign.CanUpgrade
    local BillboardGui = CanUpgrade:IsA("BillboardGui")
    assert(BillboardGui, "PlotUpgrade.Sign.CanUpgrade must be a BillboardGui")
    local SurfaceGui = Sign.SurfaceGui
    local SurfaceGui_2 = SurfaceGui:IsA("SurfaceGui")
    assert(SurfaceGui_2, "PlotUpgrade.Sign.SurfaceGui must be a SurfaceGui")
    local Info = SurfaceGui.Info
    local TextLabel = Info:IsA("TextLabel")
    assert(TextLabel, "PlotUpgrade.Sign.SurfaceGui.Info must be a TextLabel")
    local Level = SurfaceGui.Level
    local TextLabel_2 = Level:IsA("TextLabel")
    assert(TextLabel_2, "PlotUpgrade.Sign.SurfaceGui.Level must be a TextLabel")
    local Frame = SurfaceGui.Frame
    local GuiObject = Frame:IsA("GuiObject")
    assert(GuiObject, "PlotUpgrade.Sign.SurfaceGui.Frame must be a GuiObject")
    local Upgrade = Frame.Upgrade
    local GuiButton = Upgrade:IsA("GuiButton")
    assert(GuiButton, "Plot Upgrade must be a GuiButton")
    local RobuxUpgrade = Frame.RobuxUpgrade
    local GuiButton_2 = RobuxUpgrade:IsA("GuiButton")
    assert(GuiButton_2, "Plot RobuxUpgrade must be a GuiButton")
    local Cost = RobuxUpgrade.Cost
    local TextLabel_3 = Cost:IsA("TextLabel")
    assert(TextLabel_3, "Plot RobuxUpgrade.Cost must be a TextLabel")
    local v9 = 0
    local v10 = {}
    local v11 = Cost.Text

    local function setRobuxCostText(v12, v13) -- line 106 | captures: v11, Cost
        if Cost.Text == v12 then
            v11 = v12
        else
            v11 = v12
            Cost.Text = v12
        end
    end

    local Cost_2 = Upgrade.Cost
    local TextLabel_4 = Cost_2:IsA("TextLabel")
    assert(TextLabel_4, "Plot Upgrade.Cost must be a TextLabel")
    local UIGradient = Upgrade:FindFirstChildOfClass("UIGradient")
    if BackgroundColor3 == nil then
        BackgroundColor3 = Upgrade.BackgroundColor3
    end
    if UIGradient ~= nil and Enabled == nil then
        Enabled = UIGradient.Enabled
    end
    local BackgroundColor3_2 = BackgroundColor3
    local v14 = assert(BackgroundColor3_2, "Plot Upgrade authored background color must be initialized")
    Upgrade.AutoButtonColor = false
    local v15 = Trove.new()
    local v16 = FirstUpgradeInfo:Clone()
    local Icon = v16.Icon
    local ImageLabel = Icon:IsA("ImageLabel")
    assert(ImageLabel, "Plot FirstUpgradeInfo.Icon must be an ImageLabel")
    local v17 = FirstUpgrade:Clone()
    local Cost_3 = v17.Cost
    local TextLabel_5 = Cost_3:IsA("TextLabel")
    assert(TextLabel_5, "Plot FirstUpgrade.Cost must be a TextLabel")
    local ProgressFill = v17.ProgressFill
    local Frame_2 = ProgressFill:IsA("Frame")
    assert(Frame_2, "Plot FirstUpgrade.ProgressFill must be a Frame")
    local UIGradient_2 = v17.UIGradient
    local UIGradient_3 = UIGradient_2:IsA("UIGradient")
    assert(UIGradient_3, "Plot FirstUpgrade button gradient must be a UIGradient")
    local BackgroundColor3_3 = v17.BackgroundColor3
    local Enabled_2 = UIGradient_2.Enabled
    local Size = ProgressFill.Size
    v16.Visible = false
    v16.Parent = SurfaceGui
    v15:Add(v16)
    local v18 = EnsureScale(Icon)
    v18.Scale = 0.8
    local v19 = TweenService:Create(v18, v3, { Scale = 1.3 })
    v15:Add(v19)
    v19:Play()
    v17.Visible = false
    v17.AutoButtonColor = false
    v17.Parent = Frame
    v15:Add(v17)
    v4 = v15
    v15:Add(PlotFolder.Destroying:Connect(function() -- line 163 | captures: PlotUpgradeVisibility, bindLocalPlot
        task.defer(function() -- line 164 | captures: PlotUpgradeVisibility, bindLocalPlot
            bindLocalPlot()
            PlotUpgradeVisibility.Apply("PlotUpgrade")
        end)
    end))
    local Text = Cost:GetPropertyChangedSignal("Text")
    v15:Add(Text:Connect(function() -- line 169 | captures: v11, Cost
        if Cost.Text ~= v11 then
            print(("[RobuxCostDebug] EXTERNAL WRITE to=%q expected=%q\n%s"):format(Cost.Text, v11, debug.traceback()))
            v11 = Cost.Text
        end
    end))

    local function refresh() -- line 175 | captures: v9, v11, CanUpgrade, Info, Level, Upgrade, RobuxUpgrade, Cost, v10, Cost_2, UIGradient, v14, v15, v16, v17, Cost_3, ProgressFill, UIGradient_2, BackgroundColor3_3, Enabled_2, Size, v4, Enabled, BaseUpgrade, Simple, MonetizationEntitlements, Products, Save, v1, v2
        local v20 = Save.Get()
        local v21 = v20 ~= nil
        assert(v21, "Plot upgrade UI requires loaded data")
        local v22 = v20.BaseUpgradeLevel == 0
        Info.Visible = not v22
        Level.Visible = not v22
        v16.Visible = v22
        Upgrade.Visible = not v22
        v17.Visible = v22
        local v23, v24 = BaseUpgrade.ResolveNextTier(v20)
        local v25 = BaseUpgrade.IsNextTierAffordable(v20)
        CanUpgrade.Enabled = v25
        local v26 = if v25 then v14 else v2
        Upgrade.BackgroundColor3 = v26
        if UIGradient ~= nil then
            local v27 = v25 and Enabled == true
            UIGradient.Enabled = v27
        end
        local v28 = if v25 then BackgroundColor3_3 else v2
        v17.BackgroundColor3 = v28
        local v29 = v25 and Enabled_2
        UIGradient_2.Enabled = v29
        if v23 ~= nil and v24 ~= nil then
            Level.Text = ("Level %* > Level %*"):format(v20.BaseUpgradeLevel, v23)
            local v30 = "$" .. Simple.FormatCompact(v24.Cost, ".#")
            Cost_2.Text = v30
            Cost_3.Text = v30
            local v31 = v24.Cost > 0
            assert(v31, "Plot upgrade cost must be positive")
            local v32 = v20.Money / v24.Cost
            local v33 = math.clamp(v32, 0, 1)
            ProgressFill.Size = UDim2.new(v33, Size.X.Offset, Size.Y.Scale, Size.Y.Offset)
            v9 += 1
            local v34 = v9
            local v35
            if v22 then
            else
                local ProductId
                if v24 == nil then
                else
                    ProductId = v24.ProductId
                end
                if ProductId == nil or Products.DataByProductId[ProductId] == nil then
                    local v36 = ("BaseUpgradeTier%*"):format(v23)
                    if Products.ProductNameExists(v36) then
                        v35 = Products.Directory[v36]
                    end
                else
                    v35 = Products.DataByProductId[ProductId]
                end
            end
            RobuxUpgrade.Visible = v35 ~= nil
            if v35 == nil then
                ("refresh#%d no product"):format(v34)
                if Cost.Text == "" then
                    v11 = ""
                else
                    v11 = ""
                    Cost.Text = ""
                end
            else
                local RobuxPrice = v35.RobuxPrice
                local v37 = tonumber(RobuxPrice) or 0
                local v38 = v10[v35.ProductId]
                if type(v38) == "number" and v38 > 0 then
                    v37 = v38
                end
                if v37 > 0 then
                    local v39 = ("%* %*"):format(v1, (Simple.FormatCompact(v37, ".#")));
                    ("refresh#%d price"):format(v34)
                    if Cost.Text == v39 then
                        v11 = v39
                    else
                        v11 = v39
                        Cost.Text = v39
                    end
                end
                if v38 == nil and v37 <= 0 then
                    v10[v35.ProductId] = false
                    local spawn = task.spawn
                    local v40 = v35
                    spawn(function() -- line 252 | captures: v34, v40, v9, v11, Cost, v10, v15, v4, Simple, MonetizationEntitlements, v1
                        local v41 = MonetizationEntitlements.ProductPrice(v40.ProductId)
                        v10[v40.ProductId] = v41
                        if not (v4 == v15 and v34 == v9 and v41 > 0) then
                            return
                        end
                        local v42 = ("%* %*"):format(v1, (Simple.FormatCompact(v41, ".#")));
                        ("refresh#%d store"):format(v34)
                        if Cost.Text == v42 then
                            v11 = v42
                        else
                            v11 = v42
                            Cost.Text = v42
                        end
                    end)
                end
            end
        else
            Level.Text = "Level MAX"
            Cost_2.Text = "MAX"
            RobuxUpgrade.Visible = false
        end
    end

    v15:Add(ButtonFX(Upgrade, 1.05, BaseUpgrade.PurchaseNextTier))
    v15:Add(ButtonFX(v17, 1.05, BaseUpgrade.PurchaseNextTier))
    v15:Add(ButtonFX(RobuxUpgrade, 1.05, function() -- line 267 | captures: BaseUpgrade, Products, PromptPurchase, Save
        local v43 = Save.Get()
        local v44 = v43 ~= nil
        assert(v44, "Plot Robux upgrade requires loaded data")
        local v45, v46 = BaseUpgrade.ResolveNextTier(v43)
        if v45 == nil or v46 == nil then
            return
        end
        local ProductId = v46.ProductId
        local v47
        if ProductId == nil or Products.DataByProductId[ProductId] == nil then
            local v48 = ("BaseUpgradeTier%*"):format(v45)
            if Products.ProductNameExists(v48) then
                v47 = Products.Directory[v48]
            end
        else
            v47 = Products.DataByProductId[ProductId]
        end
        if v47 ~= nil then
            PromptPurchase.Prompt(v47.ProductId, true)
        end
    end))
    v15:Add(Save.FieldSignal("BaseUpgradeLevel"):Connect(refresh))
    v15:Add(Save.FieldSignal("Money"):Connect(refresh))
    refresh()
end

bindLocalPlot = bindLocalPlot_2

if not Save.IsLocalDataLoaded() then
    Save.ProfileReady:Wait()
end
bindLocalPlot_2()
PlotUpgradeVisibility.Apply("PlotUpgrade")
PlotState.LocalPlotChanged:Connect(function() -- line 290 | captures: PlotUpgradeVisibility, bindLocalPlot_2
    bindLocalPlot_2()
    PlotUpgradeVisibility.Apply("PlotUpgrade")
end)
PlotState.PlotChanged:Connect(refreshPlotUpgradeVisibility)
PlotState.FolderChanged:Connect(refreshPlotUpgradeVisibility)
