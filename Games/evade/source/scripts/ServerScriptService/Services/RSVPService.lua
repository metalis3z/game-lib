--!strict

local RSVPService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)

local Prompt = Net:RemoteEvent("RSVPService/Prompt")

return RSVPService