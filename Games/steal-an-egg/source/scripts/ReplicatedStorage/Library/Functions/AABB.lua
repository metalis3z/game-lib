-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3, p4, p5, p6) --[[ Line: 1 ]]
	if not (p3 <= p1 and (p1 <= p3 + p5 and p4 <= p2)) then
		return false
	end

	return p2 <= p4 + p6
end