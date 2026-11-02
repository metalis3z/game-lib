-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {}
local t3 = {
	Amplitude = t.optional(t.number),
	Radius = t.optional(t.number),
	Blink = t.optional(t.boolean),
	Highlight = t.optional(t.boolean),
	RotationSpeed = t.optional(t.number),
	CleanupOnPartDestroyed = t.optional(t.boolean),
	OscillationSpeed = t.optional(t.number),
	BlinkFrequency = t.optional(t.number),
	ProximityThreshold = t.optional(t.number),
	OriginOffset = t.optional(t.Vector3),
	TargetOffset = t.optional(t.Vector3),
	Color = t.optional(t.Color3)
}

t2.Config = t.interface(t3)
t2.OptionalConfig = t.optional(t.interface(t3))

return t2