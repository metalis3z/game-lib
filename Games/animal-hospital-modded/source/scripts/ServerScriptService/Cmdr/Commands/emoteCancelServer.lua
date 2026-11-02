local MessagingService = game:GetService("MessagingService")

return function(context)
	pcall(function()
		MessagingService:PublishAsync("GlobalCancelEmote", "cancel")
	end)

	return "Cancelled forced emote on all servers."
end