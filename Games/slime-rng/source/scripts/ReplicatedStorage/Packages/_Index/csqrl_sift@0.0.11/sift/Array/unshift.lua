-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: unshift, time of decompilation: Sun May  3 10:10:08 2026 ]]
return function(t1: {[any]: any}, ...) --[[ unshift ]] -- line: 22
	local t2 = { ... }

	for _, v in ipairs(t1) do
		table.insert(t2, v)
	end

	return t2
end
