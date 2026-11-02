local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local HttpService = game:GetService("HttpService")
	local Workspace = game:GetService("Workspace")

	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

	-- Track active fake events and their cleanup
	local ActiveFakeEvents = {}
	local TraitMonitorConnections = {}

	local function cleanupFakeEvent(eventName)
		-- Remove from ActiveFakeEvents
		ActiveFakeEvents[eventName] = nil

		-- Disconnect trait monitor if no more fake events
		local hasActiveFakeEvents = false
		for _ in pairs(ActiveFakeEvents) do
			hasActiveFakeEvents = true
			break
		end

		if not hasActiveFakeEvents then
			for _, conn in pairs(TraitMonitorConnections) do
				if conn then
					conn:Disconnect()
				end
			end
			TraitMonitorConnections = {}
		end
	end

	local function removeBrainrotWithTraits(animalModel)
		if not animalModel or not animalModel.Parent then
			return
		end

		local traitsAttr = animalModel:GetAttribute("Traits")
		if traitsAttr and traitsAttr ~= "" and traitsAttr ~= "[]" then
			-- This brainrot has traits - DESTROY IT
			local index = animalModel:GetAttribute("Index") or "Unknown"
			print("[FakeEvent] Removed brainrot with traits: " .. index)
			animalModel:Destroy()
		end
	end

	local function startTraitMonitor()
		-- Monitor existing animals
		local movingAnimals = Workspace:FindFirstChild("MovingAnimals")
		if movingAnimals then
			for _, animalModel in pairs(movingAnimals:GetChildren()) do
				if animalModel:IsA("Model") then
					removeBrainrotWithTraits(animalModel)
				end
			end
		end

		-- Monitor for new animals being added
		if not TraitMonitorConnections.DescendantAdded then
			TraitMonitorConnections.DescendantAdded = Workspace.DescendantAdded:Connect(function(descendant)
				if descendant:IsA("Model") then
					task.wait(0.1) -- Small delay to let attributes be set
					removeBrainrotWithTraits(descendant)
				end
			end)
		end

		-- Monitor attribute changes on existing animals
		if not TraitMonitorConnections.AttributeChanged then
			TraitMonitorConnections.AttributeChanged = Workspace.AttributeChanged:Connect(function(attributeName)
				if attributeName == "Traits" then
					-- Check all moving animals when traits change
					local movingAnimalsCheck = Workspace:FindFirstChild("MovingAnimals")
					if movingAnimalsCheck then
						for _, animalModel in pairs(movingAnimalsCheck:GetChildren()) do
							if animalModel:IsA("Model") then
								removeBrainrotWithTraits(animalModel)
							end
						end
					end
				end
			end)
		end

		-- Periodic check every second
		if not TraitMonitorConnections.PeriodicCheck then
			TraitMonitorConnections.PeriodicCheck = task.spawn(function()
				while true do
					task.wait(1)
					
					-- Only run if there are active fake events
					local hasActive = false
					for _ in pairs(ActiveFakeEvents) do
						hasActive = true
						break
					end
					
					if not hasActive then
						return
					end

					local movingAnimalsCheck = Workspace:FindFirstChild("MovingAnimals")
					if movingAnimalsCheck then
						for _, animalModel in pairs(movingAnimalsCheck:GetChildren()) do
							if animalModel:IsA("Model") then
								removeBrainrotWithTraits(animalModel)
							end
						end
					end
				end
			end)
			TraitMonitorConnections.PeriodicCheck = true -- Mark as active
		end
	end

	Conch.register("fakeevent", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "Event",
					name = "Event",
				},
			{
					kind = "argument",
					type = "number",
					name = "Duration",
					optional = true,
			}
		end,

		callback = function(eventName, duration)
			-- Get EventService to access its channels
			local EventService = require(ServerScriptService.Services.EventService)
			if not EventService then
				return false, "EventService not initialized"
			end

			-- Default duration of 180 seconds (3 minutes)
			local eventDuration = duration or 180

			-- Create fake event data (same structure as real events)
			local eventData = {
				eventName = eventName,
				startedAt = Workspace:GetServerTimeNow(),
				endsAt = Workspace:GetServerTimeNow() + eventDuration,
				isFake = true, -- Mark as fake for identification
			}

			-- Add to EventService's ActiveEvents (so it shows in UI)
			EventService.ActiveEvents[eventName] = eventData

			-- Sync to all clients via the Events channel
			if EventService.Channels and EventService.Channels.Events then
				EventService.Channels.Events:InsertOnArray("ActiveEvents", eventData)
			end

			-- Track this fake event
			ActiveFakeEvents[eventName] = true

			-- Start monitoring for traits
			startTraitMonitor()

			-- Schedule cleanup after duration
			task.delay(eventDuration, function()
				-- Remove from ActiveEvents
				if EventService.ActiveEvents[eventName] then
					EventService.ActiveEvents[eventName] = nil
				end

				-- Remove from synced array
				if EventService.Channels and EventService.Channels.Events then
					local activeEventsArray = EventService.Channels.Events:Get("ActiveEvents")
					local eventIndex = nil
					for i, data in ipairs(activeEventsArray) do
						if data.eventName == eventName then
							eventIndex = i
							break
						end
					end
					if eventIndex then
						EventService.Channels.Events:RemoveFromArray("ActiveEvents", eventIndex)
					end
				end

				cleanupFakeEvent(eventName)
			end)

			return string.format("Started FAKE event '%s' for %d seconds. Traits will be removed from brainrot!", eventName, eventDuration)
		end,
	})

	-- Add a command to stop fake events
	Conch.register("stopfakeevent", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return {
				kind = "argument",
				type = "Event",
				name = "Event",
			}
		end,

		callback = function(eventName)
			local EventService = require(ServerScriptService.Services.EventService)
			if not EventService then
				return false, "EventService not initialized"
			end

			-- Check if this is a fake event
			if not ActiveFakeEvents[eventName] then
				return false, string.format("'%s' is not a fake event or is not active", eventName)
			end

			-- Remove from ActiveEvents
			if EventService.ActiveEvents[eventName] then
				EventService.ActiveEvents[eventName] = nil
			end

			-- Remove from synced array
			if EventService.Channels and EventService.Channels.Events then
				local activeEventsArray = EventService.Channels.Events:Get("ActiveEvents")
				local eventIndex = nil
				for i, data in ipairs(activeEventsArray) do
					if data.eventName == eventName then
						eventIndex = i
						break
					end
				end
				if eventIndex then
					EventService.Channels.Events:RemoveFromArray("ActiveEvents", eventIndex)
				end
			end

			cleanupFakeEvent(eventName)

			return string.format("Stopped fake event '%s'", eventName)
		end,
	})
end

return module