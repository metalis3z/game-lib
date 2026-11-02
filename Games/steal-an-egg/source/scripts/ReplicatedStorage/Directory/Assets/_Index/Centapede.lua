-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Centapede",
	Icon = "rbxassetid://137964650556285",
	EarningRate = 1500,
	IndexSpeedReward = 960000,
	DropWeight = 0,
	VisualOdds = 135000000000,
	ModelWeight = 6,
	WalkAnimationReferenceSpeed = 2,
	Egg = {
		DisplayName = "Centapede Egg",
		Icon = "rbxassetid://131685653579153",
		GrowthTime = 120,
		WeightKg = 7
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://130821698662184").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://117298500200806").anim
	},
	Rarity = Rarity.Rarities.Epic,
	BaseModelColor = Color3.fromRGB(231, 231, 236),
	PossibleModelColors = {
		{ Color3.fromRGB(231, 231, 236), 900 },
		{ Color3.fromRGB(51, 255, 48), 100 },
		{ Color3.fromRGB(255, 255, 255), 10 }
	},
	WalkSound = {
		SoundId = 97943735213732,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	}
}, {
	__index = Default
})