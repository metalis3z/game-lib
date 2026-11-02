-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1, TextLabel
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local BaseUpgrade = require(ReplicatedStorage.Client.BaseUpgrade)
local Bases = require(ReplicatedStorage.Data.Bases)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
require(ReplicatedStorage.Shared.Globals.Constants)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local SwapGradient = require(ReplicatedStorage.Shared.Utils.Layout).SwapGradient
local Hud = require(ReplicatedStorage.Client.Hud)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local PetPenCapacityGuidanceController = require(script.PetPenCapacityGuidanceController)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local SlideDock = require(ReplicatedStorage.Client.UI.SlideDock)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v2 = Color3.fromRGB(255, 70, 70)
local v3 = Color3.fromRGB(85, 255, 85)
local v4 = Color3.fromRGB(214, 17, 17)
local v5 = ColorSequence.new(v4, Color3.fromRGB(253, 20, 20))
local v6 = Color3.fromRGB(72, 0, 0)
local v7 = Color3.fromRGB(255, 103, 103)

local function claimRowTemplate(v8) -- line 34
    local v9
    for v10, v11 in v8:GetChildren() do
        if v11.Name == "Template" and v11:IsA("GuiObject") then
            if v9 == nil then
                v9 = v11
            else
                v11:Destroy()
            end
        end
    end
    local v12 = v9 ~= nil
    assert(v12, "ActivePets.Frame.ScrollingFrame has no Template row")
    return v9
end

local function shadowFor(v13) -- line 49
    local TextLabel = v13:FindFirstChild("TextLabel")
    if TextLabel ~= nil and TextLabel:IsA("TextLabel") then
        return TextLabel
    end
    return v13
end

local LocalPlayer = Players.LocalPlayer
local v14 = GUI.ActivePets()
local Frame = v14.Frame
local Title = Frame.Header.Title
local TextLabel_2 = Title:FindFirstChild("TextLabel")

if TextLabel_2 == nil then
    v1 = Title
elseif TextLabel_2:IsA("TextLabel") then
    v1 = TextLabel_2
end
local PlusEquip = Frame.Header.PlusEquip
local TextLabel_3 = PlusEquip:FindFirstChild("TextLabel")
local ScrollingFrame = Frame.ScrollingFrame
local EmptyLast = ScrollingFrame:FindFirstChild("EmptyLast")
local v15 = claimRowTemplate(ScrollingFrame)
local Close = Frame.Close
local EquipBest = Frame.EquipBest
local PetsButton = Hud.Every("PetsButton")
local UIGradient = PlusEquip:FindFirstChildOfClass("UIGradient")
local UIStroke = PlusEquip:FindFirstChild("UIStroke")
local UIStrokeClr = PlusEquip:FindFirstChild("UIStrokeClr")
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
local v16 = Trove.new()
local v17 = 0
local v18 = false
local v19 = 0
local ScreenGui = v14:IsA("ScreenGui")
assert(ScreenGui, "PlayerGui.ActivePets must be a ScreenGui")
local GuiObject = Frame:IsA("GuiObject")
assert(GuiObject, "ActivePets.Frame must be a GuiObject")
local TextLabel_4 = Title:IsA("TextLabel")
assert(TextLabel_4, "ActivePets.Frame.Header.Title must be a TextLabel")
local GuiButton = PlusEquip:IsA("GuiButton")
assert(GuiButton, "ActivePets.Frame.Header.PlusEquip must be a GuiButton")
local v20

if TextLabel_3 == nil then
    v20 = false
else
    v20 = TextLabel_3:IsA("TextLabel")
end
assert(v20, "ActivePets.Frame.Header.PlusEquip.TextLabel must be a TextLabel")
local ScrollingFrame_2 = ScrollingFrame:IsA("ScrollingFrame")
assert(ScrollingFrame_2, "ActivePets.Frame.ScrollingFrame must be a ScrollingFrame")
local GuiButton_2 = Close:IsA("GuiButton")
assert(GuiButton_2, "ActivePets.Frame.Close must be a GuiButton")
local GuiButton_3 = EquipBest:IsA("GuiButton")
assert(GuiButton_3, "ActivePets.Frame.EquipBest must be a GuiButton")
local v21 = #PetsButton > 0
assert(v21, "the HUD has no PetsButton to open ActivePets with")
local TextLabel_5 = TextLabel_3:FindFirstChild("TextLabel")

if TextLabel_5 == nil then
    TextLabel = TextLabel_3
elseif TextLabel_5:IsA("TextLabel") then
    TextLabel = TextLabel_5
end
v14.ResetOnSpawn = false
PlusEquip.AutoButtonColor = false
GamepadBindings.TrackCloseButton(Close)
local v22 = SlideDock.new(v14, Frame, SlideDock.EscortFramesOf(PetsButton))

local function setOpen(v23, v24) -- line 127 | captures: v22
    v22:SetOpen(v23, v24)
end

local function getCapacity(v25) -- line 130 | captures: Bases
    local BaseUpgradeLevel
    if v25 == nil then
    else
        BaseUpgradeLevel = v25.BaseUpgradeLevel
    end
    return Bases.GetAssetEquipCapacity(BaseUpgradeLevel)
end

local function setTextWithShadow(v26, v27, v28) -- line 139
    v26.Text = v28
    v27.Text = v28
end

local function formatDisplayNameWithRate(v29) -- line 143 | captures: Simple
    local v30 = Simple.FormatCompact(v29.Rate, ".#")
    return v29.DisplayName .. " ($" .. v30 .. "/s)"
end

local function updateHeader(v31, v32) -- line 147 | captures: Color, Color_2, Color_3, v1, TextLabel, BaseUpgrade, Bases, Simple, v5, v6, v7, Title, PlusEquip, TextLabel_3, UIGradient, UIStroke, UIStrokeClr
    local BaseUpgradeLevel
    if v31 == nil then
    else
        BaseUpgradeLevel = v31.BaseUpgradeLevel
    end
    local v33 = ("%*/%* Active"):format(v32, (Bases.GetAssetEquipCapacity(BaseUpgradeLevel)))
    Title.Text = v33
    v1.Text = v33
    local Cost
    if v31 == nil then
    else
        local v34, v35 = BaseUpgrade.ResolveNextTier(v31)
        _ = v34
        if v35 == nil then
        else
            Cost = v35.Cost
        end
    end
    local v36
    if Cost == nil then
        v36 = "MAX EQUIP"
    else
        local v37 = math.floor(Cost)
        v36 = ("+1 EQUIP [$%*]"):format((Simple.FormatCompact(v37, ".#")))
    end
    TextLabel_3.Text = v36
    TextLabel.Text = v36
    local v38 = Cost ~= nil
    PlusEquip.Active = v38
    local v39 = if Cost == nil or v31 == nil then false else Cost <= v31.Money
    local v40 = if Cost == nil then false else not v39
    if UIGradient ~= nil then
        local v41 = if v40 then v5 else Color
        UIGradient.Color = v41
    end
    if UIStroke ~= nil then
        local v42 = if v40 then v6 else Color_2
        UIStroke.Color = v42
    end
    if UIStrokeClr ~= nil then
        local v43 = if v40 then v7 else Color_3
        UIStrokeClr.Color = v43
    end
end

local function compareEntries(v44, v45) -- line 204
    if v44.RarityNumber == v45.RarityNumber then
        if v44.Rate == v45.Rate then
            return v44.UID < v45.UID
        end
        return v45.Rate < v44.Rate
    end
    return v45.RarityNumber < v44.RarityNumber
end

local function buildEntries(v46) -- line 217 | captures: Players, Assets, AssetEarnings, AssetItems, compareEntries
    if v46 == nil then
        return {}
    end
    local v47 = {}
    for v48, v49 in ipairs(v46.EquippedAssets) do
        local v50 = v46.Inventory[v49]
        if v50 ~= nil then
            local v51 = AssetItems.Decode(v50)
            local v52 = Assets.Directory[v51.Category]
            local Rarity = v52.Rarity
            local v53 = { UID = v49 }
            if v52.DisplayName == "" then
                v53.DisplayName = v51.Category
            else
                v53.DisplayName = v52.DisplayName
            end
            v53.Icon = v52.Icon
            v53.Rate = AssetEarnings.LiveRatePerSecond(v51, v46.Gamepasses, v46.Products, Players.LocalPlayer)
            v53.RarityNumber = Rarity.RarityNumber
            v53.RarityGradient = Rarity.RarityGradient
            table.insert(v47, v53)
        end
    end
    table.sort(v47, compareEntries)
    return v47
end

local function requestUnequip(v54) -- line 247 | captures: AssetRoster, Message, v2
    local v55, v56 = AssetRoster.DoffAsset(v54)
    if not v55 and v56 ~= nil then
        Message.Bottom({
            Time = 2,
            PreventDuplicateText = true,
            Message = v56,
            Color = v2
        })
    end
end

local function mountRow(v57, v58) -- line 254 | captures: AssetRoster, ButtonFX, Simple, SwapGradient, Message, Trove, v2, ScrollingFrame, v15, v16
    local v59 = Trove.new()
    v16:Add(v59)
    local v60 = v15:Clone()
    v60.Name = ("Pet_%*"):format(v57.UID)
    v60.LayoutOrder = v58
    v60.Visible = true
    v60:SetAttribute("PetListRowClone", true)
    v59:Add(v60)
    local Spacer = v60.Spacer
    local TextLabel = Spacer.TextLabel
    local TextLabel_2 = TextLabel:FindFirstChild("TextLabel")
    if TextLabel_2 == nil or not TextLabel_2:IsA("TextLabel") then
        TextLabel_2 = TextLabel
    end
    local Unequip = Spacer.Unequip
    SwapGradient(TextLabel, v57.RarityGradient)
    if TextLabel_2 ~= TextLabel then
        SwapGradient(TextLabel_2, v57.RarityGradient)
    end
    local v61 = v57.DisplayName .. " ($" .. Simple.FormatCompact(v57.Rate, ".#") .. "/s)"
    TextLabel.Text = v61
    TextLabel_2.Text = v61
    Spacer.Icon.Image = v57.Icon or ""
    v59:Connect(Unequip.Activated, function() -- line 285 | captures: v57, AssetRoster, Message, v2
        local v62, v63 = AssetRoster.DoffAsset(v57.UID)
        if not v62 and v63 ~= nil then
            Message.Bottom({
                Time = 2,
                PreventDuplicateText = true,
                Message = v63,
                Color = v2
            })
        end
    end)
    v59:Add(ButtonFX(Unequip, 1.08))
    v60.Parent = ScrollingFrame
end

local function pinEmptyLast() -- line 295 | captures: EmptyLast
    if EmptyLast ~= nil then
        EmptyLast.LayoutOrder = 1000000
    end
end

local function refresh() -- line 300 | captures: v19, Save, LocalPlayer, ScrollingFrame, EmptyLast, v16, updateHeader, buildEntries, mountRow
    v16:Clean()
    for v64, v65 in ipairs(ScrollingFrame:GetChildren()) do
        if v65:GetAttribute("PetListRowClone") == true then
            v65:Destroy()
        end
    end
    local v66 = Save.Get(LocalPlayer, false)
    local v67 = buildEntries(v66)
    v19 = #v67
    for v68, v69 in ipairs(v67) do
        mountRow(v69, v68)
    end
    if EmptyLast ~= nil then
        EmptyLast.LayoutOrder = 1000000
    end
    updateHeader(v66, v19)
end

local function showEquipBestDebounceNotification() -- line 318 | captures: Message
    Message.Bottom({
        Message = "Please wait a bit before equipping bests again!",
        Time = 2,
        PreventDuplicateText = true,
        Color = Color3.fromRGB(255, 170, 0)
    })
end

local function requestEquipBest() -- line 321 | captures: v17, v18, Message, Remotes, v2, refresh
    local v70 = workspace:GetServerTimeNow()
    if v18 or v70 - v17 < 5 then
        Message.Bottom({
            Message = "Please wait a bit before equipping bests again!",
            Time = 2,
            PreventDuplicateText = true,
            Color = Color3.fromRGB(255, 170, 0)
        })
    else
        v17 = v70
        v18 = true
        local v71, v72 = Remotes.Haul.WearBest:InvokeServer()
        v18 = false
        if v71 == true then
            refresh()
        else
            local v73 = {
                Time = 2,
                PreventDuplicateText = true
            }
            if typeof(v72) ~= "string" then
                v72 = "Please wait a bit before equipping bests again!"
            end
            v73.Message = v72
            v73.Color = v2
            Message.Bottom(v73)
        end
    end
end

v15.Visible = false
v22:SetOpen(false, true)
refresh()
PetPenCapacityGuidanceController.Initialize()
for v74, v75 in PetsButton do
    local ButtonActivated = GUI.ButtonActivated
    ButtonActivated(v75, function() -- line 359 | captures: PetPenCapacityGuidanceController, v22, refresh
        PetPenCapacityGuidanceController.AcknowledgePetsBadge()
        v22:SetOpen(true, nil)
        refresh()
    end)
    ButtonFX(v75, 1.08)
end
GUI.ButtonActivated(Close, function() -- line 366 | captures: v22
    v22:SetOpen(false, nil)
end)
ButtonFX(Close, 1.08)
GUI.ButtonActivated(PlusEquip, function() -- line 370 | captures: BaseUpgrade
    BaseUpgrade.PurchaseNextTier()
end)
ButtonFX(PlusEquip, 1.08)
GUI.ButtonActivated(EquipBest, function() -- line 374 | captures: PetPenCapacityGuidanceController, requestEquipBest
    PetPenCapacityGuidanceController.AcknowledgeEquipBestBadge()
    requestEquipBest()
end)
ButtonFX(EquipBest, 1.08)
Save.WatchFields({ "Inventory", "EquippedAssets", "BaseUpgradeLevel", "Gamepasses", "Products" }, refresh)
Save.FieldSignal("Money"):Connect(function() -- line 386 | captures: v19, Save, LocalPlayer, updateHeader
    local v76 = Save.Get(LocalPlayer, false)
    updateHeader(v76, v19)
end)
AssetRoster.SnapshotRefreshed:Connect(refresh)
AssetRoster.OwnerRefreshed:Connect(function(v77) -- line 391 | captures: LocalPlayer, refresh
    if v77 == LocalPlayer.UserId then
        refresh()
    end
end)
AssetRoster.OwnerCleared:Connect(function(v78) -- line 396 | captures: LocalPlayer, refresh
    if v78 == LocalPlayer.UserId then
        refresh()
    end
end)
Remotes.Homestead.BaseTierRaised.OnClientEvent:Connect(function() -- line 401 | captures: Message, v3, refresh
    Message.Bottom({
        Message = "Successfully upgraded your base!",
        Time = 0.7,
        PreventDuplicateText = true,
        Color = v3
    })
    refresh()
end)
