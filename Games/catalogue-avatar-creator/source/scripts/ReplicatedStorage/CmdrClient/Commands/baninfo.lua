-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "baninfo",
    Description = "View ban status and details for a player.",
    Group = "Administrator",
    Aliases = { "viewban", "isbanned" },
    Args = { {
            Type = "string",
            Name = "Player",
            Description = "Username or UserId of the player to check."
        } }
};