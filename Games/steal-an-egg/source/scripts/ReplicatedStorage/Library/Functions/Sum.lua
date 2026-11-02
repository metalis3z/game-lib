-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	local sum = 0

	for k, v in pairs(p1) do
		sum = sum + v
	end

	return sum
end