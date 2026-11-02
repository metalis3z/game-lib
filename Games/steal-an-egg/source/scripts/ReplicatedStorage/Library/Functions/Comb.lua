-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Factorial = require(script.Parent.Factorial)

return function(p1, p2) --[[ Comb | Line: 3 | Upvalues: Factorial (copy) ]]
	return Factorial(p1) / (Factorial(p2) * Factorial(p1 - p2))
end