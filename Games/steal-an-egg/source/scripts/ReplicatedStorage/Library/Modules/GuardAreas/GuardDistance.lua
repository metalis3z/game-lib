-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return {
	XZ = function(p1, p2) --[[ XZ | Line: 16 | Upvalues: Asserts (copy) ]]
		Asserts.Vector3(p1)
		Asserts.Vector3(p2)

		local v1 = p1 - p2

		return Vector3.new(v1.X, 0, v1.Z).Magnitude
	end
}