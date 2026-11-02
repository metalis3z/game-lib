--[[
	TimedBoosts  (ModuleScript, shared: pure functions over a table you save)

	Stackable timed boosts (2x coins, luck potions, speed boosts) stored inside player data.
	Buying the same boost again ADDS time instead of resetting it.

	Two clock modes:
	  "RealTime"  - an expiry timestamp; time runs out even while the player is offline
	               (simplest, what slime-rng does with expirationTime).
	  "Playtime"  - remaining seconds that only tick while the player is in a server
	               (what rcu-roller and steal-an-egg do). Call Tick(boosts, dt) from one loop.

	Credit: slime-rng MonetizationService addBoost (extend from max(expiry, now)),
	steal-an-egg Core_Purchases grantTemporarySpeedBoost, rcu-roller DataService boost countdown,
	steal-an-egg server luck (max multiplier + extend).

	Usage (server):
		local TimedBoosts = require(game.ReplicatedStorage.TimedBoosts)

		-- data.Boosts is a table inside your saved player data (start it as {}).
		TimedBoosts.Add(data.Boosts, "Coins2x", 15 * 60, 2)            -- RealTime by default
		TimedBoosts.Add(data.Boosts, "Luck", 30 * 60, 1.5, "Playtime")

		local coinMultiplier = TimedBoosts.Multiplier(data.Boosts, "Coins2x")  -- 2 or 1
		local secondsLeft = TimedBoosts.Remaining(data.Boosts, "Luck")

		-- Once per second for every loaded player (only needed for "Playtime" boosts):
		TimedBoosts.Tick(data.Boosts, 1)

	Client: read the same table (replicated with your data) and call Remaining() to draw timers.
]]

local TimedBoosts = {}

local function now()
	return os.time()
end

-- Adds `seconds` to a boost. If it is already running the time is stacked on top.
-- A stronger multiplier replaces a weaker one; a weaker one keeps the stronger value.
function TimedBoosts.Add(boosts, name, seconds, multiplier, mode)
	mode = mode or "RealTime"
	multiplier = multiplier or 2
	local boost = boosts[name]
	if type(boost) ~= "table" or boost.Mode ~= mode then
		boost = { Mode = mode, Multiplier = multiplier, ExpiresAt = 0, Remaining = 0 }
		boosts[name] = boost
	end
	boost.Multiplier = math.max(boost.Multiplier or 1, multiplier)

	if mode == "RealTime" then
		boost.ExpiresAt = math.max(boost.ExpiresAt or 0, now()) + seconds
	else
		boost.Remaining = math.max(boost.Remaining or 0, 0) + seconds
	end
	return TimedBoosts.Remaining(boosts, name)
end

function TimedBoosts.Remaining(boosts, name)
	local boost = boosts[name]
	if type(boost) ~= "table" then
		return 0
	end
	if boost.Mode == "RealTime" then
		return math.max(0, (boost.ExpiresAt or 0) - now())
	end
	return math.max(0, boost.Remaining or 0)
end

function TimedBoosts.IsActive(boosts, name)
	return TimedBoosts.Remaining(boosts, name) > 0
end

-- Multiplier while active, otherwise 1.
function TimedBoosts.Multiplier(boosts, name)
	if TimedBoosts.IsActive(boosts, name) then
		return boosts[name].Multiplier or 1
	end
	return 1
end

-- Product of all active boosts whose names are in `names` (or all boosts when names is nil).
function TimedBoosts.Combined(boosts, names)
	local total = 1
	if names then
		for _, name in ipairs(names) do
			total *= TimedBoosts.Multiplier(boosts, name)
		end
	else
		for name in pairs(boosts) do
			total *= TimedBoosts.Multiplier(boosts, name)
		end
	end
	return total
end

-- Counts down "Playtime" boosts and removes every expired boost. Returns names that just ended.
function TimedBoosts.Tick(boosts, dt)
	local ended = {}
	for name, boost in pairs(boosts) do
		if type(boost) ~= "table" then
			boosts[name] = nil
		elseif boost.Mode == "Playtime" then
			boost.Remaining = (boost.Remaining or 0) - dt
			if boost.Remaining <= 0 then
				boosts[name] = nil
				table.insert(ended, name)
			end
		elseif (boost.ExpiresAt or 0) <= now() then
			boosts[name] = nil
			table.insert(ended, name)
		end
	end
	return ended
end

return TimedBoosts
