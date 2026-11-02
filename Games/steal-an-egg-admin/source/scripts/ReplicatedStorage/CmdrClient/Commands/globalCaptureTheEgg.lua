-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "globalCaptureTheEgg",
    Description = "Start the Capture The Egg event in all servers. The egg that drops can be any animal, with any mutation forced onto it.",
    Group = "Moderator",
    Args = {
        {
            Type = "assetName",
            Name = "Egg",
            Description = "The animal the event egg hatches into. Defaults to the event's own egg.",
            Optional = true
        },
        {
            Type = "mutation",
            Name = "Mutation",
            Description = "Mutation forced onto the event egg. None when omitted.",
            Optional = true
        }
    }
}
