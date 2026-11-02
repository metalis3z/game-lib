-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    Description = "Radiate power with a vivid slap that ragdolls enemies for an extended time.",
    DisplayInShop = true,
    DisplayName = "Emerald Slap",
    Icon = "rbxassetid://125486072175077",
    MaxShopStockQuantity = 1,
    MinShopStockQuantity = 1,
    MoneyCost = 200000,
    Persistent = false,
    Rarity = "Rare",
    ShopDropWeight = 30,
    SinglePurchase = true,
    SlapPower = 40,
    ToolController = "Slap",
    _id = "Emerald Slap",
    ControllerData = {
        Brainrot = {
            BrainrotDamage = 17,
            Duration = 0.33,
            Force = 11,
            MaxBrainrotTargets = 1
        },
        Player = {
            BrainrotDamage = 17,
            Duration = 0.83,
            Force = 32,
            MaxBrainrotTargets = 1
        }
    }
})
