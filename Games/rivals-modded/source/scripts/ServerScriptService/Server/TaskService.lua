-- Quests (the Tasks page). Each entry in data.Tasks is
--
--   { Name = <TaskLibrary.Info key>, Goal = number, Progress = number, Completed = boolean }
--
-- and completes on its own when Progress reaches Goal (there is no claim button): its
-- TaskLibrary.Info[Name].Rewards are handed out through RewardService there and then.
--
-- A new player works through TaskLibrary.NUM_BEGINNER_TASKS sets of three beginner tasks
-- (Beginner1-3, 4-6, 7-9; BeginnerTasksCompleted counts finished sets), then gets the three
-- daily Core tasks, rolled again each day by DailyService. Finishing all three in a day adds
-- one to DailyTaskStreak.
--
-- Progress comes in as events: TaskService.Record(player, event, amount). Most events are
-- fired by combat, which is not rebuilt yet; ShootingRange is fired on entering the range.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local TaskLibrary = require(Modules:WaitForChild("TaskLibrary"))

local PlayerDataService = require(script.Parent.PlayerDataService)
local RewardService = require(script.Parent.RewardService)

local BEGINNER_SET_SIZE = 3
local DAILY_TASKS = { "Core1", "Core2", "Core3" }

-- Event -> the tasks it counts towards.
local EVENTS = {
	ShootingRange = { "Beginner1" },
	TargetBroken = { "Beginner2" },
	Slide = { "Beginner3" },
	EquipScythe = { "Beginner4" },
	ScytheDash = { "Beginner5" },
	GrenadeThrown = { "Beginner6" },
	DuelPlayed = { "Beginner7", "Core1", "RepeatableCore1" },
	Elimination = { "Beginner8", "Core2", "RepeatableCore2" },
	DuelWon = { "Beginner9", "Core3", "RepeatableCore3", "RepeatableWins" },
}

local TaskService = {}

local function newTask(name: string)
	local info = TaskLibrary.Info[name]
	return { Name = name, Goal = info and info.Goal or 1, Progress = 0, Completed = false }
end

local function currentSet(data): { string }
	local finished = data.BeginnerTasksCompleted or 0
	if finished < TaskLibrary.NUM_BEGINNER_TASKS then
		local names = {}
		for index = 1, BEGINNER_SET_SIZE do
			table.insert(names, "Beginner" .. finished * BEGINNER_SET_SIZE + index)
		end
		return names
	end
	return DAILY_TASKS
end

local function allCompleted(tasks): boolean
	for _, task in tasks do
		if not task.Completed then
			return false
		end
	end
	return #tasks > 0
end

local function isBeginnerSet(tasks): boolean
	return tasks[1] ~= nil and string.sub(tasks[1].Name, 1, 8) == "Beginner"
end

-- Builds the task list the player should have now, keeping progress on tasks they already had.
function TaskService.Rebuild(player: Player, fresh: boolean?)
	local data = PlayerDataService.Get(player)
	if not data then
		return
	end

	local kept = {}
	if not fresh then
		for _, task in data.Tasks do
			kept[task.Name] = task
		end
	end

	local tasks = {}
	for _, name in currentSet(data) do
		table.insert(tasks, kept[name] or newTask(name))
	end

	data.Tasks = tasks
	PlayerDataService.Replicate(player, "Tasks")
end

local function complete(player: Player, data, task)
	task.Completed = true
	task.Progress = task.Goal
	data.TasksCompletedToday[task.Name] = (data.TasksCompletedToday[task.Name] or 0) + 1

	local info = TaskLibrary.Info[task.Name]
	RewardService.GrantAll(player, info and info.Rewards, true)
end

local function afterProgress(player: Player, data)
	if not allCompleted(data.Tasks) then
		return
	end

	if isBeginnerSet(data.Tasks) then
		PlayerDataService.Set(player, "BeginnerTasksCompleted", (data.BeginnerTasksCompleted or 0) + 1)
		TaskService.Rebuild(player, true)
	else
		PlayerDataService.Set(player, "DailyTaskStreak", (data.DailyTaskStreak or 0) + 1)
	end
end

-- Adds progress for an event (see EVENTS) to every matching task the player has.
function TaskService.Record(player: Player, event: string, amount: number?)
	local data = PlayerDataService.Get(player)
	local names = EVENTS[event]
	if not data or not names then
		return
	end

	local changed = false
	for _, task in data.Tasks do
		if not task.Completed and table.find(names, task.Name) then
			task.Progress = math.min(task.Progress + (amount or 1), task.Goal)
			changed = true
			if task.Progress >= task.Goal then
				complete(player, data, task)
			end
		end
	end

	if changed then
		PlayerDataService.Replicate(player, "Tasks")
		PlayerDataService.Replicate(player, "TasksCompletedToday")
		afterProgress(player, data)
	end
end

-- The Debug page's "Increment Tasks": +1 on every unfinished task.
function TaskService.IncrementAll(player: Player)
	local data = PlayerDataService.Get(player)
	if not data then
		return
	end

	for _, task in data.Tasks do
		if not task.Completed then
			task.Progress += 1
			if task.Progress >= task.Goal then
				complete(player, data, task)
			end
		end
	end

	PlayerDataService.Replicate(player, "Tasks")
	PlayerDataService.Replicate(player, "TasksCompletedToday")
	afterProgress(player, data)
end

-- A new day (DailyService): the streak survives only if yesterday's daily tasks were all done.
function TaskService.NewDay(player: Player, missedADay: boolean)
	local data = PlayerDataService.Get(player)
	if not data then
		return
	end

	if not isBeginnerSet(data.Tasks) and (missedADay or not allCompleted(data.Tasks)) then
		PlayerDataService.Set(player, "DailyTaskStreak", 0)
	end

	data.TasksCompletedToday = {}
	PlayerDataService.Replicate(player, "TasksCompletedToday")
	TaskService.Rebuild(player, not isBeginnerSet(data.Tasks))
end

function TaskService.Start()
	PlayerDataService.Loaded:Connect(function(player: Player)
		TaskService.Rebuild(player, false)
	end)
end

return TaskService
