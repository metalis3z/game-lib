-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "globalStartEvent",
    Description = "Start an event in all servers",
    Group = "Moderator",
    Args = {
        {
            Type = "adminStartEventType",
            Name = "Event Name"
        },
        {
            Type = "number",
            Name = "Duration"
        }
    }
}
