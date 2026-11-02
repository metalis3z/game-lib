local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Synchronizer = require(Packages.Synchronizer)
local Datas = ReplicatedStorage:WaitForChild("Datas")
local IndexData = require(Datas.Index)
require(ReplicatedStorage.Shared.Updates)
local Animals = require(Datas.Animals)

local IndexModule = {
	CanShowInIndex = function(self, animalId)
		local animalData = Animals[animalId]
		if animalData then
			if animalData.IsEnabled and not animalData.IsEnabled() then
				return false
			else
				return not animalData.HideFromIndex
			end
		else
			return false
		end
	end,

	IsComplete = function(self, player, mutationId)
		local playerData = Synchronizer:Get(player)
		if not playerData then
			return false
		end

		if mutationId == "Strawberry" then
			local animalPodiums = playerData:Get("AnimalPodiums")
			for _, podium in pairs(animalPodiums) do
				if typeof(podium) == "table" and podium.Index == "Strawberry Elephant" then
					return true
				end
			end
			return false

		elseif mutationId == "Skibidi" then
			local animalPodiums = playerData:Get("AnimalPodiums")
			for _, podium in pairs(animalPodiums) do
				if typeof(podium) == "table" and podium.Index == "Skibidi Toilet" then
					return true
				end
			end
			
		elseif mutationId == "Headless" then
			local animalPodiums = playerData:Get("AnimalPodiums")
			for _, podium in pairs(animalPodiums) do
				if typeof(podium) == "table" and podium.Index == "Headless Horseman" then
					return true
				end
			end
			
		elseif mutationId == "John Pork" then
			local animalPodiums = playerData:Get("AnimalPodiums")
			for _, podium in pairs(animalPodiums) do
				if typeof(podium) == "table" and podium.Index == "John Pork" then
					return true
				end
			end	

		elseif mutationId == "Meowl" then
			local animalPodiums = playerData:Get("AnimalPodiums")
			for _, podium in pairs(animalPodiums) do
				if typeof(podium) == "table" and podium.Index == "Meowl" then
					return true
				end
			end
			return false
		else
			local playerIndex = playerData:Get("Index")
			local collected = 0
			local required = 0

			local mutationData = mutationId and IndexData[mutationId]

			if mutationData and mutationData.DisableIndex then
				return false
			end

			local indexStructure = mutationData and mutationData.Index

			if indexStructure then
				for animalId, indexInfo in pairs(indexStructure) do
					if not indexInfo.IgnoreIndexCounter then
						required = required + 1
					end

					local playerAnimalIndex = playerIndex[animalId]
					if playerAnimalIndex then
						local isUnlocked

						if mutationData and mutationData.CustomIndex then
							isUnlocked = playerAnimalIndex[mutationData.CustomIndex.Name]
						elseif mutationData and not mutationData.IsMutation then
							isUnlocked = next(playerAnimalIndex) ~= nil
						else
							isUnlocked = playerAnimalIndex[mutationId]
						end

						if isUnlocked then
							collected = collected + 1
						end
					end
				end

				local completionPercent = mutationData and mutationData.CompletitionPercent or (mutationId == "Default" and 0.75 or 1)

				if completionPercent ~= 1 then
					local calculatedRequired = required * completionPercent
					local roundedRequired = math.ceil(calculatedRequired)
					required = math.max(roundedRequired, 1)
				end

				return collected >= required
			else
				for animalId, _ in pairs(Animals) do
					if self:CanShowInIndex(animalId) then
						required = required + 1
						local playerAnimalIndex = playerIndex[animalId]
						if playerAnimalIndex and playerAnimalIndex[mutationId or "Default"] then
							collected = collected + 1
						end
					end
				end

				local completionPercent = mutationData and mutationData.CompletitionPercent or (mutationId == "Default" and 0.75 or 1)

				if completionPercent ~= 1 then
					local calculatedRequired = required * completionPercent
					local roundedRequired = math.ceil(calculatedRequired)
					required = math.max(roundedRequired, 1)
				end

				return collected >= required
			end
		end
	end,

	GetIndexAnimals = function(self, player, mutationId)
		local playerData = Synchronizer:Get(player)
		if not playerData then
			return nil
		end

		local playerIndex = playerData:Get("Index")
		local collected = 0
		local required = 0
		local total = 0

		local mutationData = mutationId and IndexData[mutationId]
		local indexStructure = mutationData and mutationData.Index

		if indexStructure then
			for animalId, indexInfo in pairs(indexStructure) do
				total = total + 1
				if not indexInfo.IgnoreIndexCounter then
					required = required + 1
				end

				local playerAnimalIndex = playerIndex[animalId]
				if playerAnimalIndex then
					local isUnlocked

					if mutationData and mutationData.CustomIndex then
						isUnlocked = playerAnimalIndex[mutationData.CustomIndex.Name]
					elseif mutationData and not mutationData.IsMutation then
						isUnlocked = next(playerAnimalIndex) ~= nil
					else
						isUnlocked = playerAnimalIndex[mutationId]
					end

					if isUnlocked then
						collected = collected + 1
					end
				end
			end

			local completionPercent = mutationData and mutationData.CompletitionPercent or (mutationId == "Default" and 0.75 or 1)

			if completionPercent ~= 1 then
				local calculatedRequired = required * completionPercent
				local roundedRequired = math.ceil(calculatedRequired)
				required = math.max(roundedRequired, 1)
			end
		else
			for animalId, _ in pairs(Animals) do
				if self:CanShowInIndex(animalId) then
					total = total + 1
					required = required + 1
					local playerAnimalIndex = playerIndex[animalId]
					if playerAnimalIndex and playerAnimalIndex[mutationId or "Default"] then
						collected = collected + 1
					end
				end
			end

			local completionPercent = mutationData and mutationData.CompletitionPercent or (mutationId == "Default" and 0.75 or 1)

			if completionPercent ~= 1 then
				local calculatedRequired = required * completionPercent
				local roundedRequired = math.ceil(calculatedRequired)
				required = math.max(roundedRequired, 1)
			end
		end

		return collected, required, total
	end,

	GetMultipliers = function(self, player)
		local multiplier = 0

		if Synchronizer:Get(player) then
			local completedCategories = 0
			completedCategories = completedCategories + (self:IsComplete(player) == true and 1 or 0)

			for mutationId, mutationData in pairs(IndexData) do
				if not mutationData.LimitedMutation and mutationData.IsMutation then
					completedCategories = completedCategories + (self:IsComplete(player, mutationId) == true and 1 or 0)
				end
			end

			multiplier = multiplier + completedCategories * 0.5
		end

		return multiplier
	end
}

return IndexModule