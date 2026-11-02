-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1) --[[ Line: 10 | Upvalues: Asserts (copy) ]]
	Asserts.Vector3(p1)

	return { p1.X, p1.Y, p1.Z }
end