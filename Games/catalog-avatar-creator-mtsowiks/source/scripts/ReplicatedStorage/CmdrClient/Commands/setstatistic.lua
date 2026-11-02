-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "setstatistic",
    Description = "Sets a Statistics field on an online player\'s profile (e.g. Customizations, Likes).",
    Group = "GameManager",
    Aliases = { "setstat" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "Target player (must be online)."
        }, {
            Type = "string",
            Name = "Statistic",
            Description = "Statistic key (Customizations, Likes, Sessions, etc.)."
        }, {
            Type = "string",
            Name = "Value",
            Description = "Value (parsed as number/bool/string)."
        } }
};