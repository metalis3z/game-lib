-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: removeValue, time of decompilation: Sun May  3 10:10:18 2026 ]]
return function(t1: {[any]: any}, p1) --[[ removeValue ]] -- line: 19
	local t2 = {}

	for k, v in pairs(t1) do
		if v ~= p1 then
			t2[k] = v
		end
	end

	return t2
end
