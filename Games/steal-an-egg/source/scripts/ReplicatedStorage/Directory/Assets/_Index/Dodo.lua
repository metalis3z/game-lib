-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Dodo",
	Icon = "rbxassetid://106242839438595",
	EarningRate = 280,
	IndexSpeedReward = 240000,
	DropWeight = 0.1111111111111111,
	VisualOdds = 113405568998.964,
	ModelWeight = 20,
	Egg = {
		DisplayName = "Dodo Egg",
		Icon = "rbxassetid://81099734295689",
		GrowthTime = 90,
		WeightKg = 7
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://126301797160461").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://130117577438818").anim
	},
	Rarity = Rarity.Rarities.Rare,
	BaseModelColor = Color3.fromRGB(43, 44, 50),
	PossibleModelColors = {},
	WalkSound = {
		SoundId = 116675021133679,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 91917802939931,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})