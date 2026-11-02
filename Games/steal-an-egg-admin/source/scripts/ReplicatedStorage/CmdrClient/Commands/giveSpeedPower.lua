-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "giveSpeedPower",
    Description = "Gives Speed to players.",
    Group = "Admin",
    Aliases = { "" },
    Args = {
        {
            Type = "players",
            Name = "Player",
            Description = "The players to give speed to."
        },
        {
            Type = "integer",
            Name = "Amount",
            Description = "The amount of speed to give."
        }
    }
}
