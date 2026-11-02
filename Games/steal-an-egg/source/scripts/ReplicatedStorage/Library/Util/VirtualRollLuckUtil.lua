-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local DropTable = require(ReplicatedStorage.Library.DropTable)
local t = {}

local function isValidWeight(p1) --[[ isValidWeight | Line: 16 ]]
	return if typeof(p1) == "number" and (p1 > 0 and p1 == p1) then p1 ~= (1 / 0) else false
end

local function getSortedDropTable(p1) --[[ getSortedDropTable | Line: 20 ]]
	local t = {}

	for i, v in ipairs(p1) do
		table.insert(t, v)
	end

	table.sort(t, function(p1, p2) --[[ Line: 27 ]]
		local v1 = p1[2]
		local v2 = p2[2]
		local v3 = if typeof(v1) == "number" and (v1 > 0 and v1 == v1) then if v1 == (1 / 0) then false else true else false
		local v4 = if typeof(v2) == "number" and (v2 > 0 and v2 == v2) then if v2 == (1 / 0) then false else true else false

		if v3 ~= v4 then
			return v3
		end

		if v3 or v4 then
			if v1 == v2 then
				local v6 = if typeof(p1[1]) == "string" then p1[1] else ""

				return v6 < (if typeof(p2[1]) == "string" then p2[1] else "")
			end

			return v1 < v2
		end

		local v12 = if typeof(p1[1]) == "string" then p1[1] else ""

		return v12 < (if typeof(p2[1]) == "string" then p2[1] else "")
	end)

	return t
end

local function getTotalWeight(p1) --[[ getTotalWeight | Line: 59 ]]
	local sum = 0

	for i, v in ipairs(p1) do
		local v1 = v[2]

		if if typeof(v1) == "number" and (v1 > 0 and v1 == v1) then if v1 == (1 / 0) then false else true else false then
			sum = sum + v1
		end
	end

	return sum
end

local function getVirtualRollCdf(p1, p2) --[[ getVirtualRollCdf | Line: 72 | Upvalues: Asserts (copy) ]]
	Asserts.finite(p1)
	Asserts.finiteNonNegative(p2)

	if p2 <= 1 then
		return p1
	end

	return 1 - (1 - p1) ^ p2
end

function t.ComputeVirtualRolls(p1, p2) --[[ ComputeVirtualRolls | Line: 84 ]]
	local v2 = 1 + (if typeof(p1) == "number" then p1 else 0) / 100

	if v2 < 0 then
		v2 = 0
	end

	local v4 = v2 + ((if typeof(p2) == "number" then math.max(p2, 1) else 1) - 1)

	if v4 < 1 then
		return 1
	end

	return v4
end
function t.RollToken(p1, p2, p3) --[[ RollToken | Line: 102 | Upvalues: Asserts (copy), getSortedDropTable (copy), getTotalWeight (copy), DropTable (copy) ]]
	Asserts.table(p1)
	Asserts.number(p2)
	assert(if p3 == nil then true elseif typeof(p3) == "Random" then true else false, "rng must be a Random")

	local v2 = getSortedDropTable(p1)
	local v3 = getTotalWeight(v2)

	if v3 <= 0 then
		return nil
	end

	local v4 = if p3 then p3 else Random.new()
	local sum, v6 = DropTable.SimulateRolls(math.max(p2, 1), v4:NextNumber()) * v3, nil

	for i, v in ipairs(v2) do
		local v7 = v[1]
		local v8 = v[2]

		if typeof(v7) == "string" and (if typeof(v8) == "number" and (v8 > 0 and v8 == v8) then if v8 == (1 / 0) then false else true else false) then
			sum = sum - v8

			if sum <= 0 then
				return v7
			end

			v6 = v7
		end
	end

	return v6
end
function t.ComputeTokenOdds(p1, p2) --[[ ComputeTokenOdds | Line: 138 | Upvalues: Asserts (copy), getSortedDropTable (copy), getTotalWeight (copy) ]]
	Asserts.table(p1)
	Asserts.number(p2)

	local v1 = getSortedDropTable(p1)
	local v2 = getTotalWeight(v1)

	if v2 <= 0 then
		return {}
	end

	local t = {}
	local sum = 0

	for i, v in ipairs(v1) do
		local v3 = v[1]
		local v4 = v[2]

		if typeof(v3) == "string" and (if typeof(v4) == "number" and (v4 > 0 and v4 == v4) then if v4 == (1 / 0) then false else true else false) then
			local v6 = sum / v2

			sum = sum + v4

			local v7 = sum / v2
			local v8 = math.max(p2, 1)

			Asserts.finite(v7)
			Asserts.finiteNonNegative(v8)

			local v10 = math.max(p2, 1)

			Asserts.finite(v6)
			Asserts.finiteNonNegative(v10)

			local v12 = (if v8 <= 1 then v7 else 1 - (1 - v7) ^ v8) - (if v10 <= 1 then v6 else 1 - (1 - v6) ^ v10)

			if v12 > 0 then
				t[v3] = (t[v3] or 0) + v12
			end
		end
	end

	return t
end

return t