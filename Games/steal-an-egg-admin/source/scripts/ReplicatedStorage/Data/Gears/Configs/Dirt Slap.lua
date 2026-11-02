-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    Description = "A heavy clod of dirt that splatters opponents, leaving them stunned and covered in grime.",
    DisplayInShop = true,
    DisplayName = "Dirt Slap",
    Icon = "rbxassetid://126416331206871",
    MaxShopStockQuantity = 1,
    MinShopStockQuantity = 1,
    MoneyCost = 2500,
    Persistent = false,
    Rarity = "Common",
    ShopDropWeight = 100,
    SinglePurchase = true,
    SlapPower = 25,
    ToolController = "Slap",
    _id = "Dirt Slap",
    ControllerData = {
        Brainrot = {
            BrainrotDamage = 11,
            Duration = 0.2,
            Force = 4,
            MaxBrainrotTargets = 1
        },
        Player = {
            BrainrotDamage = 11,
            Duration = 0.78,
            Force = 24,
            MaxBrainrotTargets = 1
        }
    }
})
