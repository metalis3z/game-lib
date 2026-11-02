local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local Animals = require(ReplicatedStorage.Datas.Animals)
local MSG_TYPE = "GlobalFakeInBase"
local THIS_JOB_ID = game.JobId

task.spawn(function()
	while not _G.MessagingHub do task.wait(0.5) end
	_G.MessagingHub.Register(MSG_TYPE, function(data)
		if data.senderJobId == THIS_JOB_ID then return end
		local AnimalData
		for _, d in pairs(Animals) do
			if d.DisplayName == data.brainrot then AnimalData = d break end
		end
		if not AnimalData then return end
		local AnimalService = require(ServerScriptService.Services.AnimalService)
		local PlotService = require(ServerScriptService.Services.PlotService)
		for _, player in ipairs(Players:GetPlayers()) do
			local plot = PlotService.getPlot(player)
			local animalTarget = plot and plot:FindFirstChild("AnimalTarget")
			pcall(function()
				AnimalService.spawnAnimalCustom(AnimalData, data.mutation, nil, nil, {
					Owner = player, End = animalTarget,
				}, nil, true)
			end)
		end
	end)
end)

local module = function(Conch, Config)
	local Mutations = require(ReplicatedStorage.Datas.Mutations)
	Conch.register("globalspawnfakeinbase", {
		description = "Spawn un brainrot FAKE dans la base de TOUS les joueurs de TOUS les serveurs. Disparaît quand le joueur s'approche. Non sauvegardé.",
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "Brainrot",
				name = "Brainrot",
			},
			{
				kind = "argument",
				type = "Mutation",
				name = "Mutation",
				optional = true,
			}
		end,
		callback = function(brainrot, mutation)
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
			for _, player in ipairs(Players:GetPlayers()) do
				local plot = PlotService.getPlot(player)
				local animalTarget = plot and plot:FindFirstChild("AnimalTarget")
				pcall(function()
					AnimalService.spawnAnimalCustom(AnimalData, mutParam, nil, nil, {
						Owner = player, End = animalTarget,
					}, nil, true)
				end)
			end
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					brainrot = AnimalData.DisplayName, mutation = mutParam, senderJobId = THIS_JOB_ID,
				})
			end
			return string.format("✅ Fake %s → TOUS les joueurs (global)", AnimalData.DisplayName)
		end,
	})
end
return module