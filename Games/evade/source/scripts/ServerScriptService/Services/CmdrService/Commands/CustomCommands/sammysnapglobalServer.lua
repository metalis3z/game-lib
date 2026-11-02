local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local EventService = require(game.ServerScriptService.Services.EventService)

local EventsFolder = ReplicatedStorage.Controllers.EventController.Events

-- Locations
local VALID_LOCATIONS = {
	["Concert"] = true,
	["Brazil"] = true,
	["Rap Concert"] = true,
	["Mexico"] = true,
	["Indonesia"] = true,
}

-- ✅ ALWAYS EVENTS with PER-EVENT DURATION
local ALWAYS_EVENTS = {
	{ "Bubblegum", 600 },
	{ "Bombardiro Crocodilo", 180 },
	{ "Glitch", 120 },
	{ "Solar Flare", 120 },
	{ "Raining Tacos", 180 },
	{ "Nyan Cats", 180 },
	{ "Crab Rave", 155 },
	{ "UFO", 300 },
	{ "Rainbow", 900 },
	{ "3 Roads", 900,},
}

-- Picks from ALWAYS_EVENTS ONLY
local function chooseRandomEvents(amount)
	local pool = {}

	for _, data in ipairs(ALWAYS_EVENTS) do
		local name = data[1]
		if EventsFolder:FindFirstChild(name) then
			table.insert(pool, name)
		end
	end

	-- Shuffle
	for i = #pool, 2, -1 do
		local j = math.random(i)
		pool[i], pool[j] = pool[j], pool[i]
	end

	local chosen = {}
	for i = 1, math.min(amount, #pool) do
		table.insert(chosen, pool[i])
	end

	return chosen
end

-- 🔥 RECEIVE GLOBAL MESSAGE
MessagingService:SubscribeAsync("GlobalSammySnap", function(message)
	local data = message.Data
	if data.FromServer == game.JobId then return end

	local location = data.Location
	local startRandom = data.StartRandom
	local amount = data.Amount

	-- Sammy Snap Phase
	EventService:ExecuteEvent("Phase 5: Sammy Snap", 15)
	task.wait(12)

	-- Location Event
	EventService:ExecuteEvent(location, 185)

	-- ✅ ALWAYS EVENTS ALWAYS RUN
	for _, data in ipairs(ALWAYS_EVENTS) do
		local name = data[1]
		local duration = data[2]
		EventService:ExecuteEvent(name, duration)
	end

	-- Optional random picks
	if startRandom then
		local events = chooseRandomEvents(amount)
		for _, evt in ipairs(events) do
			EventService:ExecuteEvent(evt, 120)
		end
	end
end)

-- 🔥 COMMAND EXECUTION
return function(context, location, startRandomEvents, amount)
	startRandomEvents = startRandomEvents or false
	amount = amount or 10

	if not VALID_LOCATIONS[location] then
		return "❌ Invalid location."
	end

	EventService:ExecuteEvent("Phase 5: Sammy Snap", 15)
	task.wait(12)

	-- Location
	EventService:ExecuteEvent(location, 120)

	-- ALWAYS EVENTS
	for _, data in ipairs(ALWAYS_EVENTS) do
		local name = data[1]
		local duration = data[2]
		EventService:ExecuteEvent(name, duration)
	end

	-- Optional random picks
	if startRandomEvents then
		local events = chooseRandomEvents(amount)
		for _, evt in ipairs(events) do
			EventService:ExecuteEvent(evt, 120)
		end
	end

	-- Broadcast
	pcall(function()
		MessagingService:PublishAsync("GlobalSammySnap", {
			FromServer = game.JobId,
			Executor = context.Executor.Name,
			Location = location,
			StartRandom = startRandomEvents,
			Amount = amount,
		})
	end)

	return "🌐 Sammy Snap GLOBAL triggered!"
end
