local Phase = {}
local alwaysEvents = {"Bubblegum", "Bombardiro Crocodilo", "Glitch", "Solar Flare", "Raining Tacos", "Nyan Cats", "Crab Rave"}
local randomDurations = {300, 120, 180, 240}
local randomEvents = {"Concert", "Brazil", "Rap Concert", "Mexico", "Indonesia"}
local EventService = require(script.Parent.Parent)

function Phase.OnStart(event)
	task.wait(12)
	for _, eventName in ipairs(alwaysEvents) do
		local duration = randomDurations[math.random(1, #randomDurations)]
		EventService:ExecuteEvent(eventName, duration)
	end

	local chosenEvent = randomEvents[math.random(1, #randomEvents)]
	local duration = randomDurations[math.random(1, #randomDurations)]
	EventService:ExecuteEvent(chosenEvent, duration)

	EventService:CancelEvent(script.Parent.Name)
end

function Phase.OnStop()
end

return Phase
