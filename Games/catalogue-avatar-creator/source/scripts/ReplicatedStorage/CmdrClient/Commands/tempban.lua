-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "tempban",
    Description = "Temporarily bans a player for a specified duration.",
    Group = "Administrator",
    Aliases = { "tban" },
    Args = { {
            Type = "string",
            Name = "Player",
            Description = "Username or UserId of the player to ban."
        }, {
            Type = "duration",
            Name = "Duration",
            Description = "Ban duration (e.g. 1d, 3d, 1w, 12h)."
        }, {
            Type = "string",
            Name = "Reason",
            Description = "Public reason shown to the player. Use | to separate public|private reason."
        } }
};