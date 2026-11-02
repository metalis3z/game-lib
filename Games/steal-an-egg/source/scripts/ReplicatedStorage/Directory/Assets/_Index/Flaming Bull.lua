-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Flaming Bull",
	Icon = "rbxassetid://77430751529509",
	EarningRate = 9500,
	IndexSpeedReward = 30000,
	DropWeight = 0.25,
	VisualOdds = 195882346.453,
	ModelWeight = 450,
	Egg = {
		DisplayName = "Flaming Bull Egg",
		Icon = "rbxassetid://70883699567304",
		GrowthTime = 180,
		WeightKg = 5
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://118416487517713").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://96159840607053").anim
	},
	Rarity = Rarity.Rarities.Legendary,
	PossibleModelColors = {},
	WalkSound = {
		SoundId = 123565424234895,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 73942787332078,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})