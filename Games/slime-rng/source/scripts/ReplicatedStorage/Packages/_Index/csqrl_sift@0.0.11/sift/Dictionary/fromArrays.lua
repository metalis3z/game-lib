-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: fromArrays, time of decompilation: Sun May  3 10:10:15 2026 ]]
return function(t1: {[any]: any}, t2: {[any]: any}) --[[ fromArrays ]] -- line: 20
	local t3 = {}

	for i = 1, #t1 do
		t3[t1[i]] = t2[i]
	end

	return t3
end
