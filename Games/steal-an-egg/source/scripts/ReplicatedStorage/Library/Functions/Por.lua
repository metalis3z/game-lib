-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
function Por(p1, p2) --[[ Por | Line: 1 ]]
	local v1 = math.clamp(p1, 0, 1)
	local v2 = math.clamp(p2, 0, 1)

	return v1 + v2 - v1 * v2
end

return Por