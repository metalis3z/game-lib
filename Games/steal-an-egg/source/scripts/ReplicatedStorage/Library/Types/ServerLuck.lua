-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)

return {
	State = t.strictInterface({
		Multiplier = t.number,
		ExpiresAt = t.optional(t.number),
		BoostedByDisplayName = t.optional(t.string)
	})
}