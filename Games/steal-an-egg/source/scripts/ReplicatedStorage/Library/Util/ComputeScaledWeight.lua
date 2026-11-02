-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)

return function(p1, p2) --[[ computeScaledWeight | Line: 10 | Upvalues: Asserts (copy) ]]
	Asserts.number(p1)
	Asserts.number(p2)

	return p1 * math.max(p2, 0)
end