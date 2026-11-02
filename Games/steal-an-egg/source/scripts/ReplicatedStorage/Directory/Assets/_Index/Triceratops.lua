-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Triceratops",
	Icon = "rbxassetid://127014885618024",
	EarningRate = 1200000,
	IndexSpeedReward = 360000,
	DropWeight = 0.3333333333333333,
	VisualOdds = 13901.327813000002,
	ModelWeight = 3500,
	Egg = {
		DisplayName = "Triceratops Egg",
		Icon = "rbxassetid://73329615832715",
		GrowthTime = 480,
		WeightKg = 3
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://124711408481328").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://130350873209295").anim
	},
	Rarity = Rarity.Rarities.Cosmic,
	BaseModelColor = Color3.fromRGB(91, 78, 72),
	PossibleModelColors = {
		{ Color3.fromRGB(91, 78, 72), 520 },
		{ Color3.fromRGB(110, 95, 65), 180 },
		{ Color3.fromRGB(85, 105, 65), 130 },
		{ Color3.fromRGB(130, 120, 95), 110 },
		{ Color3.fromRGB(60, 55, 50), 60 },
		{ Color3.fromRGB(255, 255, 255), 10 }
	},
	WalkSound = {
		SoundId = 114321426046280,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 89022502511741,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})