-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ Line: 1 ]]
	if not p2 then
		return false
	end

	local Character = p1.Character
	local v2 = if Character then Character.PrimaryPart else Character

	if not v2 then
		return false
	end

	return (v2.Position - p2).Magnitude < (p3 or 10)
end