-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: pop, time of decompilation: Sun May  3 10:10:01 2026 ]]
return function(t1: {[any]: any}, n1: number?) --[[ pop ]] -- line: 20
	local v3 = #t1
	local t2 = {}

	if type(n1) ~= "number" then
		n1 = 1
	end

	for i = 1, v3 - n1 do
		table.insert(t2, t1[i])
	end

	return t2
end
