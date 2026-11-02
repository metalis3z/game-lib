-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Cherry Blossom",
    Emoji = "\240\159\140\184",
    GuardId = "Cherry Blossom",
    Icon = "rbxassetid://128921736835133",
    IndexBatGearId = "Katana",
    Lighting = "CherryBlossom",
    _id = "Cherry Blossom",
    DropTable = {
        { "Crane", 37.51 },
        { "Salamander", 26.27 },
        { "Red Panda", 16.83 },
        { "Snowy Owl", 13.96 },
        { "Koi", 4.36 },
        { "Stag", 7.4 },
        { "Oni Tiger", 0.31 },
        { "Kitsune", 0.02 }
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Divine
})
