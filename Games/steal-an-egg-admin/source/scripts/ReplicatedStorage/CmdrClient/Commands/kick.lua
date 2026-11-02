-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "kick",
    Description = "Kicks a player or set of players.",
    Group = "DefaultAdmin",
    Aliases = { "boot" },
    Args = {
        {
            Type = "players",
            Name = "players",
            Description = "The players to kick."
        }
    }
}
