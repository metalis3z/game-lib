--Made by NexusPrime_11 
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MessagingService = game:GetService("MessagingService")

local POLL_END_CHANNEL = "GlobalPollEndBroadcast"

local module = function(Conch, Config)
	local PollService = require(ServerScriptService.Services.PollService)

	task.spawn(function()
		pcall(function()
			MessagingService:SubscribeAsync(POLL_END_CHANNEL, function(message)
				local data = message.Data
				if data.JobId == game.JobId then return end

				PollService.endActivePoll()
			end)
		end)
	end)

	Conch.register("endpoll", {
		permissions = { Config.AdminRole or "super-user" },
		description = "Ends the active poll across ALL servers.",

		arguments = function()
			return 
		end,

		callback = function()
			PollService.endActivePoll()

			local publishSuccess = pcall(function()
				MessagingService:PublishAsync(POLL_END_CHANNEL, {
					JobId = game.JobId
				})
			end)

			if publishSuccess then
				return "Global poll ended."
			else
				return "Poll ended locally, but globally failed."
			end
		end
	})
end

return module