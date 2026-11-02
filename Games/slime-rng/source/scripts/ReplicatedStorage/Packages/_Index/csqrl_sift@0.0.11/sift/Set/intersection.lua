-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: intersection, time of decompilation: Sun May  3 10:10:25 2026 ]]
return function(...) --[[ intersection ]] -- line: 20
	local v1 = select("#", ...)
	local v2 = select(1, ...)
	local t1 = {}

	for k, _ in pairs(v2) do
		local v6 = true

		for i = 2, v1 do
			if select(i, ...)[k] ~= true then
				v6 = false

				break
			end
		end

		if v6 then
			t1[k] = true
		end
	end

	return t1
end
