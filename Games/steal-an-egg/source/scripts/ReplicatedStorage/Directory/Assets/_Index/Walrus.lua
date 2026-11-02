-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Walrus",
	Icon = "rbxassetid://122998983525363",
	EarningRate = 600,
	IndexSpeedReward = 14400,
	DropWeight = 0.5,
	VisualOdds = 4788235.136,
	ModelWeight = 200,
	Egg = {
		DisplayName = "Walrus Egg",
		Icon = "rbxassetid://81034642321828",
		GrowthTime = 60,
		WeightKg = 4
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://72488282283538").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://82142162464398").anim
	},
	Rarity = Rarity.Rarities.Epic,
	BaseModelColor = Color3.fromRGB(134, 115, 99),
	PossibleModelColors = {
		{ Color3.fromRGB(134, 115, 99), 620 },
		{ Color3.fromRGB(105, 85, 70), 180 },
		{ Color3.fromRGB(165, 140, 120), 140 },
		{ Color3.fromRGB(190, 165, 145), 45 },
		{ Color3.fromRGB(70, 60, 55), 15 },
		{ Color3.fromRGB(71, 94, 157), 7 },
		{ Color3.fromRGB(255, 255, 255), 10 }
	},
	WalkSound = {
		SoundId = 110863031812081,
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