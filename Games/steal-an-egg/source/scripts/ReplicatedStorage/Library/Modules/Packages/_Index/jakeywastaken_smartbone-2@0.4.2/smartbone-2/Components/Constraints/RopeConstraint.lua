-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function SafeUnit(p1) --[[ SafeUnit | Line: 1 ]]
	if p1.Magnitude == 0 then
		return Vector3.new(0, 0, 0)
	end

	return p1.Unit
end

return function(p1, p2, p3) --[[ Line: 9 ]]
	local v1 = p3.Bones[p1.ParentIndex]

	if not v1 then
		return
	end

	local FreeLength = p1.FreeLength
	local v2 = p2 - v1.Position
	local v3 = if v2.Magnitude == 0 then Vector3.new(0, 0, 0) else v2.Unit

	return v1.Position + v3 * (v2.Magnitude < FreeLength and v2.Magnitude or FreeLength)
end