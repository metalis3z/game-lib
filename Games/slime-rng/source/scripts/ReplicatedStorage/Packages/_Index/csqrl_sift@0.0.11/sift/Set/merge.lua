-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: merge, time of decompilation: Sun May  3 10:10:27 2026 ]]
return function(...) --[[ merge ]] -- line: 20
	local t1 = {}

	for i = 1, select("#", ...) do
		local v3 = select(i, ...)

		if type(v3) == "table" then
			for k, _ in pairs(v3) do
				t1[k] = true
			end
		end
	end

	return t1
end
