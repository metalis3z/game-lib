-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
return table.freeze({
    DisableWorldFrontend = FastFlags.Replicated("DisableWorldFrontend", Asserts.Boolean, false),
    LegacyPrompting = FastFlags.Replicated("LegacyPrompting", Asserts.Boolean, false),
    Purchases = FastFlags.Replicated("Purchases", Asserts.Boolean, true),
    SFX = FastFlags.Replicated("SFX", Asserts.Boolean, true),
    FriendBoostPercentPerFriend = FastFlags.Replicated("Game.FriendBoost.PercentPerFriend", Asserts.FiniteNonNegative, 10),
    FriendBoostCap = FastFlags.Replicated("Game.FriendBoost.Cap", Asserts.IntegerNonNegative, 4),
    BlockRepeatSingleProductPurchases = FastFlags.Replicated("BlockRepeatSingleProductPurchases", Asserts.Boolean, true),
    GreatBloomEnabled = FastFlags.Replicated("Game.GreatBloom.Enabled", Asserts.Boolean, false)
})
