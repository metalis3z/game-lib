local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v4 = FastFlags.Replicated("Trading.SignEnabled", Asserts.Boolean, true)
local v5 = FastFlags.Replicated("Trading.SignCooldown", Asserts.FinitePositive, 5)
local v6 = FastFlags.Replicated("Trading.SignMaxLength", Asserts.IntegerPositive, 100)
local v7 = FastFlags.Replicated("Trading.SignPresetsEnabled", Asserts.Boolean, true)
local v8 = FastFlags.Replicated("Trading.SignPresets", Asserts.Array(Asserts.String), {
	"➕ Add More",
	"❌ L Trade",
	"🧾 Last Offer",
	"Que Voulez Vous ?",
	"✅ Fair Trade",
	"🙅 Sa me n'interesse pas !"
})
local v9 = FastFlags.Replicated("Trading.SignAgeGroupsEnabled", Asserts.Boolean, true)
local v10 = FastFlags.Replicated("Trading.SignFreeTypeDisabled", Asserts.Boolean, false)
local v11 = FastFlags.Replicated("Trading.SignPresetCooldown", Asserts.FinitePositive, 5)
local v12 = FastFlags.Replicated("Trading.SignMaxMessages", Asserts.IntegerPositive, 30)

return table.freeze({
	SignEnabled = v4,
	SignCooldown = v5,
	SignPresetCooldown = v11,
	SignMaxLength = v6,
	SignMaxMessages = v12,
	SignPresetsEnabled = v7,
	SignPresets = v8,
	SignAgeGroupsEnabled = v9,
	SignFreeTypeDisabled = v10
})
