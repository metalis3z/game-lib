-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Jerboa",
	Icon = "rbxassetid://139650837807677",
	EarningRate = 6,
	IndexSpeedReward = 7200,
	DropWeight = 0.1,
	VisualOdds = 4275.209942,
	ModelWeight = 2,
	Egg = {
		DisplayName = "Jerboa Egg",
		Icon = "rbxassetid://109714991972247",
		GrowthTime = 20,
		WeightKg = 2
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://79659893409616").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://79182758504811").anim
	},
	Rarity = Rarity.Rarities.Common,
	BaseModelColor = Color3.fromRGB(211, 190, 150),
	PossibleModelColors = {
		{ Color3.fromRGB(214, 186, 142), 760 },
		{ Color3.fromRGB(185, 150, 95), 145 },
		{ Color3.fromRGB(235, 215, 175), 70 },
		{ Color3.fromRGB(219, 162, 105), 25 },
		{ Color3.fromRGB(255, 255, 255), 15 }
	},
	WalkSound = {
		SoundId = 135431282574136,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 129498646783866,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})