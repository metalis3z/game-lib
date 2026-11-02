-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "giveSakuraCrystals",
    Description = "Gives the player Sakura Crystals.",
    Group = "Admin",
    Aliases = { "" },
    Args = {
        {
            Type = "players",
            Name = "Player",
            Description = "The players to give crystals to."
        },
        {
            Type = "integer",
            Name = "Amount",
            Description = "The amount of crystals to give."
        }
    }
}
