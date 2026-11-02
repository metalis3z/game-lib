-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Jungle",
    Emoji = "\240\159\152\172",
    GuardId = "Jungle",
    Icon = "rbxassetid://114796463507768",
    IndexBatGearId = "Jungle Bat",
    _id = "Jungle",
    DropTable = {
        { "Chimpanzee", 26.006779 },
        { "Toucan", 20.005214 },
        { "Crocodile", 17.004432 },
        { "Gorilla", 13.003389 },
        { "Orangutini Ananassini", 11.002868 },
        { "Spider", 7.852047 },
        { "Tiger", 5.001304 },
        { "Warden", 1.23968 }
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Epic
})
