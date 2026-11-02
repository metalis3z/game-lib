-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local MonetizationEntitlements = require(ReplicatedStorage.Shared.Util.MonetizationEntitlements)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local Products = require(ReplicatedStorage.Data.Products)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Trails = require(ReplicatedStorage.Data.Trails)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local v1 = Color3.fromRGB(9, 255, 0)

local function formatCashPrice(v2) -- line 21
    local v3 = tonumber(v2) or 0
    local v4 = math.max(0, v3)
    local v5 = {
        { 1000000000000, "T" },
        { 1000000000, "B" },
        { 1000000, "M" },
        { 1000, "K" }
    }
    for v6, v7 in ipairs(v5) do
        if v7[1] <= v4 then
            local v8 = v4 / v7[1]
            local v9
            if v8 < 10 then
                v9 = 2
            elseif v8 < 100 then
                v9 = 1
            else
                v9 = 0
            end
            local v10 = string.format("%." .. v9 .. "f", v8)
            if string.find(v10, ".", 1, true) then
                v10 = v10:gsub("0+$", ""):gsub("%.$", "")
            end
            return "$" .. v10 .. v7[2]
        end
    end
    local v11 = math.floor(v4)
    return "$" .. tostring(v11)
end

local ScrollingFrame = GUI.TrailShop().Frame.ScrollingFrame
local UIListLayout = ScrollingFrame:FindFirstChildOfClass("UIListLayout")
local v12 = UIListLayout ~= nil
assert(v12, "TrailShop.Frame.ScrollingFrame needs a UIListLayout")
local Frame = Instance.new("Frame")

Frame.Name = "TrailingGap"
Frame.BackgroundTransparency = 1
Frame.BorderSizePixel = 0
Frame.LayoutOrder = 1000000
Frame.Size = UDim2.new()
Frame.Parent = ScrollingFrame

local v13 = {}
local v14 = {}

local function refreshEntry(v15, v16) -- line 55 | captures: Products, Save, Trails, formatCashPrice
    local v17 = Save.Get()
    local v18 = v17 ~= nil
    assert(v18, "Expected local save data")
    local v19 = v17.TrailInventory[v16] == true
    local v20 = v17.EquippedTrail == v16
    v15.LockedControls.BuyCash.Price.Text = formatCashPrice(Trails.Directory[v16].Price)
    v15.LockedControls.Visible = not v19
    v15.OwnedControls.Visible = v19
    local v21 = v19 and not v20
    v15.OwnedControls.Equip.Visible = v21
    v15.OwnedControls.Unequip.Visible = v19 and v20
    if v19 then
        return
    end
    local ProductId = Trails.Directory[v16].ProductId
    local v22 = if ProductId == nil then false else Products.DataByProductId[ProductId] ~= nil
    v15.LockedControls.BuyRbx.Visible = v22
end

local function showFailure(v23) -- line 76 | captures: Message
    Message.Bottom({
        Time = 3,
        Message = v23,
        Color = Color3.fromRGB(255, 64, 64)
    })
end

local function requestPurchase(v24, v25) -- line 79 | captures: Message, Remotes, refreshEntry
    local v26, v27 = Remotes.Trailwear.AskPurchase:InvokeServer(v24)
    if not v26 then
        Message.Bottom({
            Time = 3,
            Message = v27 or "Trail request failed",
            Color = Color3.fromRGB(255, 64, 64)
        })
    end
    refreshEntry(v25, v24)
end

local function requestWear(v28, v29, v30) -- line 87 | captures: Message, Remotes, refreshEntry
    local v31, v32
    if v30 then
        v31, v32 = Remotes.Trailwear.AskChoose:InvokeServer(v28)
    else
        v31, v32 = Remotes.Trailwear.AskDoff:InvokeServer()
    end
    if not v31 then
        Message.Bottom({
            Time = 3,
            Message = v32 or "Trail request failed",
            Color = Color3.fromRGB(255, 64, 64)
        })
    end
    refreshEntry(v29, v28)
end

if not Save.IsLocalDataLoaded() then
    Save.ProfileReady:Wait()
end
local v33 = {}
for v34, v35 in pairs(Trails.Directory) do
    if v35.DisplayInShop then
        v33[#v33 + 1] = v34
    end
end
table.sort(v33, function(v36, v37) -- line 112 | captures: Trails
    return Trails.Directory[v36].Price < Trails.Directory[v37].Price
end)
for v38, v39 in ipairs(v33) do
    local v40 = Trails.Directory[v39]
    local v41 = ScrollingFrame:FindFirstChild(v39)
    local v42
    if v41 == nil then
        v42 = false
    else
        v42 = v41:IsA("ImageLabel")
    end
    local v43 = ("TrailShop has no card for \"%*\""):format(v39)
    assert(v42, v43)
    v41.LayoutOrder = v38
    v41.TrailName.Text = v40.DisplayName
    v41.TrailRarity.Text = v40.Rarity.DisplayName
    v41.Icon.Image = v40.Icon
    v41.Multi.Value.RichText = true
    local v44 = v1:ToHex()
    v41.Multi.Value.Text = ("<font color=\"#%*\">%*</font> <font color=\"#FFFFFF\">Speed</font>"):format(v44, (TreadmillUtil.FormatSpeedMultiplierValue(v40.SpeedMultiplier)))
    v13[v39] = { Card = v41 }
    local BuyCash = v41.LockedControls.BuyCash
    local v45 = v39
    ButtonFX(BuyCash, 1.05, function() -- line 131 | captures: Message, Remotes, refreshEntry, v41, v45
        local v46, v47 = Remotes.Trailwear.AskPurchase:InvokeServer(v45)
        if not v46 then
            Message.Bottom({
                Time = 3,
                Message = v47 or "Trail request failed",
                Color = Color3.fromRGB(255, 64, 64)
            })
        end
        refreshEntry(v41, v45)
    end)
    local Equip = v41.OwnedControls.Equip
    ButtonFX(Equip, 1.05, function() -- line 140 | captures: Message, Remotes, refreshEntry, v41, v45
        local v48, v49 = Remotes.Trailwear.AskChoose:InvokeServer(v45)
        if not v48 then
            Message.Bottom({
                Time = 3,
                Message = v49 or "Trail request failed",
                Color = Color3.fromRGB(255, 64, 64)
            })
        end
        refreshEntry(v41, v45)
    end)
    local Unequip = v41.OwnedControls.Unequip
    ButtonFX(Unequip, 1.05, function() -- line 149 | captures: Message, Remotes, refreshEntry, v41, v45
        local v50, v51 = Remotes.Trailwear.AskDoff:InvokeServer()
        if not v50 then
            Message.Bottom({
                Time = 3,
                Message = v51 or "Trail request failed",
                Color = Color3.fromRGB(255, 64, 64)
            })
        end
        refreshEntry(v41, v45)
    end)
    local BuyRbx = v41.LockedControls.BuyRbx
    ButtonFX(BuyRbx, 1.05, function() -- line 157 | captures: Message, Products, PromptPurchase, v40
        local ProductId = v40.ProductId
        if ProductId == nil or Products.DataByProductId[ProductId] == nil then
            Message.Bottom({
                Message = "This trail Robux product is not configured yet",
                Time = 3,
                Color = Color3.fromRGB(255, 64, 64)
            })
        else
            PromptPurchase.Prompt(ProductId, true)
        end
    end)
    if v40.ProductId ~= nil and Products.DataByProductId[v40.ProductId] ~= nil then
        v41.LockedControls.BuyRbx.Price.Text = ""
        if not v14[v40.ProductId] then
            v14[v40.ProductId] = true
            local spawn = task.spawn
            local v52 = v39
            spawn(function() -- line 169 | captures: Simple, MonetizationEntitlements, v13, v40, v41, v52
                local v53 = MonetizationEntitlements.ProductPrice(v40.ProductId)
                local v54 = v13[v52]
                if v54 ~= nil and v53 > 0 then
                    v54.RobuxPrice = v53
                    v41.LockedControls.BuyRbx.Price.Text = Simple.FormatCompact(v53, ".#")
                end
            end)
        end
    end
    refreshEntry(v41, v39)
end
ScrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line 183 | captures: ScrollingFrame, UIListLayout, Frame
    local Padding = UIListLayout.Padding
    local v55 = Padding.Scale * ScrollingFrame.AbsoluteSize.X + Padding.Offset
    local v56 = math.ceil(v55)
    Frame.Size = UDim2.fromOffset(v56, 0)
end)
local Padding = UIListLayout.Padding
local v57 = Padding.Scale * ScrollingFrame.AbsoluteSize.X + Padding.Offset
local v58 = math.ceil(v57)

Frame.Size = UDim2.fromOffset(v58, 0)
Save.WatchFields({ "TrailInventory", "EquippedTrail" }, function() -- line 191 | captures: v13, refreshEntry, v33
    for v59, v60 in ipairs(v33) do
        local v61 = v13[v60]
        local v62 = v61 ~= nil
        local v63 = ("Missing trail shop entry \"%*\""):format(v60)
        assert(v62, v63)
        refreshEntry(v61.Card, v60)
    end
end)
return {}
