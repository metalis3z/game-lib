-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2, p3) --[[ Line: 4 ]]
	local Gravity = game.Workspace.Gravity
	local v2 = math.atan((p3 ^ 2 + math.sqrt(p3 ^ 4 - Gravity * (Gravity * p1 ^ 2 + 2 * p2 * p3 ^ 2))) / (Gravity * p1))

	if v2 ~= v2 then
		v2 = 0.7853981633974483
	end

	return v2
end