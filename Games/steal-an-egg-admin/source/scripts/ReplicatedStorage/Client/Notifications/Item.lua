-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local NotificationInstance = require(script.Parent.NotificationInstance)
local Discard = require(ReplicatedStorage.Shared.Utils.VFX).Discard
local Cooldown = require(ReplicatedStorage.Shared.Utils.Cooldown)
local DeepCopy = require(ReplicatedStorage.Shared.Utils.DeepCopy)
local Tween = require(ReplicatedStorage.Shared.Utils.Instances).Tween
local Audio = require(ReplicatedStorage.Shared.Audio)
local NotificationItem = require(ReplicatedStorage.Shared.NotificationItem)
local NotificationItemCard = require(ReplicatedStorage.Client.UI.NotificationItemCard)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local t = require(ReplicatedStorage.Packages.t)
local UI = ReplicatedStorage:WaitForChild("Assets").UI
local Item2 = UI.Notifications.Bottom.Item2
local Entry = UI.Notifications.Bottom.Item2.Entry
local ItemEcho = UI.OTHER.ItemEcho
local NewItem = UI.Items.NewItem
local LightGreyGradient = UI.Gradients.LightGreyGradient
local RarityNumber = Rarity.Rarities.Cosmic.RarityNumber
local v1 = {}
local v2 = {}
local v3 = Cooldown(0.15)

local function countEntries(v4) -- line 28
    local v5 = 0
    for v6, v7 in ipairs(v4:GetChildren()) do
        if v7:IsA("GuiObject") then
            v5 += 1
        end
    end
    return v5
end

local function playEntrySound(v8) -- line 37 | captures: Audio, RarityNumber, v3
    v3(function() -- line 38 | captures: v8, Audio, RarityNumber
        if RarityNumber <= v8.RarityNumber then
            Audio.Play("rbxassetid://128602051643211", script)
        else
            Audio.Play("rbxassetid://93503698471591", script, { Volume = 2 })
        end
    end)
end

local function fireRipple(v9) -- line 46 | captures: RunService, Discard, Tween, ItemEcho
    local Frame = v9:FindFirstChild("Frame")
    local v10 = Frame
    local ItemHolder
    if Frame then
        ItemHolder = Frame:FindFirstChild("ItemHolder")
        v10 = ItemHolder
    else
        ItemHolder = Frame
    end
    local ScreenGui = v9:FindFirstAncestorWhichIsA("ScreenGui")
    if not (Frame and ItemHolder and ScreenGui) then
        return
    end
    local AbsoluteSize = ItemHolder.AbsoluteSize
    local v11 = ItemEcho:Clone()
    v11.AnchorPoint = Vector2.new(0.5, 0.5)
    v11.BackgroundColor3 = Color3.new(1, 1, 1)
    v11.ZIndex = 1
    v11.Size = UDim2.fromOffset(AbsoluteSize.X * 1.2, AbsoluteSize.Y * 1.2)

    local function pinToIcon() -- line 63 | captures: v10, ScreenGui, v11
        local AbsolutePosition = ScreenGui.AbsolutePosition
        local AbsolutePosition_2 = v10.AbsolutePosition
        local AbsoluteSize = v10.AbsoluteSize
        v11.Position = UDim2.fromOffset(AbsolutePosition_2.X - AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition_2.Y - AbsolutePosition.Y + AbsoluteSize.Y / 2)
    end

    local AbsolutePosition = ScreenGui.AbsolutePosition
    local AbsolutePosition_2 = v10.AbsolutePosition
    local AbsoluteSize_2 = v10.AbsoluteSize
    v11.Position = UDim2.fromOffset(AbsolutePosition_2.X - AbsolutePosition.X + AbsoluteSize_2.X / 2, AbsolutePosition_2.Y - AbsolutePosition.Y + AbsoluteSize_2.Y / 2)
    v11.Parent = ScreenGui
    local v12 = Tween(v11, {
        ImageTransparency = 1,
        Size = UDim2.fromOffset(AbsoluteSize.X * 2.2, AbsoluteSize.Y * 2.2)
    }, { 0.4, "Sine", "Out" })
    local v13

    local function stopTracking() -- line 76 | captures: v13
        if v13 then
            v13:Disconnect()
            v13 = nil
        end
    end

    v13 = RunService.RenderStepped:Connect(function() -- line 82 | captures: v10, v13, v9, ScreenGui, v11, v12
        if v11.Parent then
            if v9.Parent and v10.Parent then
                local AbsolutePosition = ScreenGui.AbsolutePosition
                local AbsolutePosition_2 = v10.AbsolutePosition
                local AbsoluteSize = v10.AbsoluteSize
                v11.Position = UDim2.fromOffset(AbsolutePosition_2.X - AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition_2.Y - AbsolutePosition.Y + AbsoluteSize.Y / 2)
            else
                if v13 then
                    v13:Disconnect()
                    v13 = nil
                end
                v12:Cancel()
                v11:Destroy()
            end
        elseif v13 then
            v13:Disconnect()
            v13 = nil
        end
    end)
    v12.Completed:Once(function() -- line 113 | captures: v13, v11, Discard
        if v13 then
            v13:Disconnect()
            v13 = nil
        end
        Discard(v11)
    end)
end

local function startRippleBurst(v14) -- line 121
    v14.Destroying:Once(function() -- line 123
    end)
end

local function animateEntry(v15, v16) -- line 129 | captures: Tween, Audio, RarityNumber, v3
    local Frame = v15:FindFirstChild("Frame")
    if not Frame then
        return
    end
    v3(function() -- line 134 | captures: v16, Audio, RarityNumber
        if RarityNumber <= v16.RarityNumber then
            Audio.Play("rbxassetid://128602051643211", script)
        else
            Audio.Play("rbxassetid://93503698471591", script, { Volume = 2 })
        end
    end)
    local Glow = v15:FindFirstChild("Glow")
    if Glow then
        Glow.ImageTransparency = 0
        Tween(Glow, { ImageTransparency = 1 }, { 2, "Sine", "InOut" })
        local UIScale = Glow:FindFirstChildOfClass("UIScale")
        if UIScale then
            UIScale.Scale = 3
            Tween(UIScale, { Scale = 1 }, { 2, "Expo", "Out" })
        end
    end
    local ItemHolder = Frame:FindFirstChild("ItemHolder")
    local v17 = ItemHolder and ItemHolder:FindFirstChild("glow")
    if v17 then
        local ImageTransparency = v17.ImageTransparency
        v17.ImageTransparency = 1
        Tween(v17, { ImageTransparency = ImageTransparency }, { 1.5, "Sine", "Out" })
    end
    v15.Destroying:Once(function() -- line 123
    end)
end

local function createEntry(v18) -- line 163 | captures: Tween, NotificationItem, NotificationItemCard, Entry, NewItem, LightGreyGradient, animateEntry
    local v19 = Entry:Clone()
    local ItemHolder = v19.Frame.ItemHolder
    ItemHolder.Item:Destroy()
    ItemHolder.Gradient:Destroy()
    ItemHolder.glow.Gradient:Destroy()
    local Item = v18.Item
    local v20 = NotificationItem.Schema(Item)
    assert(v20, "invalid notification item")
    local Amount = Item.Amount
    local v21 = NotificationItem.Describe(Item)
    local TextLabel = v19.TextLabel
    if Amount <= 1 then
        TextLabel.Text = "New Item!"
    else
        TextLabel.Text = "New Items!"
    end
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    NewItem:Clone().Parent = TextLabel
    local Rarity = v21.Rarity
    local v22 = Rarity.DisplayName == "Basic"
    local v23 = if v22 then LightGreyGradient else Rarity.RarityGradient
    v23:Clone().Parent = ItemHolder
    v23:Clone().Parent = ItemHolder.coreImage
    v23:Clone().Parent = ItemHolder.glow
    local v24 = { NoButtonFX = true }
    if Amount == 1 then
        v24.HideQuantity = Item.Kind ~= "Currency"
    else
        v24.HideQuantity = false
    end
    v24.NoScribble = v22
    local v25 = NotificationItemCard.Build(Item, v24)
    Instance.new("UIAspectRatioConstraint").Parent = v25
    v25.Size = UDim2.fromScale(1, 1)
    v25.Parent = ItemHolder
    local UIScale = Instance.new("UIScale")
    UIScale.Scale = 1.35
    UIScale.Parent = v19
    v19.AnchorPoint = Vector2.new(0.5, 0.5)
    Tween(UIScale, { Scale = 1 }, { 0.35, "Back", "Out" })
    return v19,
        function() -- line 209 | captures: v19, Rarity, animateEntry
            animateEntry(v19, Rarity)
        end
end

local function resolveBatchConfig(v26) -- line 213 | captures: DeepCopy
    local Time, superConfig, v27
    for v28, v29 in ipairs(v26) do
        local superConfig_2 = v29.superConfig
        if type(superConfig_2) == "table" then
            if superConfig_2.Force then
                v27 = v27 or superConfig_2
            end
            local Time_2 = superConfig_2.Time
            if type(Time_2) == "number" then
                if Time == nil then
                    Time = Time_2
                    superConfig = superConfig_2
                elseif Time <= Time_2 then
                end
            end
        end
    end
    local v30 = v27 or superConfig
    if v30 then
        local v31 = DeepCopy(v30)
        if Time ~= nil then
            v31.Time = Time
        end
        if v27 then
            v31.Force = true
        end
        return v31
    end
    return nil
end

local function showBatch(v32) -- line 247 | captures: NotificationInstance, Item2, createEntry, resolveBatchConfig
    local v33 = Item2:Clone()
    local Entry = v33:FindFirstChild("Entry")
    if Entry then
        Entry:Destroy()
    end
    local v34 = {}
    for v35, v36 in ipairs(v32) do
        local v37, v38 = createEntry(v36.config)
        v37.LayoutOrder = v35
        v37.Parent = v33
        table.insert(v34, v38)
    end
    NotificationInstance.Enqueue(NotificationInstance.Locations.Bottom, v33, function() -- line 261 | captures: v34
        for v39, v40 in ipairs(v34) do
            task.spawn(v40)
        end
    end, (resolveBatchConfig(v32)))
end

local function appendToVisibleCard(v41) -- line 267 | captures: NotificationInstance, Item2, countEntries, createEntry
    local v42 = {}
    for v43, v44 in ipairs(NotificationInstance.InlineBottomRenders()) do
        if v44.created ~= nil and not v44.tweening then
            table.insert(v42, v44)
        end
    end
    table.sort(v42, function(v45, v46) -- line 275
        return v45.created < v46.created
    end)
    for v47, v48 in ipairs(v42) do
        local frame = v48.frame
        if frame.Name == Item2.Name then
            local v49 = countEntries(frame)
            if v49 < 4 then
                v48.created = tick()
                local v50, v51 = createEntry(v41)
                v50.LayoutOrder = v49 + 1
                v50.Parent = frame
                task.spawn(v51)
                return true
            end
        end
    end
    return false
end

function v1.Bottom(v52, v53) -- line 295 | captures: t, v2, appendToVisibleCard
    t.strict(t.table)(v52)
    t.strict(t.table)(v52.Item)
    if not appendToVisibleCard(v52) and not (#v2 >= 16) then
        local v54 = {
            config = v52,
            superConfig = v53
        }
        table.insert(v2, v54)
    end
end

task.spawn(function() -- line 309 | captures: v2, showBatch
    while true do
        if #v2 == 0 then
            task.wait()
            continue
        end
        local v55 = {}
        while true do
            if #v2 <= 0 then
                break
            end
            if #v55 >= 4 then
                break
            end
            local v56 = table.remove(v2, 1)
            table.insert(v55, v56)
        end
        showBatch(v55)
        task.wait(0.25)
    end
end)
return v1
