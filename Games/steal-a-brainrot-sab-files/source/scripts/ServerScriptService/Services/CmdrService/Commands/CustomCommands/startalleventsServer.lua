local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EventService = require(ServerScriptService.Services.EventService)
local Net = require(ReplicatedStorage.Packages.Net)
local globalstartevent = Net:RemoteFunction("StartGlobalEvent")

local EVENTS_FOLDER = ServerScriptService.Services.EventService.Events

local blacklisted = require(ReplicatedStorage.GameData)

local function main(player, duration)
	if game.PrivateServerId == "" then
		return false, "You can only start events in a private server."
	end

	local success, err = pcall(function()
		for _, module in ipairs(EVENTS_FOLDER:GetChildren()) do
			if module:IsA("ModuleScript") then
				local eventName = module.Name

				if blacklisted.UnSpawnableBrainrots[eventName] or blacklisted.adminevents[eventName] then
					print(string.format("Skipping blacklisted event: %s", eventName))
					continue
				end

				local finalDuration = duration or EventService.EventDurations[eventName] or 300
				EventService:ExecuteEvent(eventName, finalDuration)
			end
		end
	end)

	if not success then
		warn("Event Execution Error: " .. tostring(err))
		return false, "❌ Failed to start events: " .. tostring(err)
	end

	return true, "✅ All non-blacklisted events started successfully!"
end

globalstartevent.OnServerInvoke = main