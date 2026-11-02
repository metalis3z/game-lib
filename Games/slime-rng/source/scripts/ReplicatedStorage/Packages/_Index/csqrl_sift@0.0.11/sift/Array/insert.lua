-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: insert, time of decompilation: Sun May  3 10:09:59 2026 ]]
return function(t1: {[any]: any}, n1: number, ...) --[[ insert ]] -- line: 21
	local v3 = #t1

	if n1 < 1 then
		n1 += v3 + 1
	end

	if v3 < n1 then
		if n1 > v3 + 1 then
			return t1
		end

		n1 = v3 + 1
		v3 += 1
	end

	local t2 = {}

	for i = 1, v3 do
		if i == n1 then
			for _, v in ipairs({ ... }) do
				table.insert(t2, v)
			end
		end

		table.insert(t2, t1[i])
	end

	return t2
end
