-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local Schema = require(ReplicatedStorage.Directory.Rarity.Types.Schema)

return {
	CurrencyNameExists = function(p1) --[[ Line: 13 ]]
		error("unimplemented")
	end,
	DefaultConfig = t.interface({
		_id = t.string,
		DisplayName = t.string,
		Icon = t.optional(t.string),
		Desc = t.optional(t.string),
		Rarity = t.optional(Schema.DefaultConfig)
	})
}