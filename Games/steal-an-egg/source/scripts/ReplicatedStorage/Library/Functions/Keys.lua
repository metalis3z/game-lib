-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	local t = {}

	for k in pairs(p1) do
		table.insert(t, k)
	end

	return t
end