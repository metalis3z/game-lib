local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local MSG_TYPE = "SpawnGlobalLuckyBlock"
local THIS_JOB_ID = game.JobId

-- Enregistrer le handler via MessagingHub (pas de SubscribeAsync direct)
local function registerHandler()
	if not _G.MessagingHub then return end
	
	_G.MessagingHub.Register(MSG_TYPE, function(data)
		if typeof(data) ~= "table" then return end
		if data.senderJobId == THIS_JOB_ID then return end

		local blockName = data.blockName
		local amount = math.clamp(tonumber(data.amount) or 1, 1, 1000)
		local mutation = data.mutation
		local traits = data.traits

		local Animals = require(ReplicatedStorage.Datas.Animals)
		if not Animals[blockName] or not Animals[blockName].LuckyBlock then return end

		local Mutations = nil
		local okMut = pcall(function() Mutations = require(ReplicatedStorage.Datas.Mutations) end)

		local TraitsData = nil
		local okTraits = pcall(function() TraitsData = require(ReplicatedStorage.Datas.Traits) end)

		local AnimalService = require(ServerScriptService.Services.AnimalService)

		if mutation and mutation ~= "None" and (not okMut or not Mutations[mutation]) then return end

		local parsedTraits = {}
		if traits then
			if type(traits) == "string" then
				for t in string.gmatch(traits, "([^,]+)") do
					local tr = string.gsub(t, "^%s*(.-)%s*$", "%1")
					if tr ~= "" and okTraits and TraitsData[tr] then
						table.insert(parsedTraits, tr)
					end
				end
			elseif type(traits) == "table" then
				for _, tr in ipairs(traits) do
					if type(tr) == "string" and okTraits and TraitsData[tr] then
						table.insert(parsedTraits, tr)
					end
				end
			end
		end

		local mutParam = (mutation and mutation ~= "None" and mutation ~= "Normal") and mutation or nil

		for i = 1, amount do
			pcall(function()
				AnimalService.spawnAnimalCustom(Animals[blockName], mutParam, parsedTraits, nil, nil, nil)
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
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")

	local Animals = require(ReplicatedStorage.Datas.Animals)
	local Mutations = nil
	local okMut = pcall(function() Mutations = require(ReplicatedStorage.Datas.Mutations) end)
	local TraitsData = nil
	local okTraits = pcall(function() TraitsData = require(ReplicatedStorage.Datas.Traits) end)
	local AnimalService = require(ServerScriptService.Services.AnimalService)

	Conch.register("spawngloballuckyblock", {
		permissions = { Config.RequiredRole or "super-user" },
		arguments = function()
			return {
				kind = "argument",
				type = "LuckyBlock",
				name = "Lucky Block",
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
		callback = function(blockName, amount, mutation, traits)
			amount = math.clamp(tonumber(amount) or 1, 1, 1000)

			-- Validation
			if not blockName or not Animals[blockName] or not Animals[blockName].LuckyBlock then
				return false, "Lucky Block invalide"
			end

			if mutation and mutation ~= "None" and (not okMut or not Mutations[mutation]) then
				return false, "Mutation invalide"
			end

			-- Parser les traits
			local parsedTraits = {}
			if traits then
				if type(traits) == "string" then
					for t in string.gmatch(traits, "([^,]+)") do
						local tr = string.gsub(t, "^%s*(.-)%s*$", "%1")
						if tr ~= "" and okTraits and TraitsData[tr] then
							table.insert(parsedTraits, tr)
						end
					end
				elseif type(traits) == "table" then
					for _, tr in ipairs(traits) do
						if type(tr) == "string" and okTraits and TraitsData[tr] then
							table.insert(parsedTraits, tr)
						end
					end
				end
			end

			local mutParam = (mutation and mutation ~= "None" and mutation ~= "Normal") and mutation or nil

			-- SPAWN LOCAL (sur ce serveur)
			for i = 1, amount do
				pcall(function()
					AnimalService.spawnAnimalCustom(Animals[blockName], mutParam, parsedTraits, nil, nil, nil)
				end)
			end

			-- PUBLISH aux autres serveurs via MessagingHub
			if _G.MessagingHub then
				_G.MessagingHub.Publish(MSG_TYPE, {
					blockName = blockName,
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
