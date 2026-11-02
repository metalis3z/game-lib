-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    Description = "Unleash a demonic slap that ragdolls victims with overwhelming force.",
    DisplayInShop = true,
    DisplayName = "Demon Slap",
    Icon = "rbxassetid://103235472197288",
    MaxShopStockQuantity = 1,
    MinShopStockQuantity = 1,
    MoneyCost = 4400000,
    Persistent = false,
    Rarity = "Prismatic",
    ShopDropWeight = 0.25,
    SinglePurchase = true,
    SlapPower = 80,
    ToolController = "Slap",
    _id = "Demon Slap",
    ControllerData = {
        Brainrot = {
            BrainrotDamage = 40,
            Duration = 0.5,
            Force = 35,
            MaxBrainrotTargets = 1
        },
        Player = {
            BrainrotDamage = 40,
            Duration = 1.03,
            Force = 35,
            MaxBrainrotTargets = 1
        }
    }
})
