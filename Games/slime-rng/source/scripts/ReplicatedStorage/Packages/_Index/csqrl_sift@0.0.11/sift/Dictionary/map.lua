-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: map, time of decompilation: Sun May  3 10:10:17 2026 ]]
return function(t1: {[any]: any}, p1: ((...any) -> ...any)) --[[ map ]] -- line: 26
	local t2 = {}

	for k, v in pairs(t1) do
		local v6, v7 = p1(v, k, t1)

		t2[v7 or k] = v6
	end

	return t2
end
