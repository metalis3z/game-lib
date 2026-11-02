-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: removeIndices, time of decompilation: Sun May  3 10:10:03 2026 ]]
return function(t1: {[any]: any}, ...) --[[ removeIndices ]] -- line: 19
	local v2 = #t1
	local t2 = {}
	local t3 = {}

	for _, v in ipairs({ ... }) do
		local v7 = v

		if v7 < 1 then
			v7 += v2
		end

		t2[v7] = true
	end

	for i, v in ipairs(t1) do
		if not t2[i] then
			table.insert(t3, v)
		end
	end

	return t3
end
