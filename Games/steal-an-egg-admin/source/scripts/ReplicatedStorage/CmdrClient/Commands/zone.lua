-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "zone",
    Description = "Teleport players to a guard area (anti-cheat authorised).",
    Group = "Moderator",
    Args = {
        {
            Type = "players",
            Name = "Players",
            Description = "Who to teleport"
        },
        {
            Type = "guardArea",
            Name = "Zone",
            Description = "The area to land in, at its exit point facing the nests"
        }
    }
}
