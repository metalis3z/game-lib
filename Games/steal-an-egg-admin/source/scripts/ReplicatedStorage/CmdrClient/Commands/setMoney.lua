-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "setMoney",
    Description = "Sets the player money.",
    Group = "Admin",
    Aliases = { "" },
    Args = {
        {
            Type = "players",
            Name = "Player",
            Description = "The players to give money to."
        },
        {
            Type = "integer",
            Name = "Amount",
            Description = "The amount of money to give."
        }
    }
}
