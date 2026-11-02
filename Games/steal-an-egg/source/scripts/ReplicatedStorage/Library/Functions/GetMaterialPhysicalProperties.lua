-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

return function(p1) --[[ Line: 3 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if not v1 then
		local v2 = PhysicalProperties.new(p1)

		t[p1] = v2
		v1 = v2
	end

	return v1
end