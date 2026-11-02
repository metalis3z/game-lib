-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: withKeys, time of decompilation: Sun May  3 10:10:21 2026 ]]
return function(t1: {[any]: any}, ...) --[[ withKeys ]] -- line: 19
	local t2 = {}

	for _, v in ipairs({ ... }) do
		t2[v] = t1[v]
	end

	return t2
end
