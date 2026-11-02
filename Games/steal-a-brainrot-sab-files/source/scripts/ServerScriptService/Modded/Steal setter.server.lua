local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

local GiveStealRF = Net:RemoteFunction("AdminService/GiveSteal")
local SaveKeyRE = Net:RemoteEvent("AdminService/SaveKey")

GiveStealRF.OnServerInvoke = function(player, amount, isAddition)
	if not amount or type(amount) ~= "number" then
		return false, "Invalid amount provided."
	end

	local playerChannel = Synchronizer:Get(player)

	if playerChannel then
		if isAddition then
			playerChannel:Increase("Steals", amount)
		else
			playerChannel:Set("Steals", amount)
		end
		return true
	else
		return false, "Data channel not found. Player might still be loading."
	end
end