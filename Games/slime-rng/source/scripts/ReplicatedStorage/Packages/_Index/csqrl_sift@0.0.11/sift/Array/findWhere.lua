-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: findWhere, time of decompilation: Sun May  3 10:09:56 2026 ]]
return function(t1: {[any]: any}, p1: ((...any) -> ...any), n1: number?) --[[ findWhere ]] -- line: 21
	local v4 = #t1

	if type(n1) == "number" then
		if n1 < 1 then
			n1 = v4 + n1
		end
	else
		n1 = 1
	end

	for i = n1, #t1 do
		if p1(t1[i], i, t1) then
			return i
		end
	end
end
