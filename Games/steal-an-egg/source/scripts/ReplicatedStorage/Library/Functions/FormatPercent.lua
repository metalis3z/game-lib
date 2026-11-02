-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local FormatFigures = require(script.Parent.FormatFigures)

return function(p1) --[[ Line: 3 | Upvalues: FormatFigures (copy) ]]
	return FormatFigures(p1 * 100, 4, 5) .. "%"
end