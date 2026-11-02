-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Sand Spider",
	Icon = "rbxassetid://70412724408814",
	EarningRate = 16000,
	IndexSpeedReward = 12600,
	DropWeight = 0.16666666666666666,
	VisualOdds = 53867.64527500001,
	ModelWeight = 120,
	Egg = {
		DisplayName = "Sand Spider Egg",
		Icon = "rbxassetid://122421093207285",
		GrowthTime = 240,
		WeightKg = 3
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://97026670257755").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://123140921486472").anim
	},
	Rarity = Rarity.Rarities.Mythic,
	BaseModelColor = Color3.fromRGB(132, 109, 65),
	PossibleModelColors = {
		{ Color3.fromRGB(132, 109, 65), 670 },
		{ Color3.fromRGB(145, 105, 65), 180 },
		{ Color3.fromRGB(220, 195, 140), 100 },
		{ Color3.fromRGB(255, 255, 255), 12 }
	},
	WalkSound = {
		SoundId = 116105360458227,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 108765457146691,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})