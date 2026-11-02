--credit to quartz games studio
local NumberUtils = require(script.Parent.NumberUtils)
local WeightFormat = require(script.Parent.WeightFormat)
local t = {
	Tags = {
		CarrotsHarvested = "carrots_harvested",
		GoldenCarrotsHarvested = "golden_carrots_harvested",
		PlantWeightHarvested = "plant_weight_harvested"
	}
}
local t2 = {}

for v1, v2 in t.Tags do
	t2[v2] = true
end

function t.IsKnownTag(p1) --[[ IsKnownTag | Line: 42 | Upvalues: t2 (copy) ]]
	return t2[p1] == true
end

local v3 = nil

function t._setReporter(p1) --[[ _setReporter | Line: 53 | Upvalues: v3 (ref) ]]
	v3 = p1
end
function t.Report(p1, p2, p3) --[[ Report | Line: 61 | Upvalues: v3 (ref), t2 (copy) ]]
	if not v3 then
		return
	end

	if typeof(p1) ~= "Instance" or not p1:IsA("Player") then
		return
	end

	if typeof(p2) ~= "string" or not t2[p2] then
		return
	end

	if typeof(p3) == "number" and (p3 == p3 and not (p3 <= 0)) then
		v3(p1, p2, p3)
	end
end
function t.Combine(p1, p2) --[[ Combine | Line: 74 ]]
	if not (p1 and p2) then
		return 0
	end

	local sum = 0

	for v1, v2 in p1 do
		local v3 = p2[v1]

		if typeof(v3) == "number" and typeof(v2) == "number" then
			sum = sum + v3 * v2
		end
	end

	return sum
end
t.ScoreFormats = {
	integer = function(p1) --[[ integer | Line: 95 ]]
		return string.format("%d", (math.round(p1)))
	end,
	commas = function(p1) --[[ commas | Line: 99 | Upvalues: NumberUtils (copy) ]]
		return NumberUtils.FormatWithCommas((math.round(p1)))
	end,
	abbreviated = function(p1) --[[ abbreviated | Line: 103 | Upvalues: NumberUtils (copy) ]]
		return NumberUtils.Abbreviate((math.floor(p1)))
	end,
	weight = function(p1) --[[ weight | Line: 107 | Upvalues: WeightFormat (copy) ]]
		return WeightFormat.FormatGrams(p1)
	end
}
function t.FormatScore(p1, p2) --[[ FormatScore | Line: 116 | Upvalues: t (copy) ]]
	local v1 = if typeof(p1) == "number" then p1 else 0

	if v1 ~= v1 or (v1 == (1 / 0) or v1 == (-1 / 0)) then
		v1 = 0
	end

	local ScoreFormats = t.ScoreFormats

	return ((if p2 == nil then nil else ScoreFormats[p2]) or ScoreFormats.integer)(v1)
end

return t