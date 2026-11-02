-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: delete, time of decompilation: Sun May  3 10:10:23 2026 ]]
return function(t1: {[any]: any}, ...) --[[ delete ]] -- line: 20
	local t2 = {}

	for k, _ in pairs(t1) do
		t2[k] = true
	end

	for _, v in ipairs({ ... }) do
		t2[v] = nil
	end

	return t2
end
