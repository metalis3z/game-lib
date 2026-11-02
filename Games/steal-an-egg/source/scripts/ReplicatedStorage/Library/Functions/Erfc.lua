-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	local v1 = 1 / (1 + 0.5 * p1)
	local v2 = v1 * math.exp(-p1 * p1 - 1.26551223 + v1 * (1.00002368 + v1 * (0.37409196 + v1 * (0.09678418 + v1 * (-0.18628806 + v1 * (0.27886807 + v1 * (-1.13520398 + v1 * (1.48851587 + v1 * (-0.82215223 + v1 * 0.17087277)))))))))

	if p1 >= 0 then
		return v2
	end

	return 2 - v2
end