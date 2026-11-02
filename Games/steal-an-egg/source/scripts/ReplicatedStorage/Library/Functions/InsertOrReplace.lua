-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ Line: 1 ]]
	if #p1 < p3 then
		table.insert(p1, p2)
	else
		p1[p3] = p2
	end
end