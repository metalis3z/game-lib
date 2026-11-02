--[[
	Toolkit  (ModuleScript, shared)

	Three small helpers almost every game re-writes:

	  Toolkit.WeightedPicker  - weighted random ("Common 70, Rare 25, Legendary 5"), with
	                            luck multipliers for rare entries and an optional seed
	  Toolkit.Cooldown        - per-key cooldowns / debounce ("can this player swing yet?")
	  Toolkit.Pool            - object pool for parts / effects / UI rows you spawn a lot

	Credit: punching-simulator RandomUtility.chance (cumulative weight roll) and Pool (get/back),
	rcu-roller RewardService rollWeighted (pick N rewards), steal-a-brainrot CodeService
	(mutation weights), aura-ascension RateLimiter (per-player per-key next-allowed time),
	escape-kitty-keyboard AdminPanelServer (per-admin cooldown), BIG Paintball RandomizeTable idea.

	Usage:
		local Toolkit = require(game.ReplicatedStorage.Toolkit)

		local eggPicker = Toolkit.WeightedPicker.new({
			{ Item = "Dog", Weight = 70 },
			{ Item = "Cat", Weight = 25 },
			{ Item = "Dragon", Weight = 5, Rare = true },
		})
		local pet = eggPicker:Pick()                  -- "Dog" most of the time
		local lucky = eggPicker:Pick(nil, 2)          -- Rare entries weigh 2x
		print(eggPicker:Chance("Dragon"))             -- 0.05

		local swing = Toolkit.Cooldown.new(0.6)
		if swing:Try(player) then ... end             -- true at most every 0.6s per player
		print(swing:Remaining(player))

		local pool = Toolkit.Pool.new(ReplicatedStorage.CoinTemplate, 20) -- pre-make 20
		local coin = pool:Get()  coin.Parent = workspace
		pool:Return(coin)                             -- parented to nil and reused later
]]

local Toolkit = {}

------------------------------------------------------------------------
-- WeightedPicker
------------------------------------------------------------------------
local WeightedPicker = {}
WeightedPicker.__index = WeightedPicker

function WeightedPicker.new(entries, seed)
	local self = setmetatable({}, WeightedPicker)
	self.Entries = {}
	self.Total = 0
	for _, entry in ipairs(entries) do
		assert(type(entry.Weight) == "number" and entry.Weight >= 0, "every entry needs a Weight >= 0")
		table.insert(self.Entries, entry)
		self.Total += entry.Weight
	end
	assert(self.Total > 0, "WeightedPicker needs a positive total weight")
	self.Random = if seed then Random.new(seed) else Random.new()
	return self
end

-- rng: optional Random to use (for seeded / reproducible rolls).
-- rareMultiplier: multiplies the weight of entries marked Rare = true (luck boosts).
function WeightedPicker:Pick(rng, rareMultiplier)
	rng = rng or self.Random
	rareMultiplier = rareMultiplier or 1
	local total = 0
	for _, entry in ipairs(self.Entries) do
		total += if entry.Rare then entry.Weight * rareMultiplier else entry.Weight
	end
	local roll = rng:NextNumber() * total
	local running = 0
	for _, entry in ipairs(self.Entries) do
		running += if entry.Rare then entry.Weight * rareMultiplier else entry.Weight
		if roll < running then
			return entry.Item, entry
		end
	end
	local last = self.Entries[#self.Entries]
	return last.Item, last
end

-- Picks `count` items (with repeats).
function WeightedPicker:PickMany(count, rng, rareMultiplier)
	local results = {}
	for i = 1, count do
		results[i] = self:Pick(rng, rareMultiplier)
	end
	return results
end

-- Chance (0..1) of one item without luck, for "1 in N" labels.
function WeightedPicker:Chance(item)
	for _, entry in ipairs(self.Entries) do
		if entry.Item == item then
			return entry.Weight / self.Total
		end
	end
	return 0
end

Toolkit.WeightedPicker = WeightedPicker

------------------------------------------------------------------------
-- Cooldown
------------------------------------------------------------------------
local Cooldown = {}
Cooldown.__index = Cooldown

function Cooldown.new(seconds)
	return setmetatable({ Seconds = seconds, _next = {} }, Cooldown)
end

-- Returns true (and starts the cooldown) if `key` is ready. Key can be a player, a string, anything.
function Cooldown:Try(key, seconds)
	local now = os.clock()
	if (self._next[key] or 0) > now then
		return false
	end
	self._next[key] = now + (seconds or self.Seconds)
	return true
end

function Cooldown:Remaining(key)
	return math.max(0, (self._next[key] or 0) - os.clock())
end

function Cooldown:Reset(key)
	self._next[key] = nil
end

-- Call from PlayerRemoving if you key by player, so the table does not grow forever.
function Cooldown:Forget(key)
	self._next[key] = nil
end

-- Wraps a function so it runs at most once per `seconds` per first argument (debounce).
function Toolkit.Debounce(seconds, fn)
	local cooldown = Cooldown.new(seconds)
	return function(key, ...)
		if cooldown:Try(key) then
			return fn(key, ...)
		end
		return nil
	end
end

Toolkit.Cooldown = Cooldown

------------------------------------------------------------------------
-- Pool
------------------------------------------------------------------------
local Pool = {}
Pool.__index = Pool

function Pool.new(template, prewarm, maxSize)
	local self = setmetatable({ Template = template, MaxSize = maxSize or 200, _free = {}, _out = {} }, Pool)
	for _ = 1, prewarm or 0 do
		table.insert(self._free, template:Clone())
	end
	return self
end

function Pool:Get()
	local object = table.remove(self._free) or self.Template:Clone()
	self._out[object] = true
	return object
end

function Pool:Return(object)
	if not self._out[object] then
		return -- not ours, or returned twice
	end
	self._out[object] = nil
	if #self._free >= self.MaxSize then
		object:Destroy()
		return
	end
	object.Parent = nil
	table.insert(self._free, object)
end

function Pool:Destroy()
	for _, object in ipairs(self._free) do
		object:Destroy()
	end
	for object in pairs(self._out) do
		object:Destroy()
	end
	table.clear(self._free)
	table.clear(self._out)
end

Toolkit.Pool = Pool

return Toolkit
