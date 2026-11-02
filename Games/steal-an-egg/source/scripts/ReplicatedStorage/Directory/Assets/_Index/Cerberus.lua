-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Cerberus",
	Icon = "rbxassetid://71959618623573",
	GenderLocked = "Male",
	EarningRate = 8000000,
	IndexSpeedReward = 42000,
	DropWeight = 0.12,
	VisualOdds = 718235270.327,
	ModelWeight = 9000,
	WalkAnimationReferenceSpeed = 7,
	Egg = {
		DisplayName = "Cerberus Egg",
		Icon = "rbxassetid://81989677951623",
		GrowthTime = 7200,
		WeightKg = 5
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://82724993186340").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://103585492351786").anim
	},
	Rarity = Rarity.Rarities.Secret,
	BaseModelColor = Color3.fromRGB(59, 54, 54),
	PossibleModelColors = {
		{ Color3.fromRGB(59, 54, 54), 950 },
		{ Color3.fromRGB(180, 35, 25), 50 },
		{ Color3.fromRGB(255, 255, 255), 12 }
	},
	WalkSound = {
		SoundId = 102364255861367,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 112652966180684,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})