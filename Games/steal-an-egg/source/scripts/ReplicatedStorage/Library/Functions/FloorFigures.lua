-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RoundFigures = require(ReplicatedStorage.Library.Functions.RoundFigures)

function FloorFigures(p1, p2, p3) --[[ FloorFigures | Line: 4 | Upvalues: RoundFigures (copy) ]]
	return RoundFigures(p1, p2, p3, math.floor)
end

return FloorFigures