--!strict
-- PityCounter: per-player bad-luck protection for gacha rolls (server only).
-- Pattern module written for this library. Ideas taken from:
--   slime-rng (RollService: golden / diamond / void "special roll" every 10 / 100 / 1000 rolls)
--   brainrot-lab (BrainrotConveyor: Legendary / Mythical / Secret guaranteed by a pity timer)
--   rcu-roller (data.pity[eggName] + "Mythical Pity" upgrade shown on the egg UI)
--
-- It supports two kinds of pity for each "banner" (egg, crate, roll button...):
--   Hard pity : after N rolls without reaching a tier, the next roll is forced to that tier.
--   Soft pity : from roll S onward, the tier's chance grows a bit every roll (handled by
--               giving you a luck multiplier to feed into your weighted roll).
-- And "every N rolls" bonus rolls (slime-rng style) through :Tick().
--
-- The state is a plain table so you can save it inside your player profile.
--
-- Usage:
--   local PityCounter = require(ServerScriptService.PityCounter)
--   local pity = PityCounter.new({
--       Legendary = { HardPity = 200, SoftPityStart = 150, SoftPityStep = 0.05 },
--       Secret    = { HardPity = 2000 },
--   }, { "Common", "Rare", "Epic", "Legendary", "Secret" }) -- tier order, low to high
--
--   -- inside your server roll handler:
--   local state = profile.Data.Pity            -- {} the first time
--   local forced = pity:ForcedTier(state, "BasicEgg")   -- "Secret" / "Legendary" / nil
--   local luck   = baseLuck * pity:SoftLuck(state, "BasicEgg", "Legendary")
--   local tier   = forced or rollTierWithLuck(luck)    -- your own WeightedTable roll
--   pity:Record(state, "BasicEgg", tier)              -- resets counters the roll satisfied
--   print(pity:RollsLeft(state, "BasicEgg", "Legendary")) -- for the UI ("Legendary in 37")

export type TierRule = { HardPity: number?, SoftPityStart: number?, SoftPityStep: number? }
export type State = { [string]: { [string]: number } } -- banner -> tier -> rolls since last hit

local PityCounter = {}
PityCounter.__index = PityCounter

function PityCounter.new(rules: { [string]: TierRule }, tierOrder: { string })
	local self = setmetatable({}, PityCounter)
	self.Rules = rules
	self.Order = {}
	for i, tier in ipairs(tierOrder) do
		self.Order[tier] = i
	end
	return self
end

local function bucket(state: State, banner: string): { [string]: number }
	local b = state[banner]
	if not b then
		b = {}
		state[banner] = b
	end
	return b
end

-- Highest tier whose hard pity is reached, or nil.
function PityCounter:ForcedTier(state: State, banner: string): string?
	local b = bucket(state, banner)
	local best: string? = nil
	for tier, rule in pairs(self.Rules) do
		if rule.HardPity and (b[tier] or 0) + 1 >= rule.HardPity then
			if not best or (self.Order[tier] or 0) > (self.Order[best] or 0) then
				best = tier
			end
		end
	end
	return best
end

-- Luck multiplier (>= 1) to apply for one tier while in its soft-pity window.
function PityCounter:SoftLuck(state: State, banner: string, tier: string): number
	local rule = self.Rules[tier]
	if not rule or not rule.SoftPityStart then
		return 1
	end
	local count = bucket(state, banner)[tier] or 0
	local over = count - rule.SoftPityStart
	if over <= 0 then
		return 1
	end
	return 1 + over * (rule.SoftPityStep or 0.05)
end

-- Call once per roll with the tier the player actually got.
-- Every tracked tier at or below the result resets; tiers above it count up.
function PityCounter:Record(state: State, banner: string, gotTier: string)
	local b = bucket(state, banner)
	local gotRank = self.Order[gotTier] or 0
	for tier in pairs(self.Rules) do
		if (self.Order[tier] or math.huge) <= gotRank then
			b[tier] = 0
		else
			b[tier] = (b[tier] or 0) + 1
		end
	end
end

function PityCounter:RollsLeft(state: State, banner: string, tier: string): number?
	local rule = self.Rules[tier]
	if not rule or not rule.HardPity then
		return nil
	end
	return math.max(0, rule.HardPity - (bucket(state, banner)[tier] or 0))
end

-- slime-rng style "every N rolls" bonus. cadence = { Golden = 10, Diamond = 100 }.
-- Returns a set of bonus names that fire on THIS roll. Stores its own counters under "__every".
function PityCounter.Tick(state: State, cadence: { [string]: number }): { [string]: boolean }
	local b = bucket(state, "__every")
	local fired = {}
	for name, every in pairs(cadence) do
		local n = (b[name] or 0) + 1
		if n >= every then
			fired[name] = true
			n = 0
		end
		b[name] = n
	end
	return fired
end

return PityCounter
