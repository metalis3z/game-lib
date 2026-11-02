-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	HalfExtents = function(p1) --[[ HalfExtents | Line: 13 ]]
		local Size = p1.Size

		return math.max(Size.X * 0.5 - 1.75, 0), math.max(Size.Z * 0.5 - 1.75, 0)
	end
}

function t.ClampedPointToward(p1, p2) --[[ ClampedPointToward | Line: 19 | Upvalues: t (copy) ]]
	local v1, v2 = t.HalfExtents(p1)
	local v3 = p1.CFrame:PointToObjectSpace(p2)

	return (p1.CFrame * CFrame.new(math.clamp(v3.X, -v1, v1), 0, (math.clamp(v3.Z, -v2, v2)))).Position
end
function t.RandomPoint(p1, p2) --[[ RandomPoint | Line: 28 | Upvalues: t (copy) ]]
	local v1, v2 = t.HalfExtents(p1)
	local v3 = p2:NextNumber(-v1, v1)

	return (p1.CFrame * CFrame.new(v3, 0, (p2:NextNumber(-v2, v2)))).Position
end
function t.IsPositionInside(p1, p2) --[[ IsPositionInside | Line: 36 | Upvalues: t (copy) ]]
	local v1, v2 = t.HalfExtents(p1)
	local v3 = p1.CFrame:PointToObjectSpace(p2)

	return if math.abs(v3.X) <= v1 then math.abs(v3.Z) <= v2 else false
end
function t.PointNearOwner(p1, p2, p3) --[[ PointNearOwner | Line: 43 | Upvalues: t (copy) ]]
	return t.ClampedPointToward(p1, p2 + p3)
end

return t