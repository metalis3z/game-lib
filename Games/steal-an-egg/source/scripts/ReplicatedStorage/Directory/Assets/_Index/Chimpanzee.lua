-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Chimpanzee",
	Icon = "rbxassetid://74635759656969",
	EarningRate = 90,
	IndexSpeedReward = 7200,
	DropWeight = 0,
	VisualOdds = 190000,
	ModelWeight = 65,
	Egg = {
		DisplayName = "Chimpanzee Egg",
		Icon = "rbxassetid://134992089982715",
		GrowthTime = 30,
		WeightKg = 3
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://81544627592529").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://72867656782960").anim
	},
	Rarity = Rarity.Rarities.Rare,
	BaseModelColor = Color3.fromRGB(86, 57, 37),
	PossibleModelColors = {
		{ Color3.fromRGB(86, 57, 37), 650 },
		{ Color3.fromRGB(55, 42, 32), 180 },
		{ Color3.fromRGB(120, 85, 55), 125 },
		{ Color3.fromRGB(155, 125, 95), 45 },
		{ Color3.fromRGB(255, 255, 255), 10 }
	},
	WalkSound = {
		SoundId = 121714510466004,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 140380957391871,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})