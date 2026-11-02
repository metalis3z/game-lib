-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: removeValue, time of decompilation: Sun May  3 10:10:03 2026 ]]
return function(t1: {[any]: any}, p1) --[[ removeValue ]] -- line: 18
	local t2 = {}

	for _, v in ipairs(t1) do
		if v ~= p1 then
			table.insert(t2, v)
		end
	end

	return t2
end
