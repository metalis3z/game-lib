-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: every, time of decompilation: Sun May  3 10:09:54 2026 ]]
return function(t1: {[any]: any}, p1: ((...any) -> ...any)) --[[ every ]] -- line: 24
	for i, v in ipairs(t1) do
		if not p1(v, i, t1) then
			return false
		end
	end

	return true
end
