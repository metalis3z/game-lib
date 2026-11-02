local module = function(Conch, Config)
	local ServerStorage = game:GetService("ServerStorage")
	local SS = game:GetService("ServerScriptService")
	local CraftingData = require(ServerStorage.Modules.CraftingData)
	local CraftingMachineService = require(SS.Services.CraftingMachineService)

	Conch.register("setrecipe", {
		description = "Définit la recette active globale de la Crafting Machine. La recette sera visible pour tous les joueurs.",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return { kind = "argument", type = "Brainrot to Craft", name = "Brainrot" }
		end,
		callback = function(brainrotName)
			local foundBrainrot, rarityKey
			for rarity, rarityData in pairs(CraftingData.Rarities) do
				for _, b in ipairs(rarityData.Brainrots) do
					if b.Name == brainrotName then
						foundBrainrot = b
						rarityKey = rarity
						break
					end
				end
				if foundBrainrot then break end
			end
			if not foundBrainrot then
				return false, ("Brainrot '%s' introuvable."):format(tostring(brainrotName))
			end
			local craftables = CraftingMachineService.getList()
			craftables.List[rarityKey] = {
				Name = foundBrainrot.Name,
				CraftTime = CraftingData.Rarities[rarityKey].CraftTime,
				Cost = foundBrainrot.Cost,
				Recipe = foundBrainrot.Recipe,
			}
			CraftingMachineService.updateList(craftables)
			return string.format("✅ Recette globale → %s (%s)", foundBrainrot.Name, rarityKey)
		end,
	})
end
return module