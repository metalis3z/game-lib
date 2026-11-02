local EventService = require(game.ServerScriptService.Services.EventService)
local Net = require(game.ReplicatedStorage.Packages.Net)
local globalstartevent = Net:RemoteFunction("StopGlobalEvent")
function main(context, duration)
	if game.PrivateServerId == "" then
		return false, "You can only start events in a private server."
	end

	local success, err = pcall(function()
		for i, v in pairs(game.ServerScriptService.Services.EventService.Events:GetChildren()) do
			if v:IsA("ModuleScript") then
				duration = duration or EventService.EventDurations[v.Name] or 300
				EventService:CancelEvent(v.Name, duration)
			end
		end
	end)

	if not success then
		return "❌ Failed to start event: " .. tostring(err)
	end
end

globalstartevent.OnServerInvoke = main