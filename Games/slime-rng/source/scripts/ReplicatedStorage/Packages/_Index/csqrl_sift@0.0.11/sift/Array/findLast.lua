-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: findLast, time of decompilation: Sun May  3 10:09:55 2026 ]]
return function(t1: {[any]: any}, p1, n1: number?) --[[ findLast ]] -- line: 20
	local v4 = #t1

	if type(n1) == "number" then
		if n1 < 1 then
			n1 = v4 + n1
		end
	else
		n1 = v4
	end

	for i = n1, 1, -1 do
		if p1 == t1[i] then
			return i
		end
	end
end
