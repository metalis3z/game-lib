-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: at, time of decompilation: Sun May  3 10:09:48 2026 ]]
return function(t1: {[any]: any}, n1: number) --[[ at ]] -- line: 19
	local v3 = #t1

	if n1 < 1 then
		n1 += v3
	end

	return t1[n1]
end
