-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "giveEgg",
    Description = "Gives the players an egg of the given asset.",
    Group = "Admin",
    Aliases = { "" },
    Args = {
        {
            Type = "players",
            Name = "Players",
            Description = "The players to give the egg to."
        },
        {
            Type = "assetName",
            Name = "Egg",
            Description = "The asset the egg hatches into."
        },
        {
            Type = "mutations",
            Name = "Mutations",
            Description = "Comma separated mutations. Defaults to none.",
            Optional = true
        },
        {
            Type = "number",
            Name = "Scale",
            Description = "Egg scale. Defaults to 1.",
            Optional = true
        }
    }
}
