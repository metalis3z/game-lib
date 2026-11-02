-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: reduceRight, time of decompilation: Sun May  3 10:10:02 2026 ]]
return function(t1: {[any]: any}, p1: ((...any) -> ...any), p2) --[[ reduceRight ]] -- line: 28
	local v4 = #t1

	if p2 == nil then
		p2 = t1[v4]
		v4 -= 1
	end

	for i = v4, 1, -1 do
		p2 = p1(p2, t1[i], i, t1)
	end

	return p2
end
