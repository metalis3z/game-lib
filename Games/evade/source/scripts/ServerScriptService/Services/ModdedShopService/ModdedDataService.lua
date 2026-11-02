--!native

local ModdedDataService = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Mutations = require(ReplicatedStorage.Datas.Mutations)

function ModdedDataService.ChangeAllBrainrotsMutation(Player: Player, MutationName: string)
	if MutationName and not Mutations[MutationName] then
		return false
	end

	local PlayerChannel = Synchronizer:Get(Player)

	local AnimalPodiums = PlayerChannel:Get("AnimalPodiums")
	local Index = PlayerChannel:Get("Index")

	local ChangedCount = 0

	for PodiumIndex, PodiumData in pairs(AnimalPodiums) do
		if type(PodiumData) ~= "table" or not PodiumData.Index then
			continue
		end

		local AnimalIndex = PodiumData.Index
		local OldMutation = PodiumData.Mutation

		if Index[AnimalIndex] then
			if OldMutation then
				Index[AnimalIndex][OldMutation] = math.max(0, (Index[AnimalIndex][OldMutation] or 0) - 1)
			else
				Index[AnimalIndex].Default = math.max(0, (Index[AnimalIndex].Default or 0) - 1)
			end

			if MutationName then
				Index[AnimalIndex][MutationName] = (Index[AnimalIndex][MutationName] or 0) + 1
			else
				Index[AnimalIndex].Default = (Index[AnimalIndex].Default or 0) + 1
			end
		end

		PodiumData.Mutation = MutationName
		ChangedCount += 1
	end

	PlayerChannel:Set("AnimalPodiums", AnimalPodiums)
	PlayerChannel:Set("Index", Index)
	PlayerChannel:Set("AnimalAddedOrRemoved", true)

	return true
end

return ModdedDataService