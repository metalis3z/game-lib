local Phase = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventService = require(script.Parent.Parent)
local AnimalService = require(game:GetService("ServerScriptService").Services.AnimalService)

local isActive = false
local mainEventTask = nil

local alwaysEvents = {
	["Bubblegum"] = 600,
	["Bombardiro Crocodilo"] = 120,
	["Glitch"] = 180,
	["Solar Flare"] = 120,
	["Raining Tacos"] = 180,
	["Nyan Cats"] = 135,
	["Crab Rave"] = 160,
}

local coffinEvents = {
	["Water"] = 180,
	["Sammyni Spyderini"] = 180,
	["UFO"] = 300,
	["Sammy's Base"] = 120,
	["Los Matteos"] = 170,
	["La Vacca Saturno Saturnita"] = 300,
	["Starfall"] = 180,
}

local delays = {
	["Crab Rave"] = 8,
}

function Phase.OnStart(data)
	if isActive then return end
	isActive = true

	local startTime = data.startedAt or data.StartedAt or workspace:GetServerTimeNow()

	local isCoffinMode = data.arguments ~= nil and table.find(data.arguments, "Coffin") ~= nil

	AnimalService:PauseSpawning()
	task.wait(isCoffinMode and 18.5 or 12)
	AnimalService:UnpauseSpawning()

	for eventName, duration in pairs(alwaysEvents) do
		local startOffset = delays[eventName] or 0
		EventService:ExecuteEvent(eventName, duration, startOffset)
	end

	if isCoffinMode then
		for eventName, duration in pairs(coffinEvents) do
			local startOffset = delays[eventName] or 0
			EventService:ExecuteEvent(eventName, duration, startOffset, {"Coffin"})
		end
	end

	EventService:CancelEvent(script.Parent.Name)
end

function Phase.OnStop()
	isActive = false
	if mainEventTask then
		task.cancel(mainEventTask)
		mainEventTask = nil
	end
end

return Phase