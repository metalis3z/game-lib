-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "moderateoutfit",
    Description = "Moderate a community outfit (approve, ban, or restore).",
    Group = "ContentModerator",
    Aliases = { "modoutfit" },
    Args = { {
            Type = "string",
            Name = "OutfitIdentifier",
            Description = "The outfit ID or 6-character share code."
        }, {
            Type = "string",
            Name = "Action",
            Description = "The moderation action: approve, ban, or restore."
        }, {
            Type = "string",
            Name = "BanType",
            Description = "Ban type: ban1Day, ban3Days, ban7Days, permBan. Only required for ban action.",
            Optional = true
        }, {
            Type = "string",
            Name = "Reason",
            Description = "Reason for the moderation action. Required for ban action.",
            Optional = true
        } }
};