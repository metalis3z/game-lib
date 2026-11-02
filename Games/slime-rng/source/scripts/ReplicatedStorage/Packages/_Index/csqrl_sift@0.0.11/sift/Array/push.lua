-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: push, time of decompilation: Sun May  3 10:10:01 2026 ]]
return function(t1: {[any]: any}, ...) --[[ push ]] -- line: 22
	local t2 = {}

	for _, v in ipairs(t1) do
		table.insert(t2, v)
	end

	for _, v in ipairs({ ... }) do
		table.insert(t2, v)
	end

	return t2
end
