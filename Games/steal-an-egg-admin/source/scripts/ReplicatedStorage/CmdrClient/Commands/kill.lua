-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "kill",
    Description = "Kills a player or set of players.",
    Group = "DefaultAdmin",
    Aliases = { "slay" },
    Args = {
        {
            Type = "players",
            Name = "victims",
            Description = "The players to kill."
        }
    }
}
