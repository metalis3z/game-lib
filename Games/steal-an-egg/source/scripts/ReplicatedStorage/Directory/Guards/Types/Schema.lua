-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local Types = require(ReplicatedStorage.Directory.Animations.Pipeline.Private.Types)
local Rarity = require(ReplicatedStorage.Directory.Rarity)
local t2 = {
	GuardNameExists = function(p1) --[[ Line: 14 ]]
		error("unimplemented")
	end,
	SoundConfig = t.interface({
		SoundId = t.string,
		SoundIds = t.optional(t.array(t.string)),
		Volume = t.number,
		MaxDistance = t.number,
		PlaybackSpeed = t.optional(t.number),
		Looped = t.optional(t.boolean)
	})
}

t2.AfterWakeSoundConfig = t.union(t2.SoundConfig, t.array(t2.SoundConfig))
t2.DefaultConfig = t.interface({
	_id = t.string,
	Rarity = Rarity.Types.DefaultConfig,
	FlatRadius = t.number,
	WalkSpeed = t.number,
	HitDistance = t.optional(t.numberPositive),
	EggPickupDistance = t.optional(t.numberPositive),
	AnimationBaseWalkSpeed = t.optional(t.number),
	HomeImpulseBoostDistanceXZ = t.numberPositive,
	IdleAnimation = Types.SerializedAnimation,
	SleepAnimation = Types.SerializedAnimation,
	WalkAnimation = Types.SerializedAnimation,
	AttackAnimation = Types.SerializedAnimation,
	SleepSound = t2.SoundConfig,
	WakeSound = t2.SoundConfig,
	AfterWakeSound = t.optional(t2.AfterWakeSoundConfig),
	AttackSound = t2.SoundConfig,
	FootstepSound = t.optional(t2.SoundConfig)
})

return t2