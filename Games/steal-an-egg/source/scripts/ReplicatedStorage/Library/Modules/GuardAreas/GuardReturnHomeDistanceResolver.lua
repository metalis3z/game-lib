-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {
	["Abyss Ocean"] = 15,
	Cosmic = 15,
	Prehistoric = 15
}

return {
	Resolve = function(p1) --[[ Resolve | Line: 24 | Upvalues: Asserts (copy), t (copy) ]]
		Asserts.string(p1)

		return t[p1] or 3
	end
}