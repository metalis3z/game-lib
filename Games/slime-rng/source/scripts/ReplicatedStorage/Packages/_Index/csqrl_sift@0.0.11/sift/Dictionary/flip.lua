-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: flip, time of decompilation: Sun May  3 10:10:14 2026 ]]
return function(t1: {[any]: any}) --[[ flip ]] -- line: 17
	local t2 = {}

	for k, v in pairs(t1) do
		t2[v] = k
	end

	return t2
end
