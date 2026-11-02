-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1) --[[ Line: 12 | Upvalues: Asserts (copy) ]]
	Asserts.table(p1)

	return p1[math.random(#p1)]
end