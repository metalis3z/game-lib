-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1) --[[ Line: 10 | Upvalues: Asserts (copy) ]]
	Asserts.array.finite(p1)

	return Vector3.new(p1[1], p1[2], p1[3])
end