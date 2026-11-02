-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "renameoutfit",
    Description = "Renames a community outfit by its ID or share code.",
    Group = "ContentModerator",
    Aliases = { "renoutfit" },
    Args = { {
            Type = "string",
            Name = "OutfitIdentifier",
            Description = "The outfit ID or 6-character share code."
        }, {
            Type = "string",
            Name = "NewName",
            Description = "The new name (1-25 chars, no consecutive whitespace)."
        } }
};