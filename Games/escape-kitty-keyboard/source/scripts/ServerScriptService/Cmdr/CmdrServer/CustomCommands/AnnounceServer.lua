local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local AdminAnnounce = Remotes:WaitForChild("AdminAnnounce")

local TOPIC = "GlobalAnnounce"

return function(context, message)
	local executor = context.Executor

	local announceData = {
		text = "devlenny: " .. message,
		senderName = executor and executor.Name or "Admin",
		senderUserId = 1580586066,
		isOwner = false,
		serverId = game.JobId, -- Identifie le serveur qui envoie
	}

	-- Affiche l'annonce sur CE serveur
	AdminAnnounce:FireAllClients(announceData)

	-- Envoie aux autres serveurs
	pcall(function()
		MessagingService:PublishAsync(TOPIC, announceData)
	end)

	return string.format("Global announcement sent: \"%s\"", message)
end