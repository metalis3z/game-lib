-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ Line: 1 ]]
	local v1 = p1:Directory()
	local v2 = p1:GetName()
	local v3 = p1:GetRarity()

	return v3.Message(p2.DisplayName, v2, v1, p3), v3.Color, v3.Announce
end