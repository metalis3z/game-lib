local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local AnimalData = require(ReplicatedStorage.Datas.Animals)
local Synchronizer = require(game.ReplicatedStorage.Packages.Synchronizer)

return function(context, targetPlayer, podiumIndex)
	if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
		return "❌ Invalid player."
	end

	local PlayerChannel = Synchronizer:Get(targetPlayer)
	if not PlayerChannel then
		return "❌ Failed to access player's save data."
	end

	local AnimalList = PlayerChannel:Get("AnimalPodiums")
	if not AnimalList or typeof(AnimalList[podiumIndex]) ~= "table" then
		return "❌ Invalid or empty podium slot."
	end

	local AnimalInfo = AnimalList[podiumIndex]
	if AnimalInfo.Steal then
		return "❌ Cannot remove this brainrot (it is being stolen)."
	end

	local animalId = AnimalInfo.Index
	local animalData = AnimalData[animalId]

	AnimalList[podiumIndex] = "Empty"
	PlayerChannel:Set("AnimalPodiums", AnimalList)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)

	local animalName = animalData and animalData.DisplayName or animalId or "Unknown"

	return string.format("✅ Removed brainrot '%s' from %s's podium slot #%d.", animalName, targetPlayer.Name, podiumIndex)
end
