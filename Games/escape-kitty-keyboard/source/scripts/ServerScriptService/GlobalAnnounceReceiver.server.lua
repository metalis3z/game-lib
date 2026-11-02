local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AdminAnnounce = Remotes:WaitForChild("AdminAnnounce")

local TOPIC = "GlobalAnnounce"

-- Subscribe to receive announcements from other servers
MessagingService:SubscribeAsync(TOPIC, function(message)
	local data = message.Data
	if type(data) == "table" and data.text then
		AdminAnnounce:FireAllClients(data)
	end
end)