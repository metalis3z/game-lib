-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {
	States = {
		Slot = "Slot",
		Carried = "Carried",
		Dropped = "Dropped",
		GuardCarried = "GuardCarried",
		Claimed = "Claimed"
	},
	DropReasons = {
		PlayerRequest = "PlayerRequest",
		GuardHit = "GuardHit",
		PlayerSlap = "PlayerSlap",
		Rewind = "Rewind",
		CharacterRemoving = "CharacterRemoving",
		HumanoidDied = "HumanoidDied",
		PlayerRemoving = "PlayerRemoving",
		External = "External"
	}
}
local v1 = t.union(t.literal(t2.States.Slot), t.literal(t2.States.Carried), t.literal(t2.States.Dropped), t.literal(t2.States.GuardCarried), t.literal(t2.States.Claimed))
local v2 = t.union(t.literal(t2.DropReasons.PlayerRequest), t.literal(t2.DropReasons.GuardHit), t.literal(t2.DropReasons.PlayerSlap), t.literal(t2.DropReasons.Rewind), t.literal(t2.DropReasons.CharacterRemoving), t.literal(t2.DropReasons.HumanoidDied), t.literal(t2.DropReasons.PlayerRemoving), t.literal(t2.DropReasons.External))
local v3 = t.interface({
	Uid = t.string,
	AreaId = t.string,
	NestId = t.string,
	AssetCategory = t.string,
	AssetScale = t.number,
	AssetEyeColor = t.string,
	AssetColorSeed = t.number,
	AssetColorIndex = t.number,
	Mutations = t.array(t.string),
	BaseMutation = t.optional(t.string),
	NestScale = t.number,
	BottomCFrame = t.CFrame,
	BoundsCFrame = t.CFrame,
	BoundsSize = t.Vector3,
	State = v1,
	CarrierUserId = t.optional(t.number),
	DroppedAt = t.optional(t.number),
	Version = t.number
})

t2.SchemaValidation = {
	AreaEggState = v1,
	DropReason = v2,
	AreaEggRecord = v3,
	AreaEggSnapshot = t.interface({
		Records = t.array(v3),
		ServerTime = t.number
	}),
	AreaEggBatchUpdate = t.interface({
		UpdatedRecords = t.array(v3),
		RemovedUids = t.array(t.string),
		ServerTime = t.number
	}),
	AreaEggCarryRequest = t.interface({
		Uid = t.string,
		FirstAreaSlotKey = t.optional(t.string)
	}),
	AreaEggDropRequest = t.interface({
		Reason = t.optional(v2)
	}),
	AreaEggCarryState = t.interface({
		IsCarrying = t.boolean,
		Uid = t.optional(t.string),
		AreaId = t.optional(t.string),
		AssetCategory = t.optional(t.string),
		RunBackWakeDelayRequired = t.optional(t.boolean),
		SpeedMultiplier = t.number
	}),
	AreaEggClaimFeedback = t.interface({
		AssetCategory = t.string,
		DisplayName = t.string,
		Rarity = t.string,
		Color = t.Color3,
		Position = t.Vector3
	})
}

return t2