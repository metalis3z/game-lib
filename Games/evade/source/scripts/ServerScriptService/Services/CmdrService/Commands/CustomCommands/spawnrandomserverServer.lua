local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local ServerScriptService = game:GetService("ServerScriptService")
local HttpService = game:GetService("HttpService")

local Animals = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(ServerScriptService.Services.AnimalService)

local TOPIC_INVITE = "SRS_Invite"
local TOPIC_EXECUTE = "SRS_Execute"

local function executeSpawn(data)
	local animalData = Animals[data.animalName]
	if not animalData then return end

	local traitTable = nil
	if data.traits and data.traits ~= "" and data.traits ~= "None" then
		traitTable = {}
		for quoted in data.traits:gmatch('"(.-)"') do table.insert(traitTable, quoted) end
		local withoutQuoted = data.traits:gsub('"(.-)"', "")
		for _, trait in ipairs(string.split(withoutQuoted, ",")) do
			local cleaned = trait:match("^%s*(.-)%s*$")
			if cleaned and cleaned ~= "" then table.insert(traitTable, cleaned) end
		end
	end

	AnimalService.spawnAnimalCustom(animalData, data.mutation, traitTable, data.speed)
end

MessagingService:SubscribeAsync(TOPIC_INVITE, function(message)
	local requestId = message.Data
	MessagingService:PublishAsync("SRS_Response_" .. requestId, game.JobId)
end)

MessagingService:SubscribeAsync(TOPIC_EXECUTE, function(message)
	if message.Data.targetJobId == game.JobId then
		executeSpawn(message.Data.animalParams)
	end
end)

return function(context, numServersToSpawn, animalName, mutation, traits, speed)
	local requestedAmount = math.max(1, tonumber(numServersToSpawn) or 1)
	if not Animals[animalName] then return "aaah" end

	local requestId = HttpService:GenerateGUID(false)
	local foundServers = {}

	local connection
	connection = MessagingService:SubscribeAsync("SRS_Response_" .. requestId, function(message)
		local serverJobId = message.Data
		if not table.find(foundServers, serverJobId) then
			table.insert(foundServers, serverJobId)
		end
	end)

	MessagingService:PublishAsync(TOPIC_INVITE, requestId)

	task.wait(1.5)
	connection:Disconnect()

	if #foundServers == 0 then
		executeSpawn({
			animalName = animalName,
			mutation = mutation,
			traits = traits,
			speed = speed
		})
		return "lol"
	end

	local selectedServers = {}
	local available = {unpack(foundServers)}

	for i = 1, math.min(requestedAmount, #foundServers) do
		local randomIndex = math.random(1, #available)
		table.insert(selectedServers, table.remove(available, randomIndex))
	end

	for _, jobId in ipairs(selectedServers) do
		MessagingService:PublishAsync(TOPIC_EXECUTE, {
			targetJobId = jobId,
			animalParams = {
				animalName = animalName,
				mutation = mutation,
				traits = traits,
				speed = speed
			}
		})
	end

	return ("aaa"):format(#foundServers, #selectedServers)
end