-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BuildConfig = require(script.Parent.Parent.BuildConfig)
local Rarities = require(ReplicatedStorage.Directory.Rarity).Rarities
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local DefaultAnimationConfigLooped = require(script.Parent.Parent.BaseConfigs.DefaultAnimationConfigLooped)

return BuildConfig({
	WalkSpeed = 130,
	HitDistance = 5,
	EggPickupDistance = 18,
	AnimationBaseWalkSpeed = 17,
	HomeImpulseBoostDistanceXZ = 250,
	Rarity = Rarities.Cosmic,
	SleepAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://93048039542192", DefaultAnimationConfigLooped),
	IdleAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://128167820597029", DefaultAnimationConfigLooped),
	WalkAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://126369826616604", DefaultAnimationConfigLooped),
	AttackAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://134105095548057"),
	AfterWakeSound = {
		{
			SoundId = "rbxassetid://109513647043767",
			Volume = 5,
			MaxDistance = 250.48046875,
			PlaybackSpeed = 1,
			Looped = false
		},
		{
			SoundId = "rbxassetid://112789890097920",
			Volume = 5,
			MaxDistance = 250.48046875,
			PlaybackSpeed = 1,
			Looped = false
		}
	},
	AttackSound = {
		SoundId = "rbxassetid://125914568551299",
		Volume = 2,
		MaxDistance = 150,
		PlaybackSpeed = 1.0700000524520874,
		Looped = false
	}
})