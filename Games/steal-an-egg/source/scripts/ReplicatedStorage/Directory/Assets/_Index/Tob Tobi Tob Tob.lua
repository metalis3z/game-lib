-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Tob Tobi Tob Tob",
	Icon = "rbxassetid://127993958977152",
	GenderLocked = "Male",
	EarningRate = 325,
	IndexSpeedReward = 9900,
	DropWeight = 0.3333333333333333,
	VisualOdds = 13901.327813000002,
	ModelWeight = 700,
	Egg = {
		DisplayName = "Tob Tobi Tob Tob Egg",
		Icon = "rbxassetid://100658524019292",
		GrowthTime = 75,
		WeightKg = 3
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://117531573765818").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://99521895801002").anim
	},
	Rarity = Rarity.Rarities.Epic,
	PossibleModelColors = {},
	WalkSound = {
		SoundId = 132784244995896,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 127796243605681,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})