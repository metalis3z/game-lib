local ServerScriptService = game:GetService("ServerScriptService")

local Services         = ServerScriptService.Services
local MessagingService = require(Services.MessagingService)
local SoundService     = require(Services.SoundService)

local TOPIC = "SoundService/PlayAll"

MessagingService:SubscribeAsync(TOPIC, function(payload: { SoundId: string })
	if type(payload) ~= "table" or not payload.SoundId then return end

	SoundService:PlayAll(payload.SoundId)
end)


return function(context, soundId: string, jobId: string?)
	local assetId: string = tostring(soundId):match("^%d+$")
		and ("rbxassetid://" .. soundId)
		or  soundId

	local published = MessagingService:PublishAsync(TOPIC, { SoundId = assetId }, jobId)

	if not published then
		return false, ("MessagingService publish failed — check server logs.")
	end

	return string.format(
		"▶ PlayAll [%s] → %s",
		assetId,
		jobId and ("server " .. jobId) or "all servers"
	)
end