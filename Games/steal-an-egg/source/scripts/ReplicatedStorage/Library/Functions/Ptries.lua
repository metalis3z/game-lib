-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	local v1 = math.clamp(p1, 0, 1)

	assert(p2 >= 1)

	return 1 - (1 - v1) ^ p2
end