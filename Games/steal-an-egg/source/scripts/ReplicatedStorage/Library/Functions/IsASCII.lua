-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	assert(type(p1) == "string")

	for i = 1, #p1 do
		local v2 = p1:byte(i)

		if v2 < 32 or v2 > 126 then
			return false
		end
	end

	return true
end