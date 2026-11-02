-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local t = require(ReplicatedStorage.Packages.t)

return {
    PendingEggReward = t.interface({
        Uid = t.string,
        Egg = Eggs.SchemaValidation.SerializedSavedEgg
    }),
    FuseResult = Eggs.SchemaValidation.SerializedSavedEgg
}
