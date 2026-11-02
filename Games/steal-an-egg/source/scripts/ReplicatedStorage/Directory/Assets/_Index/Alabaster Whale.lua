-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Beluga Whale",
	Icon = "rbxassetid://90630918901856",
	EarningRate = 850000,
	IndexSpeedReward = 126000,
	DropWeight = 0,
	VisualOdds = 22000000000,
	ModelWeight = 5000,
	Egg = {
		DisplayName = "Beluga Whale Egg",
		Icon = "rbxassetid://94470939106990",
		GrowthTime = 720,
		WeightKg = 6
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://128167820597029").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://126369826616604").anim
	},
	Rarity = Rarity.Rarities.Cosmic,
	PossibleModelColors = {},
	RandomIdleSound = {
		SoundId = 109084013864839,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})