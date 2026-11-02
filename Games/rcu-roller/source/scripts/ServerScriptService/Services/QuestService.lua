--[[ QuestService — Server-side quest progress tracking ]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
local Maps = require(ReplicatedStorage.Shared.List.Maps)

local QuestService = Knit.CreateService({
	Name = "QuestService",
	Client = {},
	_ds = nil,
})

function QuestService:IncrementQuest(player, questType, amount, subjectName)
	local data = self._ds:GetData(player)
	if not data then return end

	-- Determine which map the player is working toward
	local mapCount = 0
	for _ in data.maps do
		mapCount += 1
	end
	local nextMapId = mapCount + 1
	local mapDef = Maps[nextMapId]
	if not mapDef or not mapDef.quests then return end

	for i, quest in ipairs(mapDef.quests) do
		if quest.quest == questType then
			if quest.name and quest.name ~= subjectName then continue end

			local current = data.mapQuests[i] or 0
			if current >= quest.amount then continue end

			local newValue = math.min(current + amount, quest.amount)
			self._ds:Set(player, {"mapQuests", i}, newValue)
		end
	end
end

function QuestService:ResetQuests(player)
	self._ds:Set(player, {"mapQuests"}, {})
end

function QuestService:KnitInit()
	self._ds = Knit.GetService("DataService")
end

function QuestService:KnitStart()
end

return QuestService
