local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local MessagingService = require(ServerScriptService.Services.MessagingService)
local net = require(ReplicatedStorage.Packages.Net)
local remote = net:RemoteEvent("RSVPService/Prompt")
local isadmin = require(ReplicatedStorage.Shared.IsAdmin)

local TOPIC_NAME = "GlobalEventPrompt"

local function fireToAllInServer(id)
	remote:FireAllClients(tostring(id))
end

MessagingService:SubscribeAsync(TOPIC_NAME, function(eventId)
	fireToAllInServer(eventId)
end)

return function(context, id, jobid)
	if not isadmin(context.Executor.UserId) then
		return false, "Unauthorized"
	end

	jobid = (jobid and jobid ~= "") and jobid or nil

	if jobid then
		local ok = MessagingService:PublishAsync(TOPIC_NAME, id, jobid)
		if not ok then
			return string.format("invalid jobid '%s' (or publish failed).", jobid)
		end
		return string.format("Prompt sent to server %s only!", jobid)
	end

	local success = MessagingService:PublishAsync(TOPIC_NAME, id)

	if not success then 
		warn("[RSVPService] Failed to queue message to MessagingService wrapper.") 
	end

	fireToAllInServer(id)

	return "Prompt sent to all servers!"
end