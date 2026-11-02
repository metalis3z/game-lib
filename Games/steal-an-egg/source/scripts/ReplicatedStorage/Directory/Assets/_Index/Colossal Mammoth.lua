-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "King Mammoth",
	Icon = "rbxassetid://125958663108854",
	GenderLocked = "Male",
	EarningRate = 400000,
	IndexSpeedReward = 22400,
	DropWeight = 0.2,
	VisualOdds = 17955881.758,
	ModelWeight = 25000,
	Egg = {
		DisplayName = "King Mammoth Egg",
		Icon = "rbxassetid://139700961680740",
		GrowthTime = 900,
		WeightKg = 4
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://85363825751333").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://113455183242044").anim
	},
	Rarity = Rarity.Rarities.Cosmic,
	PossibleModelColors = {},
	WalkSound = {
		SoundId = 73924753601037,
		Data = {
			Speed = 1,
			Volume = 2,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 109052627263741,
		Data = {
			Volume = 1.8,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})