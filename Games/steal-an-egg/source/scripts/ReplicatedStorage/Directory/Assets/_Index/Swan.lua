-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Swan",
	Icon = "rbxassetid://125076114591417",
	EarningRate = 320,
	IndexSpeedReward = 3500,
	DropWeight = 0.2,
	VisualOdds = 670.5118643718583,
	ModelWeight = 22,
	Egg = {
		DisplayName = "Swan Egg",
		Icon = "rbxassetid://84237066771646",
		GrowthTime = 120,
		WeightKg = 2
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://107772834983305").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://116919724871800").anim
	},
	Rarity = Rarity.Rarities.Epic,
	BaseModelColor = Color3.fromRGB(202, 203, 209),
	PossibleModelColors = {
		{ Color3.fromRGB(202, 203, 209), 200 },
		{ Color3.fromRGB(245, 245, 238), 710 },
		{ Color3.fromRGB(55, 55, 55), 70 },
		{ Color3.fromRGB(190, 175, 155), 20 }
	},
	WalkSound = {
		SoundId = 84639143672331,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 124101960931522,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})