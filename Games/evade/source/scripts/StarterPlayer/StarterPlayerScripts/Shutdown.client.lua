local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)
local ForceRejoinEvent = Net:RemoteEvent("ForceRejoin")

local placeId = game.PlaceId

ForceRejoinEvent.OnClientEvent:Connect(function()
	-- Smooth auto rejoin
	TeleportService:Teleport(placeId, Players.LocalPlayer)
end)
