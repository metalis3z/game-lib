-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "givePet",
    Description = "Gives the players a pet of the given asset.",
    Group = "Admin",
    Aliases = { "" },
    Args = {
        {
            Type = "players",
            Name = "Players",
            Description = "The players to give the pet to."
        },
        {
            Type = "assetName",
            Name = "Pet",
            Description = "The asset to give."
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
            Description = "Pet scale. Defaults to 1.",
            Optional = true
        },
        {
            Type = "personality",
            Name = "Personality",
            Description = "Pet personality. Defaults to a random roll.",
            Optional = true
        }
    }
}
