-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "setflag",
    Description = "Sets a specific flag for a player using ProfileStore MessageAsync.",
    Group = "GameManager",
    Aliases = { "flag" },
    Args = { {
            Type = "string",
            Name = "Username",
            Description = "The name of the player."
        }, {
            Type = "string",
            Name = "Flag",
            Description = "The key in the Flags table."
        }, {
            Type = "string",
            Name = "Value",
            Description = "The value to set."
        } }
};