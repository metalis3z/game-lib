-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    COOLDOWN = 10,
    Description = "Pull targets towards you with magnetic force",
    DisplayInShop = false,
    DisplayName = "Magnet",
    Icon = "rbxassetid://999316662",
    MAX_RANGE = 50,
    MaxShopStockQuantity = 1,
    MinShopStockQuantity = 1,
    MoneyCost = 200000000,
    PULL_DURATION = 3,
    PULL_FORCE = 50,
    PULL_SFX_ID = "rbxassetid://0",
    PULL_SMOOTHNESS = 0.15,
    PULL_SPEED = 10,
    Persistent = false,
    Rarity = "Uncommon",
    SHOW_RANGE_INDICATOR = false,
    ShopDropWeight = 60,
    SinglePurchase = true,
    ToolController = "None",
    _id = "Magnet",
    BEAM_TEMPLATE_PATH = game:GetService("ReplicatedStorage").Assets.ToolEffects.beamTrail,
    MAGNET_EFFECT_PATH = game:GetService("ReplicatedStorage").Assets.ToolEffects.MagnetEffect
})
