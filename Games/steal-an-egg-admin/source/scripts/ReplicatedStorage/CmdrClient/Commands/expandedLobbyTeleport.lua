-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "expandedLobbyTeleport",
    Description = "Teleports players into a reserved server locked to an ExpandedLobby group.",
    Group = "Admin",
    Aliases = {},
    Args = {
        {
            Type = "string",
            Name = "Group",
            Description = "Control or Variant."
        },
        {
            Type = "players",
            Name = "Players",
            Description = "The players to teleport. Defaults to you.",
            Optional = true
        }
    }
}
