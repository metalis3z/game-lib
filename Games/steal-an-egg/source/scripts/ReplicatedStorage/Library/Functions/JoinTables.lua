-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 4 ]]
	local t = {}

	for i, v in ipairs(p1) do
		table.insert(t, v)
	end

	for i, v in ipairs(p2) do
		table.insert(t, v)
	end

	return t
end