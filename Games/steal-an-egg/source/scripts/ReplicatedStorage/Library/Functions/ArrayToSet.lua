-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 1 ]]
	local t = {}

	for i, v in ipairs(p1) do
		t[v] = true
	end

	return t
end