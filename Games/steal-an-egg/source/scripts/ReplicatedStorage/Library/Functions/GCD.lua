-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 1 ]]
	while p2 ~= 0 do
		p2, p1 = p1 % p2, p2
	end

	return p1
end