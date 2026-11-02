-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Unicorn",
	Icon = "rbxassetid://118241918856064",
	EarningRate = 1000000000,
	IndexSpeedReward = 2400000,
	DropWeight = 10,
	VisualOdds = 168336391482836.53,
	ModelWeight = 1200,
	Egg = {
		DisplayName = "Unicorn Egg",
		Icon = "rbxassetid://126240842939586",
		GrowthTime = 43200,
		WeightKg = 10
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://136305746365813").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://116384986982148").anim
	},
	Rarity = Rarity.Rarities.Divine,
	PossibleModelColors = {},
	WalkSound = {
		SoundId = 93124590164789,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 116297838397212,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})