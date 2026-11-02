-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "earningsBoost",
    Description = "Gives the player the x2 earnings boost. Duration 0 clears it.",
    Group = "Admin",
    Aliases = { "" },
    Args = {
        {
            Type = "players",
            Name = "Player",
            Description = "The players to boost."
        },
        {
            Type = "integer",
            Name = "DurationSeconds",
            Description = "Seconds to add (default 900). 0 clears the boost.",
            Optional = true
        }
    }
}
