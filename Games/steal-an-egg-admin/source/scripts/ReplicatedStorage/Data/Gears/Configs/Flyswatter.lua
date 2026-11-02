-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    Description = "A parasite-event flyswatter that ragdolls nearby players.",
    DisplayInShop = false,
    DisplayName = "Flyswatter",
    Icon = "rbxassetid://120654052677460",
    MaxShopStockQuantity = 99,
    MinShopStockQuantity = 0,
    MoneyCost = 0,
    Persistent = true,
    Rarity = "Prismatic",
    ShopDropWeight = 0,
    SinglePurchase = false,
    SlapPower = 80,
    ToolController = "Slap",
    _id = "Flyswatter",
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
