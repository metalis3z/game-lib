-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	local v1 = 0

	for i = 1, #p1 do
		v1 = bit32.bor(bit32.lshift(v1, 8), string.byte(p1, i))
	end

	return v1
end