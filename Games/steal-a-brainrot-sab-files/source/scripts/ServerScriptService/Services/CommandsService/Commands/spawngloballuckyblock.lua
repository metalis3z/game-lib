local MessagingService = game:GetService("MessagingService")
local CHANNEL_LUCKYBLOCK = "SpawnGlobalLuckyBlock"

MessagingService:SubscribeAsync(CHANNEL_LUCKYBLOCK, function(msg)
	local d = msg.Data
	if typeof(d) ~= "table" then return end

	local blockName = d.blockName
	local amount = math.clamp(tonumber(d.amount) or 1, 1, 1000)
	local mutation = d.mutation
	local traits = d.traits

	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")

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

local module = function(Conch, Config)
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
			MessagingService:PublishAsync(CHANNEL_LUCKYBLOCK, {
				blockName = blockName,
				amount = tonumber(amount) or 1,
				mutation = mutation,
				traits = traits,
			})
			return "spawned"
		end,
	})
end

return module