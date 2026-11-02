local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local MSG_TYPE = "GlobalBrainrotSpawn"
local THIS_JOB_ID = game.JobId

-- Enregistrer le handler via MessagingHub (pas de SubscribeAsync direct)
local function registerHandler()
	if not _G.MessagingHub then return end
	
	_G.MessagingHub.Register(MSG_TYPE, function(data)
		if typeof(data) ~= "table" then return end
		if data.senderJobId == THIS_JOB_ID then return end

		local brainrot = data.brainrot
		local amount = math.clamp(tonumber(data.amount) or 1, 1, 1000)
		local mutation = data.mutation
		local traits = data.traits

		if not brainrot then return end

		local Animals = require(ReplicatedStorage.Datas.Animals)
		if not Animals[brainrot] or Animals[brainrot].LuckyBlock then return end

		local Mutations = nil
		local hasMutations = pcall(function()
			Mutations = require(ReplicatedStorage.Datas.Mutations)
		end)

		local TraitsData = nil
		local hasTraits = pcall(function()
			TraitsData = require(ReplicatedStorage.Datas.Traits)
		end)

		local AnimalService = require(ServerScriptService.Services.AnimalService)

		if mutation and mutation ~= "None" and (not hasMutations or not Mutations[mutation]) then return end

		local parsedTraits = {}
		if traits then
			if type(traits) == "string" then
				for trait in string.gmatch(traits, "([^,]+)") do
					local t = string.gsub(trait, "^%s*(.-)%s*$", "%1")
					if t ~= "" and hasTraits and TraitsData[t] then
						table.insert(parsedTraits, t)
					end
				end
			elseif type(traits) == "table" then
				for _, t in ipairs(traits) do
					if type(t) == "string" and hasTraits and TraitsData[t] then
						table.insert(parsedTraits, t)
					end
				end
			end
		end

		local mutParam = (mutation and mutation ~= "None" and mutation ~= "Normal") and mutation or nil

		for i = 1, amount do
			pcall(function()
				AnimalService.spawnAnimalCustom(Animals[brainrot], mutParam, parsedTraits, nil, nil, nil)
			end)
		end
	end)
end

-- Attendre que MessagingHub soit prêt
task.spawn(function()
	while not _G.MessagingHub do
		task.wait(0.5)
	end
	registerHandler()
end)

local module = function(Conch, Config)
	local Animals = require(ReplicatedStorage.Datas.Animals)
	local Mutations = nil
	local hasMutations = pcall(function() Mutations = require(ReplicatedStorage.Datas.Mutations) end)
	local TraitsData = nil
	local hasTraits = pcall(function() TraitsData = require(ReplicatedStorage.Datas.Traits) end)
	local AnimalService = require(ServerScriptService.Services.AnimalService)

	Conch.register("spawnglobalbrainrot", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "Brainrot",
				name = "Brainrot",
			},
			{
				kind = "argument",
				type = "number",
				name = "Amount",
				optional = true,
			},
			{
				kind = "argument",
				type = "Mutation",
				name = "Mutation",
				optional = true,
			},
			{
				kind = "argument",
				name = "Traits",
				type = "Traits",
				optional = true,
			}
		end,
		callback = function(brainrot, amount, mutation, traits)
			amount = math.clamp(tonumber(amount) or 1, 1, 1000)

			-- Validation
			if not brainrot or not Animals[brainrot] or Animals[brainrot].LuckyBlock then
				return false, "Brainrot invalide"
			end

			if mutation and mutation ~= "None" and (not hasMutations or not Mutations[mutation]) then
				return false, "Mutation invalide"
			end

			-- Parser les traits
			local parsedTraits = {}
			if traits then
				if type(traits) == "string" then
					for trait in string.gmatch(traits, "([^,]+)") do
						local t = string.gsub(trait, "^%s*(.-)%s*$", "%1")
						if t ~= "" and hasTraits and TraitsData[t] then
							table.insert(parsedTraits, t)
						end
					end
				elseif type(traits) == "table" then
					for _, t in ipairs(traits) do
						if type(t) == "string" and hasTraits and TraitsData[t] then
							table.insert(parsedTraits, t)
						end
					end
				end
			end

			local mutParam = (mutation and mutation ~= "None" and mutation ~= "Normal") and mutation or nil

			-- SPAWN LOCAL (sur ce serveur)
			for i = 1, amount do
				pcall(function()
					AnimalService.spawnAnimalCustom(Animals[brainrot], mutParam, parsedTraits, nil, nil, nil)
				end)
			end

			-- PUBLISH aux autres serveurs via MessagingHub
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					brainrot = brainrot,
					amount = amount,
					mutation = mutation,
					traits = traits,
					senderJobId = THIS_JOB_ID,
				})
			end
			return "spawned"
		end,
	})
end

return module
