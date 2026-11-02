--!strict

local ConfirmationService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)

local Show = Net:RemoteEvent("ConfirmationService/Show")

function ConfirmationService.Show(...)
	Show:FireClient(...)
end

return ConfirmationService