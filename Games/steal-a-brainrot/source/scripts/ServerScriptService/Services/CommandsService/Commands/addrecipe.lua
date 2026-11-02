local module = function(Conch, Config)
	local ServerStorage = game:GetService("ServerStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local TextChatService = game:GetService("TextChatService")
	local Players = game:GetService("Players")

	local CraftingData = require(ServerStorage.Modules.CraftingData)
	local CraftingMachineService = require(ServerScriptService.Services.CraftingMachineService)

	Conch.register("addrecipe", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "Brainrot to Craft",
					name = "Brainrot",
				}
		end,

		callback = function(brainrotName)
			local foundBrainrot
			local rarityKey

			for rarity, rarityData in pairs(CraftingData.Rarities) do
				for _, brainrot in ipairs(rarityData.Brainrots) do
					if brainrot.Name == brainrotName then
						foundBrainrot = brainrot
						rarityKey = rarity
						break
					end
				end
				if foundBrainrot then break end
			end

			if not foundBrainrot then
				return false, ("Brainrot '%s' not found"):format(tostring(brainrotName))
			end

			local craftables = CraftingMachineService.getList()

			craftables.List[rarityKey] = {
				Name = foundBrainrot.Name,
				CraftTime = CraftingData.Rarities[rarityKey].CraftTime,
				Cost = foundBrainrot.Cost,
				Recipe = foundBrainrot.Recipe,
			}

			CraftingMachineService.updateList(craftables)

			local speaker = Conch:get_speaker()
			local player = speaker and Players:FindFirstChild(speaker)

			if player then
				TextChatService:DisplaySystemMessage(
					string.format(
						"%s added %s to the Craft Machine!",
						player.DisplayName,
						foundBrainrot.Name
					)
				)
			end

			return "added"
		end,
	})
end

return module