-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BuildConfig = require(script.Parent.Parent.BuildConfig)
local Rarities = require(ReplicatedStorage.Directory.Rarity).Rarities
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local DefaultAnimationConfigLooped = require(script.Parent.Parent.BaseConfigs.DefaultAnimationConfigLooped)

return BuildConfig({
	WalkSpeed = 200,
	HitDistance = 4,
	AnimationBaseWalkSpeed = 28,
	HomeImpulseBoostDistanceXZ = 300,
	Rarity = Rarities.Eternal,
	SleepAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://125243528231234", DefaultAnimationConfigLooped),
	IdleAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://105013251719934", DefaultAnimationConfigLooped),
	WalkAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://98685615837375", DefaultAnimationConfigLooped),
	AttackAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://99631180573492"),
	AfterWakeSound = {
		{
			SoundId = "rbxassetid://135419634519147",
			Volume = 5,
			MaxDistance = 250.48046875,
			PlaybackSpeed = 1,
			Looped = false
		},
		{
			SoundId = "rbxassetid://136805444765117",
			Volume = 5,
			MaxDistance = 250.48046875,
			PlaybackSpeed = 1,
			Looped = false
		}
	},
	AttackSound = {
		SoundId = "rbxassetid://103302796486965",
		Volume = 2,
		MaxDistance = 150,
		PlaybackSpeed = 1.0700000524520874,
		Looped = false
	},
	FootstepSound = {
		SoundId = "rbxassetid://85892053481113",
		Volume = 1.5,
		MaxDistance = 60,
		PlaybackSpeed = 1,
		Looped = true
	}
})