-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	local v1 = #p1
	local v2 = table.create(math.ceil(v1), "")

	for i = 1, v1 do
		v2[i] = string.format("%02x", string.byte(p1, i))
	end

	return table.concat(v2)
end