-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	local sum = p1 - p2

	if sum > math.pi then
		return sum - 6.283185307179586
	end

	if sum < -3.141592653589793 then
		sum = sum + 6.283185307179586
	end

	return sum
end