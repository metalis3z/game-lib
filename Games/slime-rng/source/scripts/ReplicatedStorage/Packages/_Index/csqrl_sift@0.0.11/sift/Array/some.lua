-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: some, time of decompilation: Sun May  3 10:10:06 2026 ]]
return function(t1: {[any]: any}, p1: ((...any) -> ...any)) --[[ some ]] -- line: 24
	for i, v in ipairs(t1) do
		if p1(v, i, t1) then
			return true
		end
	end

	return false
end
