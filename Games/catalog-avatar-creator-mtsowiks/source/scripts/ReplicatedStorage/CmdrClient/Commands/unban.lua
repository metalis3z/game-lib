-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "unban",
    Description = "Unbans a player.",
    Group = "Administrator",
    Aliases = {},
    Args = { {
            Type = "string",
            Name = "Player",
            Description = "Username or UserId of the player to unban."
        }, {
            Type = "string",
            Name = "Reason",
            Description = "Reason for unbanning the player.",
            Optional = true,
            Default = "No reason provided."
        } }
};