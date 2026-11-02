-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BuildConfig = require(script.Parent.Parent.BuildConfig)
local Rarities = require(ReplicatedStorage.Directory.Rarity).Rarities
local Pipeline = require(ReplicatedStorage.Directory.Animations.Pipeline)
local DefaultAnimationConfigLooped = require(script.Parent.Parent.BaseConfigs.DefaultAnimationConfigLooped)

return BuildConfig({
	WalkSpeed = 62,
	HitDistance = 4,
	HomeImpulseBoostDistanceXZ = 130,
	Rarity = Rarities.Rare,
	SleepAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://72051937860705", DefaultAnimationConfigLooped),
	IdleAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://122119321846584", DefaultAnimationConfigLooped),
	WalkAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://120635257153661", DefaultAnimationConfigLooped),
	AttackAnimation = Pipeline:GetAndSerializeAnimation("rbxassetid://71459880228662"),
	FootstepSound = {
		SoundId = "rbxassetid://137682861871003",
		Volume = 1.5,
		MaxDistance = 60,
		PlaybackSpeed = 1,
		Looped = true
	}
})