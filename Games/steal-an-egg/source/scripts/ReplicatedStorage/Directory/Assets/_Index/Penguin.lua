-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Penguin",
	Icon = "rbxassetid://87887271393121",
	EarningRate = 140,
	IndexSpeedReward = 12800,
	DropWeight = 0.1111111111111111,
	VisualOdds = 2355664.694028593,
	ModelWeight = 16,
	WalkAnimationReferenceSpeed = 4,
	Egg = {
		DisplayName = "Penguin Egg",
		Icon = "rbxassetid://91985894703067",
		GrowthTime = 45,
		WeightKg = 4
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://129919023274864").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://129919023274864").anim
	},
	Rarity = Rarity.Rarities.Rare,
	BaseModelColor = Color3.fromRGB(27, 42, 53),
	PossibleModelColors = {},
	WalkSound = {
		SoundId = 118893161321883,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 126342128456953,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})