-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "globalEggSizeBoost",
    Description = "Boosts the size of eggs spawning on the map in all servers.",
    Group = "Admin",
    Aliases = { "" },
    Args = {
        {
            Type = "number",
            Name = "Multiplier",
            Description = "The multiplier to apply (1 - 4)."
        },
        {
            Type = "integer",
            Name = "Duration",
            Description = "The duration in seconds."
        }
    }
}
