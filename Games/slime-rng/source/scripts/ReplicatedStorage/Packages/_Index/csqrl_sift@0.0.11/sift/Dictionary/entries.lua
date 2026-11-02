-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: entries, time of decompilation: Sun May  3 10:10:10 2026 ]]
return function(t1: {[any]: any}) --[[ entries ]] -- line: 17
	local t2 = {}

	for k, v in pairs(t1) do
		table.insert(t2, {
			k,
			v
		})
	end

	return t2
end
