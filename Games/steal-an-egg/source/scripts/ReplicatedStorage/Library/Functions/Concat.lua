-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	for i, v in ipairs(p2) do
		table.insert(p1, v)
	end

	return p1
end