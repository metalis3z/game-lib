-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SocialService = game:GetService("SocialService")
local v3 = require(ReplicatedStorage.Packages.Net):RemoteEvent("RSVPService/Prompt")

return {
	Start = function(_)
		v3.OnClientEvent:Connect(function(s1: string)
			pcall(function()
				local EventRsvpStatusAsync = SocialService:GetEventRsvpStatusAsync((tostring(s1)))

				if EventRsvpStatusAsync == Enum.RsvpStatus.None or EventRsvpStatusAsync == Enum.RsvpStatus.NotGoing then
					SocialService:PromptRsvpToEventAsync((tostring(s1)))
				end
			end)
		end)
	end
}
