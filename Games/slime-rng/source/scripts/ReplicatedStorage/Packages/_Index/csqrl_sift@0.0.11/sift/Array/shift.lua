-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: shift, time of decompilation: Sun May  3 10:10:05 2026 ]]
return function(t1: {[any]: any}, n1: number?) --[[ shift ]] -- line: 20
	local v3 = #t1
	local t2 = {}

	for i = type(n1) ~= "number" and 2 or n1 + 1, v3 do
		table.insert(t2, t1[i])
	end

	return t2
end
