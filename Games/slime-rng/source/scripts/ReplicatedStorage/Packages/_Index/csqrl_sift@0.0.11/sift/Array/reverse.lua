-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: reverse, time of decompilation: Sun May  3 10:10:04 2026 ]]
return function(t1: {[any]: any}) --[[ reverse ]] -- line: 17
	local t2 = {}

	for i = #t1, 1, -1 do
		table.insert(t2, t1[i])
	end

	return t2
end
