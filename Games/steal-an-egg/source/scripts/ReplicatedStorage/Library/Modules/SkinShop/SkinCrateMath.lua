-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local SkinCrateConfig = require(script.Parent.SkinCrateConfig)
local t = {}

local function foldHash(p1, p2) --[[ foldHash | Line: 9 ]]
	local v1 = p1

	for i = 1, #p2 do
		v1 = (v1 * 33 + string.byte(p2, i)) % 2147483647
	end

	return v1
end

function t.GetCycleBucket(p1) --[[ GetCycleBucket | Line: 17 | Upvalues: SkinCrateConfig (copy) ]]
	return math.floor(p1 / SkinCrateConfig.RefreshTime)
end
function t.GetCycleWindow(p1) --[[ GetCycleWindow | Line: 21 | Upvalues: t (copy), SkinCrateConfig (copy) ]]
	local v1 = t.GetCycleBucket(p1)
	local v2 = v1 * SkinCrateConfig.RefreshTime

	return v1, v2, v2 + SkinCrateConfig.RefreshTime
end
function t.GetCycleId(p1, p2) --[[ GetCycleId | Line: 28 ]]
	return ("%*:%*"):format(p1, p2)
end
function t.GetEligibilityThreshold(p1) --[[ GetEligibilityThreshold | Line: 32 | Upvalues: SkinCrateConfig (copy) ]]
	return math.ceil(p1 * SkinCrateConfig.EligibilityRatio)
end
function t.ComputeStock(p1, p2, p3) --[[ ComputeStock | Line: 36 ]]
	return math.max(p3, (math.ceil(math.max(p1, 0) * p2)))
end
function t.ComputeNextPrice(p1, p2, p3, p4, p5) --[[ ComputeNextPrice | Line: 40 ]]
	local v1 = math.max(0, p3) / math.max(1, p2)

	return math.max(1, (math.floor(p1 * math.clamp(1 + (0.1 * (v1 - p5.TargetFill) + (if p4 == nil then 0 else math.max(0, 1 - p4 / p5.TargetSelloutTime)) * 0.08), p5.MinCycleMultiplier, p5.MaxCycleMultiplier))))
end
function t.RollSpawn(p1, p2, p3) --[[ RollSpawn | Line: 60 ]]
	local v1 = p2 + 17

	for i = 1, #p1 do
		v1 = (v1 * 33 + string.byte(p1, i)) % 2147483647
	end

	return Random.new(v1):NextNumber() <= p3
end

return t