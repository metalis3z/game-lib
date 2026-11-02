--credit to leon games studio
local t = {}
local v1 = if Random then function(p1) --[[ Line: 6 ]]
	return p1 and Random.new(p1) or Random.new()
end else nil

local function sig(p1) --[[ sig | Line: 11 ]]
	return 1 / (math.exp(-p1) + 1)
end

local t2 = {
	chanceAtLuck1 = 0.01,
	chanceAtLuck100 = 0.05,
	maxSize = 10000000
}

local function doublingChance(p1) --[[ doublingChance | Line: 34 | Upvalues: t2 (copy) ]]
	return t2.chanceAtLuck1 + (t2.chanceAtLuck100 - t2.chanceAtLuck1) * ((math.clamp(p1 or 1, 1, 100) - 1) / 99)
end

local function rollDoublings(p1, p2, p3) --[[ rollDoublings | Line: 41 | Upvalues: t2 (copy) ]]
	local v2 = t2.chanceAtLuck1 + (t2.chanceAtLuck100 - t2.chanceAtLuck1) * ((math.clamp(p2 or 1, 1, 100) - 1) / 99)
	local v3, count = p3, 0

	while v3 * 2 <= t2.maxSize and p1:NextNumber() <= v2 do
		v3 = v3 * 2
		count = count + 1
	end

	return v3, count
end

local function getFruitWeight(p1, p2) --[[ getFruitWeight | Line: 66 ]]
	if not p1.usesLuck then
		return p1.weight
	end

	local luckExponent = p1.luckExponent

	if luckExponent == 1 then
		return 100 + 14000 * (1 / (math.exp(-(0.8 * (p2 - 8))) + 1)) * (1 - 1 / (math.exp(-(0.5 * (p2 - 20))) + 1) * 0.85)
	end

	if luckExponent == 1.5 then
		return 20 + 18000 * (1 / (math.exp(-(0.3 * (p2 - 18))) + 1)) * (1 - 1 / (math.exp(-(0.08 * (p2 - 75))) + 1) * 0.6)
	end

	if luckExponent == 2 then
		return 5 + 25000 * (1 / (math.exp(-(0.1 * (p2 - 50))) + 1))
	end

	if luckExponent == 2.5 then
		return 1.5 + p2 * 30
	end

	if luckExponent == 3.5 then
		return 0.01 + p2 * 3
	end

	if luckExponent == 4.5 then
		return 0.001 + p2 * 0.1
	end

	if luckExponent == 5.5 then
		return 0.0001 + p2 * 0.003
	end

	return p1.weight
end

local function getPlantWeight(p1, p2) --[[ getPlantWeight | Line: 108 ]]
	if not p1.usesLuck then
		return p1.weight
	end

	local v1 = p1.luckExponent or 1

	if v1 == 1 then
		return 500 + 5000 * (1 / (math.exp(-(1 * (p2 - 3))) + 1)) * (1 - 1 / (math.exp(-(0.4 * (p2 - 12))) + 1) * 0.85)
	end

	if v1 == 1.5 then
		return 250 + 10000 * (1 / (math.exp(-(0.4 * (p2 - 10))) + 1)) * (1 - 1 / (math.exp(-(0.06 * (p2 - 55))) + 1) * 0.5)
	end

	if v1 == 2 then
		return 125 + 15000 * (1 / (math.exp(-(0.12 * (p2 - 30))) + 1)) * (1 - 1 / (math.exp(-(0.06 * (p2 - 75))) + 1) * 0.4)
	end

	if v1 == 2.5 then
		return 62.5 + 20000 * (1 / (math.exp(-(0.08 * (p2 - 55))) + 1))
	end

	if v1 == 3 then
		return 31.25 + p2 * 50
	end

	if v1 == 3.5 then
		return 15.625 + p2 * 8
	end

	if v1 == 4 then
		return 3 + p2 * 0.5
	end

	if v1 == 4.5 then
		return 0.05 + p2 * 0.02
	end

	return p1.weight
end

local function getRandomSize(p1, p2, p3, p4) --[[ getRandomSize | Line: 147 | Upvalues: v1 (ref), rollDoublings (copy) ]]
	local v12 = v1(p3)
	local v3, v4, sum = math.clamp(p2 or 1, 1, 100), {}, 0

	for v5, v6 in p1 do
		v4[v5] = p4(v6, v3)
		sum = sum + v4[v5]
	end

	local v7 = v12:NextNumber() * sum
	local sum2 = 0
	local v8 = 1

	for v9, v10 in p1 do
		sum2 = sum2 + v4[v9]

		if v7 <= sum2 then
			v8 = v10.min + v12:NextNumber() * (v10.max - v10.min)

			break
		end
	end

	local v11, v122 = rollDoublings(v12, v3, v8)

	return v11, v122, v8
end

function t.GetRandomFruitSize(p1, p2) --[[ GetRandomFruitSize | Line: 174 | Upvalues: getRandomSize (copy), getFruitWeight (copy) ]]
	return getRandomSize({
		{
			min = 0.85,
			max = 1.15,
			weight = 10000,
			usesLuck = false
		},
		{
			min = 2.8,
			max = 3.3,
			weight = 5,
			usesLuck = true,
			luckExponent = 2
		},
		{
			min = 4,
			max = 5,
			weight = 1.5,
			usesLuck = true,
			luckExponent = 2.5
		},
		{
			min = 6.5,
			max = 7.5,
			weight = 0.01,
			usesLuck = true,
			luckExponent = 3.5
		},
		{
			min = 9.5,
			max = 12.5,
			weight = 0.001,
			usesLuck = true,
			luckExponent = 4.5
		},
		{
			min = 14.5,
			max = 17.5,
			weight = 0.0001,
			usesLuck = true,
			luckExponent = 5.5
		}
	}, p1, p2, getFruitWeight)
end

local t3 = {
	{
		min = 0.95,
		max = 1.05,
		weight = 2000,
		usesLuck = false
	},
	{
		min = 1.45,
		max = 1.55,
		weight = 250,
		usesLuck = true,
		luckExponent = 1.5
	},
	{
		min = 1.9,
		max = 2.1,
		weight = 125,
		usesLuck = true,
		luckExponent = 2
	},
	{
		min = 2.85,
		max = 3.15,
		weight = 62.5,
		usesLuck = true,
		luckExponent = 2.5
	},
	{
		min = 3.8,
		max = 4.2,
		weight = 31.25,
		usesLuck = true,
		luckExponent = 3
	},
	{
		min = 5.8,
		max = 6.2,
		weight = 15.625,
		usesLuck = true,
		luckExponent = 3.5
	},
	{
		min = 9.5,
		max = 12.5,
		weight = 3,
		usesLuck = true,
		luckExponent = 4
	},
	{
		min = 12,
		max = 17,
		weight = 0.05,
		usesLuck = true,
		luckExponent = 4.5
	},
	{
		min = 20,
		max = 35,
		weight = 0.0001,
		usesLuck = true,
		luckExponent = 5
	}
}
local t4 = {}

local function deepCloneTiers(p1) --[[ deepCloneTiers | Line: 206 ]]
	local t = {}

	for v1, v2 in p1 do
		t[v1] = {
			min = v2.min,
			max = v2.max,
			weight = v2.weight,
			usesLuck = v2.usesLuck,
			luckExponent = v2.luckExponent
		}
	end

	return t
end

function t.GetRandomPlantSize(p1, p2, p3) --[[ GetRandomPlantSize | Line: 220 | Upvalues: t4 (copy), t3 (copy), getRandomSize (copy), getPlantWeight (copy) ]]
	return getRandomSize(p3 and t4[p3] or t3, p1, p2, getPlantWeight)
end
function t.GetDefaultPlantTiers() --[[ GetDefaultPlantTiers | Line: 227 | Upvalues: deepCloneTiers (copy), t3 (copy) ]]
	return deepCloneTiers(t3)
end
function t.SetDevOverride(p1, p2) --[[ SetDevOverride | Line: 234 | Upvalues: t4 (copy), deepCloneTiers (copy) ]]
	t4[p1] = deepCloneTiers(p2)
end
function t.ClearDevOverride(p1) --[[ ClearDevOverride | Line: 238 | Upvalues: t4 (copy) ]]
	t4[p1] = nil
end
function t.GetPlantWeightAtLuck(p1, p2) --[[ GetPlantWeightAtLuck | Line: 245 | Upvalues: getPlantWeight (copy) ]]
	return getPlantWeight(p1, (math.clamp(p2 or 1, 1, 100)))
end
function t.SetDoublingConfig(p1) --[[ SetDoublingConfig | Line: 253 | Upvalues: t2 (copy) ]]
	for v1, v2 in p1 do
		t2[v1] = v2
	end
end
function t.GetDoublingChanceAtLuck(p1) --[[ GetDoublingChanceAtLuck | Line: 260 | Upvalues: t2 (copy) ]]
	return t2.chanceAtLuck1 + (t2.chanceAtLuck100 - t2.chanceAtLuck1) * ((math.clamp(p1 or 1, 1, 100) - 1) / 99)
end
function t.GetDoublingOdds(p1, p2) --[[ GetDoublingOdds | Line: 266 | Upvalues: t2 (copy) ]]
	return (t2.chanceAtLuck1 + (t2.chanceAtLuck100 - t2.chanceAtLuck1) * ((math.clamp(p1 or 1, 1, 100) - 1) / 99)) ^ p2
end

return t