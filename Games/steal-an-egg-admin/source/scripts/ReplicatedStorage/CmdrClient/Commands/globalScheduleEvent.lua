-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "globalScheduleEvent",
    Description = "Schedules an event in all servers",
    Group = "Moderator",
    Args = {
        {
            Type = "adminEventType",
            Name = "Event Name"
        },
        {
            Type = "number",
            Name = "Duration"
        },
        {
            Type = "integer",
            Name = "UnixTimestamp"
        }
    }
}
