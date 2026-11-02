-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local AdminBoosts = require(ReplicatedStorage.Shared.Util.AdminBoosts)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Player = require(ReplicatedStorage.Shared.Player)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Trove = require(ReplicatedStorage.Packages.Trove)
local OFFLINE_ASSETS = Constants.OFFLINE_ASSETS
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local PlayerGui_2 = PlayerGui:IsA("PlayerGui")
assert(PlayerGui_2, "Expected PlayerGui")
local OfflineMoneyInPlot = PlayerGui:WaitForChild("OfflineMoneyInPlot")
local ScreenGui = OfflineMoneyInPlot:IsA("ScreenGui")
assert(ScreenGui, "OfflineMoneyInPlot must be a ScreenGui")
local TopBar = OfflineMoneyInPlot:WaitForChild("TopBar")
local GuiObject = TopBar:IsA("GuiObject")
assert(GuiObject, "OfflineMoneyInPlot.TopBar must be a GuiObject")
local InPlot = TopBar:WaitForChild("InPlot")
local GuiObject_2 = InPlot:IsA("GuiObject")
assert(GuiObject_2, "OfflineMoneyInPlot.TopBar.InPlot must be a GuiObject")
local TextLabel = InPlot:WaitForChild("TextLabel")
local TextLabel_2 = TextLabel:IsA("TextLabel")
assert(TextLabel_2, "OfflineMoneyInPlot.TopBar.InPlot.TextLabel must be a TextLabel")
local v1 = Trove.new()
local v2 = 0
local v3

local function formatOfflineAmount(v4) -- line 39 | captures: Simple
    return Simple.FormatCompact((math.max(v4, 0)))
end

local function getOfflinePreviewAmountFromTotalRate(v5) -- line 42 | captures: OFFLINE_ASSETS
    return math.max(v5, 0) * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER
end

local function updateText() -- line 46 | captures: v2, OFFLINE_ASSETS, TextLabel, formatOfflineAmount
    TextLabel.RichText = true
    local v6 = v2
    local v7 = math.max(v6, 0)
    TextLabel.Text = string.format("You earn <font color = \"#00ff00\">$%s</font>/Day offline! \240\159\152\136", formatOfflineAmount(v7 * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER))
end

local function isWorldPositionInsideScaledPetAreaXZ(v8) -- line 51 | captures: AssetRoster, LocalPlayer
    local v9 = AssetRoster.FindPenArea(LocalPlayer)
    if v9 ~= nil then
        local v10 = v9.CFrame:PointToObjectSpace(v8)
        local v11 = v9.Size.X * 0.74 * 0.5
        local v12 = v9.Size.Z * 0.74 * 0.5
        local X = v10.X
        if math.abs(X) <= v11 then
            local Z = v10.Z
            return math.abs(Z) <= v12
        end
    end
    return false
end

local function refreshRateFromSave() -- line 62 | captures: v2, v3, AssetItems, Save, OFFLINE_ASSETS, LocalPlayer, TextLabel, formatOfflineAmount
    local v13 = Save.Get()
    if v13 == nil then
        v2 = 0
    else
        v2 = AssetItems.ProfileIncomePerSecond(LocalPlayer, v13)
    end
    TextLabel.RichText = true
    local v14 = v2
    local v15 = math.max(v14, 0)
    TextLabel.Text = string.format("You earn <font color = \"#00ff00\">$%s</font>/Day offline! \240\159\152\136", formatOfflineAmount(v15 * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER))
    v3()
end

function v3() -- line 76 | captures: v2, HiddenUIHandler, Player, LocalPlayer, OfflineMoneyInPlot, isWorldPositionInsideScaledPetAreaXZ
    local v16 = Player.Optional.HumanoidRootPart(LocalPlayer)
    local v17 = not HiddenUIHandler.IsHidden()
    if v17 then
        if v2 > 1000 then
            if v16 == nil then
                v17 = false
            else
                v17 = isWorldPositionInsideScaledPetAreaXZ(v16.Position)
            end
        else
            v17 = false
        end
    end
    OfflineMoneyInPlot.Enabled = v17
end

TextLabel.RichText = true
OfflineMoneyInPlot.Enabled = false

local v18 = Save.Get()

if v18 == nil then
    v2 = 0
else
    v2 = AssetItems.ProfileIncomePerSecond(LocalPlayer, v18)
end
TextLabel.RichText = true

local v19 = v2
local v20 = math.max(v19, 0)

TextLabel.Text = string.format("You earn <font color = \"#00ff00\">$%s</font>/Day offline! \240\159\152\136", formatOfflineAmount(v20 * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER))
v3()
v3()
v1:Add(Save.WatchFields({ "EquippedAssets", "Inventory", "Gamepasses", "Products" }, refreshRateFromSave))
v1:Add(AdminBoosts.Observe(AdminBoosts.EARNINGS):Connect(refreshRateFromSave))
v1:Add(Save.ProfileReady:Connect(function(v21) -- line 99 | captures: v2, v3, AssetItems, Save, OFFLINE_ASSETS, LocalPlayer, TextLabel, formatOfflineAmount
    if v21 ~= LocalPlayer then
        return
    end
    local v22 = Save.Get()
    if v22 == nil then
        v2 = 0
    else
        v2 = AssetItems.ProfileIncomePerSecond(LocalPlayer, v22)
    end
    TextLabel.RichText = true
    local v23 = v2
    local v24 = math.max(v23, 0)
    TextLabel.Text = string.format("You earn <font color = \"#00ff00\">$%s</font>/Day offline! \240\159\152\136", formatOfflineAmount(v24 * OFFLINE_ASSETS.MAX_DURATION_SECONDS * OFFLINE_ASSETS.MONEY_RATE_MULTIPLIER))
    v3()
end))
v1:Add(PlotState.LocalPlotChanged:Connect(v3))
v1:Connect(RunService.Heartbeat, v3)
