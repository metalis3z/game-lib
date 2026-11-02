-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GUI = require(ReplicatedStorage.Client.GUI)
require(ReplicatedStorage.Client.Types.GUI)
local Price = require(ReplicatedStorage.Shared.Utils.Marketplace).Price
require(ReplicatedStorage.Data.Products)
local Products = require(ReplicatedStorage.Data.Products)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local v1 = {
    Products.Directory.SpeedPower_150000,
    Products.Directory.SpeedPower_1000000,
    Products.Directory.SpeedPower_10000000,
    Products.Directory.SpeedPower_50000000,
    Products.Directory.SpeedPower_500000000,
    Products.Directory.SpeedPower_1000000000
}
local Speed = GUI.Shop().Frame.ScrollingFrame.Speed
local Speed_2 = GUI.TreadmillSpeedShop().Frame.ScrollingFrame.Speed
local v2 = {}
local v3 = {
    Speed_2.c1,
    Speed_2.c2,
    Speed_2.c3,
    Speed_2.c4,
    Speed_2.c5,
    Speed_2.c6
}

v2[1] = {
    Speed.c1,
    Speed.c2,
    Speed.c3,
    Speed.c4,
    Speed.c5,
    Speed.c6
}
v2[2] = v3

local function updateProductPrice(v4, v5) -- line 46 | captures: Constants, Price
    if v5 == nil then
        v4.Text = "???"
    else
        local ProductId = v5.ProductId
        if ProductId <= 0 then
            v4.Text = "???"
        else
            task.spawn(function() -- line 56 | captures: v4, ProductId, Constants, Price
                local v6, v7 = Price(ProductId, true)
                local v8
                if v7 then
                    v8 = tostring(v6)
                else
                    v8 = "???"
                end
                v4.Text = ("%*%*"):format(Constants.ROBUX_ICON_STR, v8)
            end)
        end
    end
end

local function bindSpeedPowerProductFrame(v9, v10, v11) -- line 67 | captures: ButtonFX, Constants, Price, PromptPurchase, Simple
    local Price_2 = v9.Btns.Buy.Price
    if v10 == nil then
        Price_2.Text = "???"
    else
        local ProductId = v10.ProductId
        if ProductId > 0 then
            task.spawn(function() -- line 73 | captures: Price_2, ProductId, Constants, Price
                local v12, v13 = Price(ProductId, true)
                local v14
                if v13 then
                    v14 = tostring(v12)
                else
                    v14 = "???"
                end
                Price_2.Text = ("%*%*"):format(Constants.ROBUX_ICON_STR, v14)
            end)
        else
            Price_2.Text = "???"
        end
    end
    v9.Title.RichText = true
    local v15 = v11:ToHex()
    v9.Title.Text = ("<font color=\"#%*\">+%*</font> SPEED"):format(v15, (Simple.FormatCompact(v10.SpeedPowerReward, ".#")))
    local Buy = v9.Btns.Buy
    ButtonFX(Buy, nil, function() -- line 92 | captures: v10, PromptPurchase
        PromptPurchase.Prompt(v10.ProductId, true)
    end)
end

if not Save.IsLocalDataLoaded() then
    Save.ProfileReady:Wait()
end
for v16, v17 in ipairs(v2) do
    for v18, v19 in ipairs(v17) do
        local v20 = v1[v18]
        local v21
        if v18 > 3 then
            v21 = Color3.fromRGB(255, 200, 0)
        else
            v21 = Color3.fromRGB(0, 255, 0)
        end
        bindSpeedPowerProductFrame(v19, v20, v21)
    end
end
