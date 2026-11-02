-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Volcano",
    Emoji = "\240\159\152\176",
    GuardId = "Volcano",
    Icon = "rbxassetid://114058528069937",
    IndexBatGearId = "Volcano Bat",
    _id = "Volcano",
    DropTable = {
        { "Ash Gecko", 26.848869 },
        { "Lava frog", 22.040116 },
        { "Flaming Bull", 18.032822 },
        { "Lava Iguana", 15.027352 },
        { "Chillin Chilli", 17.030999 },
        { "Cerberus", 6.1984 },
        { "Ascended Vermilion Phoenix", 0.222224 },
        { "Dragon", 0.177779 }
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Mythic
})
