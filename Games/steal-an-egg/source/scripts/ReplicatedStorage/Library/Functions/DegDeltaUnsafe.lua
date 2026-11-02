-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	local v1 = p1 - p2

	if v1 > 180 then
		return v1 - 360
	end

	if v1 < -180 then
		return v1 + 360
	end

	return v1
end