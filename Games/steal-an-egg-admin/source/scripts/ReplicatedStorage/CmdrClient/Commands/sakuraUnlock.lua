-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "sakuraUnlock",
    Description = "Unlocks or re-seals the Sakura Incubator for the players.",
    Group = "Admin",
    Aliases = { "" },
    Args = {
        {
            Type = "players",
            Name = "Player",
            Description = "The players to change."
        },
        {
            Type = "boolean",
            Name = "Unlocked",
            Description = "true to unlock, false to seal."
        }
    }
}
