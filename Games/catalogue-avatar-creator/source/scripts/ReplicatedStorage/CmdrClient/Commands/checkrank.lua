-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "checkrank",
    Description = "Run the rank check for a player synchronously and report diagnostics (HTTP errors, current/desired role, etc.).",
    Group = "GameManager",
    Aliases = { "rankcheck" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "Target player."
        } }
};