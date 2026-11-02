-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: isSubset, time of decompilation: Sun May  3 10:10:26 2026 ]]
return function(t1: {[any]: any}, t2: {[any]: any}) --[[ isSubset ]] -- line: 19
	for k, v in pairs(t1) do
		if v ~= t2[k] then
			return false
		end
	end

	return true
end
