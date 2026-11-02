local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventService = require(game.ServerScriptService.Services.EventService)

local EventsFolder = ReplicatedStorage.Controllers.EventController.Events

local VALID_LOCATIONS = {
	["Concert"] = true,
	["Brazil"] = true,
	["Rap Concert"] = true,
	["Mexico"] = true,
	["Indonesia"] = true,
}

local function chooseRandomEvents(amount)
	local allEvents = EventsFolder:GetChildren()
	local pool = {}

	-- Build a list EXCLUDING all valid locations
	for _, evt in ipairs(allEvents) do
		if not VALID_LOCATIONS[evt.Name] then
			table.insert(pool, evt)
		end
	end

	-- Shuffle pool
	for i = #pool, 2, -1 do
		local j = math.random(i)
		pool[i], pool[j] = pool[j], pool[i]
	end

	-- Pick first N
	local chosen = {}
	for i = 1, math.min(amount, #pool) do
		table.insert(chosen, pool[i].Name)
	end

	return chosen
end

return function(context, location, startRandomEvents, amount)
	-- Default amount if not given
	amount = amount or 10

	-- Validate location
	if not VALID_LOCATIONS[location] then
		return "❌ Invalid location. Must be: Concert, Brazil, Rap Concert, Mexico, or Indonesia."
	end

	-- Phase 5
	local ok, err = pcall(function()
		EventService:ExecuteEvent("Phase 5: Sammy Snap", 15)
	end)
	if not ok then
		return "❌ Failed running Phase 5: Sammy Snap → " .. tostring(err)
	end

	task.wait(12)

	-- Run the location event
	local ok2, err2 = pcall(function()
		EventService:ExecuteEvent(location, 120)
	end)
	if not ok2 then
		return "❌ Failed running '" .. location .. "' → " .. tostring(err2)
	end

	-- Choose N random events excluding valid locations
	local randomEvents = chooseRandomEvents(amount)

	for _, eventName in ipairs(randomEvents) do
		pcall(function()
			EventService:ExecuteEvent(eventName, 120)
		end)
	end

	-- Optional random events system
	if startRandomEvents then
		pcall(function()
			EventService:StartRandomEvents()
		end)
	end

	return "✅ Sammy Snap completed → ran '" .. location .. "' → plus " .. amount .. " random events!"
end
