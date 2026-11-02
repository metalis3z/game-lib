-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local FormatAbbreviated = require(script.Parent.FormatAbbreviated)

return function(p1) --[[ Line: 3 | Upvalues: FormatAbbreviated (copy) ]]
	return "1/" .. FormatAbbreviated(1 / p1)
end