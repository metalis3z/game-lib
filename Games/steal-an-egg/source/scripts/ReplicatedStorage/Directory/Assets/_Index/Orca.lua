-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Orca",
	Icon = "rbxassetid://90382263788089",
	EarningRate = 80000,
	IndexSpeedReward = 99000,
	DropWeight = 0,
	VisualOdds = 19000000000,
	ModelWeight = 1800,
	Egg = {
		DisplayName = "Orca Egg",
		Icon = "rbxassetid://99932807273458",
		GrowthTime = 360,
		WeightKg = 6
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://72649379588549").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://86371261736646").anim
	},
	Rarity = Rarity.Rarities.Mythic,
	BaseModelColor = Color3.fromRGB(17, 17, 17),
	PossibleModelColors = {},
	RandomIdleSound = {
		SoundId = 72265202988047,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})