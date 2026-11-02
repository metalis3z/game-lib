-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "Cosmic Gorilla",
	Icon = "rbxassetid://85663322244323",
	EarningRate = 180000,
	IndexSpeedReward = 1200000,
	DropWeight = 0.2,
	VisualOdds = 1723764648784.246,
	ModelWeight = 450,
	Egg = {
		DisplayName = "Cosmic Gorilla Egg",
		Icon = "rbxassetid://116039419189340",
		GrowthTime = 420,
		WeightKg = 8
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://87538145688230").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://139052805389303").anim
	},
	Rarity = Rarity.Rarities.Mythic,
	BaseModelColor = Color3.fromRGB(100, 102, 148),
	PossibleModelColors = {
		{ Color3.fromRGB(100, 102, 148), 990 },
		{ Color3.fromRGB(255, 255, 255), 10 }
	},
	WalkSound = {
		SoundId = 92160997537319,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 136718215664675,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})