-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BuildConfig = require(script.Parent.Parent.BuildConfig)
local Rarities = require(ReplicatedStorage.Directory.Rarity).Rarities
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local DefaultAnimationConfigLooped = require(script.Parent.Parent.BaseConfigs.DefaultAnimationConfigLooped)

return BuildConfig({
	WalkSpeed = 98,
	HitDistance = 3,
	AnimationBaseWalkSpeed = 30,
	HomeImpulseBoostDistanceXZ = 190,
	Rarity = Rarities.Legendary,
	IdleAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://72781750515188", DefaultAnimationConfigLooped),
	SleepAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://76878866796833", DefaultAnimationConfigLooped),
	WalkAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://101831046652331", DefaultAnimationConfigLooped),
	AttackAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://126159723586018"),
	AfterWakeSound = {
		{
			SoundId = "rbxassetid://93143455867850",
			Volume = 5,
			MaxDistance = 250.48046875,
			PlaybackSpeed = 1,
			Looped = false
		},
		{
			SoundId = "rbxassetid://84067036540604",
			Volume = 5,
			MaxDistance = 250.48046875,
			PlaybackSpeed = 1,
			Looped = false
		}
	},
	AttackSound = {
		SoundId = "rbxassetid://129410289087112",
		Volume = 2,
		MaxDistance = 150,
		PlaybackSpeed = 1.0700000524520874,
		Looped = false
	},
	FootstepSound = {
		SoundId = "rbxassetid://86923272173832",
		Volume = 1.5,
		MaxDistance = 60,
		PlaybackSpeed = 1,
		Looped = true
	}
})