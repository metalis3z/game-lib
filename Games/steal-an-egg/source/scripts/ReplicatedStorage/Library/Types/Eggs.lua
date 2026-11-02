-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)

require(ReplicatedStorage.Directory.Assets.Types.Personality)
require(ReplicatedStorage.Library.Types.AssetItem)

local t2 = {
	MAX_INVENTORY = 115
}
local v1 = t.interface({
	LocalCFrame = t.CFrame,
	PlacedAt = t.number,
	GrowthDuration = t.optional(t.number),
	GrowthCreditSeconds = t.optional(t.number),
	NightGrowthPeriodIndex = t.optional(t.number),
	NightGrowthCreditSeconds = t.optional(t.number),
	ReadyAt = t.optional(t.number)
})
local v2 = t.interface({
	LocalCFrame = t.array(t.number),
	PlacedAt = t.number,
	GrowthDuration = t.optional(t.number),
	GrowthCreditSeconds = t.optional(t.number),
	NightGrowthPeriodIndex = t.optional(t.number),
	NightGrowthCreditSeconds = t.optional(t.number),
	ReadyAt = t.optional(t.number)
})
local v3 = t.interface({
	AssetCategory = t.string,
	AssetScale = t.number,
	AssetEyeColor = t.string,
	AssetColorSeed = t.number,
	AssetColorIndex = t.number,
	Mutations = t.optional(t.array(t.string)),
	BaseMutation = t.optional(t.string),
	AssetGender = t.optional(t.union(t.literal("Male"), t.literal("Female"))),
	AssetPersonality = t.optional(t.string),
	IsStolenDNA = t.optional(t.boolean),
	Placement = t.optional(v1)
})
local v4 = t.interface({
	AssetCategory = t.string,
	AssetScale = t.number,
	AssetEyeColor = t.string,
	AssetColorSeed = t.number,
	AssetColorIndex = t.number,
	Mutations = t.optional(t.array(t.string)),
	BaseMutation = t.optional(t.string),
	AssetGender = t.optional(t.union(t.literal("Male"), t.literal("Female"))),
	AssetPersonality = t.optional(t.string),
	IsStolenDNA = t.optional(t.boolean),
	Placement = t.optional(v2)
})
local v5 = t.interface({
	AssetCategory = t.string,
	AssetScale = t.number,
	AssetEyeColor = t.string,
	AssetColorSeed = t.number,
	AssetColorIndex = t.number,
	Mutations = t.optional(t.array(t.string)),
	BaseMutation = t.optional(t.string),
	AssetGender = t.optional(t.union(t.literal("Male"), t.literal("Female"))),
	AssetPersonality = t.optional(t.string),
	IsStolenDNA = t.optional(t.boolean),
	Placement = t.optional(v1),
	GrowthSpeedMultiplier = t.number
})

t2.SchemaValidation = {
	EggPlacement = v1,
	EggInventory = t.map(t.string, v4),
	PlaceEggRequest = t.interface({
		Uid = t.string,
		LocalCFrame = t.CFrame
	}),
	RuntimeEggOwnerClear = t.interface({
		OwnerUserId = t.number
	}),
	RuntimeEggOwnerUpdate = t.interface({
		OwnerUserId = t.number,
		Records = t.map(t.string, v5)
	}),
	RuntimeEggSnapshot = t.array(t.interface({
		OwnerUserId = t.number,
		Records = t.map(t.string, v5)
	})),
	RuntimeEggRecord = v5,
	SavedEgg = v3,
	SerializedEggPlacement = v2,
	SerializedSavedEgg = v4
}

return t2