-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)

return {
	Event = t.strictInterface({
		x = t.optional(t.boolean),
		u = t.number,
		c = t.string,
		t = t.string
	})
}