-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local NotificationItem = require(ReplicatedStorage.Shared.NotificationItem)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local InfoOverlay = require(ReplicatedStorage.Client.InfoOverlay)
local Sparkles = require(ReplicatedStorage.Client.UI.VFX.Sparkles)
local v1 = {
    Mythical = true,
    Legendary = true,
    Rainbow = true,
    Exotic = true,
    Divine = true
}
local v2 = {}

function v2.Build(v3, v4) -- line 20 | captures: Audio, NotificationItem, Simple, InfoOverlay, Sparkles, v1
    local v5 = NotificationItem.Schema(v3)
    assert(v5, "invalid notification item card")
    local v6 = v4 or {}
    local v7 = NotificationItem.Describe(v3)
    local Rarity = v7.Rarity
    local v8 = Rarity.ItemTemplate:Clone()
    v8.Icon.Image = v7.Icon
    v8.Quantity.Text = ("x%*"):format(Simple.FormatCompact(v3.Amount))
    v8.Strength.Visible = false
    local Level = v8:FindFirstChild("Level")
    if Level then
        Level.Visible = false
    end
    if v6.HideQuantity then
        v8.Quantity.Visible = false
    end
    if v6.NoScribble then
        v8.scribble.Visible = false
    end
    local v9 = {}
    local v10 = {}
    local v11 = (" %* "):format(v7.Name)
    v10[1] = "Title"
    v10[2] = v11
    v10[3] = "Rare"
    local v12 = {
        "Rarity",
        Rarity._id
    }
    v9[1] = v10
    v9[2] = v12
    if v7.Description ~= "" then
        local v13 = { "Div" }
        table.insert(v9, v13)
        local v14 = {
            "Desc",
            v7.Description
        }
        table.insert(v9, v14)
    end
    InfoOverlay.Hook(v8, function() -- line 57 | captures: v9, Audio
        Audio.Play("rbxassetid://72058086648303", script, { Volume = 0.2 })
        return v9
    end)
    if not v6.NoButtonFX then
        Sparkles(v8)
    end
    if v1[Rarity._id] then
        local v15 = false
        v8.AncestryChanged:Connect(function(v16, v17) -- line 66 | captures: v15, v8, Sparkles
            if v17 ~= nil and not v15 then
                task.defer(function() -- line 68 | captures: v8, Sparkles
                    Sparkles(v8)
                end)
                v15 = true
            end
        end)
    end
    return v8
end

return v2
