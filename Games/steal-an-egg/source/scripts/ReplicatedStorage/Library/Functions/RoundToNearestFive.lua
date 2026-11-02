-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ roundToNearestFive | Line: 3 ]]
	if p1 == 0 then
		return 0
	end

	local v1 = math.round(p1 / 5) * 5

	if v1 ~= 0 then
		return v1
	end

	if p1 > 0 then
		return 5
	end

	if p1 < 0 then
		return -5
	end

	return v1
end