-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = workspace

return function(p1, p2, p3, p4) --[[ SafeRaycast | Line: 11 | Upvalues: v1 (copy) ]]
	local v12 = p4 or 0.001

	assert(if v12 >= 0 then true else false, "luau")

	local Magnitude = p2.Magnitude

	assert(if v12 < Magnitude then true else false, "luau")

	local v4 = v1:Raycast(p1, p2, p3)

	if v4 then
		local v6 = math.max(0, v4.Distance - v12)

		return {
			Distance = v6,
			Instance = v4.Instance,
			Material = v4.Material,
			Position = p1 + v6 * p2 / Magnitude,
			Normal = v4.Normal
		}
	end

	return nil
end