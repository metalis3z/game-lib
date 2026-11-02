--credit to quartz games studio
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts)
local v1 = require(ReplicatedStorage.UserGenerated.Randoms.ISAAC).Unique()
local v2 = Asserts.Table({
	Weight = Asserts.FinitePositive,
	Value = Asserts.Any
})
local v3 = Asserts.Table({
	Weight = Asserts.FinitePositive,
	Chance = Asserts.Range(0, 1),
	Value = Asserts.Any
})
local t = {}

local function Search(p1, p2) --[[ Search | Line: 73 ]]
	local v1 = 1
	local v2 = #p1

	while v1 < v2 do
		local v3 = v1 + (v2 - v1) // 2

		if p2 < p1[v3] then
			v2 = v3
		else
			v1 = v3 + 1
		end
	end

	return v1
end

function t.Next(p1) --[[ Next | Line: 90 | Upvalues: v1 (copy), Search (copy) ]]
	local v3 = p1.Entries[Search(p1.Uppers, p1.TotalWeight * v1:NextDouble())]

	return v3.Value, v3
end
function t.Pick(p1, p2) --[[ Pick | Line: 102 | Upvalues: Search (copy) ]]
	assert(if p2 >= 0 then if p2 <= 1 then true else false else false)

	local v3 = p1.Entries[Search(p1.Uppers, p1.TotalWeight * p2)]

	return v3.Value, v3
end

local v4 = table.freeze({
	__index = table.freeze(t)
})

local function CompareOrderedEntry(p1, p2) --[[ CompareOrderedEntry | Line: 115 ]]
	if p1.Weight == p2.Weight then
		return p1.Index < p2.Index
	end

	return p1.Weight < p2.Weight
end

local function new(p1) --[[ new | Line: 123 | Upvalues: Asserts (copy), v2 (copy), CompareOrderedEntry (copy), v4 (copy) ]]
	Asserts.Array(v2)(p1)

	local v1 = #p1

	assert(v1 > 0)

	local list = {}

	for i, v in ipairs(p1) do
		table.insert(list, {
			Index = i,
			Weight = v.Weight
		})
	end

	table.sort(list, CompareOrderedEntry)

	local v3 = table.create(v1, 0)
	local sum = 0
	local list2 = {}

	for i, v in ipairs(list) do
		local v42 = p1[v.Index]
		local Weight = v42.Weight

		sum = sum + Weight
		v3[i] = sum
		table.insert(list2, {
			Chance = 0,
			Weight = Weight,
			Value = v42.Value
		})
	end

	table.freeze(v3)

	for i, v in ipairs(list2) do
		v.Chance = v.Weight / sum
		table.freeze(v)
	end

	table.freeze(list2)

	local v6 = setmetatable({
		TotalWeight = sum,
		Entries = list2,
		Uppers = v3
	}, v4)

	table.freeze(v6)

	return v6
end

local function IsA(p1) --[[ IsA | Line: 176 | Upvalues: v4 (copy) ]]
	return if type(p1) == "table" then getmetatable(p1) == v4 else false
end

local function Assert(p1) --[[ Assert | Line: 180 | Upvalues: v4 (copy) ]]
	if type(p1) ~= "table" then
		error("table", 2)
	end

	if getmetatable(p1) == v4 then
		return p1
	end

	error("DropTable", 2)
end

local v5 = table.freeze({
	__index = table.freeze({
		Add = function(p1, p2, p3) --[[ Add | Line: 211 | Upvalues: Asserts (copy) ]]
			Asserts.FinitePositive(p2)
			p1.AssertValue(p3)
			table.insert(p1.Entries, {
				Weight = p2,
				Value = p3
			})

			return p1
		end,
		Build = function(p1) --[[ Build | Line: 221 | Upvalues: new (copy) ]]
			return new(p1.Entries)
		end
	})
})

return table.freeze({
	new = new,
	IsA = IsA,
	Assert = Assert,
	AssertEntry = v3,
	Builder = function(p1) --[[ Builder | Line: 227 | Upvalues: Asserts (copy), v5 (copy) ]]
		Asserts.Function(p1)

		local v2 = setmetatable({
			AssertValue = p1,
			Entries = {}
		}, v5)

		table.freeze(v2)

		return v2
	end,
	IsABuilder = function(p1) --[[ IsABuilder | Line: 241 | Upvalues: v5 (copy) ]]
		return if type(p1) == "table" then getmetatable(p1) == v5 else false
	end,
	AssertBuilder = function(p1) --[[ AssertBuilder | Line: 245 | Upvalues: v5 (copy) ]]
		if type(p1) ~= "table" then
			error("table", 2)
		end

		if getmetatable(p1) == v5 then
			return p1
		end

		error("table", 2)
	end,
	AssertBuilderEntry = v2
})