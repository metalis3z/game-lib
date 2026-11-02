-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "setcredits",
    Description = "Sets a Credits field (Balance or Earned) on an online player\'s profile.",
    Group = "GameManager",
    Aliases = {},
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "Target player (must be online)."
        }, {
            Type = "string",
            Name = "Field",
            Description = "Balance or Earned."
        }, {
            Type = "number",
            Name = "Value",
            Description = "New value (clamped to >= 0)."
        } }
};