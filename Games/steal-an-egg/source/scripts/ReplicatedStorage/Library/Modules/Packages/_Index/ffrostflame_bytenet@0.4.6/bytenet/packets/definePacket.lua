-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent.types)

local packet = require(script.Parent.packet)

return function(p1) --[[ Line: 12 | Upvalues: packet (copy) ]]
	return function(p12) --[[ Line: 13 | Upvalues: packet (ref), p1 (copy) ]]
		return packet(p1, p12)
	end
end