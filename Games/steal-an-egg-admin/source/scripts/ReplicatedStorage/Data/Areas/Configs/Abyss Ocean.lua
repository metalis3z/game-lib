-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Abyss Ocean",
    Emoji = "\240\159\152\177",
    GuardId = "Abyss Ocean",
    Icon = "rbxassetid://114973940272302",
    IndexBatGearId = "Abyss Ocean Bat",
    _id = "Abyss Ocean",
    DropTable = {
        { "Parrotfish", 34.755713 },
        { "Swordfish", 24.665345 },
        { "Finned Thresher", 19.059585 },
        { "Orca", 14.574977 },
        { "Whale Shark", 3.412663 },
        { "Alabaster Whale", 2.616375 },
        { "Kraken", 8.26453 },
        { "El Maja", 0.08889 }
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Cosmic
})
