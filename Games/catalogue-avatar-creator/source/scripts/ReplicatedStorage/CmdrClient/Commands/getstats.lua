-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "getstats",
    Description = "Prints all Statistics fields for an online player.",
    Group = "GameManager",
    Aliases = { "getstatistics", "stats" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "Target player (must be online)."
        } }
};