-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: merge, time of decompilation: Sun May  3 10:10:48 2026 ]]
return function(p1, p2) --[[ merge ]] -- line: 1
	local v3 = p1

	for v4, v5 in p2 do
		if v5 ~= p1[v4] then
			if v3 == p1 then
				v3 = table.clone(p1)
			end

			v3[v4] = v5
		end
	end

	return v3
end
