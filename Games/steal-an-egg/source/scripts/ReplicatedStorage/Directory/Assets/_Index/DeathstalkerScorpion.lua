-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Scorpion",
	Icon = "rbxassetid://95410883489917",
	EarningRate = 18500,
	IndexSpeedReward = 14400,
	DropWeight = 0.2,
	VisualOdds = 35911.763516,
	ModelWeight = 75,
	Egg = {
		DisplayName = "Scorpion Egg",
		Icon = "rbxassetid://124805981735905",
		GrowthTime = 300,
		WeightKg = 3
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://122119321846584").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://120635257153661").anim
	},
	Rarity = Rarity.Rarities.Mythic,
	BaseModelColor = Color3.fromRGB(213, 161, 93),
	PossibleModelColors = {
		{ Color3.fromRGB(234, 177, 102), 520 },
		{ Color3.fromRGB(175, 120, 65), 220 },
		{ Color3.fromRGB(191, 131, 91), 150 },
		{ Color3.fromRGB(220, 205, 150), 30 },
		{ Color3.fromRGB(255, 255, 255), 12 }
	},
	WalkSound = {
		SoundId = 137682861871003,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 90970709685819,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})