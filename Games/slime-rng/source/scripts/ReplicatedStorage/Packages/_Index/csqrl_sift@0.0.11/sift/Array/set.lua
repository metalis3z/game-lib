-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: set, time of decompilation: Sun May  3 10:10:04 2026 ]]
return function(t1: {[any]: any}, n1: number, p1) --[[ set ]] -- line: 20
	local v4 = #t1
	local t2 = {}

	if n1 < 1 then
		n1 += v4
	end

	for i, v in ipairs(t1) do
		if i == n1 then
			table.insert(t2, p1)
		else
			table.insert(t2, v)
		end
	end

	return t2
end
