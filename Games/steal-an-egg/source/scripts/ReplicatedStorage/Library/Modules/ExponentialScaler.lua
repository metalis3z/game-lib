-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t
function t.new(p1) --[[ new | Line: 4 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.BaseCost = p1.BaseCost or 100
	v2.ScalingFactor = p1.ScalingFactor or 1.2

	return v2
end
function t.GetCost(p1, p2) --[[ GetCost | Line: 11 ]]
	return p1.BaseCost * math.pow(p2, p1.ScalingFactor)
end

return t