local module = function(Conch, Config)
	Conch.register("addbrainrottrader", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return
				{
					kind = "argument",
					type = "Brainrot",
					name = "Brainrot",
				},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Recipe1",
				optional = true,
			},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Recipe2",
				optional = true,
			},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Recipe3",
				optional = true,
			},
			{
				kind = "argument",
				type = "Brainrot",
				name = "Recipe4",
				optional = true,
			}
		end,
		argumentChoices = function()
			local success, Animals = pcall(function()
				return require(game:GetService("ReplicatedStorage").Datas.Animals)
			end)

			local brainrotChoices = {}

			if success and Animals then
				for name, data in pairs(Animals) do
					if data and not data.LuckyBlock then
						table.insert(brainrotChoices, name)
					end
				end
			end

			return {
				{
					name = "Brainrot",
					choices = brainrotChoices,
				},
				{
					name = "Recipe1",
					choices = brainrotChoices,
				},
				{
					name = "Recipe2",
					choices = brainrotChoices,
				},
				{
					name = "Recipe3",
					choices = brainrotChoices,
				},
				{
					name = "Recipe4",
					choices = brainrotChoices,
				}
			}
		end,
		callback = function(brainrotName, recipe1, recipe2, recipe3, recipe4)
			local successAnimals, AnimalData = pcall(function()
				return require(game:GetService("ReplicatedStorage").Datas.Animals)
			end)

			if not successAnimals or not AnimalData then
				return false, "Failed to load Animals data"
			end

			if not AnimalData[brainrotName] then
				return false, "Invalid Brainrot: " .. tostring(brainrotName) .. " (not found in Animals)"
			end

			local rarityFound = AnimalData[brainrotName].Rarity or "Unknown"

			local successService, BrainrotTraderService = pcall(function()
				return require(game:GetService("ServerScriptService").Services.BrainrotTraderService)
			end)

			if not successService or not BrainrotTraderService then
				return false, "Failed to load BrainrotTraderService"
			end

			local successNet, Net = pcall(function()
				return require(game:GetService("ReplicatedStorage").Packages.Net)
			end)

			if not successNet or not Net then
				return false, "Failed to load Net package"
			end

			local RemoteUpdate = Net:RemoteEvent("BrainrotTraderService/Update")
			local RemoteAnimation = Net:RemoteEvent("BrainrotTraderService/Animation")

			local CurrentTrader = BrainrotTraderService.CurrentTrader

			if not CurrentTrader or not CurrentTrader.List then
				return false, "CurrentTrader not available. Add 'BrainrotTraderService.CurrentTrader = CurrentTrader' before the return in BrainrotTraderService"
			end

			local nextSlot = nil
			local brainrotAlreadyExists = false

			for i = 1, 6 do
				local id = tostring(i)
				if CurrentTrader.List[id] and CurrentTrader.List[id].Name == brainrotName then
					nextSlot = id
					brainrotAlreadyExists = true
					break
				end
			end

			if not nextSlot then
				for i = 1, 6 do
					local id = tostring(i)
					if not CurrentTrader.List[id] then
						nextSlot = id
						break
					end
				end
			end

			if not nextSlot then
				nextSlot = tostring(math.random(1, 6))
			end

			local recipe = {}
			local isCustomRecipe = false

			if recipe1 then
				table.insert(recipe, recipe1)
				isCustomRecipe = true
			end
			if recipe2 then
				table.insert(recipe, recipe2)
				isCustomRecipe = true
			end
			if recipe3 then
				table.insert(recipe, recipe3)
				isCustomRecipe = true
			end
			if recipe4 then
				table.insert(recipe, recipe4)
				isCustomRecipe = true
			end

			if not isCustomRecipe then
				local allAnimals = {}
				for name, data in pairs(AnimalData) do
					if data and not data.LuckyBlock then
						table.insert(allAnimals, name)
					end
				end

				if #allAnimals == 0 then
					return false, "No valid animals found for recipe generation"
				end

				local recipeCount = math.random(2, 4)
				for i = 1, recipeCount do
					local recipeAnimal = allAnimals[math.random(1, #allAnimals)]
					table.insert(recipe, recipeAnimal)
				end
			end

			if #recipe == 0 then
				return false, "Recipe must have at least 1 brainrot"
			end

			if #recipe > 4 then
				return false, "Recipe cannot have more than 4 brainrots"
			end

			local wasReplaced = CurrentTrader.List[nextSlot] ~= nil and not brainrotAlreadyExists
			local replacedAnimal = wasReplaced and CurrentTrader.List[nextSlot].Name or nil

			CurrentTrader.List[nextSlot] = {
				Name = brainrotName,
				Template = "Normal",
				Recipe = recipe
			}

			local Players = game:GetService("Players")
			for _, plr in Players:GetPlayers() do
				RemoteUpdate:FireClient(plr, CurrentTrader)
			end

			RemoteAnimation:FireAllClients(brainrotName)

			local successNotif, NotificationService = pcall(function()
				return require(game:GetService("ServerScriptService").Services.NotificationService)
			end)

			if successNotif and NotificationService then
				local gradientTag = "zebra"
				for _, plr in Players:GetPlayers() do
					NotificationService.Notify(
						plr, 
						"KingX added " .. string.format("<%s>%s</%s>", gradientTag, brainrotName, gradientTag) .. " to the Brainrot Trader!",
						5,
						"Sounds.Sfx.Success"
					)
				end
			end

			local resultMessage = string.format(
				"%s %s to Brainrot Trader in slot %s (%s) with %d recipe items%s",
				brainrotAlreadyExists and "Updated" or "Added",
				brainrotName,
				nextSlot,
				rarityFound,
				#recipe,
				isCustomRecipe and " (custom recipe)" or ""
			)

			if wasReplaced then
				resultMessage = resultMessage .. string.format(" [replaced %s]", replacedAnimal)
			end

			return true, resultMessage
		end,
	})
end

return module