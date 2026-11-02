-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: fromEntries, time of decompilation: Sun May  3 10:10:15 2026 ]]
return function(t1: {[any]: any}) --[[ fromEntries ]] -- line: 17
	local t2 = {}

	for _, v in ipairs(t1) do
		t2[v[1]] = v[2]
	end

	return t2
end
