local module = function(Conch, Config)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")
	local Animals = require(ReplicatedStorage.Datas.Animals)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)

	Conch.register("spawnfakeinbase", {
		description = "Spawn un brainrot FAKE sur le tapis qui va dans la base du joueur ciblé. L'animal disparaît quand le joueur s'approche à moins de 10 studs. Il n'est pas sauvegardé.",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "Brainrot",
				name = "Brainrot",
			},
			{
				kind = "argument",
				type = "string",
				name = "Player",
			},
			{
				kind = "argument",
				type = "Mutation",
				name = "Mutation",
				optional = true,
			}
		end,
		callback = function(brainrot, targetName, mutation)
			local AnimalService = require(game.ServerScriptService.Services.AnimalService)
			local PlotService = require(game.ServerScriptService.Services.PlotService)
			local AnimalData
			for _, data in pairs(Animals) do
				if data.DisplayName == brainrot or data.Name == brainrot then AnimalData = data break end
			end
			if not AnimalData then return false, ("Brainrot '%s' introuvable."):format(tostring(brainrot)) end
			local target = Players:FindFirstChild(targetName)
			if not target then return false, ("Joueur '%s' introuvable."):format(tostring(targetName)) end
			local mutParam = nil
			if mutation and mutation ~= "" and mutation ~= "Normal" then
				if not Mutations[mutation] then return false, ("Mutation '%s' introuvable."):format(tostring(mutation)) end
				mutParam = mutation
			end
			local plot = PlotService.getPlot(target)
			local animalTarget = plot and plot:FindFirstChild("AnimalTarget")
			AnimalService.spawnAnimalCustom(AnimalData, mutParam, nil, nil, {
				Owner = target,
				End = animalTarget,
			}, nil, true)
			return string.format("✅ Fake %s → base de %s", AnimalData.DisplayName, target.Name)
		end,
	})
end
return module