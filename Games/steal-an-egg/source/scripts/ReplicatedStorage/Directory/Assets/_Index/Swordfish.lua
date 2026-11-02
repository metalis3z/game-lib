-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Swordfish",
	Icon = "rbxassetid://103426699196063",
	EarningRate = 1100,
	IndexSpeedReward = 81000,
	DropWeight = 0.5,
	VisualOdds = 4910446705.478001,
	ModelWeight = 250,
	Egg = {
		DisplayName = "Swordfish Egg",
		Icon = "rbxassetid://108314641239947",
		GrowthTime = 120,
		WeightKg = 6
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://130171365959815").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://137609645215205").anim
	},
	Rarity = Rarity.Rarities.Epic,
	BaseModelColor = Color3.fromRGB(58, 76, 99),
	PossibleModelColors = {
		{ Color3.fromRGB(58, 76, 99), 650 },
		{ Color3.fromRGB(110, 146, 181), 170 },
		{ Color3.fromRGB(35, 55, 85), 120 },
		{ Color3.fromRGB(25, 35, 55), 15 },
		{ Color3.fromRGB(255, 255, 255), 10 }
	},
	RandomIdleSound = {
		SoundId = 72092807529166,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})