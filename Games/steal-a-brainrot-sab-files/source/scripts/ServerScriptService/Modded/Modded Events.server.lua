local net           = require(game.ReplicatedStorage.Packages.Net)
local EventService  = require(game.ServerScriptService.Services.EventService)
local IsAdmin       = require(game.ReplicatedStorage.Shared.IsAdmin)
local eventsRemote  = net:RemoteEvent("AdminService/ModdedEvents")
local updateRemote  = net:RemoteEvent("AdminService/UpdateEventsButton")
local INTERVAL = 180
local isEventsActive = false
local loopThread: thread? = nil
local BLACKLIST = require(game:GetService("ReplicatedStorage").GameData).adminevents
local function startEventLoop()
	if loopThread then return end 
	loopThread = task.spawn(function()
		while isEventsActive do
			task.wait(INTERVAL)
			if not isEventsActive then break end
			local events = EventService:GetRegisteredEvents()
			if not events or #events == 0 then continue end
			local filtered = {}
			for _, event in ipairs(events) do
				if not BLACKLIST[event.Name] and event.Name ~= "Phase 2: Galaxy Introduction" and event.Name ~= "Car Cutscene" and event.Name ~= "North Pole" then
					table.insert(filtered, event)
				end
			end
			if #filtered > 0 then
				local chosen = filtered[math.random(1, #filtered)]
				local success, err = pcall(function()
					EventService:ExecuteEvent(chosen.Name, EventService.EventDurations[chosen.Name] or 180)
				end)
				if not success then
					warn("Failed to execute event " .. chosen.Name .. ": " .. err)
				end
			end
		end
		loopThread = nil
	end)
end
local function stopEventLoop()
	isEventsActive = false
	if loopThread then
		task.cancel(loopThread)
		loopThread = nil
	end
end
local function setRandomEvents(enabled: boolean)
	if isEventsActive == enabled then return end
	isEventsActive = enabled
	updateRemote:FireAllClients(enabled)
	if enabled then
		startEventLoop()
	else
		stopEventLoop()
	end
end
eventsRemote.OnServerEvent:Connect(function(player, value)
	if not IsAdmin(player.UserId) then return end
	if typeof(value) == "boolean" then
		setRandomEvents(value)
	end
end)