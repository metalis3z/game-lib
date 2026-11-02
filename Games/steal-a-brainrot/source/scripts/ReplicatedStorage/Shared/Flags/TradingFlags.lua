-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = FastFlags.Replicated("Trading.SignEnabled", Asserts.Boolean, false)
local v2 = FastFlags.Replicated("Trading.SignCooldown", Asserts.FinitePositive, 5)
local v3 = FastFlags.Replicated("Trading.SignMaxLength", Asserts.IntegerPositive, 100)
local v4 = FastFlags.Replicated("Trading.SignPresetsEnabled", Asserts.Boolean, true)
local v5 = FastFlags.Replicated("Trading.SignPresets", Asserts.Array(Asserts.String), { "\226\158\149 Add More", "\226\157\140 L Trade", "\240\159\167\190 Last Offer", "\240\159\164\157 Deal?", "\226\156\133 Fair Trade", "\240\159\153\133 No Thanks" })
local v6 = FastFlags.Replicated("Trading.SignAgeGroupsEnabled", Asserts.Boolean, true)
local v7 = FastFlags.Replicated("Trading.SignFreeTypeDisabled", Asserts.Boolean, false)
return table.freeze({
	SignEnabled = v1,
	SignCooldown = v2,
	SignPresetCooldown = FastFlags.Replicated("Trading.SignPresetCooldown", Asserts.FinitePositive, 5),
	SignMaxLength = v3,
	SignPresetsEnabled = v4,
	SignPresets = v5,
	SignAgeGroupsEnabled = v6,
	SignFreeTypeDisabled = v7
})