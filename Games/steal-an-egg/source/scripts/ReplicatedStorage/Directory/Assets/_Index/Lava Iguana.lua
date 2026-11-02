-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Lava Iguana",
	Icon = "rbxassetid://94900383358369",
	EarningRate = 11000,
	IndexSpeedReward = 36000,
	DropWeight = 0.2,
	VisualOdds = 307815115.854,
	ModelWeight = 400,
	Egg = {
		DisplayName = "Lava Iguana Egg",
		Icon = "rbxassetid://94119365219057",
		GrowthTime = 240,
		WeightKg = 5
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://130767121797455").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://123106869012272").anim
	},
	Rarity = Rarity.Rarities.Legendary,
	PossibleModelColors = {},
	WalkSound = {
		SoundId = 132145651741965,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 88149843107998,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})