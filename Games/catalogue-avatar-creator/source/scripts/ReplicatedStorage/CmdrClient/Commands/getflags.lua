-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "getflags",
    Description = "Gets all flags for a player using ProfileStore MessageAsync.",
    Group = "Administrator",
    Aliases = { "flags", "getflag" },
    Args = { {
            Type = "string",
            Name = "Username",
            Description = "The name of the player."
        }, {
            Type = "string",
            Name = "Flag",
            Description = "Specific key in the Flags table.",
            Optional = true
        } }
};