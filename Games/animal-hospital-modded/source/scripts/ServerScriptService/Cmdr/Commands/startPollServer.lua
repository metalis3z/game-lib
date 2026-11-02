local MessagingService = game:GetService("MessagingService")
local HttpService = game:GetService("HttpService")

return function(context, duration: number, option1: string, option2: string, question: string)
	duration = math.floor(math.clamp(duration, 5, 300))

	local pollData = {
		question = question,
		option1 = option1,
		option2 = option2,
		duration = duration,
		sender = context.Executor.DisplayName,
	}

	pcall(function()
		MessagingService:PublishAsync("GlobalPoll", HttpService:JSONEncode(pollData))
	end)

	return "Global poll started: " .. question
end