-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local t = require(ReplicatedStorage.Packages.t)
local AssetGender = require(ReplicatedStorage.Shared.Util.AssetGender)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local AssetRuntime = require(ReplicatedStorage.Shared.Types.AssetRuntime)
local GUI = require(ReplicatedStorage.Client.GUI)
local HoverHighlight = require(ReplicatedStorage.Client.WorldFX.HoverHighlight)
local ModelHover = require(ReplicatedStorage.Client.UI.ModelHover)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local v1 = {}
local v2 = {}
local v3, Key, v4
local v5 = 0
local v6 = {}

local function getKey(v7) -- line 24
    return (("%*:%*"):format(v7.OwnerUserId, v7.UID))
end

local function bindGui() -- line 27 | captures: v3, GUI
    local v8 = v3
    if v8 == nil then
        local v9 = GUI.AssetHoverData()
        local ScreenGui = v9:IsA("ScreenGui")
        assert(ScreenGui, "PlayerGui.AssetHoverData must be a ScreenGui")
        local Frame = v9.Frame
        local GuiObject = Frame:IsA("GuiObject")
        assert(GuiObject, "AssetHoverData.Frame must be a GuiObject")
        local CanvasGroup = Frame.CanvasGroup
        local CanvasGroup_2 = CanvasGroup:IsA("CanvasGroup")
        assert(CanvasGroup_2, "AssetHoverData.Frame.CanvasGroup must be a CanvasGroup")
        local Weight = CanvasGroup.Weight
        local TextLabel = Weight:IsA("TextLabel")
        assert(TextLabel, "AssetHoverData.Frame.CanvasGroup.Weight must be a TextLabel")
        local Gender = CanvasGroup.Gender
        local ImageLabel = Gender:IsA("ImageLabel")
        assert(ImageLabel, "AssetHoverData.Frame.CanvasGroup.Gender must be an ImageLabel")
        local v10 = {
            Root = v9,
            Frame = Frame,
            CanvasGroup = CanvasGroup,
            Weight = Weight,
            Gender = Gender
        }
        v3 = v10
        v9.Enabled = false
        Frame.Visible = false
        CanvasGroup.GroupTransparency = 1
        return v10
    end
    return v8
end

local function clearActiveHighlight() -- line 60 | captures: v4, HoverHighlight
    local v11 = v4
    v4 = nil
    if v11 ~= nil then
        HoverHighlight.FadeOut(v11, 0.2)
    end
end

local function updateFramePosition(v12, v13) -- line 67
    v12.Frame.Position = UDim2.fromOffset(v13.X, v13.Y)
end

local function updateStaticContent(v14, v15) -- line 70 | captures: AssetGender, AssetItems
    v14.Weight.Text = AssetItems.WeightLabel(v15.Record.ItemData)
    v14.Gender.Image = AssetGender.BadgeImage(AssetGender.Settle(v15.Record.ItemData.Category, v15.Record.ItemData.Gender))
end

local function setActiveEntry(v16, v17) -- line 74 | captures: Key, v4, v5, AssetGender, AssetItems, HoverHighlight, Tween, bindGui
    if v16 == nil then
        if Key ~= nil then
            local v18 = bindGui()
            v18.Frame.Position = UDim2.fromOffset(v17.X, v17.Y)
            Key = nil
            v5 += 1
            local v19 = v5
            local v20 = v4
            v4 = nil
            if v20 ~= nil then
                HoverHighlight.FadeOut(v20, 0.2)
            end
            Tween(v18.CanvasGroup, { GroupTransparency = 1 }, {
                0.2,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            }).Completed:Once(function(v21) -- line 90 | captures: v18, v19, Key, v5
                if v21 == Enum.PlaybackState.Completed and Key == nil and v5 == v19 then
                    v18.Frame.Visible = false
                    v18.Root.Enabled = false
                end
            end)
        end
    else
        local v22 = bindGui()
        v22.Frame.Position = UDim2.fromOffset(v17.X, v17.Y)
        v5 += 1
        v22.Root.Enabled = true
        v22.Frame.Visible = true
        if Key ~= v16.Key then
            Key = v16.Key
            local v23 = v4
            v4 = nil
            if v23 ~= nil then
                HoverHighlight.FadeOut(v23, 0.2)
            end
            v4 = HoverHighlight.FadeIn(v16.Model, "AssetHoverHighlight", 0.2)
            v22.Weight.Text = AssetItems.WeightLabel(v16.Record.ItemData)
            v22.Gender.Image = AssetGender.BadgeImage(AssetGender.Settle(v16.Record.ItemData.Category, v16.Record.ItemData.Gender))
            v22.CanvasGroup.GroupTransparency = 1
            Tween(v22.CanvasGroup, { GroupTransparency = 0 }, {
                0.2,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            })
        end
    end
end

function v6.SetEntry(v24) -- line 120 | captures: t, AssetRuntime, v1, v2
    local v25 = AssetRuntime.SchemaValidation.RuntimeAssetRecord(v24.Record)
    assert(v25, "Invalid runtime asset record")
    t.strict(t.instanceIsA("Model"))(v24.Model)
    local Record = v24.Record
    local v26 = ("%*:%*"):format(Record.OwnerUserId, Record.UID)
    v1[v26] = {
        Key = v26,
        Record = v24.Record,
        Model = v24.Model
    }
    v2[v26] = v24.Model
end

function v6.RemoveEntry(v27, v28) -- line 130 | captures: Key, UserInputService, t, v1, v2, setActiveEntry
    t.strict(t.number)(v27)
    t.strict(t.string)(v28)
    local v29 = ("%*:%*"):format(v27, v28)
    v1[v29] = nil
    v2[v29] = nil
    if Key == v29 then
        setActiveEntry(nil, UserInputService:GetMouseLocation())
    end
end

function v6.DestroyOwner(v30) -- line 142 | captures: Key, UserInputService, t, v1, v2, setActiveEntry
    t.strict(t.number)(v30)
    for v31, v32 in pairs(v1) do
        if v32.Record.OwnerUserId == v30 then
            v1[v31] = nil
            v2[v31] = nil
            if Key == v31 then
                setActiveEntry(nil, UserInputService:GetMouseLocation())
            end
        end
    end
end

RunService.RenderStepped:Connect(function() -- line 155 | captures: UserInputService, ModelHover, v1, v2, setActiveEntry
    local v33 = UserInputService:GetMouseLocation()
    local v34 = ModelHover.KeyUnderCursor(v2, v33, 200)
    local v35
    if v34 == nil then
    else
        v35 = v1[v34]
    end
    setActiveEntry(v35, v33)
end)
return table.freeze(v6)
