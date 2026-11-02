--[[
	QuestTracker  (ModuleScript, server only)

	Event-driven quests. Gameplay code only reports what happened:
		QuestTracker.Record(player, "EnemyKilled", 1)
	and every active quest listening to that event moves forward.

	  * quest definitions in one table (event, goal, rewards, pool)
	  * daily quests rolled once per UTC day with a seed, so every server picks the same set
	  * beginner chain: fixed quests in order until finished, then the daily pool
	  * auto-complete or claim-button quests (Claim(player, id))
	  * daily streak when all of a day's quests are done
	  * state lives in a table inside your saved data; you replicate it however you like

	Credit: rivals-modded TaskService (EVENTS -> tasks map, beginner sets then daily Core tasks,
	streak kept only if yesterday was finished) and DailyService (UTC day number reset);
	rcu-roller RewardService (claim checks against thresholds); bee-swarm-sim / punching-simulator
	quest UIs for the progress/goal shape.

	Usage (server):
		local QuestTracker = require(game.ServerScriptService.QuestTracker)

		QuestTracker.Configure({
			Quests = {
				Tutorial1 = { Event = "CoinCollected", Goal = 10, Rewards = { Coins = 50 }, Beginner = 1 },
				Tutorial2 = { Event = "EggHatched",    Goal = 1,  Rewards = { Coins = 100 }, Beginner = 2 },
				KillSlimes = { Event = "EnemyKilled",  Goal = 25, Rewards = { Gems = 5 },  Pool = "Daily" },
				Hatch5     = { Event = "EggHatched",   Goal = 5,  Rewards = { Gems = 5 },  Pool = "Daily" },
				Play10Min  = { Event = "MinutePlayed", Goal = 10, Rewards = { Coins = 500 }, Pool = "Daily" },
			},
			DailyCount = 2,
			AutoClaim = false, -- false = player presses Claim
			GetState = function(player) local d = MyData:Get(player) return d and d.Quests end,
			GiveRewards = function(player, rewards, questId) ... return true end,
			OnChanged = function(player, state) QuestRemote:FireClient(player, state) end,
		})

		Players.PlayerAdded -> after data loads: QuestTracker.Refresh(player)
		QuestTracker.Record(player, "EnemyKilled")
		ClaimRemote.OnServerInvoke = function(player, id) return QuestTracker.Claim(player, id) end
]]

local QuestTracker = {}

local DAY = 86400
local config = nil
local byEvent = {} -- [event] = { questId, ... }
local beginnerOrder = {} -- { questId } sorted by Beginner index
local dailyPool = {}

function QuestTracker.Configure(options)
	config = options
	config.DailyCount = config.DailyCount or 3
	table.clear(byEvent)
	table.clear(beginnerOrder)
	table.clear(dailyPool)
	for id, quest in pairs(options.Quests) do
		byEvent[quest.Event] = byEvent[quest.Event] or {}
		table.insert(byEvent[quest.Event], id)
		if quest.Beginner then
			table.insert(beginnerOrder, id)
		elseif quest.Pool == "Daily" then
			table.insert(dailyPool, id)
		end
	end
	table.sort(beginnerOrder, function(a, b)
		return options.Quests[a].Beginner < options.Quests[b].Beginner
	end)
	table.sort(dailyPool) -- stable order so the seeded pick is the same everywhere
end

-- Same pick on every server for a given UTC day.
local function rollDaily(dayNumber)
	local rng = Random.new(dayNumber * 7919)
	local pool = table.clone(dailyPool)
	local picked = {}
	for _ = 1, math.min(config.DailyCount, #pool) do
		table.insert(picked, table.remove(pool, rng:NextInteger(1, #pool)))
	end
	return picked
end

local function newEntry(id)
	return { Id = id, Progress = 0, Goal = config.Quests[id].Goal, Done = false, Claimed = false }
end

local function allDone(state)
	if #state.Active == 0 then
		return false
	end
	for _, entry in ipairs(state.Active) do
		if not entry.Claimed then
			return false
		end
	end
	return true
end

local function changed(player, state)
	if config.OnChanged then
		task.spawn(config.OnChanged, player, state)
	end
end

local function claimEntry(player, state, entry)
	local quest = config.Quests[entry.Id]
	local ok, given = pcall(config.GiveRewards, player, quest.Rewards, entry.Id)
	if not ok or not given then
		warn("[QuestTracker] reward failed for " .. entry.Id .. ": " .. tostring(given))
		return false
	end
	entry.Claimed = true
	return true
end

-- Builds the active list: next beginner quest, or today's daily set. Call after data loads
-- (and it is called again by Record / a periodic check when the day changes).
function QuestTracker.Refresh(player)
	local state = config.GetState(player)
	if not state then
		return
	end
	state.Active = state.Active or {}
	state.BeginnerIndex = state.BeginnerIndex or 1
	state.Streak = state.Streak or 0

	local nextBeginner = beginnerOrder[state.BeginnerIndex]
	if nextBeginner then
		local current = state.Active[1]
		if not current or current.Id ~= nextBeginner then
			state.Active = { newEntry(nextBeginner) }
			changed(player, state)
		end
		return
	end

	local dayNumber = os.time() // DAY
	if state.Day == dayNumber and #state.Active > 0 then
		return
	end
	-- New day: the streak survives only if the previous day's set was finished and no day was skipped.
	local finishedLast = state.Day ~= nil and allDone(state)
	local consecutive = state.Day ~= nil and dayNumber - state.Day == 1
	state.Streak = if finishedLast and consecutive then state.Streak else 0
	state.Day = dayNumber
	state.Active = {}
	for _, id in ipairs(rollDaily(dayNumber)) do
		table.insert(state.Active, newEntry(id))
	end
	changed(player, state)
end

-- Report gameplay: QuestTracker.Record(player, "EnemyKilled", 1)
function QuestTracker.Record(player, event, amount)
	local listeners = byEvent[event]
	if not listeners then
		return
	end
	QuestTracker.Refresh(player)
	local state = config.GetState(player)
	if not state or not state.Active then
		return
	end

	local any = false
	for _, entry in ipairs(state.Active) do
		if not entry.Done and table.find(listeners, entry.Id) then
			entry.Progress = math.min(entry.Goal, entry.Progress + (amount or 1))
			any = true
			if entry.Progress >= entry.Goal then
				entry.Done = true
				if config.AutoClaim then
					QuestTracker.Claim(player, entry.Id)
				end
			end
		end
	end
	if any then
		changed(player, state)
	end
end

-- Claim a finished quest. Returns true when rewards were given.
function QuestTracker.Claim(player, questId)
	local state = config.GetState(player)
	if not state or type(questId) ~= "string" then
		return false
	end
	for _, entry in ipairs(state.Active or {}) do
		if entry.Id == questId and entry.Done and not entry.Claimed then
			if not claimEntry(player, state, entry) then
				return false
			end
			if config.Quests[questId].Beginner then
				state.BeginnerIndex += 1
				QuestTracker.Refresh(player)
			elseif allDone(state) then
				state.Streak += 1
			end
			changed(player, state)
			return true
		end
	end
	return false
end

-- Seconds until the daily set rolls over (for a UI countdown).
function QuestTracker.SecondsUntilReset()
	return (os.time() // DAY + 1) * DAY - os.time()
end

return QuestTracker
