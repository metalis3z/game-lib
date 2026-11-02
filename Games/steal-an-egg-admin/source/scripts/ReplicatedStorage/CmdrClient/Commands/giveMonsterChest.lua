-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "giveMonsterChest",
    Description = "Gives the players a ready Monster Chest, for testing.",
    Group = "Admin",
    Args = {
        {
            Type = "players",
            Name = "Players",
            Description = "The players to give a Monster Chest to."
        },
        {
            Type = "integer",
            Name = "Amount",
            Description = "How many chests to give. Defaults to 1.",
            Optional = true
        }
    }
}
