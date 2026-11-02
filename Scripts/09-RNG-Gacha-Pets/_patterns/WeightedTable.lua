--!strict
-- WeightedTable: weighted random picks with luck, "1 in N" odds and a fast cumulative search.
-- Pattern module written for this library. Ideas taken from:
--   pet-rng (Roll.lua: plain cumulative roll, luck multiplies only very rare weights)
--   rcu-roller (EggService: weight ^ (1 / luck); PetUtils/AuraUtils: move % from common to rare)
--   smash-egg-for-animals (EggZoneServer.pickKey: boost every entry except the most common one)
--   grow-a-garden-2 DropTable (sorted upper bounds + binary search)
--
-- Usage (ModuleScript in ReplicatedStorage, roll ONLY on the server):
--   local WeightedTable = require(ReplicatedStorage.WeightedTable)
--   local pets = WeightedTable.new({
--       { Value = "Dog",    Weight = 50 },
--       { Value = "Cat",    Weight = 30 },
--       { Value = "Dragon", Weight = 1  },
--   })
--   local name = pets:Roll()                                  -- no luck
--   local name2 = pets:Roll(3, "Exponent")                    -- luck x3, flattens the curve
--   local name3 = pets:Roll(2, "BoostRare", { RareBelow = 5 })-- only weights < 5 are multiplied
--   print(pets:OddsText("Dragon"))                            -- "1/81"
--
-- Luck modes:
--   "BoostRare" : weight * luck for entries whose base weight < opts.RareBelow (default: all but the most common)
--   "Exponent"  : weight ^ (1 / luck). luck 1 = unchanged, big luck pulls all weights toward 1 (rare gets closer to common)
--   "Shift"     : like rcu-roller. Rare chances are multiplied by luck and the same amount is taken
--                 away from the most common entry, so the total stays the same (never below 0)

export type Entry = { Value: any, Weight: number }
export type LuckMode = "BoostRare" | "Exponent" | "Shift"
export type Options = { RareBelow: number? }

local WeightedTable = {}
WeightedTable.__index = WeightedTable

function WeightedTable.new(entries: { Entry }, rng: Random?)
	assert(type(entries) == "table" and #entries > 0, "WeightedTable.new needs at least one entry")
	local self = setmetatable({}, WeightedTable)
	self.Entries = {}
	self.Rng = rng or Random.new()
	local maxWeight, maxIndex = -math.huge, 1
	for i, e in ipairs(entries) do
		assert(type(e.Weight) == "number" and e.Weight >= 0 and e.Weight == e.Weight, "bad weight at entry " .. i)
		table.insert(self.Entries, { Value = e.Value, Weight = e.Weight })
		if e.Weight > maxWeight then
			maxWeight, maxIndex = e.Weight, i
		end
	end
	self.CommonIndex = maxIndex
	self:_rebuild(self:_baseWeights())
	return self
end

function WeightedTable:_baseWeights(): { number }
	local w = table.create(#self.Entries)
	for i, e in ipairs(self.Entries) do
		w[i] = e.Weight
	end
	return w
end

-- builds the cumulative "upper bound" array used by the binary search
function WeightedTable:_rebuild(weights: { number })
	local uppers = table.create(#weights)
	local total = 0
	for i, w in ipairs(weights) do
		total += w
		uppers[i] = total
	end
	self._uppers = uppers
	self._total = total
	self._weights = weights
end

function WeightedTable:_luckWeights(luck: number, mode: LuckMode, opts: Options?): { number }
	local base = self:_baseWeights()
	if luck <= 1 then
		return base
	end
	if mode == "Exponent" then
		for i, w in ipairs(base) do
			base[i] = if w > 0 then w ^ (1 / luck) else 0
		end
	elseif mode == "Shift" then
		local moved = 0
		for i, w in ipairs(base) do
			if i ~= self.CommonIndex then
				moved += w * (luck - 1)
				base[i] = w * luck
			end
		end
		base[self.CommonIndex] = math.max(0, base[self.CommonIndex] - moved)
	else -- "BoostRare"
		local rareBelow = opts and opts.RareBelow
		for i, w in ipairs(base) do
			local isRare = if rareBelow then w < rareBelow else i ~= self.CommonIndex
			if isRare then
				base[i] = w * luck
			end
		end
	end
	return base
end

-- binary search: first index whose upper bound is >= x
local function search(uppers: { number }, x: number): number
	local lo, hi = 1, #uppers
	while lo < hi do
		local mid = (lo + hi) // 2
		if x <= uppers[mid] then
			hi = mid
		else
			lo = mid + 1
		end
	end
	return lo
end

-- Roll once. Returns (value, index).
function WeightedTable:Roll(luck: number?, mode: LuckMode?, opts: Options?): (any, number)
	local l = luck or 1
	if l > 1 then
		self:_rebuild(self:_luckWeights(l, mode or "BoostRare", opts))
	elseif self._total == nil then
		self:_rebuild(self:_baseWeights())
	end
	if self._total <= 0 then
		return self.Entries[self.CommonIndex].Value, self.CommonIndex
	end
	local index = search(self._uppers, self.Rng:NextNumber() * self._total)
	-- skip zero-weight entries that share an upper bound with the previous one
	while self._weights[index] == 0 and index < #self._weights do
		index += 1
	end
	local value = self.Entries[index].Value
	if l > 1 then
		self:_rebuild(self:_baseWeights()) -- restore so OddsText shows base odds
	end
	return value, index
end

-- Roll many times (multi-hatch / x3 roll). Returns an array of values.
function WeightedTable:RollMany(count: number, luck: number?, mode: LuckMode?, opts: Options?): { any }
	local results = table.create(count)
	for i = 1, count do
		results[i] = (self:Roll(luck, mode, opts))
	end
	return results
end

-- Chance (0..1) of a value under the base weights (or with luck if given).
function WeightedTable:Chance(value: any, luck: number?, mode: LuckMode?, opts: Options?): number
	local weights = if luck and luck > 1 then self:_luckWeights(luck, mode or "BoostRare", opts) else self:_baseWeights()
	local total, w = 0, 0
	for i, e in ipairs(self.Entries) do
		total += weights[i]
		if e.Value == value then
			w += weights[i]
		end
	end
	return if total > 0 then w / total else 0
end

-- "1/250" style text used by RNG games (pet-rng shows math.round(total / weight)).
function WeightedTable:OddsText(value: any, luck: number?, mode: LuckMode?, opts: Options?): string
	local c = self:Chance(value, luck, mode, opts)
	if c <= 0 then
		return "1/inf"
	end
	return "1/" .. tostring(math.max(1, math.round(1 / c)))
end

return WeightedTable
