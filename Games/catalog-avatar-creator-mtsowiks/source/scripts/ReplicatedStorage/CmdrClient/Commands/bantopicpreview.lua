-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

return {
    Name = "bantopicpreview",
    Description = "Hides an outfit from being surfaced as a topic-tile preview (top-match per topic). Outfit stays available in /search and elsewhere.",
    Group = "ContentModerator",
    Aliases = { "hidefromtopic" },
    Args = { {
            Type = "string",
            Name = "OutfitIdentifier",
            Description = "The outfit ID or 6-character share code."
        }, {
            Type = "string",
            Name = "Reason",
            Description = "Why this outfit is being hidden from topic previews.",
            Optional = true
        } }
};