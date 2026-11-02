-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "deleteoutfit",
    Description = "Deletes a community outfit by its ID or share code.",
    Group = "ContentModerator",
    Aliases = { "deloutfit" },
    Args = { {
            Type = "string",
            Name = "OutfitIdentifier",
            Description = "The outfit ID or 6-character share code."
        } }
};