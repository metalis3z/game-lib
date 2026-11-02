--!strict

local SoundService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)

local PlayClientSound = Net:RemoteEvent("SoundService/PlayClientSound")

function SoundService:Play(...)
	PlayClientSound:FireClient(...)
end

return SoundService