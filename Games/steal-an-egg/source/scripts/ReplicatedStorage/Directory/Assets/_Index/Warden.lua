-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(script.Parent.Parent.Types.Interface)

local Default = require(script.Parent.Parent.BaseConfigs.Default)
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local Rarity = require(ReplicatedStorage.Directory.Rarity)

return setmetatable({
	DisplayName = "King Snake",
	Icon = "rbxassetid://82294183801565",
	GenderLocked = "Male",
	EarningRate = 3500000,
	IndexSpeedReward = 18000,
	DropWeight = 0.125,
	VisualOdds = 1652583.9179961935,
	ModelWeight = 10000,
	Egg = {
		DisplayName = "King Snake Egg",
		Icon = "rbxassetid://71739449912371",
		GrowthTime = 5400,
		WeightKg = 4
	},
	Animations = {
		Idle = Pipeline:GetAndSerializeAnimation("rbxassetid://95141652737592").anim,
		Walk = Pipeline:GetAndSerializeAnimation("rbxassetid://118062442461764").anim
	},
	Rarity = Rarity.Rarities.Secret,
	BaseModelColor = Color3.fromRGB(69, 104, 30),
	PossibleModelColors = {
		{ Color3.fromRGB(69, 104, 30), 990 },
		{ Color3.fromRGB(255, 255, 255), 10 }
	},
	WalkSound = {
		SoundId = 96852920499596,
		Data = {
			Speed = 1,
			Volume = 1.5,
			MaxDistance = 20,
			Looped = true
		}
	},
	RandomIdleSound = {
		SoundId = 86273497689098,
		Data = {
			Volume = 1.5,
			MaxDistance = 20
		}
	}
}, {
	__index = Default
})