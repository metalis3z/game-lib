local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local AnimalData = require(ReplicatedStorage.Datas.Animals)
local Synchronizer = require(game.ReplicatedStorage.Packages.Synchronizer)
local net = require(game.ReplicatedStorage.Packages.Net)
local removeallfunction = net:RemoteFunction("AdminService/ResetBrainrots")

local function removeAllPodiums(targetPlayer)
	if typeof(targetPlayer) ~= "Instance" or not targetPlayer:IsA("Player") then
		return "❌ Invalid player."
	end

	local PlayerChannel = Synchronizer:Get(targetPlayer)
	if not PlayerChannel then
		return "❌ Failed to access player's save data."
	end

	local AnimalList = PlayerChannel:Get("AnimalPodiums")
	if not AnimalList or typeof(AnimalList) ~= "table" then
		return "❌ No podium data found."
	end

	local removedCount = 0
	local containsStealing = false

	for index, AnimalInfo in pairs(AnimalList) do
		if typeof(AnimalInfo) == "table" then
			if AnimalInfo.Steal then
				containsStealing = true
			else
				AnimalList[index] = "Empty"
				removedCount = removedCount + 1
			end
		end
	end

	if removedCount > 0 then
		PlayerChannel:Set("AnimalPodiums", AnimalList)
		PlayerChannel:Set("AnimalAddedOrRemoved", true)
	end

	if containsStealing then
		return "✅ Cleared " .. removedCount .. " slots (some slots were skipped because they are being stolen)."
	elseif removedCount == 0 then
		return "ℹ️ All slots were already empty."
	else
		return "✅ Successfully cleared all " .. removedCount .. " slots."
	end
end

removeallfunction.OnServerInvoke = removeAllPodiums

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
