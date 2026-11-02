-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local IsFinite = require(script.Parent.IsFinite)

return function(p1) --[[ Line: 3 | Upvalues: IsFinite (copy) ]]
	if IsFinite(p1.X) and IsFinite(p1.Y) then
		return IsFinite(p1.Z)
	end

	return false
end