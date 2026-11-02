-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1) --[[ Line: 3 ]]
	if p1 < 0 then
		p1 = p1 + math.ceil(-p1 / 6.283185307179586) * 6.283185307179586
	end

	return p1 % 6.283185307179586
end