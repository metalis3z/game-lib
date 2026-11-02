-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Por = require(ReplicatedStorage.Library.Functions.Por)
local Ptries = require(ReplicatedStorage.Library.Functions.Ptries)
local AbstractItem = require(ReplicatedStorage.Library.Items.AbstractItem)
local v1 = Random.new()
local t = {}
local t2 = {}

local function safeToString(p1) --[[ safeToString | Line: 54 ]]
	local ok, result = pcall(function() --[[ Line: 55 | Upvalues: p1 (copy) ]]
		return game:GetService("HttpService"):JSONEncode(p1)
	end)

	if ok then
		return result
	end

	return tostring(p1)
end

local function computeIsOnlyCurrency(p1) --[[ computeIsOnlyCurrency | Line: 65 | Upvalues: t2 (copy), AbstractItem (copy) ]]
	local v1 = false

	for i, v in ipairs(p1.entries) do
		for i2, v2 in ipairs(t2.ParseValues(v.Value)) do
			if t2.IsDropTable(v2) then
				return false
			end

			if AbstractItem.IsAnyItem(v2) then
				if not v2:IsA("Currency") then
					return false
				end

				v1 = true
			end
		end
	end

	return v1
end

local function computeFlatTable(p1) --[[ computeFlatTable | Line: 83 | Upvalues: t2 (copy), AbstractItem (copy) ]]
	local t = {}

	local function insertEntry(p1) --[[ insertEntry | Line: 85 | Upvalues: t (copy) ]]
		table.insert(t, table.freeze(p1))
	end

	local v1 = p1:GetTotalWeight()

	for i, v in ipairs(p1.entries) do
		local v2 = v.Amount or 1

		for i2, v3 in ipairs(t2.ParseValues(v.Value)) do
			if t2.IsDropTable(v3) then
				for i3, v4 in ipairs(v3:GetFlatTable()) do
					table.insert(t, table.freeze({
						Item = v4.Item,
						Amount = v2 * v4.Amount,
						Probability = v4.Probability * v.Weight / v1
					}))
				end

				continue
			end

			if AbstractItem.IsAnyItem(v3) then
				table.insert(t, table.freeze({
					Item = v3,
					Amount = v2,
					Probability = v.Weight / v1
				}))
			end
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 111 ]]
		return p1.Probability < p2.Probability
	end)
	table.freeze(t)

	return t
end

local function computeDisplayTable(p1) --[[ computeDisplayTable | Line: 118 | Upvalues: Por (copy), t2 (copy), Ptries (copy), AbstractItem (copy) ]]
	local v1 = p1:GetTotalWeight()
	local tbl = {}

	for i, v in ipairs(p1.entries) do
		local tbl2 = {}

		local function addDisplayData(p1) --[[ addDisplayData | Line: 124 | Upvalues: tbl2 (copy), Por (ref) ]]
			local ItemBase = p1.ItemBase
			local v1 = ItemBase.Class.Name
			local v2 = ItemBase:ExactStackKey()
			local v3 = tbl2[v1]

			if not v3 then
				v3 = {}
				tbl2[v1] = v3
			end

			if v3[v2] then
				local v4 = v3[v2]

				v4.Probability = Por(v4.Probability, p1.Probability)
				v4.AvgAmount = v4.AvgAmount + p1.AvgAmount
				v4.MinAmount = v4.MinAmount + p1.MinAmount
				v4.MaxAmount = v4.MaxAmount + p1.MaxAmount
			else
				v3[v2] = p1
			end
		end

		local v2 = v.Amount or 1
		local v3 = v.Weight / v1
		local v5 = true

		for i2, v6 in ipairs((t2.ParseValues(v.Value))) do
			if t2.IsDropTable(v6) then
				if not v6:HasNil() then
					v5 = false
				end

				for i3, v7 in ipairs(v6:GetDisplayTable()) do
					addDisplayData({
						ItemBase = v7.ItemBase,
						Probability = Ptries(v7.Probability, v2) * v3,
						AvgAmount = v2 * v7.AvgAmount,
						MinAmount = v2 * v7.MinAmount,
						MaxAmount = v2 * v7.MaxAmount
					})
				end

				continue
			end

			if AbstractItem.IsAnyItem(v6) then
				local v62 = v6:GetAmount()

				addDisplayData({
					ItemBase = v6,
					Probability = v3,
					AvgAmount = v2 * v62 * v3,
					MinAmount = v2 * v62,
					MaxAmount = v2 * v62
				})
				v5 = false
			end
		end

		for k, v6 in pairs(tbl2) do
			local v7 = tbl[k] or {}

			tbl[k] = v7

			for k2, v8 in pairs(v6) do
				if v5 then
					v8.MinAmount = 0
				end

				if v7[k2] then
					local v82 = v7[k2]

					v82.Probability = Por(v82.Probability, v8.Probability)
					v82.AvgAmount = v82.AvgAmount + v8.AvgAmount
					v82.MinAmount = math.min(v82.MinAmount, v8.MinAmount)
					v82.MaxAmount = math.max(v82.MaxAmount, v8.MaxAmount)

					continue
				end

				v7[k2] = v8
			end
		end
	end

	local t = {}

	for k, v in pairs(tbl) do
		for k2, v2 in pairs(v) do
			table.insert(t, table.freeze(v2))
		end
	end

	table.sort(t, function(p1, p2) --[[ Line: 205 ]]
		return p1.Probability < p2.Probability
	end)

	return table.freeze(t)
end

function t2.ParseValues(p1) --[[ ParseValues | Line: 212 ]]
	if p1 == nil then
		return {}
	end

	if type(p1) == "table" then
		if #p1 > 0 then
			return p1
		end

		return { p1 }
	end

	local v1 = error
	local ok, result = pcall(function() --[[ Line: 55 | Upvalues: p1 (copy) ]]
		return game:GetService("HttpService"):JSONEncode(p1)
	end)

	v1(("Unknown DropTable value: %s"):format(if ok then result else tostring(p1)))
end
function t2.CompactValues(p1) --[[ CompactValues | Line: 226 ]]
	if #p1 == 0 then
		return nil
	end

	if #p1 == 1 then
		return p1[1]
	end

	return p1
end
function t2.DeepFreezeEntries(p1) --[[ DeepFreezeEntries | Line: 236 | Upvalues: t2 (copy), AbstractItem (copy) ]]
	table.freeze(p1)

	for i, v in ipairs(p1) do
		table.freeze(v)

		local v1 = t2.ParseValues(v.Value)

		table.freeze(v1)

		for i2, v2 in ipairs(v1) do
			if not t2.IsDropTable(v2) and AbstractItem.IsAnyItem(v2) then
				v2:Freeze()
			end
		end
	end
end
function t2.IsDropTable(p1) --[[ IsDropTable | Line: 252 | Upvalues: t (copy) ]]
	if type(p1) ~= "table" then
		return false
	end

	return p1.Roll == t.Roll
end
function t2.TInterfaceIsDropTable(p1) --[[ TInterfaceIsDropTable | Line: 259 | Upvalues: t2 (copy) ]]
	if t2.IsDropTable(p1) then
		return true
	end

	return false, "Value is not a DropTable"
end
function t2.withAmount(p1, p2, p3) --[[ withAmount | Line: 267 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.positiveInteger(p1)
	assert(if p3 == nil then true else false, "withAmount: unused must be nil")

	if p1 == 1 then
		return t2.new(p2)
	end

	if p1 > 100000 then
		error(("Using too large of amount: %*"):format(p1))
	end

	return t2.new({
		{
			Weight = 1,
			Value = t2.new(p2),
			Amount = p1
		}
	})
end
function t2.new(p1, p2) --[[ new | Line: 286 | Upvalues: Asserts (copy), t2 (copy), AbstractItem (copy), t (copy) ]]
	assert(if p2 == nil then true else false, "new: extra must be nil")
	Asserts.array.table(p1)
	assert(#p1 > 0, "new: entries table must not be empty")

	for i, v in ipairs(p1) do
		local Weight = v.Weight

		Asserts.finite(Weight)
		assert(Weight > 0, "new: entry weight must be greater than zero. Traceback: " .. debug.traceback())

		local Amount = v.Amount

		Asserts.optional.positiveInteger(Amount)

		local v5 = Amount or 1

		for i2, v7 in ipairs(t2.ParseValues(v.Value)) do
			local v6

			if not t2.IsDropTable(v7) then
				if AbstractItem.IsAnyItem(v7) then
					assert(not v7:GetOptionalUID(), "new: AbstractItem should not have an OptionalUID")

					if v7:IsA("Currency") and (v7:GetId() == "Diamonds" and v5 * v7:GetAmount() > 1000000000) then
						error(("Diamonds in loot table: %s"):format(v5 * v7:GetAmount()))
					end

					continue
				end

				local v8 = error
				local ok, result = pcall(function() --[[ Line: 55 | Upvalues: v7 (copy) ]]
					return game:GetService("HttpService"):JSONEncode(v7)
				end)

				v6 = if ok then result else tostring(v7)
				v8(("Invalid DropTable value: %s"):format(v6))
			end
		end
	end

	local function v11(p1, p2) --[[ validateNoLoop | Line: 319 | Upvalues: t2 (ref), v11 (copy) ]]
		local v1 = false

		for i, v in ipairs(p1) do
			for i2, v2 in ipairs(t2.ParseValues(v.Value)) do
				if t2.IsDropTable(v2) then
					if not v1 then
						v1, p2 = true, table.clone(p2)
					end

					if p2[v2] then
						error("LOOP!")
					end

					p2[v2] = true
					v11(v2.entries, p2)
				end
			end
		end
	end

	v11(p1, {})

	local v12 = table.clone(p1)

	table.sort(v12, function(p1, p2) --[[ Line: 341 ]]
		return (p1.Value ~= nil and p1.Weight or (1 / 0)) < (p2.Value ~= nil and p2.Weight or (1 / 0))
	end)
	t2.DeepFreezeEntries(v12)

	local v13 = setmetatable({
		entries = v12,
		_caches = {}
	}, {
		__index = t
	})

	table.freeze(v13)

	return v13
end
function t.GetFlatTable(p1) --[[ GetFlatTable | Line: 359 | Upvalues: computeFlatTable (copy) ]]
	local flatTable = p1._caches.flatTable

	if flatTable then
		return flatTable
	end

	local v1 = computeFlatTable(p1)

	p1._caches.flatTable = v1

	return v1
end
function t.GetDisplayTable(p1) --[[ GetDisplayTable | Line: 370 | Upvalues: computeDisplayTable (copy) ]]
	local displayTable = p1._caches.displayTable

	if displayTable then
		return displayTable
	end

	local v1 = computeDisplayTable(p1)

	p1._caches.displayTable = v1

	return v1
end
function t.IsOnlyCurrency(p1) --[[ IsOnlyCurrency | Line: 381 | Upvalues: computeIsOnlyCurrency (copy) ]]
	if p1._caches.isOnlyCurrency == nil then
		local v1 = computeIsOnlyCurrency(p1)

		p1._caches.isOnlyCurrency = v1

		return v1
	end

	return p1._caches.isOnlyCurrency
end
function t.GetTotalWeight(p1) --[[ GetTotalWeight | Line: 391 ]]
	if p1._caches.totalWeight ~= nil then
		return p1._caches.totalWeight
	end

	local sum = 0

	for i, v in ipairs(p1.entries) do
		sum = sum + v.Weight
	end

	p1._caches.totalWeight = sum

	return sum
end
function t.HasNil(p1) --[[ HasNil | Line: 404 | Upvalues: t2 (copy) ]]
	if p1._caches.hasNil ~= nil then
		return p1._caches.hasNil
	end

	local v1 = false

	for i, v in ipairs(p1.entries) do
		local v3 = true

		for i2, v4 in ipairs((t2.ParseValues(v.Value))) do
			if not (t2.IsDropTable(v4) and v4:HasNil()) then
				v3 = false

				break
			end
		end

		if v3 then
			v1 = true

			break
		end
	end

	p1._caches.hasNil = v1

	return v1
end
function t.ApplyChance(p1, p2) --[[ ApplyChance | Line: 433 | Upvalues: Asserts (copy), t2 (copy) ]]
	Asserts.finite(p2)
	assert(if p2 > 0 then true else false, "ApplyChance: chance must be greater than zero")

	if p2 == 1 then
		return p1
	end

	local entries = p1.entries

	if #entries == 1 then
		local v2 = entries[1]
		local t = {}

		for i, v in ipairs((t2.ParseValues(v2.Value))) do
			if t2.IsDropTable(v) then
				table.insert(t, v:ApplyChance(p2))

				continue
			end

			table.insert(t, v)
		end

		local v4 = table.clone(v2)

		v4.Value = t2.CompactValues(t)

		return t2.new({ v4 })
	end

	local list = {}
	local sum = 0
	local sum2 = 0

	for i, v in ipairs(entries) do
		if v.Value == nil then
			sum2 = sum2 + v.Weight

			continue
		end

		table.insert(list, table.clone(v))
		sum = sum + v.Weight
	end

	if #list == 0 then
		return p1
	end

	if p2 >= 1 and sum2 >= 0 then
		return p1
	end

	for i, v in ipairs(list) do
		v.Weight = v.Weight * p2
	end

	local v5 = sum2 + sum * (1 - p2)

	if v5 > 0 then
		table.insert(list, {
			Weight = v5
		})
	end

	return t2.new(list)
end
function t2.ToRandom(p1) --[[ ToRandom | Line: 484 | Upvalues: v1 (copy) ]]
	if p1 == nil then
		return function() --[[ Line: 486 | Upvalues: v1 (ref) ]]
			return v1:NextNumber()
		end
	end

	if type(p1) == "function" then
		return p1
	end

	if type(p1) == "number" then
		local v12 = Random.new(p1)

		return function() --[[ Line: 493 | Upvalues: v12 (copy) ]]
			return v12:NextNumber()
		end
	end

	if typeof(p1) == "Random" then
		return function() --[[ Line: 497 | Upvalues: p1 (copy) ]]
			return p1:NextNumber()
		end
	end

	error(("Invalid rng: %s"):format((tostring(p1))))
end
function t2.SimulateRolls(p1, p2) --[[ SimulateRolls | Line: 505 | Upvalues: Asserts (copy) ]]
	Asserts.finiteNonNegative(p1)
	Asserts.finite(p2)
	assert(if p2 >= 0 then if p2 < 1 then true else false else false, "SimulateRolls: probability must be between 0 and 1")

	return 1 - (1 - p2) ^ (1 / p1)
end
function t.RollN(p1, p2, p3, p4) --[[ RollN | Line: 514 | Upvalues: Asserts (copy), t2 (copy), AbstractItem (copy) ]]
	Asserts.integerNonNegative(p2)
	Asserts.optional.func(p4)

	if p2 == 0 then
		return {}
	end

	local v1 = t2.ToRandom(p3)
	local entries = p1.entries
	local t = {}

	if #entries == 1 then
		local v2 = entries[1]
		local v3 = v2.Amount or 1

		for i, v in ipairs(t2.ParseValues(v2.Value)) do
			if t2.IsDropTable(v) then
				for i2, v4 in ipairs(v:RollN(p2 * v3, v1, p4)) do
					table.insert(t, v4)
				end

				continue
			end

			if AbstractItem.IsAnyItem(v) then
				for i2 = 1, p2 * v3 do
					table.insert(t, {
						Item = v:Clone(),
						Entry = v2
					})
				end
			end
		end
	else
		local sum = p1:GetTotalWeight()
		local v4

		if p4 then
			local t3 = {}

			sum = 0

			for i, v in ipairs(entries) do
				local v5 = p4(p1, v.Weight, v.Value, v.Amount or 1, v)

				Asserts.finite(v5)
				assert(if v5 >= 0 then true else false, "RollN: weight returned by callback must be non-negative")
				table.insert(t3, {
					Index = i,
					Weight = v5
				})
				sum = sum + v5
			end

			table.sort(t3, function(p1, p2) --[[ Line: 559 | Upvalues: entries (copy) ]]
				return (if entries[p1.Index].Value == nil then (1 / 0) else p1.Weight or (1 / 0)) < (entries[p2.Index].Value ~= nil and p2.Weight or (1 / 0))
			end)
			v4 = t3
		else
			v4 = nil
		end

		for j = 1, p2 do
			local v7 = v1()

			Asserts.finite(v7)
			assert(if v7 >= 0 then if v7 < 1 then true else false else false, (("RollN: Invalid roll provided, must be between 0 and 1: %*"):format(v7)))

			local v10 = v7 * sum
			local v11 = 0

			if v4 then
				local sum2 = v10

				for i, v in ipairs(v4) do
					sum2 = sum2 - v.Weight
					v11 = v.Index

					if not (sum2 > 0) then
						break
					end
				end
			else
				local sum2 = v10

				for i, v in ipairs(entries) do
					sum2 = sum2 - v.Weight
					v11 = i

					if not (sum2 > 0) then
						break
					end
				end
			end

			local v12 = entries[v11]

			if v12 then
				for i, v in ipairs(t2.ParseValues(v12.Value)) do
					local v13 = v12.Amount or 1

					if t2.IsDropTable(v) then
						for i2, v2 in ipairs(v:RollN(v13, v1)) do
							table.insert(t, v2)
						end

						continue
					end

					if AbstractItem.IsAnyItem(v) then
						for k = 1, v13 do
							table.insert(t, {
								Item = v:Clone(),
								Entry = v12
							})
						end
					end
				end
			end
		end
	end

	return t
end
function t.Roll(p1, p2, p3) --[[ Roll | Line: 620 | Upvalues: t (copy) ]]
	return t.RollN(p1, 1, p2, p3)
end
function t.RollOne(p1, p2, p3) --[[ RollOne | Line: 624 | Upvalues: t (copy) ]]
	return t.RollN(p1, 1, p2, p3)[1]
end
function t.ComputeEstValue(p1) --[[ ComputeEstValue | Line: 628 | Upvalues: t2 (copy), AbstractItem (copy) ]]
	local sum = 0
	local sum2 = 0

	for i, v in ipairs(p1.entries) do
		local Weight = v.Weight
		local sum3 = 0

		for i2, v2 in ipairs((t2.ParseValues(v.Value))) do
			if t2.IsDropTable(v2) then
				sum3 = sum3 + v2:ComputeEstValue()

				continue
			end

			if AbstractItem.IsAnyItem(v2) then
				sum3 = sum3 + (v2:GetDevRAP() or 0) * v2:GetAmount()
			end
		end

		sum = sum + sum3 * (v.Amount or 1) * Weight
		sum2 = sum2 + Weight
	end

	return sum / sum2
end
setmetatable(t, {
	__index = function(p1, p2) --[[ __index | Line: 653 ]]
		error(("Unknown DropTable prototype key \'%s\'"):format(p2))
	end
})
table.freeze(t)
setmetatable(t2, {
	__index = function(p1, p2) --[[ __index | Line: 661 ]]
		error(("Unknown DropTable key \'%s\'"):format(p2))
	end
})

return table.freeze(t2)