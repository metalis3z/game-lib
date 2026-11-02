-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetIconShape = require(ReplicatedStorage.Client.UI.AssetIconShape)
require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local AutoGridLayout = require(ReplicatedStorage.Client.AutoGridLayout)
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local FuseKernel = require(ReplicatedStorage.Shared.Util.FuseKernel)
require(ReplicatedStorage.Shared.Types.FuseMachine)
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local Log = require(ReplicatedStorage.Packages.Log)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
require(ReplicatedStorage.Shared.Save)
local ViewportSize = require(ReplicatedStorage.Client.ViewportSize)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v1 = Log.new()
local v2 = {}

v2.__index = v2
v2.__class = "FuseMachineBackpackSelection"

local v3 = UserInputService.TouchEnabled and ViewportSize.Get().X < 1024
local v4 = { ScalePaddingOffset = true }
local v5 = if v3 then 4 else 5

v4.PerRow = v5
v4.Padding = UDim2.fromScale(0.02, 0.04)

local GUI = Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("GUI")
local Folder = GUI:IsA("Folder")
assert(Folder, "PlayerScripts.GUI must be a Folder")
local Main = GUI.BackpackController.Main
local ModuleScript = Main:IsA("ModuleScript")
assert(ModuleScript, "BackpackController.Main must be a ModuleScript")
local InventoryTemplate = Main.InventoryTemplate
local GuiButton = InventoryTemplate:IsA("GuiButton")
assert(GuiButton, "BackpackController.Main.InventoryTemplate must be a GuiButton")

function v2.new(v6) -- line 50 | captures: AutoGridLayout, Trove, v2, v4
    local v7 = {}
    local v8 = setmetatable(v7, v2)
    v8._active = false
    v8._rows = Trove.new()
    v8._scrollingFrame = v6
    v8._trove = Trove.new()
    v8._updateGridLayout = AutoGridLayout.Bind(v6, v4)
    v6.AutomaticCanvasSize = Enum.AutomaticSize.None
    for v9, v10 in v6:GetChildren() do
        if v10:IsA("GuiObject") then
            v10:Destroy()
        end
    end
    v8._trove:Add(v8._rows)
    return v8
end

local function getConfig(v11) -- line 66 | captures: Directory
    local v12 = Directory[v11.Category]
    local v13 = v12 ~= nil
    local v14 = ("Missing asset config %*"):format(v11.Category)
    assert(v13, v14)
    return v12
end

local function getOddsDenominator(v15) -- line 72 | captures: Directory, Mutations
    local v16 = Directory[v15.Category]
    local v17 = v16 ~= nil
    local v18 = ("Missing asset config %*"):format(v15.Category)
    assert(v17, v18)
    return 1 / v16.DropWeight * Mutations.RarityFactorFor(v15.Mutations, v15.BaseMutation)
end

local function clearDirectGradients(v19) -- line 78
    for v20, v21 in ipairs(v19:GetChildren()) do
        if v21:IsA("UIGradient") then
            v21:Destroy()
        end
    end
end

local function sortLikeBackpack(v22, v23, v24, v25) -- line 85 | captures: AssetEarnings, AssetItems, Directory, Mutations
    local v26 = Directory[v22.Category]
    local v27 = v26 ~= nil
    local v28 = ("Missing asset config %*"):format(v22.Category)
    assert(v27, v28)
    local v29 = Directory[v24.Category]
    local v30 = v29 ~= nil
    local v31 = ("Missing asset config %*"):format(v24.Category)
    assert(v30, v31)
    local RarityNumber = v26.Rarity.RarityNumber
    local RarityNumber_2 = v29.Rarity.RarityNumber
    if RarityNumber == RarityNumber_2 then
        local v32 = AssetEarnings.MutationOnlyRatePerSecond(v22)
        local v33 = AssetEarnings.MutationOnlyRatePerSecond(v24)
        if v32 == v33 then
            local v34 = Directory[v22.Category]
            local v35 = v34 ~= nil
            local v36 = ("Missing asset config %*"):format(v22.Category)
            assert(v35, v36)
            local v37 = 1 / v34.DropWeight * Mutations.RarityFactorFor(v22.Mutations, v22.BaseMutation)
            local v38 = Directory[v24.Category]
            local v39 = v38 ~= nil
            local v40 = ("Missing asset config %*"):format(v24.Category)
            assert(v39, v40)
            local v41 = 1 / v38.DropWeight * Mutations.RarityFactorFor(v24.Mutations, v24.BaseMutation)
            if v37 == v41 then
                if v26.DropWeight == v29.DropWeight then
                    local v42 = AssetItems.WeightKg(v22)
                    local v43 = AssetItems.WeightKg(v24)
                    if v42 == v43 then
                        return v23 < v25
                    end
                    return v43 < v42
                end
                return v26.DropWeight < v29.DropWeight
            end
            return v41 < v37
        end
        return v33 < v32
    end
    return RarityNumber_2 < RarityNumber
end

function v2._createRow(v44, v45, v46, v47, v48) -- line 134 | captures: AssetIconShape, AssetItems, Directory, ButtonFX, ItemDisplay, InventoryTemplate, clearDirectGradients
    local v49 = InventoryTemplate:Clone()
    v49.Name = ("FuseSelection.%*"):format(v45)
    v49.LayoutOrder = v47
    v49:SetAttribute("IsInventorySlot", true)
    v49.Active = true
    v49.AutoButtonColor = false
    v49.BackgroundColor3 = Color3.new(0, 0, 0)
    v49.BackgroundTransparency = 0.5
    local UIStroke = v49.UIStroke
    local UIStroke_2 = UIStroke:IsA("UIStroke")
    assert(UIStroke_2, "Fuse inventory row requires UIStroke")
    UIStroke.Thickness = 0
    v49.Visible = true
    v49.Parent = v44._scrollingFrame
    v44._rows:Add(v49)
    local BaseTemplate = v49.BaseTemplate
    local Amount = BaseTemplate.Amount
    local TextLabel = Amount:IsA("TextLabel")
    assert(TextLabel, "Fuse inventory row Amount must be a TextLabel")
    Amount.Text = ""
    Amount.Visible = false
    local Mutations = BaseTemplate.Mutations
    local GuiObject = Mutations:IsA("GuiObject")
    assert(GuiObject, "Fuse inventory row Mutations must be a GuiObject")
    Mutations.Visible = false
    local Icon = v49.Icon
    local ImageLabel = Icon:IsA("ImageLabel")
    assert(ImageLabel, "Fuse inventory row Icon must be an ImageLabel")
    AssetIconShape.Paint(Icon, v46)
    Icon.ImageColor3 = Color3.new(1, 1, 1)
    local v50 = Directory[v46.Category]
    local v51 = v50 ~= nil
    local v52 = ("Missing asset config %*"):format(v46.Category)
    assert(v51, v52)
    local ToolName = v49.ToolName
    local TextLabel_2 = ToolName:IsA("TextLabel")
    assert(TextLabel_2, "Fuse inventory row ToolName must be a TextLabel")
    clearDirectGradients(ToolName)
    v50.Rarity.RarityGradient:Clone().Parent = ToolName
    ToolName.Text = ("%* (%*)"):format(ItemDisplay.GetNameFromItemData(v46), (AssetItems.WeightLabel(v46)))
    ToolName.Visible = true
    local Shadow = v49.Shadow
    local ImageLabel_2 = Shadow:IsA("ImageLabel")
    assert(ImageLabel_2, "Fuse inventory row Shadow must be an ImageLabel")
    clearDirectGradients(Shadow)
    v50.Rarity.RarityGradient:Clone().Parent = Shadow
    Shadow.Visible = true
    local FavIcon = v49.FavIcon
    local GuiObject_2 = FavIcon:IsA("GuiObject")
    assert(GuiObject_2, "Fuse inventory row FavIcon must be a GuiObject")
    FavIcon.Visible = false
    local Weight = v49.Weight
    local GuiObject_3 = Weight:IsA("GuiObject")
    assert(GuiObject_3, "Fuse inventory row Weight must be a GuiObject")
    Weight.Visible = false
    v44._rows:Add(v49.Activated:Connect(function() -- line 191 | captures: v45, v48
        v48(v45)
    end))
    ButtonFX(v49, 1.015)
end

function v2.Open(v53, v54, v55, v56) -- line 196 | captures: AssetItems, FuseKernel, sortLikeBackpack
    if v53._active then
        return 0
    end
    local v57 = {}
    local v58 = {}
    for v59, v60 in pairs(v54.Inventory) do
        if FuseKernel.MayEnterFuse(v59, v60, v55, false) then
            table.insert(v57, v59)
            v58[v59] = AssetItems.Decode(v60)
        end
    end
    table.sort(v57, function(v61, v62) -- line 209 | captures: v58, sortLikeBackpack
        local v63 = v58[v61]
        local v64 = ("Missing Fuse selection item data for %*"):format(v61)
        local v65 = assert(v63, v64)
        local v66 = v58[v62]
        local v67 = ("Missing Fuse selection item data for %*"):format(v62)
        local v68 = assert(v66, v67)
        return (sortLikeBackpack(v65, v61, v68, v62))
    end)
    if #v57 == 0 then
        return 0
    end
    v53._active = true
    v53._scrollingFrame.CanvasPosition = Vector2.zero
    for v69, v70 in ipairs(v57) do
        local v71 = v58[v70]
        local v72 = ("Missing Fuse selection item data for %*"):format(v70)
        v53:_createRow(v70, assert(v71, v72), v69, v56)
    end
    return #v57
end

local function Close(v73) -- line 225
    if not v73._active then
        return
    end
    v73._rows:Clean()
    v73._scrollingFrame.CanvasPosition = Vector2.zero
    v73._active = false
end

v2.Close = Close

local function RefreshGridLayout(v74) -- line 233
    local _active = v74._active
    assert(_active, "FuseMachine backpack selection must be open before refreshing its grid")
    v74._updateGridLayout()
end

v2.RefreshGridLayout = RefreshGridLayout

local function IsOpen(v75) -- line 237
    return v75._active
end

v2.IsOpen = IsOpen

function v2.Destroy(v76) -- line 240 | captures: v1
    v76:Close()
    v76._trove:Destroy()
    v1:AtTrace():Log("Destroyed FuseMachine backpack selection")
end

return v2
