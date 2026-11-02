local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ServerScriptService = game:GetService("ServerScriptService")
local MessagingService = require(ServerScriptService.Services.MessagingService)

local REQUEST_TOPIC = "__MS_JobIdLookupRequest"
local RESPONSE_PREFIX = "__MS_JobIdLookupResponse:"
local LOOKUP_TIMEOUT = 4

MessagingService:SubscribeAsync(REQUEST_TOPIC, function(payload)
	if type(payload) ~= "table" then return end
	if type(payload.Username) ~= "string" then return end
	if type(payload.RequestId) ~= "string" then return end

	local needle = string.lower(payload.Username)
	for _, plr in ipairs(Players:GetPlayers()) do
		if string.lower(plr.Name) == needle then
			MessagingService:PublishAsync(RESPONSE_PREFIX .. payload.RequestId, {
				Username = plr.Name,
				UserId = plr.UserId,
				DisplayName = plr.DisplayName,
				JobId = game.JobId,
			})
			return
		end
	end
end)

return function(context, username)
	if not username or username == "" then
		return "❌ Provide a username."
	end

	local lowerName = string.lower(username)
	for _, plr in ipairs(Players:GetPlayers()) do
		if string.lower(plr.Name) == lowerName then
			local jid = (game.JobId ~= "" and game.JobId) or "(studio)"
			return string.format(
				"✅ %s (UserId %d) is on THIS server. JobId: %s",
				plr.Name, plr.UserId, jid
			)
		end
	end

	local requestId = HttpService:GenerateGUID(false)
	local responseTopic = RESPONSE_PREFIX .. requestId

	local response = nil
	local connection = MessagingService:SubscribeAsync(responseTopic, function(payload)
		if type(payload) == "table" and type(payload.JobId) == "string" then
			response = payload
		end
	end)

	MessagingService:PublishAsync(REQUEST_TOPIC, {
		Username = username,
		RequestId = requestId,
	})

	local deadline = os.clock() + LOOKUP_TIMEOUT
	while os.clock() < deadline and not response do
		task.wait(0.1)
	end
	connection:Disconnect()

	if response then
		MessagingService:AddKnownJobId(response.JobId)
		return string.format(
			"✅ %s (UserId %d) is in JobId: %s",
			response.Username, response.UserId, response.JobId
		)
	end
	return string.format("❌ Player '%s' not found on any active server.", username)
end