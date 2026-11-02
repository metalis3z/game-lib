-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: find, time of decompilation: Sun May  3 10:09:55 2026 ]]
return function(t1: {[any]: any}, p1, n1: number?) --[[ find ]] -- line: 25
	local v4 = #t1

	if type(n1) == "number" then
		if n1 < 1 then
			n1 = v4 + n1
		end
	else
		n1 = 1
	end

	return table.find(t1, p1, n1)
end
