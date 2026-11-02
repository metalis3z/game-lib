-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)

return {
	DefaultConfig = t.interface({
		ProductId = t.number,
		DisplayName = t.optional(t.string),
		ClientTest = t.optional(t.callback),
		Icon = t.optional(t.string),
		Desc = t.optional(t.string)
	})
}