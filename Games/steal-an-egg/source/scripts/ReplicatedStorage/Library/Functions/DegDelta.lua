-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local DegDeltaUnsafe = require(script.Parent.DegDeltaUnsafe)
local DegNorm = require(script.Parent.DegNorm)

return function(p1, p2) --[[ Line: 3 | Upvalues: DegDeltaUnsafe (copy), DegNorm (copy) ]]
	return DegDeltaUnsafe(DegNorm(p1), DegNorm(p2))
end