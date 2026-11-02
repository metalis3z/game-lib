-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local IsFinite = require(script.Parent.IsFinite)

return function(p1) --[[ Line: 3 | Upvalues: IsFinite (copy) ]]
	local v1 = IsFinite(p1.X)

	if v1 then
		v1 = IsFinite(p1.Y)
	end

	return v1
end