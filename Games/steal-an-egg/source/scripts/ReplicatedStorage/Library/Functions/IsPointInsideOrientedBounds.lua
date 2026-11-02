-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1, p2, p3) --[[ Line: 9 | Upvalues: Asserts (copy) ]]
	Asserts.CFrame(p1)
	Asserts.Vector3(p2)
	Asserts.Vector3(p3)

	local v1 = p1:PointToObjectSpace(p3)
	local v2 = p2 * 0.5

	return if math.abs(v1.X) <= v2.X then if math.abs(v1.Y) <= v2.Y then math.abs(v1.Z) <= v2.Z else false else false
end