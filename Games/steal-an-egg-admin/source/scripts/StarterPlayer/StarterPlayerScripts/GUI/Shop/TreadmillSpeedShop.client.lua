-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
require(ReplicatedStorage.Shared.Modules.DefaultStats.Types.Interface)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
require(ReplicatedStorage.Client.Types.GUI)
local Price = require(ReplicatedStorage.Shared.Utils.Marketplace).Price
local Hud = require(ReplicatedStorage.Client.Hud)
local Products = require(ReplicatedStorage.Data.Products)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Client = require(script.Parent.Parent.TreadmillUpgrade.Client)
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
local v1 = Color3.fromRGB(214, 17, 17)
local v2 = ColorSequence.new(v1, Color3.fromRGB(253, 20, 20))
local v3 = Color3.fromRGB(72, 0, 0)
local v4 = Color3.fromRGB(255, 103, 103)
local Treadmill = Hud.Get("ShopButton", "Treadmill")
local UpgradeTreadmil = GUI.TreadmillSpeedShop().Frame.ScrollingFrame.UpgradeTreadmil
local Spacer = UpgradeTreadmil.Spacer
local Btns = Spacer.Btns
local Cash = Btns.Cash
local Robux = Btns.Robux
local UIGradient = Cash:FindFirstChildOfClass("UIGradient")
local UIStroke = Cash:FindFirstChild("UIStroke")
local UIStrokeClr = Cash:FindFirstChild("UIStrokeClr")
local Color

if UIGradient == nil then
else
    Color = UIGradient.Color
end
local Color_2

if UIStroke == nil then
else
    Color_2 = UIStroke.Color
end
local Color_3

if UIStrokeClr == nil then
else
    Color_3 = UIStrokeClr.Color
end
local v5 = 0

local function getLoadedData() -- line 50 | captures: Save
    local v6 = Save.Get()
    local v7 = v6 ~= nil
    assert(v7, "Treadmill speed shop requires loaded player data")
    return v6
end

local function updateRobuxUpgradePrice(v8, v9) -- line 56 | captures: v5, Constants, Simple, Price, Robux
    Robux.Price.Text = Constants.ROBUX_ICON_STR
    task.spawn(function() -- line 58 | captures: v8, v9, v5, Constants, Simple, Price, Robux
        local v10, v11 = Price(v8, true)
        if v9 == v5 then
            local v12
            if v11 then
                v12 = Simple.FormatCompact(v10, ".#")
            else
                v12 = "???"
            end
            Robux.Price.Text = ("%* %*"):format(Constants.ROBUX_ICON_STR, v12)
        end
    end)
end

local function applyMoneyAffordability(v13) -- line 72 | captures: Color, Color_2, Color_3, v2, v3, v4, UIGradient, UIStroke, UIStrokeClr
    if UIGradient ~= nil then
        local v14 = if v13 then Color else v2
        UIGradient.Color = v14
    end
    if UIStroke ~= nil then
        local v15 = if v13 then Color_2 else v3
        UIStroke.Color = v15
    end
    if UIStrokeClr ~= nil then
        local v16 = if v13 then Color_3 else v4
        UIStrokeClr.Color = v16
    end
end

local function refreshUpgrade(v17, v18) -- line 99 | captures: Color, Color_2, Color_3, v5, Constants, Simple, Price, Products, Client, Treadmills, v2, v3, v4, UpgradeTreadmil, Spacer, Cash, Robux, UIGradient, UIStroke, UIStrokeClr
    local v19 = Treadmills.GetByUpgradeLevel(v17.TreadmillUpgradeLevel)
    local v20 = v19 ~= nil
    local v21 = ("Invalid current treadmill level %*"):format(v17.TreadmillUpgradeLevel)
    assert(v20, v21)
    Spacer.CurrentTreadmill.Image = v19.Icon
    local v22, v23 = Client.GetNextConfig(v17)
    _ = v22
    if v23 == nil then
        UpgradeTreadmil.Visible = false
    else
        UpgradeTreadmil.Visible = true
        Spacer.NextTreadmill.Image = v23.Icon
        Cash.Price.Text = "$" .. Simple.FormatCompact(v23.Price, ".#")
        local v24 = Client.CanAffordNext(v17)
        if UIGradient ~= nil then
            local v25 = if v24 then Color else v2
            UIGradient.Color = v25
        end
        if UIStroke ~= nil then
            local v26 = if v24 then Color_2 else v3
            UIStroke.Color = v26
        end
        if UIStrokeClr ~= nil then
            local v27 = if v24 then Color_3 else v4
            UIStrokeClr.Color = v27
        end
        local ProductId = v23.ProductId
        local v28 = if ProductId == nil then false else Products.DataByProductId[ProductId] ~= nil
        Robux.Visible = v28
        if ProductId ~= nil and Robux.Visible then
            Robux.Price.Text = Constants.ROBUX_ICON_STR
            task.spawn(function() -- line 144 | captures: v18, ProductId, v5, Constants, Simple, Price, Robux
                local v29, v30 = Price(ProductId, true)
                if v18 == v5 then
                    local v31
                    if v30 then
                        v31 = Simple.FormatCompact(v29, ".#")
                    else
                        v31 = "???"
                    end
                    Robux.Price.Text = ("%* %*"):format(Constants.ROBUX_ICON_STR, v31)
                end
            end)
        end
    end
end

local function refreshShop() -- line 159 | captures: v5, Save, refreshUpgrade
    v5 += 1
    local v32 = Save.Get()
    local v33 = v32 ~= nil
    assert(v33, "Treadmill speed shop requires loaded player data")
    refreshUpgrade(v32, v5)
end

if not Save.IsLocalDataLoaded() then
    Save.ProfileReady:Wait()
end
ButtonFX(Treadmill, 1.08, function() -- line 169 | captures: Tabs
    Tabs.Toggle("TreadmillSpeedShop")
end)
ButtonFX(Cash, nil, Client.RequestCashUpgrade)
ButtonFX(Robux, nil, Client.PromptRobuxUpgrade)
Tabs.Shown:Connect(function(v34) -- line 174 | captures: v5, Save, refreshUpgrade
    if v34 ~= "TreadmillSpeedShop" then
        return
    end
    v5 += 1
    local v35 = Save.Get()
    local v36 = v35 ~= nil
    assert(v36, "Treadmill speed shop requires loaded player data")
    refreshUpgrade(v35, v5)
end)
Save.FieldSignal("TreadmillUpgradeLevel"):Connect(function() -- line 183 | captures: v5, Save, Tabs, refreshUpgrade
    if not Tabs.IsShowing("TreadmillSpeedShop") then
        return
    end
    v5 += 1
    local v37 = Save.Get()
    local v38 = v37 ~= nil
    assert(v38, "Treadmill speed shop requires loaded player data")
    refreshUpgrade(v37, v5)
end)
Save.FieldSignal("Money"):Connect(function() -- line 192 | captures: v5, Save, Tabs, refreshUpgrade
    if not Tabs.IsShowing("TreadmillSpeedShop") then
        return
    end
    v5 += 1
    local v39 = Save.Get()
    local v40 = v39 ~= nil
    assert(v40, "Treadmill speed shop requires loaded player data")
    refreshUpgrade(v39, v5)
end)
v5 += 1
local v41 = Save.Get()
local v42 = v41 ~= nil
assert(v42, "Treadmill speed shop requires loaded player data")
refreshUpgrade(v41, v5)
