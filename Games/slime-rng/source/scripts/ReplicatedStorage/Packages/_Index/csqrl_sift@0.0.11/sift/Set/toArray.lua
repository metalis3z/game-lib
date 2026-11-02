-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: toArray, time of decompilation: Sun May  3 10:10:27 2026 ]]
return function(t1: {[any]: any}) --[[ toArray ]] -- line: 17
	local t2 = {}

	for k, _ in pairs(t1) do
		table.insert(t2, k)
	end

	return t2
end
