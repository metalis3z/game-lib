-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Shark",
	Icon = "rbxassetid://125497863961128",
	EarningRate = 15000,
	IndexSpeedReward = 90000,
	DropWeight = 0,
	VisualOdds = 9500000000,
	ModelWeight = 450,
	Egg = {
		DisplayName = "Shark Egg",
		Icon = "rbxassetid://71615245424079",
		GrowthTime = 240,
		WeightKg = 6
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://97647786462223").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://81203454889263").anim
	},
	Rarity = Rarity.Rarities.Legendary,
	BaseModelColor = Color3.fromRGB(0, 71, 109),
	PossibleModelColors = {
		{ Color3.fromRGB(0, 71, 109), 610 },
		{ Color3.fromRGB(45, 75, 90), 190 },
		{ Color3.fromRGB(20, 45, 70), 70 },
		{ Color3.fromRGB(255, 255, 255), 10 }
	},
	RandomIdleSound = {
		SoundId = 92586563973540,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})