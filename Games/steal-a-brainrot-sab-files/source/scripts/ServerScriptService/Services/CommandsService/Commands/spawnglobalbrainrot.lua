local MessagingService = game:GetService("MessagingService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local CHANNEL = "GlobalBrainrotSpawn"

MessagingService:SubscribeAsync(CHANNEL, function(message)
	local data = message.Data
	if typeof(data) ~= "table" then return end

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

	local successCount = 0
	for i = 1, amount do
		local ok = pcall(function()
			AnimalService.spawnAnimalCustom(Animals[brainrot], mutParam, parsedTraits, nil, nil, nil)
		end)
		if ok then
			successCount += 1
		end
	end
end)

local module = function(Conch, Config)
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
			MessagingService:PublishAsync(CHANNEL, {
				brainrot = brainrot,
				amount = tonumber(amount) or 1,
				mutation = mutation,
				traits = traits
			})
			return "spawned"
		end,
	})
end

return module