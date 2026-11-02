-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: map, time of decompilation: Sun May  3 10:10:00 2026 ]]
return function(t1: {[any]: any}, p1: ((...any) -> ...any)) --[[ map ]] -- line: 20
	local t2 = {}

	for i, v in ipairs(t1) do
		local v6 = p1(v, i, t1)

		if v6 ~= nil then
			table.insert(t2, v6)
		end
	end

	return t2
end
