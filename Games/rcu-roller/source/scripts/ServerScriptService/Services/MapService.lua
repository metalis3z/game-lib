local RS = game:GetService("ReplicatedStorage")
local Knit = require(RS.Packages.Knit)
local Rebirths = require(RS.Shared.List.Rebirths)

local MAP_REQUIREMENTS = {
	[2] = 5,
	[3] = 25,
	[4] = 100,
	[5] = 500,
	[6] = 2500,
	[7] = 10000,
}

local MapService = Knit.CreateService({
	Name = "MapService",
	Client = {},
	_ds = nil,
})

function MapService.Client:unlockMap(player, mapId)
	if type(mapId) ~= "number" then return "invalid" end
	local required = MAP_REQUIREMENTS[mapId]
	if not required then return "invalid" end
	local data = self.Server._ds:GetData(player)
	if not data then return "noData" end
	if data.maps and data.maps[mapId] then return "alreadyUnlocked" end
	if (data.rebirths or 0) < required then return "notEnoughRebirths" end
	self.Server._ds:Set(player, {"maps", mapId}, true)
	-- Reset quests for new map progression
	local QuestService = Knit.GetService("QuestService")
	QuestService:ResetQuests(player)
	return "success"
end

function MapService:KnitInit()
	self._ds = Knit.GetService("DataService")
end

function MapService:KnitStart()
	print("[MapService] Started")
end

return MapService