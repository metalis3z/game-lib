-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Snow",
    Emoji = "\240\159\152\159",
    GuardId = "Snow",
    Icon = "rbxassetid://94742267172174",
    IndexBatGearId = "Snow Bat",
    _id = "Snow",
    DropTable = {
        { "Penguin", 29.444067 },
        { "Walrus", 21.570745 },
        { "Polar Bear", 18.335133 },
        { "Sabertooth Tiger", 14.020984 },
        { "Mammoth", 11.86391 },
        { "Colossal Mammoth", 4.171033 },
        { "Yeti", 3.71904 },
        { "Ice Dragon", 0.222224 }
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Legendary
})
