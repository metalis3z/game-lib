-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "echo",
    Description = "Echoes your text back to you.",
    Group = "DefaultUtil",
    Aliases = { "=" },
    Args = {
        {
            Type = "string",
            Name = "Text",
            Description = "The text."
        }
    },
    Run = function(v1, v2) -- Run | line 14
        return v2
    end
}
