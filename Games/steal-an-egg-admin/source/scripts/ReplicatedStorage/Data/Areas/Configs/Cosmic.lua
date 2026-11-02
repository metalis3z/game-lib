-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Cosmic",
    Emoji = "\240\159\145\185",
    GuardId = "Cosmic",
    Icon = "rbxassetid://130113964572741",
    IndexBatGearId = "Cosmic Bat",
    _id = "Cosmic",
    DropTable = {
        { "Centapede", 39.869773 },
        { "Galaxy Gecko", 34.387407 },
        { "Cyclops Gorilla", 19.618806 },
        { "La Vacca Saturno Saturnita", 4.550072 },
        { "Alien Skeleton Boss", 4.95856 },
        { "Cave Dragon", 7.43784 },
        { "Eternal Lunar Dragon", 0.311104 },
        { "Unicorn", 0.0231993 }
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Eternal
})
