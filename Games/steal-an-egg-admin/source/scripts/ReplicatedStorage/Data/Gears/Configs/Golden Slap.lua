-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    Description = "Strike with gilded strength to send opponents flying in a long ragdoll.",
    DisplayInShop = true,
    DisplayName = "Golden Slap",
    Icon = "rbxassetid://73587459668895",
    MaxShopStockQuantity = 1,
    MinShopStockQuantity = 1,
    MoneyCost = 15000,
    Persistent = false,
    Rarity = "Legendary",
    ShopDropWeight = 15,
    SinglePurchase = true,
    SlapPower = 35,
    ToolController = "Slap",
    _id = "Golden Slap",
    ControllerData = {
        Brainrot = {
            BrainrotDamage = 14,
            Duration = 0.3,
            Force = 9,
            MaxBrainrotTargets = 1
        },
        Player = {
            BrainrotDamage = 14,
            Duration = 0.85,
            Force = 25,
            MaxBrainrotTargets = 1
        }
    }
})
