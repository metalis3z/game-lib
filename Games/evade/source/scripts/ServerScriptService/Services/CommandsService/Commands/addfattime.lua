local module = function(Conch, Config)
	Conch.register("addfattime", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				{
					kind = "argument",
					type = "number",
					name = "Seconds",
				},
			}
		end,
		callback = function(seconds)
			if seconds < 0 then
				return false, "Seconds cannot be negative"
			end

			local ServerScriptService = game:GetService("ServerScriptService")

			local success, EventService = pcall(function()
				return require(ServerScriptService.Services.EventService)
			end)

			if not success or not EventService then
				return false, "Could not find EventService"
			end

			local activeEvent = EventService.ActiveEvents["FatSammy"]

			if not activeEvent then
				return false, "Fat event is not active! Start the event first with /executeevent FatSammy"
			end

			local currentTime = workspace:GetServerTimeNow()
			local oldRemaining = math.max(0, activeEvent.endsAt - currentTime)
			local newDuration = oldRemaining + seconds

			local BubblegumModule = require(ServerScriptService.Services.EventService.Events.FatSammy)
			local wasActive = BubblegumModule.IsRunning()

			local cancelSuccess, cancelErr = pcall(function()
				EventService.ActiveEvents["FatSammy"] = nil

				if EventService.Channels.Events then
					local arr = EventService.Channels.Events:Get("ActiveEvents")
					for i, data in ipairs(arr) do
						if data.eventName == "FatSammy" then
							EventService.Channels.Events:RemoveFromArray("ActiveEvents", i)
							break
						end
					end
				end
			end)

			if not cancelSuccess then
				return false, "Failed to stop event: " .. (cancelErr or "Unknown error")
			end

			task.wait(0.1)

			local restartSuccess, restartErr = pcall(function()
				local now = workspace:GetServerTimeNow()
				local eventData = {eventName = "FatSammy", startedAt = now, endsAt = now + newDuration}

				EventService.ActiveEvents["FatSammy"] = eventData

				if EventService.Channels.Events then
					EventService.Channels.Events:InsertOnArray("ActiveEvents", eventData)
				end

				task.delay(newDuration, function()
					if EventService.ActiveEvents["FatSammy"] then
						EventService:CancelEvent("FatSammy")
					end
				end)
			end)

			if not restartSuccess then
				return false, "Failed to restart event: " .. (restartErr or "Unknown error")
			end

			local minutes = math.floor(newDuration / 60)
			local secs = math.floor(newDuration % 60)

			return true, string.format("FatSammy event restarted with %dm %ds (added %ds)", minutes, secs, seconds)
		end,
	})
end
return module