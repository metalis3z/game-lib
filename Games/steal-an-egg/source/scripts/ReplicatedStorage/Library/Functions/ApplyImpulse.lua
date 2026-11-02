-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local v1 = require(ReplicatedStorage.Library.Modules.BetterRandom).new()

return function(p1, p2, p3) --[[ Line: 5 | Upvalues: Asserts (copy), v1 (copy) ]]
	Asserts.BasePart(p1)
	Asserts.table(p3)
	p1.Anchored = false

	local v2 = assert(p3[1], "Offsets must contain at least one value for X")
	local v4 = assert(p3[2], "Offsets must contain at least one value for Z")
	local v5 = if type(p2) == "number" and p2 then p2 else v1:numberArray(p2)

	Asserts.number(v5)

	local v7 = (p1.Position - (p1.Position + Vector3.new(v2, 0, v4))) / v5

	p1:ApplyImpulse((v7 + Vector3.new(0, workspace.Gravity * v5 * 0.5, 0)) * p1.AssemblyMass)
end