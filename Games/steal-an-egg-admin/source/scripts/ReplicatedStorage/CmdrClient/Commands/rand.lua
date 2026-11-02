-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "rand",
    Description = "Returns a random number between min and max",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "integer",
            Name = "First number",
            Description = "If second number is nil, random number is between 1 and this value. If second number is provided, number is between this number and the second number."
        },
        {
            Type = "integer",
            Name = "Second number",
            Description = "The upper bound.",
            Optional = true
        }
    },
    Run = function(v1, v2, v3) -- Run | line 15
        local v4 = v3 and math.random(v2, v3) or math.random(v2)
        return (tostring(v4))
    end
}
