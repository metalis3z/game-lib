-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Desert",
    Emoji = "\240\159\152\174",
    GuardId = "Desert",
    Icon = "rbxassetid://84222502657359",
    IndexBatGearId = "Desert Bat",
    _id = "Desert",
    DropTable = {
        { "Jerboa", 26.585432 },
        { "FennecFox", 20.450332 },
        { "Camel", 15.337749 },
        { "Tob Tobi Tob Tob", 12.270199 },
        { "Rattlesnake", 9.20265 },
        { "Sand Spider", 8.180133 },
        { "DeathstalkerScorpion", 6.646358 },
        { "Irihorus", 1.327147 }
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Rare
})
