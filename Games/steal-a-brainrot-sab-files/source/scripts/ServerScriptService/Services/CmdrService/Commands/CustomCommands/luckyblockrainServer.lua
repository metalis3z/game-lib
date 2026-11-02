local MessagingService = require(game:GetService("ServerScriptService").Services.MessagingService)
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AnimalService = require(ServerScriptService.Services.AnimalService)
local Animals = require(ReplicatedStorage.Datas.Animals)
local EventService = require(ServerScriptService.Services.EventService)

local GLOBAL_TOPIC = "GlobalLuckyRain"

local LuckyBlockNames = {
	"",
	",
	"",
	"",
	"",
	"",
	""
}

local CachedBlockList = {}
for _, name in ipairs(LuckyBlockNames) do
	local data = Animals[name]
	if data then
		table.insert(CachedBlockList, data)
	end
end

local spawnThreeRoads = AnimalService.SpawnThreeRoads
local spawnAnimalCustom = AnimalService.spawnAnimalCustom
local floor = math.floor
local max = math.max

local function SpawnBlocksLocally(amount)
	local spawnAmount = tonumber(amount) or 3
	local is3RoadsActive = EventService:GetActiveEvent("3 Roads") == true or ReplicatedStorage:GetAttribute("3RoadsEvent")

	if is3RoadsActive then
		local perRoadAmount = max(1, floor(spawnAmount / 3))

		for i = 1, #CachedBlockList do
			local data = CachedBlockList[i]
			for _ = 1, perRoadAmount do
				spawnThreeRoads(data)
			end
		end
	else
		for i = 1, #CachedBlockList do
			local data = CachedBlockList[i]
			for _ = 1, spawnAmount do
				spawnAnimalCustom(data)
			end
		end
	end
end

local success, subConnection = pcall(function()
	return MessagingService:SubscribeAsync(GLOBAL_TOPIC, function(payload)
		local amount, source
		if type(payload) == "table" then
			amount = tonumber(payload.amount) or 3
			source = payload.sourceJobId
		else
			amount = tonumber(payload) or 3
		end
		if source ~= nil and source == game.JobId then return end
		SpawnBlocksLocally(amount)
	end)
end)

if not success then
	warn("Failed to subscribe to GlobalLuckyRain:", subConnection)
end

return function(context, amount: number, isglobal: boolean?, jobid: string?)
	jobid = (jobid and jobid ~= "") and jobid or nil
	local n = tonumber(amount) or 3

	if jobid then
		if not MessagingService:IsKnownJobId(jobid) then
			return string.format("invalid jobid '%s'.", jobid)
		end
		MessagingService:PublishAsync(GLOBAL_TOPIC, { amount = n, sourceJobId = game.JobId }, jobid)
		if jobid == game.JobId then
			SpawnBlocksLocally(n)
		end
		return string.format("Lucky Rain sent to server %s only. Amount: %d", jobid, n)
	end

	if isglobal then
		SpawnBlocksLocally(n)
		MessagingService:PublishAsync(GLOBAL_TOPIC, { amount = n, sourceJobId = game.JobId })
		return string.format("✅ Global Lucky Rain — rained here and broadcast to all servers. Amount: %d", n)
	else
		local spawnSuccess, spawnErr = pcall(SpawnBlocksLocally, n)
		if spawnSuccess then
			return string.format("✅ Lucky Rain spawned locally! Amount: %d", n)
		else
			return string.format("❌ Local Lucky Rain failed: %s", tostring(spawnErr))
		end
	end
end 