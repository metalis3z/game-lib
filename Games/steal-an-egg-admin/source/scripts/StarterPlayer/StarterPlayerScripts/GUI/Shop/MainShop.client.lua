-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Gamepasses = require(ReplicatedStorage.Client.Gamepasses)
local Gamepasses_2 = require(ReplicatedStorage.Data.Gamepasses)
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
local MonetizationEntitlements = require(ReplicatedStorage.Shared.Util.MonetizationEntitlements)
local Products = require(ReplicatedStorage.Data.Products)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local SurfaceButton = require(ReplicatedStorage.Client.UI.VFX.SurfaceButton)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local LocalPlayer = Players.LocalPlayer
local ScrollingFrame = GUI.Shop().Frame.ScrollingFrame
local Money = ScrollingFrame.Money
local Passes = ScrollingFrame.Passes
local v1 = utf8.char(57346)
local v2 = {
    {
        card = Money.c1,
        config = Products.Directory.Money_24000
    },
    {
        card = Money.c2,
        config = Products.Directory.Money_200000
    },
    {
        card = Money.c3,
        config = Products.Directory.Money_800000
    },
    {
        card = Money.c4,
        config = Products.Directory.Money_4000000
    },
    {
        card = Money.c5,
        config = Products.Directory.Money_8000000
    }
}
local v3 = {
    {
        card = Passes.Money,
        config = Gamepasses_2.Directory.X2Money
    },
    {
        card = Passes.Growth,
        config = Gamepasses_2.Directory.X2Growth
    }
}
for v4, v5 in ipairs(v2) do
    local Buy = v5.card.Btns.Buy
    Buy.Price.Text = v1 .. "..."
    local v6 = v5
    ButtonFX(Buy, nil, function() -- line 39 | captures: PromptPurchase, v6
        PromptPurchase.Prompt(v6.config.ProductId, true)
    end)
    local spawn = task.spawn
    spawn(function() -- line 42 | captures: MonetizationEntitlements, Simple, v1, Buy, v6
        local v7 = MonetizationEntitlements.ProductPrice(v6.config.ProductId)
        if Buy.Parent == nil then
            return
        end
        local Price = Buy.Price
        if v7 > 0 then
            Price.Text = v1 .. Simple.FormatCompact(v7, ".#")
        else
            Price.Text = v1 .. "?"
        end
    end)
end
local v8 = 0

local function refreshPasses() -- line 51 | captures: v8, Gamepasses, MonetizationEntitlements, Simple, v1, v3
    v8 += 1
    local v9 = v8
    for v10, v11 in ipairs(v3) do
        local v12 = Gamepasses.Owns(v11.config._id)
        local Price = v11.card.Price
        if v12 then
            Price.Text = "OWNED"
        else
            Price.Text = v1 .. "..."
            local spawn = task.spawn
            local v13 = v11
            spawn(function() -- line 58 | captures: v9, v13, v8, Gamepasses, MonetizationEntitlements, Simple, v1
                local v14 = MonetizationEntitlements.GamepassPrice(v13.config.ProductId)
                local Price, v15, v16
                if v9 == v8 then
                    if v13.card.Parent == nil or Gamepasses.Owns(v13.config._id) then
                        v16 = true
                    else
                        Price = v13.card.Price
                        if v14 > 0 then
                            v15 = v1 .. Simple.FormatCompact(v14, ".#")
                        else
                            v15 = v1 .. "?"
                        end
                        v16 = false
                    end
                else
                    v16 = true
                end
                if not v16 then
                    Price.Text = v15
                end
            end)
        end
    end
end

for v17, v18 in ipairs(v3) do
    local card = v18.card
    local v19 = v18
    SurfaceButton(card, 1.08, function() -- line 69 | captures: Gamepasses, PromptPurchase, v19
        if not Gamepasses.Owns(v19.config._id) then
            PromptPurchase.Prompt(v19.config.ProductId, false)
        end
    end)
end
local ShopButton = Hud.Find("ShopButton")

if ShopButton then
    ButtonFX(ShopButton, 1.08, function() -- line 78 | captures: Tabs
        Tabs.Toggle("Shop")
    end)
end
refreshPasses()
Save.ProfileReady:Connect(function(v20) -- line 84 | captures: LocalPlayer, refreshPasses
    if v20 == LocalPlayer then
        refreshPasses()
    end
end)
Save.WatchFields("Gamepasses", refreshPasses)
return {}
