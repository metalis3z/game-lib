--Made by NexusPrime_11 
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local MessagingService = game:GetService("MessagingService")

local POLL_CHANNEL = "GlobalPollBroadcast"

local module = function(Conch, Config)
	local PollService = require(ServerScriptService.Services.PollService)

	task.spawn(function()
		pcall(function()
			MessagingService:SubscribeAsync(POLL_CHANNEL, function(message)
				local data = message.Data
				if data.JobId == game.JobId then return end

				PollService.startPoll(data.PollData, data.PollID)
			end)
		end)
	end)

	Conch.register("startpoll", {
		permissions = { Config.AdminRole or "super-user" },
		description = "Starts a poll across ALL servers with live global vote syncing.",
		arguments = function()
			return 
				{ kind = "argument", type = "string", name = "Question" },
			{ kind = "argument", type = "string", name = "Option1" },
			{ kind = "argument", type = "string", name = "Option2" },
			{ kind = "argument", type = "number", name = "Duration", optional = true },
			{ kind = "argument", type = "boolean", name = "AllowSwitch", optional = true }
		end,

		callback = function(question, option1, option2, duration, allowSwitch)
			local pollData = {
				question        = question,
				option1         = option1,
				option2         = option2,
				option1colorHex = "2197ff",
				option2colorHex = "da261a",
				duration        = duration or 30,
				allowSwitch     = allowSwitch ~= false,
			}
			--Made by NexusPrime_11 lol

			local generatedID = PollService.startPoll(pollData)

			pcall(function()
				MessagingService:PublishAsync(POLL_CHANNEL, {
					PollData = pollData,
					PollID = generatedID,
					JobId = game.JobId
				})
			end)

			return "poll started."
		end
	})
end

return module