-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	[Enum.PartType.Block] = function(p1) --[[ Line: 4 ]]
		return (p1.X * p1.Y + p1.X * p1.Z + p1.Y * p1.Z) / 3
	end,
	[Enum.PartType.Wedge] = function(p1) --[[ Line: 7 ]]
		return (p1.X * p1.Y + p1.X * p1.Z + p1.Y * p1.Z / 2) / 3
	end,
	[Enum.PartType.Cylinder] = function(p1) --[[ Line: 10 ]]
		local v1 = p1.X / 2

		return (v1 * math.pi * v1 + v1 * 2 * p1.Y) / 2
	end,
	[Enum.PartType.CornerWedge] = function(p1) --[[ Line: 14 ]]
		return (p1.X * p1.Y / 2 + p1.X * p1.Z / 2 + p1.Y * p1.Z / 2) / 3
	end,
	[Enum.PartType.Ball] = function(p1) --[[ Line: 17 ]]
		local v1 = p1.X / 2

		return v1 * 12.566370614359172 * v1 / 3
	end
}

return function(p1, p2) --[[ AverageCrossSectionalArea | Line: 23 | Upvalues: t (copy) ]]
	return (t[p1] or t[Enum.PartType.Block])(p2)
end