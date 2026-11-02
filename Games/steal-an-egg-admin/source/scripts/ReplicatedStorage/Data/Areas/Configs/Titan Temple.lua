-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Titan Temple",
    Emoji = "\240\159\166\150",
    GuardId = "Titan Temple",
    Icon = "rbxassetid://137142000533131",
    IndexBatGearId = "Titan Axe",
    _id = "Titan Temple",
    DropTable = {
        { "Kaiju Spider", 37.51 },
        { "Crab", 26.27 },
        { "Blade Head", 16.83 },
        { "Mantis", 13.96 },
        { "Rhino", 4.36 },
        { "Shark", 7.4 },
        { "King Kong", 0.31 },
        { "Godzilla", 0.02 }
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Titan
})
