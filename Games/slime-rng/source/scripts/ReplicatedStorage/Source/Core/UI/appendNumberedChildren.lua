-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: appendNumberedChildren, time of decompilation: Sun May  3 10:10:58 2026 ]]
return function(t1: {[any]: any}, t2: {[any]: any}) -- line: 1
	for v3, v4 in t1 do
		if type(v3) == "number" then
			table.insert(t2, v4)
		end
	end
end
