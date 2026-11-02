-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Parent.Directory.Assets.Types.Personality)

local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {}
local v1 = t.union(t.literal("Male"), t.literal("Female"))

t2.AssetItemData = t.interface({
	Category = t.string,
	Mutations = t.array(t.string),
	BaseMutation = t.optional(t.string),
	Scale = t.number,
	Gender = t.optional(v1),
	EyeColor = t.optional(t.string),
	ColorSeed = t.optional(t.number),
	ColorIndex = t.optional(t.number),
	IsFavorite = t.optional(t.boolean),
	GeneratedMoney = t.optional(t.number),
	LastTick = t.optional(t.number),
	PendingEggName = t.optional(t.string),
	Claimed = t.optional(t.boolean),
	LuckyBlockUnlockTimestamp = t.optional(t.number),
	LuckyBlockUnlockDuration = t.optional(t.number),
	LuckyBlockInstantUnlock = t.optional(t.boolean),
	InFuse = t.optional(t.boolean),
	SpecialLuckyBlockColumn = t.optional(t.number),
	SpecialLuckyBlockCapturedAt = t.optional(t.number),
	Personality = t.optional(t.string),
	HasBeenFirstPlaced = t.optional(t.boolean),
	IsStolenDNA = t.optional(t.boolean)
})
t2.AssetItemDataArray = t.array(t2.AssetItemData)
t2.SerializedAssetItemData = t.interface({
	Category = t.string,
	Mutations = t.array(t.string),
	BaseMutation = t.optional(t.string),
	Scale = t.number,
	Gender = t.optional(v1),
	EyeColor = t.optional(t.string),
	ColorSeed = t.optional(t.number),
	ColorIndex = t.optional(t.number),
	IsFavorite = t.optional(t.boolean),
	GeneratedMoney = t.optional(t.number),
	LastTick = t.optional(t.number),
	PendingEggName = t.optional(t.string),
	Claimed = t.optional(t.boolean),
	LuckyBlockUnlockTimestamp = t.optional(t.number),
	LuckyBlockUnlockDuration = t.optional(t.number),
	LuckyBlockInstantUnlock = t.optional(t.boolean),
	InFuse = t.optional(t.boolean),
	SpecialLuckyBlockColumn = t.optional(t.number),
	SpecialLuckyBlockCapturedAt = t.optional(t.number),
	Personality = t.optional(t.string),
	HasBeenFirstPlaced = t.optional(t.boolean),
	IsStolenDNA = t.optional(t.boolean)
})

return t2