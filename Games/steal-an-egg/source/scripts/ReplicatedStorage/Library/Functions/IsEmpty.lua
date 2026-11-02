-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	for k, v in pairs(p1) do
		if v == nil then
			return true
		end
	end

	return false
end