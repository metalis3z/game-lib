-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Polar Bear",
	Icon = "rbxassetid://101736883038036",
	EarningRate = 7000,
	IndexSpeedReward = 16000,
	DropWeight = 0.5,
	VisualOdds = 4788235.136,
	ModelWeight = 650,
	Egg = {
		DisplayName = "Polar Bear Egg",
		Icon = "rbxassetid://118897853908991",
		GrowthTime = 120,
		WeightKg = 4
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://79913958746459").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://74183061147329").anim
	},
	Rarity = Rarity.Rarities.Legendary,
	PossibleModelColors = {},
	WalkSound = {
		SoundId = 98962076190481,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 127207447045739,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})