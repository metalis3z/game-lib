local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Knit = require(RS.Packages.Knit)
local ActiveEvents = require(RS.Shared.List.Items.ActiveEvents)

local EVENT_INTERVAL = 300
local EVENT_DURATION = 60
local MIN_PLAYERS = 1
local STARS_PER_EVENT = 10

-- Build a weighted list of star event keys for random item assignment
local STAR_KEYS = {}
local STAR_TOTAL_WEIGHT = 0
for eventName, event in ActiveEvents do
	if event.isStar then
		STAR_KEYS[#STAR_KEYS + 1] = { key = eventName, weight = event.chance }
		STAR_TOTAL_WEIGHT += event.chance
	end
end

local function pickRandomStarKey()
	local roll = math.random() * STAR_TOTAL_WEIGHT
	local accumulated = 0
	for _, entry in STAR_KEYS do
		accumulated += entry.weight
		if roll <= accumulated then
			return entry.key
		end
	end
	return STAR_KEYS[1] and STAR_KEYS[1].key or "luckyStar"
end

local FallingStarsService = Knit.CreateService({
	Name = "FallingStarsService",
	Client = {
		startEvent = Knit.CreateSignal(),
		endEvent = Knit.CreateSignal(),
		spawnStar = Knit.CreateSignal(),
		despawnStar = Knit.CreateSignal(),
	},
	_ds = nil,
	_activeStars = {},
	_eventActive = false,
	_activeMapId = 1,  -- default map; updated by SetActiveMapId
})

-- Called by external services (e.g. MapService) to tell FallingStars which map the event is on
function FallingStarsService:SetActiveMapId(mapId)
	self._activeMapId = mapId
end

function FallingStarsService.Client:claimStar(player, starId)
	if type(starId) ~= "string" then return "invalid" end
	local starData = self.Server._activeStars[starId]
	if not starData then return "notFound" end
	if starData.claimed then return "alreadyClaimed" end

	starData.claimed = true
	local data = self.Server._ds:GetData(player)
	if not data then return "noData" end

	local totalChance = 0
	for _, event in ActiveEvents do
		if event.isStar then totalChance += event.chance end
	end

	local roll = math.random() * totalChance
	local accumulated = 0
	local wonEvent = nil
	for eventName, event in ActiveEvents do
		if event.isStar then
			accumulated += event.chance
			if roll <= accumulated then
				wonEvent = eventName
				break
			end
		end
	end

	if wonEvent then
		self.Server._ds:Set(player, {"activeBoosts", wonEvent}, true)
		task.delay(ActiveEvents[wonEvent].seconds, function()
			local currentData = self.Server._ds:GetData(player)
			if currentData then
				self.Server._ds:Set(player, {"activeBoosts", wonEvent}, nil)
			end
		end)
	end

	for _, p in Players:GetPlayers() do
		self.Server.Client.despawnStar:Fire(p, starId)
	end
	return "success"
end

function FallingStarsService:_runEvent()
	if #Players:GetPlayers() < MIN_PLAYERS then return end
	self._eventActive = true

	local mapId = self._activeMapId
	for _, player in Players:GetPlayers() do
		self.Client.startEvent:Fire(player, mapId)
	end

	for i = 1, STARS_PER_EVENT do
		task.delay(i * (EVENT_DURATION / STARS_PER_EVENT), function()
			if not self._eventActive then return end
			local starId = "star_" .. os.clock() .. "_" .. i
			local itemKey = pickRandomStarKey()
			local starData = {
				claimed = false,
				item = { id = itemKey, class = "event" },
				mapId = mapId,
			}
			self._activeStars[starId] = starData
			for _, player in Players:GetPlayers() do
				self.Client.spawnStar:Fire(player, starId, starData)
			end
		end)
	end

	task.delay(EVENT_DURATION, function()
		self._eventActive = false
		self._activeStars = {}
		for _, player in Players:GetPlayers() do
			self.Client.endEvent:Fire(player)
		end
	end)
end

function FallingStarsService:KnitInit()
	self._ds = Knit.GetService("DataService")
end

function FallingStarsService:KnitStart()
	task.spawn(function()
		while true do
			task.wait(EVENT_INTERVAL)
			self:_runEvent()
		end
	end)
	print("[FallingStarsService] Started")
end

return FallingStarsService
