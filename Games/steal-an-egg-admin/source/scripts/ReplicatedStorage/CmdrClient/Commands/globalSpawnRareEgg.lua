-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

return {
    Name = "globalSpawnRareEgg",
    Description = "Replaces a random untouched egg in a random biome with a rare egg, in all servers.",
    Group = "Admin",
    Args = {
        {
            Type = "mutation",
            Name = "Mutation",
            Description = "Mutation to force onto the spawned egg. Rolled normally when omitted.",
            Optional = true
        }
    }
}
