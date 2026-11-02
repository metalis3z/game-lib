-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "pick",
    Description = "Picks a value out of a comma-separated list.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "integer",
            Name = "Index to pick",
            Description = "The index of the item you want to pick"
        },
        {
            Type = "string",
            Name = "CSV",
            Description = "The comma-separated list"
        }
    },
    Run = function(v1, v2, v3) -- Run | line 15
        return v3:split(",")[v2] or ""
    end
}
