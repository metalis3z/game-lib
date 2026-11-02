-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3, p4, p5) --[[ MapValue | Line: 1 ]]
	return p4 + (p1 - p2) * (p5 - p4) / (p3 - p2)
end