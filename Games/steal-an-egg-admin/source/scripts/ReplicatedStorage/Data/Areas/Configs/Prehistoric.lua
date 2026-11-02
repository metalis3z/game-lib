-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

require(script.Parent.Parent.Types)
return table.freeze({
    DisplayName = "Prehistoric",
    Emoji = "\240\159\152\168",
    GuardId = "Prehistoric",
    Icon = "rbxassetid://128413001319264",
    IndexBatGearId = "Prehistoric Bat",
    _id = "Prehistoric",
    DropTable = {
        { "Dodo", 39.066058 },
        { "Pterodactyl", 26.044039 },
        { "Ankylosaurus", 20.835231 },
        { "Triceratops", 4.929402 },
        { "Bronto", 6.995959 },
        { "TyrannosaurusRex", 9.91743 },
        { "Tralaledon", 8.26453 },
        { "Mosasaurus", 0.311113 }
    },
    Rarity = require(game:GetService("ReplicatedStorage").Data.Rarity).Rarities.Secret
})
