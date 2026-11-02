-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: RemoveKeys, time of decompilation: Sun May  3 10:11:09 2026 ]]
return function(t1: {[any]: any}, t2: {[any]: any}, b1: boolean?) -- line: 1
	local t3 = {}
	local v5 = if not b1 then nil else {}

	for v6, v7 in t1 do
		if not table.find(t2, v6) and (not b1 or typeof(v6) ~= "number") then
			t3[v6] = v7
		end

		if b1 and typeof(v6) == "number" then
			table.insert(v5, v7)
		end
	end

	return t3, v5
end
