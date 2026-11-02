-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)

return {
	AnnounceData = t.interface({
		message = t.string,
		color = t.optional(t.Color3),
		font = t.optional(t.EnumItem),
		fontSize = t.optional(t.EnumItem),
		omitColor = t.optional(t.boolean),
		metadata = t.optional(t.string)
	})
}