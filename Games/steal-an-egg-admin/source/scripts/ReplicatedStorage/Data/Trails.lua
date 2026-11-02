-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local v1 = {
    BlueTrail = table.freeze({
        _id = "BlueTrail",
        Price = 75000,
        Icon = "rbxassetid://89552229715368",
        SpeedMultiplier = 2.5,
        DisplayInShop = true,
        DisplayName = "Blue Trail",
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Trail_BlueTrail,
        Rarity = Rarity.Rarities.Rare
    }),
    DivineTrail = table.freeze({
        _id = "DivineTrail",
        Price = 300000000000000,
        Icon = "rbxassetid://90599887895372",
        SpeedMultiplier = 14,
        DisplayInShop = true,
        DisplayName = "Divine Trail",
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Trail_DivineTrail,
        Rarity = Rarity.Rarities.Divine
    }),
    EternalTrail = table.freeze({
        _id = "EternalTrail",
        Price = 12500000000000,
        Icon = "rbxassetid://134123417984110",
        SpeedMultiplier = 10,
        DisplayInShop = true,
        DisplayName = "Eternal Trail",
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Trail_EternalTrail,
        Rarity = Rarity.Rarities.Eternal
    }),
    GalaxyTrail = table.freeze({
        _id = "GalaxyTrail",
        Price = 20000000000,
        Icon = "rbxassetid://102896664453189",
        SpeedMultiplier = 5,
        DisplayInShop = true,
        DisplayName = "Galaxy Trail",
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Trail_GalaxyTrail,
        Rarity = Rarity.Rarities.Cosmic
    }),
    GoldenTrail = table.freeze({
        _id = "GoldenTrail",
        Price = 30000000,
        Icon = "rbxassetid://106112477122863",
        SpeedMultiplier = 3.5,
        DisplayInShop = true,
        DisplayName = "Golden Trail",
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Trail_GoldenTrail,
        Rarity = Rarity.Rarities.Legendary
    }),
    GreenTrail = table.freeze({
        _id = "GreenTrail",
        Price = 5000,
        Icon = "rbxassetid://102684396551127",
        SpeedMultiplier = 2,
        DisplayInShop = true,
        DisplayName = "Green Trail",
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Trail_GreenTrail,
        Rarity = Rarity.Rarities.Uncommon
    }),
    GreyTrail = table.freeze({
        _id = "GreyTrail",
        Price = 100,
        Icon = "rbxassetid://125097172180827",
        SpeedMultiplier = 1.5,
        DisplayInShop = true,
        DisplayName = "Grey Trail",
        Rarity = Rarity.Rarities.Common
    }),
    PurpleTrail = table.freeze({
        _id = "PurpleTrail",
        Price = 1500000,
        Icon = "rbxassetid://96700840151484",
        SpeedMultiplier = 3,
        DisplayInShop = true,
        DisplayName = "Purple Trail",
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Trail_PurpleTrail,
        Rarity = Rarity.Rarities.Epic
    }),
    RedTrail = table.freeze({
        _id = "RedTrail",
        Price = 750000000,
        Icon = "rbxassetid://126398208882919",
        SpeedMultiplier = 4,
        DisplayInShop = true,
        DisplayName = "Red Trail",
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Trail_RedTrail,
        Rarity = Rarity.Rarities.Mythic
    }),
    SecretTrail = table.freeze({
        _id = "SecretTrail",
        Price = 500000000000,
        Icon = "rbxassetid://129876809370234",
        SpeedMultiplier = 7,
        DisplayInShop = true,
        DisplayName = "Secret Trail",
        ProductId = require(game:GetService("ReplicatedStorage").Data.MonetizationConfig).ProductIds.Trail_SecretTrail,
        Rarity = Rarity.Rarities.Secret
    })
}
table.freeze(v1)
local freeze = table.freeze
local v2 = { Directory = v1 }

function v2.TrailNameExists(v3) -- line 108 | captures: v1
    if v1[v3] == nil then
        return false, (("Trails name \"%*\" does not exist in the Trails directory."):format(v3))
    end
    return true
end

return freeze(v2)
