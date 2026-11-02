-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 8 ]]
	if not p1 or p1 <= 0 then
		return 1, 1
	end

	local v1 = math.clamp(p1, 50, 480)
	local v2 = (math.log(v1) - 3.912023005428146) / 2.2617630984737906

	return v2 * 0.5 + 2.5, if v1 >= 80 and v1 <= 110 then 1 else 2 - v2 * 1.5
end