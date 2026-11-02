-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Duckling",
	Icon = "rbxassetid://81116137079823",
	EarningRate = 4,
	IndexSpeedReward = 2250,
	DropWeight = 0,
	VisualOdds = 190,
	ModelWeight = 3,
	Egg = {
		DisplayName = "Duckling Egg",
		Icon = "rbxassetid://81777724258949",
		GrowthTime = 20,
		WeightKg = 2
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://134228759543802").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://101962084548246").anim
	},
	Rarity = Rarity.Rarities.Common,
	BaseModelColor = Color3.fromRGB(130, 126, 82),
	PossibleModelColors = {
		{ Color3.fromRGB(130, 126, 82), 360 },
		{ Color3.fromRGB(255, 202, 122), 480 },
		{ Color3.fromRGB(95, 75, 45), 80 },
		{ Color3.fromRGB(245, 235, 180), 60 },
		{ Color3.fromRGB(60, 55, 45), 20 },
		{ Color3.fromRGB(255, 255, 255), 20 }
	},
	WalkSound = {
		SoundId = 84639143672331,
		Data = {
			Speed = 1,
			Volume = 1.9,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 87598259027411,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})