-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "ban",
    Description = "Permanently bans a player from the game.",
    Group = "Administrator",
    Aliases = {},
    Args = { {
            Type = "string",
            Name = "Player",
            Description = "Username or UserId of the player to ban."
        }, {
            Type = "string",
            Name = "Reason",
            Description = "Public reason shown to the player. Use | to separate public|private reason."
        } }
};