-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Yeti",
	Icon = "rbxassetid://112918798684335",
	GenderLocked = "Male",
	EarningRate = 5000000,
	IndexSpeedReward = 25600,
	DropWeight = 0.14285714285714285,
	VisualOdds = 39176469.291,
	ModelWeight = 1500,
	Egg = {
		DisplayName = "Yeti Egg",
		Icon = "rbxassetid://123510916905046",
		GrowthTime = 6300,
		WeightKg = 4
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://72781750515188").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://101831046652331").anim
	},
	Rarity = Rarity.Rarities.Secret,
	BaseModelColor = Color3.fromRGB(163, 162, 165),
	PossibleModelColors = {},
	WalkSound = {
		SoundId = 86923272173832,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 140562418935008,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})