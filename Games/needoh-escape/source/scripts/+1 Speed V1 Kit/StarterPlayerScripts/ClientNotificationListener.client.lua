--!strict
-- LOCATION: StarterPlayerScripts/ClientNotificationListener

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local NotificationManager = require(ReplicatedStorage.Modules.NotificationManager)

local eventsFolder = ReplicatedStorage:WaitForChild("Events")
local showNotificationEvent = eventsFolder:WaitForChild("ShowNotification") :: RemoteEvent

-- Listen for server requests to show notifications
showNotificationEvent.OnClientEvent:Connect(function(message: string, msgType: string)
	NotificationManager.show(message, msgType)
end)