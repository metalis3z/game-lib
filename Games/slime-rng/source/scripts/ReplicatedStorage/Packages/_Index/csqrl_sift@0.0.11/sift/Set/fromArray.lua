-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: fromArray, time of decompilation: Sun May  3 10:10:24 2026 ]]
return function(t1: {[any]: any}) --[[ fromArray ]] -- line: 20
	local t2 = table.create(#t1)

	for _, v in ipairs(t1) do
		t2[v] = true
	end

	return t2
end
