-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: reduce, time of decompilation: Sun May  3 10:10:02 2026 ]]
return function(t1: {[any]: any}, p1: ((...any) -> ...any), p2) --[[ reduce ]] -- line: 27
	local n1 = 1

	if p2 == nil then
		p2 = t1[1]
		n1 = 2
	end

	for i = n1, #t1 do
		p2 = p1(p2, t1[i], i, t1)
	end

	return p2
end
