-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "warn",
    Description = "Warns a player with a fullscreen acknowledgment popup. Works for offline players.",
    Group = "Administrator",
    Aliases = {},
    Args = { {
            Type = "string",
            Name = "Player",
            Description = "Username or UserId of the player to warn."
        }, {
            Type = "string",
            Name = "Reason",
            Description = "Reason shown to the player."
        } }
};