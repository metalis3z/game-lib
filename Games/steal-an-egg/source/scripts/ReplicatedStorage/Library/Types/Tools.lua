-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {
	SlapControllerProfile = t.interface({
		Duration = t.number,
		Force = t.number,
		BrainrotDamage = t.number,
		MaxBrainrotTargets = t.optional(t.number)
	})
}

t2.SlapControllerData = t.interface({
	Player = t2.SlapControllerProfile,
	Brainrot = t2.SlapControllerProfile,
	PlayerCooldown = t.optional(t.number),
	MobCooldown = t.optional(t.number)
})

return t2