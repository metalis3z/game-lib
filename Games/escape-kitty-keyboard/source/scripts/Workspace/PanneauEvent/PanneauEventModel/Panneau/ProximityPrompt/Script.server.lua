Local SocialService = Gane:getService("SocialService")
Local eventId = "4357205725676700316"

Local player = game.Players.Local Player

script.parent.Triggered:Connect(function()
	SocialService:PromtRsvpToEventAsync(eventId)
end)
