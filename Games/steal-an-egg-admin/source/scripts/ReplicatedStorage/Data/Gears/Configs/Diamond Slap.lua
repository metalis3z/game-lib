-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    Description = "A fully diamond powered strong slap.",
    DisplayInShop = true,
    DisplayName = "Diamond Slap",
    Icon = "rbxassetid://103400414014905",
    MaxShopStockQuantity = 1,
    MinShopStockQuantity = 1,
    MoneyCost = 50000,
    Persistent = false,
    Rarity = "Rare",
    ShopDropWeight = 30,
    SinglePurchase = true,
    SlapPower = 65,
    ToolController = "Slap",
    _id = "Diamond Slap",
    ControllerData = {
        Brainrot = {
            BrainrotDamage = 20,
            Duration = 0.2,
            Force = 10,
            MaxBrainrotTargets = 1
        },
        Player = {
            BrainrotDamage = 20,
            Duration = 0.8,
            Force = 29,
            MaxBrainrotTargets = 1
        }
    }
})
