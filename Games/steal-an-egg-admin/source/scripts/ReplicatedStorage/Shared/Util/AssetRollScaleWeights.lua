-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
return require(ReplicatedStorage.Shared.Utils.Collections).Seal({
    {
        low = 1,
        high = 1.01,
        weight = 250
    },
    {
        low = 0.48,
        high = 0.5,
        weight = 45.17
    },
    {
        low = 0.24,
        high = 0.25,
        weight = 17.09
    },
    {
        low = 1.49,
        high = 1.5,
        weight = 4.27
    },
    {
        low = 1.99,
        high = 2,
        weight = 0.1857
    }
})
