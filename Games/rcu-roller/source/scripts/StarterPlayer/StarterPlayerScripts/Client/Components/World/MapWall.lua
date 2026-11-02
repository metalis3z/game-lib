--[[ MapWall Component
     Handles the NextMap barrier interaction.
     Each wall has attribute "mapId" = the map ID you unlock by touching it.
     Shows quest progress from data.mapQuests on SurfaceGui.
     When all quests completed, shows "Touch to Unlock!"
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Knit = require(ReplicatedStorage.Packages.Knit)

local MapWall = require(Knit.Util.Component).new({
	Tag = "MapWall";
})

local DataController
local MapController
local UIController
local SoundController
local MapService
local Maps
local Quests
local Functions

function MapWall.updateGui(self)
	local mapId = self.Instance:GetAttribute("mapId")
	if not mapId then return end

	local data = DataController:getData()
	if not data then return end

	local gui = self.Instance:FindFirstChild("UnlockGui")
	if not gui then return end

	local mainFrame = gui:FindFirstChild("Main")
	local unlockedLabel = gui:FindFirstChild("Unlocked")
	if not mainFrame or not unlockedLabel then return end

	-- Check if already unlocked
	if data.maps and data.maps[mapId] then
		gui.Enabled = false
		self.Instance.CanCollide = false
		self.Instance.Transparency = 1
		return
	end

	-- Map is locked → ensure wall is visible
	gui.Enabled = true
	self.Instance.CanCollide = true
	self.Instance.Transparency = 0

	local mapDef = Maps[mapId]
	if not mapDef or not mapDef.quests then
		gui.Enabled = false
		return
	end

	-- Update world info
	local worldInfo = mainFrame:FindFirstChild("WorldInfo")
	if worldInfo then
		local worldName = worldInfo:FindFirstChild("WorldName")
		if worldName then
			worldName.Text = mapDef.name
		end
		local icon1 = worldInfo:FindFirstChild("Icon1")
		local icon2 = worldInfo:FindFirstChild("Icon2")
		if icon1 then icon1.Image = mapDef.icon or "" end
		if icon2 then icon2.Image = mapDef.icon or "" end
	end

	-- Update quest progress
	local questGrid = mainFrame:FindFirstChild("QuestGrid")
	if not questGrid then return end

	-- Dynamically create missing quest frames by cloning from frame "1"
	local templateFrame = questGrid:FindFirstChild("1")
	if templateFrame then
		for i = 2, #mapDef.quests do
			local name = tostring(i)
			if not questGrid:FindFirstChild(name) then
				local clone = templateFrame:Clone()
				clone.Name = name
				clone.Parent = questGrid
			end
		end
	end

	local allComplete = true
	for i, quest in ipairs(mapDef.quests) do
		local current = (data.mapQuests and data.mapQuests[i]) or 0
		local required = quest.amount
		local isComplete = current >= required

		if not isComplete then
			allComplete = false
		end

		local questFrame = questGrid:FindFirstChild(tostring(i))
		if questFrame then
			local questName = questFrame:FindFirstChild("QuestName")
			if questName then
				local template = Quests[quest.quest] or quest.quest
				local text = template:gsub("%$a", Functions.suffixes(required))
				text = text:gsub("%$s", quest.name or "")
				questName.Text = text
			end

			local progress = questFrame:FindFirstChild("Progress")
			if progress then
				local percentage = progress:FindFirstChild("Percentage")
				if percentage then
					percentage.Text = Functions.suffixes(current) .. "/" .. Functions.suffixes(required)
				end

				local bar = progress:FindFirstChild("Bar")
				if bar then
					local pct = math.clamp(current / required, 0, 1)
					bar.Size = UDim2.new(pct, 0, 1, 0)
					bar.Visible = true
				end
			end
		end
	end

	-- Toggle main/unlocked views
	mainFrame.Visible = not allComplete
	unlockedLabel.Visible = allComplete
	self._allComplete = allComplete
end

function MapWall.onTouched(self)
	if self._debounce then return end
	if not self._allComplete then return end

	local mapId = self.Instance:GetAttribute("mapId")
	if not mapId then return end

	self._debounce = true

	MapService:unlockMap(mapId):andThen(function(result)
		if result == "success" then
			MapController:unlockAnimation(self.Instance, mapId)
			MapController:setCurrentMap(mapId)
		else
			UIController:createNotification("Warning", "Could not unlock map: " .. tostring(result), 3)
			self._debounce = false
		end
	end):catch(function(err)
		warn("[MapWall] unlockMap error:", err)
		UIController:createNotification("Warning", "Error unlocking map.", 3)
		self._debounce = false
	end)
end

function MapWall.Start(self)
	task.spawn(function()
		DataController:waitForData()
		self:updateGui()

		DataController.replica:OnSet({"mapQuests"}, function()
			self:updateGui()
		end)

		DataController.replica:OnSet({"maps"}, function()
			self:updateGui()
		end)
	end)

	self.Instance.Touched:Connect(function(hit)
		local player = Players:GetPlayerFromCharacter(hit.Parent)
		if player == Players.LocalPlayer then
			self:onTouched()
		end
	end)
end

function MapWall.Stop(self)
end

function MapWall.Construct(self)
	DataController = Knit.GetController("DataController")
	MapController = Knit.GetController("MapController")
	UIController = Knit.GetController("UIController")
	SoundController = Knit.GetController("SoundController")
	MapService = Knit.GetService("MapService")
	Maps = require(ReplicatedStorage.Shared.List.Maps)
	Quests = require(ReplicatedStorage.Shared.List.Quests)
	Functions = require(ReplicatedStorage.Shared.Functions)
	self._allComplete = false
	self._debounce = false
end

return MapWall
