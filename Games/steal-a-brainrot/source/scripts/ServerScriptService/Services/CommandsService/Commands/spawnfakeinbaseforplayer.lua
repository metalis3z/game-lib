local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local Animals = require(ReplicatedStorage.Datas.Animals)
local MSG_TYPE = "FAKE_INBASE_FOR_PLAYER"
local THIS_JOB_ID = game.JobId

task.spawn(function()
	while not _G.MessagingHub do task.wait(0.5) end
	_G.MessagingHub.Register(MSG_TYPE, function(data)
		if data.senderJobId == THIS_JOB_ID then return end
		local target = Players:FindFirstChild(data.targetName)
		if not target then return end
		local AnimalData
		for _, d in pairs(Animals) do
			if d.DisplayName == data.brainrot then AnimalData = d break end
		end
		if not AnimalData then return end
		local AnimalService = require(ServerScriptService.Services.AnimalService)
		local PlotService = require(ServerScriptService.Services.PlotService)
		local plot = PlotService.getPlot(target)
		local animalTarget = plot and plot:FindFirstChild("AnimalTarget")
		pcall(function()
			AnimalService.spawnAnimalCustom(AnimalData, data.mutation, nil, nil, {
				Owner = target, End = animalTarget,
			}, nil, true)
		end)
	end)
end)

local module = function(Conch, Config)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	Conch.register("spawnfakeinbaseforplayer", {
		description = "Spawn un FAUX brainrot directement dans la base du joueur ciblé (cross-serveur). L'animal disparaît quand le joueur s'approche à moins de 10 studs. Non sauvegardé.",
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
			local AnimalService = require(ServerScriptService.Services.AnimalService)
			local PlotService = require(ServerScriptService.Services.PlotService)
			local AnimalData
			for _, data in pairs(Animals) do
				if data.DisplayName == brainrot or data.Name == brainrot then AnimalData = data break end
			end
			if not AnimalData then return false, ("Brainrot '%s' introuvable."):format(tostring(brainrot)) end
			local mutParam = nil
			if mutation and mutation ~= "" and mutation ~= "Normal" then
				if not Mutations[mutation] then return false, ("Mutation '%s' introuvable."):format(tostring(mutation)) end
				mutParam = mutation
			end
			local target = Players:FindFirstChild(targetName)
			if target then
				local plot = PlotService.getPlot(target)
				local animalTarget = plot and plot:FindFirstChild("AnimalTarget")
				AnimalService.spawnAnimalCustom(AnimalData, mutParam, nil, nil, {
					Owner = target, End = animalTarget,
				}, nil, true)
				return string.format("✅ Fake %s → base de %s (local)", AnimalData.DisplayName, targetName)
			end
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					brainrot = AnimalData.DisplayName, mutation = mutParam,
					targetName = targetName, senderJobId = THIS_JOB_ID,
				})
				return string.format("✅ Fake %s → base de %s (broadcast)", AnimalData.DisplayName, targetName)
			end
			return false, "Joueur introuvable"
		end,
	})
end
return module