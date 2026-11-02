local SocialService = game:GetService("SocialService")
local eventId = "509394308042981999"

local player = game.Players.LocalPlayer

script.Parent.Triggered:Connect(function()
	SocialService:PromptRsvpToEventAsync(eventId)
end)