local RS = game:GetService("ReplicatedStorage")
local Knit = require(RS.Packages.Knit)

local BuildingService = Knit.CreateService({
	Name = "BuildingService",
	Client = {},
	_ds = nil,
})

function BuildingService.Client:build(player, buildingId)
	if type(buildingId) ~= "string" then return "invalid" end
	local data = self.Server._ds:GetData(player)
	if not data then return "noData" end
	if data.clanBuildings and data.clanBuildings[buildingId] then return "alreadyBuilt" end
	self.Server._ds:Set(player, {"clanBuildings", buildingId}, true)
	local QuestService = Knit.GetService("QuestService")
	QuestService:IncrementQuest(player, "building", 1, buildingId)
	return "success"
end

function BuildingService:KnitInit()
	self._ds = Knit.GetService("DataService")
end

function BuildingService:KnitStart()
	print("[BuildingService] Started")
end

return BuildingService