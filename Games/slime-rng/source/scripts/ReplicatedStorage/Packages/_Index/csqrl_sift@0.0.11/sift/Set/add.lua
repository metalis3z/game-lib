-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: add, time of decompilation: Sun May  3 10:10:22 2026 ]]
return function(t1: {[any]: any}, ...) --[[ add ]] -- line: 18
	local t2 = {}

	for k, _ in pairs(t1) do
		t2[k] = true
	end

	for _, v in ipairs({ ... }) do
		t2[v] = true
	end

	return t2
end
