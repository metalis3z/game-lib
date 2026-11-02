-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    Description = "A trusty slap that ragdolls nearby players with a solid launch.",
    DisplayInShop = true,
    DisplayName = "Slap",
    Icon = "rbxassetid://111744314864127",
    MaxShopStockQuantity = 1,
    MinShopStockQuantity = 1,
    MoneyCost = 500,
    Persistent = false,
    Rarity = "Rare",
    ShopDropWeight = 30,
    SinglePurchase = true,
    SlapPower = 15,
    ToolController = "Slap",
    _id = "Slap",
    ControllerData = {
        Brainrot = {
            BrainrotDamage = 12,
            Duration = 0.25,
            Force = 7,
            MaxBrainrotTargets = 1
        },
        Player = {
            BrainrotDamage = 12,
            Duration = 0.8,
            Force = 25,
            MaxBrainrotTargets = 1
        }
    }
})
