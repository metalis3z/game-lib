-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return function(p1, p2) --[[ Line: 7 ]]
	local v1 = p1 or 1
	local v2 = p2 or math.random()

	return function(p1) --[[ Line: 11 | Upvalues: v2 (ref), v1 (copy) ]]
		v2 = v2 + p1 * v1

		return Color3.fromHSV(v2 % 1, 1, 1)
	end
end