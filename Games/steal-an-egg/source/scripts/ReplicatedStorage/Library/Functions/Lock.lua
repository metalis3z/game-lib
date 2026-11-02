-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local finally = require(script.Parent.finally)

return function() --[[ Line: 5 | Upvalues: finally (copy) ]]
	local v1 = false

	return function(p1, ...) --[[ acquire | Line: 7 | Upvalues: v1 (ref), finally (ref) ]]
		if v1 then
			return false
		end

		v1 = true

		return true, finally(p1, function() --[[ Line: 12 | Upvalues: v1 (ref) ]]
			v1 = false
		end, ...)
	end
end