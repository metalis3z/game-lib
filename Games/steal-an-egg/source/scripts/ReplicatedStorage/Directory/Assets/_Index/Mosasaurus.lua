-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Mosasaurus",
	Icon = "rbxassetid://124293259998827",
	EarningRate = 180000000,
	IndexSpeedReward = 600000,
	DropWeight = 0.55,
	VisualOdds = 2773109151.841,
	ModelWeight = 30000,
	AlbinosColorFullWhite = true,
	Egg = {
		DisplayName = "Mosasaurus Egg",
		Icon = "rbxassetid://110731551346220",
		GrowthTime = 21600,
		WeightKg = 6
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://111780744427837").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://83741788696719").anim
	},
	Rarity = Rarity.Rarities.Eternal,
	BaseModelColor = Color3.fromRGB(82, 94, 126),
	PossibleModelColors = {
		{ Color3.fromRGB(82, 94, 126), 540 },
		{ Color3.fromRGB(45, 75, 95), 190 },
		{ Color3.fromRGB(60, 85, 75), 120 },
		{ Color3.fromRGB(40, 45, 50), 100 },
		{ Color3.fromRGB(117, 102, 54), 120 },
		{ Color3.fromRGB(135, 140, 135), 50 },
		{ Color3.fromRGB(255, 0, 0), 10 },
		{ Color3.fromRGB(255, 255, 255), 10 }
	},
	RandomIdleSound = {
		SoundId = 81960453819318,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})