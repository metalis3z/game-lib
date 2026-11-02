-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Forest",
    Emoji = "\240\159\153\130",
    GuardId = "Forest",
    Icon = "rbxassetid://110449023764288",
    IndexBatGearId = "Forest Bat",
    _id = "Forest",
    DropTable = {
        { "Chicken", 34 },
        { "Dog", 24 },
        { "DesertLark", 17 },
        { "Burrowing Owl", 10 },
        { "Raccoon", 7 },
        { "Mire Fox", 4.5 },
        { "Bear", 2.5 },
        { "Brr Brr Patapim", 1 }
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Common
})
