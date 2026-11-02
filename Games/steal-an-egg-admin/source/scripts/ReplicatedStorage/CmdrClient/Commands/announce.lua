-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "announce",
    Description = "Makes a server-wide announcement.",
    Group = "DefaultAdmin",
    Aliases = { "m" },
    Args = {
        {
            Type = "string",
            Name = "text",
            Description = "The announcement text."
        }
    }
}
