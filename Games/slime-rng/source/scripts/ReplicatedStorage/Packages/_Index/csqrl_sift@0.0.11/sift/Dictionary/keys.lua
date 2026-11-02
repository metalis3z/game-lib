-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: keys, time of decompilation: Sun May  3 10:10:16 2026 ]]
return function(t1: {[any]: any}) --[[ keys ]] -- line: 17
	local t2 = {}

	for k in pairs(t1) do
		table.insert(t2, k)
	end

	return t2
end
