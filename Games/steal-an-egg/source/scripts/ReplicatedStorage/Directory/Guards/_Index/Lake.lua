-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BuildConfig = require(script.Parent.Parent.BuildConfig)
local Rarities = require(ReplicatedStorage.Directory.Rarity).Rarities
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local DefaultAnimationConfigLooped = require(script.Parent.Parent.BaseConfigs.DefaultAnimationConfigLooped)

return BuildConfig({
	WalkSpeed = 35,
	HitDistance = 3,
	HomeImpulseBoostDistanceXZ = 100,
	Rarity = Rarities.Uncommon,
	SleepAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://113926285960945", DefaultAnimationConfigLooped),
	IdleAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://107772834983305", DefaultAnimationConfigLooped),
	WalkAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://116919724871800", DefaultAnimationConfigLooped),
	AttackAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://108901434490139"),
	FootstepSound = {
		SoundId = "rbxassetid://84639143672331",
		Volume = 1.5,
		MaxDistance = 60,
		PlaybackSpeed = 1,
		Looped = true
	}
})