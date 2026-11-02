--[[
	DailyRewards  (ModuleScript, server; the read-only helpers also work on the client)

	A login-streak calendar (Day 1..N, then loops) that works on a small table inside your saved
	player data. Two clock styles:
	  "Rolling" - next claim 24h after the last one; streak breaks if you wait longer than
	              GraceSeconds (drill-and-mine, zombie-outbreak-survival style)
	  "UTCDay"  - one claim per calendar day (00:00 UTC); streak breaks if a whole day is missed
	              (rivals-modded DailyService style: day number = os.time() // 86400)

	Credit: drill-and-mine DailyRewardService (lazy resolveState on read, 2-day reset window,
	7-day loop), rivals-modded DailyService + ClaimService (UTC day number, ClaimedToday flag),
	zombie-outbreak-survival DailyChestHandler (claim debounce), punching-simulator
	DailyGiftUtility (shared canClaim/getTimeLeft for client and server).

	Usage (server):
		local DailyRewards = require(game.ReplicatedStorage.DailyRewards)

		local calendar = DailyRewards.new({
			Mode = "Rolling",
			Rewards = {
				{ Coins = 100 }, { Coins = 200 }, { Coins = 300 }, { Gems = 5 },
				{ Coins = 500 }, { Coins = 750 }, { Gems = 25, Crate = "Epic" },
			},
			Grant = function(player, reward, day)
				-- give `reward` here; return true if it was given
				return true
			end,
		})

		-- data.Daily is a table in the player's saved data (start it as {}).
		ClaimRemote.OnServerInvoke = function(player)
			local data = MyData:Get(player)
			return calendar:Claim(player, data.Daily) -- ok, dayClaimed | false, reason
		end

		-- For the UI (server or client): who can claim, which day, how long to wait.
		local status = calendar:Status(data.Daily)
		-- { Day = 3, Streak = 2, CanClaim = false, SecondsLeft = 5130 }
]]

local DailyRewards = {}
DailyRewards.__index = DailyRewards

local DAY = 86400

function DailyRewards.new(options)
	assert(type(options.Rewards) == "table" and #options.Rewards > 0, "DailyRewards needs a Rewards list")
	local self = setmetatable({}, DailyRewards)
	self.Mode = options.Mode or "Rolling"
	self.Rewards = options.Rewards
	self.Cooldown = options.Cooldown or DAY -- Rolling: time between claims
	self.GraceSeconds = options.GraceSeconds or 2 * DAY -- Rolling: wait longer than this = streak lost
	self.ResetDayOnBreak = options.ResetDayOnBreak ~= false -- false keeps the calendar day, only the streak resets
	self.Grant = options.Grant
	self._busy = {}
	return self
end

local function today()
	return os.time() // DAY
end

-- Returns the state the player is in right now WITHOUT changing their data.
function DailyRewards:Status(state)
	local last = state.LastClaim or 0
	local day = state.Day or 1
	local streak = state.Streak or 0
	local now = os.time()

	if last == 0 then
		return { Day = 1, Streak = 0, CanClaim = true, SecondsLeft = 0, Broken = false }
	end

	local canClaim, secondsLeft, broken
	if self.Mode == "UTCDay" then
		local lastDay = last // DAY
		canClaim = today() > lastDay
		broken = today() - lastDay > 1
		secondsLeft = if canClaim then 0 else (lastDay + 1) * DAY - now
	else
		local elapsed = now - last
		canClaim = elapsed >= self.Cooldown
		broken = elapsed >= self.GraceSeconds
		secondsLeft = math.max(0, self.Cooldown - elapsed)
	end

	if broken then
		streak = 0
		if self.ResetDayOnBreak then
			day = 1
		end
	end
	return { Day = day, Streak = streak, CanClaim = canClaim, SecondsLeft = secondsLeft, Broken = broken }
end

function DailyRewards:RewardFor(day)
	return self.Rewards[((day - 1) % #self.Rewards) + 1]
end

-- Claims today's reward. Returns (true, dayClaimed, reward) or (false, reason).
function DailyRewards:Claim(player, state)
	if type(state) ~= "table" then
		return false, "Data not loaded"
	end
	if self._busy[player] then
		return false, "Busy"
	end
	local status = self:Status(state)
	if not status.CanClaim then
		return false, "Come back later"
	end

	self._busy[player] = true
	local reward = self:RewardFor(status.Day)
	local ok, given = pcall(self.Grant, player, reward, status.Day)
	self._busy[player] = nil
	if not ok or not given then
		warn("[DailyRewards] Grant failed: " .. tostring(given))
		return false, "Could not give the reward"
	end

	state.LastClaim = os.time()
	state.Streak = status.Streak + 1
	state.Day = if status.Day >= #self.Rewards then 1 else status.Day + 1
	state.BestStreak = math.max(state.BestStreak or 0, state.Streak)
	return true, status.Day, reward
end

-- Lets a paid "skip the wait" product make the next claim available right now.
function DailyRewards:SkipWait(state)
	state.LastClaim = os.time() - math.max(self.Cooldown, DAY)
end

return DailyRewards
