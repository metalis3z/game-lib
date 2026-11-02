local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Heartbeat = RunService.Heartbeat
local LocalPlayer = RunService:IsClient() and Players.LocalPlayer or nil

local Enums = require(script.Enum).enums
local Janitor = require(script.Janitor)
local Signal = require(script.Signal)
local ZonePlusReference = require(script.ZonePlusReference)
local ZoneController = require(script.ZoneController)
local Tracker = script.ZoneController.Tracker
local CollectiveWorldModel = script.ZoneController.CollectiveWorldModel

local referencedObject = ZonePlusReference.getObject()
local referenceName = RunService:IsClient() and "Client" or "Server"
local existingReference = referencedObject and referencedObject:FindFirstChild(referenceName)

if existingReference then
	return require(referencedObject.Value)
end

local Zone = {}
Zone.__index = Zone

if not existingReference then
	ZonePlusReference.addToReplicatedStorage()
end

Zone.enum = Enums

local REGION_CONSTRUCTORS = {
	Ball = function(part)
		return "GetPartBoundsInRadius", {part.Position, part.Size.X}
	end,
	Block = function(part)
		return "GetPartBoundsInBox", {part.CFrame, part.Size}
	end,
	Other = function(part)
		return "GetPartsInPart", {part}
	end
}

function Zone.new(container)
	local self = setmetatable({}, Zone)

	local containerType = typeof(container)
	if containerType ~= "table" and containerType ~= "Instance" then
		error("The zone container must be a model, folder, basepart or table!")
	end

	self.accuracy = Enums.Accuracy.High
	self.autoUpdate = true
	self.respectUpdateQueue = true

	local janitor = Janitor.new()
	self.janitor = janitor
	self._updateConnections = janitor:add(Janitor.new(), "destroy")

	self.container = container
	self.zoneParts = {}
	self.overlapParams = {}
	self.region = nil
	self.volume = nil
	self.boundMin = nil
	self.boundMax = nil
	self.recommendedMaxParts = nil
	self.zoneId = HttpService:GenerateGUID()
	self.activeTriggers = {}
	self.occupants = {}
	self.trackingTouchedTriggers = {}
	self.enterDetection = Enums.Detection.Centre
	self.exitDetection = Enums.Detection.Centre
	self._currentEnterDetection = nil
	self._currentExitDetection = nil
	self.totalPartVolume = 0
	self.allZonePartsAreBlocks = true
	self.trackedItems = {}
	self.settingsGroupName = nil
	self.worldModel = workspace
	self.onItemDetails = {}
	self.itemsToUntrack = {}

	ZoneController.updateDetection(self)
	self.updated = janitor:add(Signal.new(), "destroy")

	local triggerTypes = {"player", "part", "localPlayer", "item"}
	local eventTypes = {"entered", "exited"}

	for _, triggerType in pairs(triggerTypes) do
		local prevConnections = 0
		local currentConnections = 0

		for _, eventType in pairs(eventTypes) do
			local signal = janitor:add(Signal.new(true), "destroy")
			local eventName = eventType:sub(1, 1):upper() .. eventType:sub(2)
			self[triggerType .. eventName] = signal

			signal.connectionsChanged:Connect(function(change)
				if triggerType == "localPlayer" and not LocalPlayer and change == 1 then
					error(("Can only connect to 'localPlayer%s' on the client!"):format(eventName))
				end

				prevConnections = currentConnections
				currentConnections = currentConnections + change

				if prevConnections == 0 and currentConnections > 0 then
					ZoneController._registerConnection(self, triggerType, eventName)
				elseif prevConnections > 0 and currentConnections == 0 then
					ZoneController._deregisterConnection(self, triggerType)
				end
			end)
		end
	end

	Zone.touchedConnectionActions = {}
	for _, triggerType in pairs(triggerTypes) do
		local touchedMethod = self[("_%sTouchedZone"):format(triggerType)]
		if touchedMethod then
			self.trackingTouchedTriggers[triggerType] = {}
			Zone.touchedConnectionActions[triggerType] = function(part)
				touchedMethod(self, part)
			end
		end
	end

	self:_update()
	ZoneController._registerZone(self)

	janitor:add(function()
		ZoneController._deregisterZone(self)
	end, true)

	return self
end

function Zone.fromRegion(cframe, size)
	local model = Instance.new("Model")

	local function createParts(cf, sz)
		if sz.X > 2024 or sz.Y > 2024 or sz.Z > 2024 then
			local quarterSize = sz * 0.25
			local halfSize = sz * 0.5

			createParts(cf * CFrame.new(-quarterSize.X, -quarterSize.Y, -quarterSize.Z), halfSize)
			createParts(cf * CFrame.new(-quarterSize.X, -quarterSize.Y, quarterSize.Z), halfSize)
			createParts(cf * CFrame.new(-quarterSize.X, quarterSize.Y, -quarterSize.Z), halfSize)
			createParts(cf * CFrame.new(-quarterSize.X, quarterSize.Y, quarterSize.Z), halfSize)
			createParts(cf * CFrame.new(quarterSize.X, -quarterSize.Y, -quarterSize.Z), halfSize)
			createParts(cf * CFrame.new(quarterSize.X, -quarterSize.Y, quarterSize.Z), halfSize)
			createParts(cf * CFrame.new(quarterSize.X, quarterSize.Y, -quarterSize.Z), halfSize)
			createParts(cf * CFrame.new(quarterSize.X, quarterSize.Y, quarterSize.Z), halfSize)
		else
			local part = Instance.new("Part")
			part.CFrame = cf
			part.Size = sz
			part.Anchored = true
			part.Parent = model
		end
	end

	createParts(cframe, size)

	local zone = Zone.new(model)
	zone:relocate()
	return zone
end

function Zone:_calculateRegion(parts, exact)
	local bounds = {
		Min = {Values = {}, Type = "Min"},
		Max = {Values = {}, Type = "Max"}
	}

	local function parseCheck(boundType, val1, val2)
		if boundType == "Min" then
			return val1 <= val2
		elseif boundType == "Max" then
			return val2 <= val1
		end
	end

	local function parse(bound, values)
		for i, value in pairs(values) do
			local current = bound.Values[i] or value
			if parseCheck(bound.Type, value, current) then
				bound.Values[i] = value
			end
		end
	end

	for _, part in pairs(parts) do
		local halfSize = part.Size * 0.5
		local corners = {
			part.CFrame * CFrame.new(-halfSize.X, -halfSize.Y, -halfSize.Z),
			part.CFrame * CFrame.new(-halfSize.X, -halfSize.Y, halfSize.Z),
			part.CFrame * CFrame.new(-halfSize.X, halfSize.Y, -halfSize.Z),
			part.CFrame * CFrame.new(-halfSize.X, halfSize.Y, halfSize.Z),
			part.CFrame * CFrame.new(halfSize.X, -halfSize.Y, -halfSize.Z),
			part.CFrame * CFrame.new(halfSize.X, -halfSize.Y, halfSize.Z),
			part.CFrame * CFrame.new(halfSize.X, halfSize.Y, -halfSize.Z),
			part.CFrame * CFrame.new(halfSize.X, halfSize.Y, halfSize.Z)
		}

		for _, corner in pairs(corners) do
			local x, y, z = corner:GetComponents()
			parse(bounds.Min, {x, y, z})
			parse(bounds.Max, {x, y, z})
		end
	end

	local minValues = {}
	local maxValues = {}

	for boundType, bound in pairs(bounds) do
		for _, value in pairs(bound.Values) do
			local target = boundType == "Min" and minValues or maxValues
			if not exact then
				local adjusted = (value + (boundType == "Min" and -2 or 2) + 2) / 4
				value = math.floor(adjusted) * 4
			end
			table.insert(target, value)
		end
	end

	local minVector = Vector3.new(unpack(minValues))
	local maxVector = Vector3.new(unpack(maxValues))

	return Region3.new(minVector, maxVector), minVector, maxVector
end

function Zone:_update()
	local container = self.container
	local parts = {}
	local updateQueue = 0

	self._updateConnections:clean()

	local containerType = typeof(container)
	local containers = {}

	if containerType == "table" then
		for _, item in pairs(container) do
			if item:IsA("BasePart") then
				table.insert(parts, item)
			end
		end
	elseif containerType == "Instance" then
		if container:IsA("BasePart") then
			table.insert(parts, container)
		else
			table.insert(containers, container)
			for _, descendant in pairs(container:GetDescendants()) do
				if descendant:IsA("BasePart") then
					table.insert(parts, descendant)
				else
					table.insert(containers, descendant)
				end
			end
		end
	end

	self.zoneParts = parts
	self.overlapParams = {}

	local allBlocks = true
	for _, part in pairs(parts) do
		local success, shapeName = pcall(function()
			return part.Shape.Name
		end)
		if shapeName ~= "Block" then
			allBlocks = false
		end
	end
	self.allZonePartsAreBlocks = allBlocks

	local whitelistParams = OverlapParams.new()
	whitelistParams.FilterType = Enum.RaycastFilterType.Whitelist
	whitelistParams.MaxParts = #parts
	whitelistParams.FilterDescendantsInstances = parts
	self.overlapParams.zonePartsWhitelist = whitelistParams

	local ignorelistParams = OverlapParams.new()
	ignorelistParams.FilterType = Enum.RaycastFilterType.Blacklist
	ignorelistParams.FilterDescendantsInstances = parts
	self.overlapParams.zonePartsIgnorelist = ignorelistParams

	local function scheduleUpdate()
		if self.autoUpdate then
			local updateTime = os.clock()
			if self.respectUpdateQueue then
				updateQueue = updateQueue + 1
				updateTime = updateTime + 0.1
			end

			local connection
			connection = Heartbeat:Connect(function()
				if updateTime <= os.clock() then
					connection:Disconnect()
					if self.respectUpdateQueue then
						updateQueue = updateQueue - 1
					end
					if updateQueue == 0 and self.zoneId then
						self:_update()
					end
				end
			end)
		end
	end

	local properties = {"Size", "Position"}
	for _, part in pairs(parts) do
		for _, property in pairs(properties) do
			self._updateConnections:add(part:GetPropertyChangedSignal(property):Connect(scheduleUpdate), "Disconnect")
		end

		if part.CollisionGroupId ~= 0 then
			error("Zone parts must belong to the 'Default' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
		end

		self._updateConnections:add(part:GetPropertyChangedSignal("CollisionGroupId"):Connect(function()
			if part.CollisionGroupId ~= 0 then
				error("Zone parts must belong to the 'Default' (0) CollisionGroup!")
			end
		end), "Disconnect")
	end

	local childEvents = {"ChildAdded", "ChildRemoved"}
	for _, container in pairs(containers) do
		for _, event in pairs(childEvents) do
			self._updateConnections:add(self.container[event]:Connect(function(child)
				if child:IsA("BasePart") and self.autoUpdate then
					local updateTime = os.clock()
					if self.respectUpdateQueue then
						updateQueue = updateQueue + 1
						updateTime = updateTime + 0.1
					end

					local connection
					connection = Heartbeat:Connect(function()
						if updateTime <= os.clock() then
							connection:Disconnect()
							if self.respectUpdateQueue then
								updateQueue = updateQueue - 1
							end
							if updateQueue == 0 and self.zoneId then
								self:_update()
							end
						end
					end)
				end
			end), "Disconnect")
		end
	end

	local region, minBound, maxBound = self:_calculateRegion(parts)
	local exactRegion = self:_calculateRegion(parts, true)

	self.region = region
	self.exactRegion = exactRegion
	self.boundMin = minBound
	self.boundMax = maxBound

	local regionSize = region.Size
	self.volume = regionSize.X * regionSize.Y * regionSize.Z

	self:_updateTouchedConnections()
	self.updated:Fire()
end

function Zone:_updateOccupants(triggerType, newOccupants)
	local currentOccupants = self.occupants[triggerType]
	if not currentOccupants then
		currentOccupants = {}
		self.occupants[triggerType] = currentOccupants
	end

	local changes = {}

	for occupant, data in pairs(currentOccupants) do
		local newData = newOccupants[occupant]
		if newData == nil or newData ~= data then
			currentOccupants[occupant] = nil
			if not changes.exited then
				changes.exited = {}
			end
			table.insert(changes.exited, occupant)
		end
	end

	for occupant, _ in pairs(newOccupants) do
		if currentOccupants[occupant] == nil then
			currentOccupants[occupant] = occupant:IsA("Player") and (occupant.Character or true) or true
			if not changes.entered then
				changes.entered = {}
			end
			table.insert(changes.entered, occupant)
		end
	end

	return changes
end

function Zone:_formTouchedConnection(triggerType)
	local janitorKey = "_touchedJanitor" .. triggerType
	local existingJanitor = self[janitorKey]

	if existingJanitor then
		existingJanitor:clean()
	else
		self[janitorKey] = self.janitor:add(Janitor.new(), "destroy")
	end

	self:_updateTouchedConnection(triggerType)
end

function Zone:_updateTouchedConnection(triggerType)
	local janitor = self["_touchedJanitor" .. triggerType]
	if janitor then
		for _, part in pairs(self.zoneParts) do
			janitor:add(part.Touched:Connect(self.touchedConnectionActions[triggerType], self), "Disconnect")
		end
	end
end

function Zone:_updateTouchedConnections()
	for triggerType, _ in pairs(self.touchedConnectionActions) do
		local janitor = self["_touchedJanitor" .. triggerType]
		if janitor then
			janitor:cleanup()
			self:_updateTouchedConnection(triggerType)
		end
	end
end

function Zone:_disconnectTouchedConnection(triggerType)
	local janitorKey = "_touchedJanitor" .. triggerType
	local janitor = self[janitorKey]
	if janitor then
		janitor:cleanup()
		self[janitorKey] = nil
	end
end

function Zone:_getRegionConstructor(part, overlapParams)
	local success, shapeName = pcall(function()
		return part.Shape.Name
	end)

	local methodName, args

	if success and self.allZonePartsAreBlocks then
		local constructor = REGION_CONSTRUCTORS[shapeName]
		if constructor then
			methodName, args = constructor(part)
		end
	end

	if not methodName then
		methodName, args = REGION_CONSTRUCTORS.Other(part)
	end

	if overlapParams then
		table.insert(args, overlapParams)
	end

	return methodName, args
end

function Zone:findLocalPlayer()
	if not LocalPlayer then
		error("Can only call 'findLocalPlayer' on the client!")
	end
	return self:findPlayer(LocalPlayer)
end

function Zone:_find(trackerType, item)
	ZoneController.updateDetection(self)
	local tracker = ZoneController.trackers[trackerType]
	local zones = ZoneController.getTouchingZones(item, false, self._currentEnterDetection, tracker)

	for _, zone in pairs(zones) do
		if zone == self then
			return true
		end
	end

	return false
end

function Zone:findPlayer(player)
	local character = player.Character
	if character then
		character = character:FindFirstChildOfClass("Humanoid")
	end

	if character then
		return self:_find("player", player.Character)
	else
		return false
	end
end

function Zone:findItem(item)
	return self:_find("item", item)
end

function Zone:findPart(part)
	local methodName, args = self:_getRegionConstructor(part, self.overlapParams.zonePartsWhitelist)
	local results = self.worldModel[methodName](self.worldModel, unpack(args))

	if #results > 0 then
		return true, results
	else
		return false
	end
end

function Zone:getCheckerPart()
	local checkerPart = self.checkerPart

	if not checkerPart then
		checkerPart = self.janitor:add(Instance.new("Part"), "Destroy")
		checkerPart.Size = Vector3.new(0.1, 0.1, 0.1)
		checkerPart.Name = "ZonePlusCheckerPart"
		checkerPart.Anchored = true
		checkerPart.Transparency = 1
		checkerPart.CanCollide = false
		self.checkerPart = checkerPart
	end

	local worldModel = self.worldModel
	if worldModel == workspace then
		worldModel = ZoneController.getWorkspaceContainer()
	end

	if checkerPart.Parent ~= worldModel then
		checkerPart.Parent = worldModel
	end

	return checkerPart
end

function Zone:findPoint(position)
	if typeof(position) == "Vector3" then
		position = CFrame.new(position)
	end

	local checkerPart = self:getCheckerPart()
	checkerPart.CFrame = position

	local methodName, args = self:_getRegionConstructor(checkerPart, self.overlapParams.zonePartsWhitelist)
	local results = self.worldModel[methodName](self.worldModel, unpack(args))

	if #results > 0 then
		return true, results
	else
		return false
	end
end

function Zone:_getAll(trackerType)
	ZoneController.updateDetection(self)
	local results = {}
	local items = ZoneController._getZonesAndItems(trackerType, {self = true}, self.volume, false, self._currentEnterDetection)[self]

	if items then
		for item, _ in pairs(items) do
			table.insert(results, item)
		end
	end

	return results
end

function Zone:getPlayers()
	return self:_getAll("player")
end

function Zone:getItems()
	return self:_getAll("item")
end

function Zone:getParts()
	local parts = {}

	if self.activeTriggers.part then
		local tracked = self.trackingTouchedTriggers.part
		for part, _ in pairs(tracked) do
			table.insert(parts, part)
		end
		return parts
	else
		local allParts = self.worldModel:GetPartBoundsInBox(
			self.region.CFrame,
			self.region.Size,
			self.overlapParams.zonePartsIgnorelist
		)

		for _, part in pairs(allParts) do
			if self:findPart(part) then
				table.insert(parts, part)
			end
		end

		return parts
	end
end

function Zone:getRandomPoint()
	local region = self.exactRegion
	local size = region.Size
	local cframe = region.CFrame
	local random = Random.new()
	local foundPoint

	repeat
		local randomCFrame = cframe * CFrame.new(
			random:NextNumber(-size.X / 2, size.X / 2),
			random:NextNumber(-size.Y / 2, size.Y / 2),
			random:NextNumber(-size.Z / 2, size.Z / 2)
		)

		local isInZone, parts = self:findPoint(randomCFrame)
		foundPoint = isInZone and true or foundPoint
	until foundPoint

	return randomCFrame.Position, parts
end

function Zone:setAccuracy(accuracy)
	local accuracyId = tonumber(accuracy)

	if accuracyId then
		if not Enums.Accuracy.getName(accuracyId) then
			error(("%s is an invalid enumId!"):format(accuracyId))
		end
	else
		accuracyId = Enums.Accuracy[accuracy]
		if not accuracyId then
			error(("'%s' is an invalid enumName!"):format(accuracy))
		end
	end

	self.accuracy = accuracyId
end

function Zone:setDetection(detection)
	local detectionId = tonumber(detection)

	if detectionId then
		if not Enums.Detection.getName(detectionId) then
			error(("%s is an invalid enumId!"):format(detectionId))
		end
	else
		detectionId = Enums.Detection[detection]
		if not detectionId then
			error(("'%s' is an invalid enumName!"):format(detection))
		end
	end

	self.enterDetection = detectionId
	self.exitDetection = detectionId
end

function Zone:trackItem(item)
	local isBasePart = item:IsA("BasePart")
	local isCharacter = not isBasePart and item:FindFirstChildOfClass("Humanoid") and item:FindFirstChild("HumanoidRootPart")

	assert(isBasePart or isCharacter, "Only BaseParts or Characters/NPCs can be tracked!")

	if not self.trackedItems[item] then
		if self.itemsToUntrack[item] then
			self.itemsToUntrack[item] = nil
		end

		local janitor = self.janitor:add(Janitor.new(), "destroy")
		local itemData = {
			janitor = janitor,
			item = item,
			isBasePart = isBasePart,
			isCharacter = isCharacter
		}

		self.trackedItems[item] = itemData

		janitor:add(item.AncestryChanged:Connect(function()
			if not item:IsDescendantOf(game) then
				self:untrackItem(item)
			end
		end), "Disconnect")

		require(Tracker).itemAdded:Fire(itemData)
	end
end

function Zone:untrackItem(item)
	local itemData = self.trackedItems[item]
	if itemData then
		itemData.janitor:destroy()
	end

	self.trackedItems[item] = nil
	require(Tracker).itemRemoved:Fire(itemData)
end

function Zone:bindToGroup(groupName)
	self:unbindFromGroup()
	local group = ZoneController.getGroup(groupName) or ZoneController.setGroup(groupName)
	group._memberZones[self.zoneId] = self
	self.settingsGroupName = groupName
end

function Zone:unbindFromGroup()
	if self.settingsGroupName then
		local group = ZoneController.getGroup(self.settingsGroupName)
		if group then
			group._memberZones[self.zoneId] = nil
		end
		self.settingsGroupName = nil
	end
end

function Zone:relocate()
	if not self.hasRelocated then
		local worldModel = require(CollectiveWorldModel).setupWorldModel(self)
		self.worldModel = worldModel
		self.hasRelocated = true

		local container = self.container
		if typeof(container) == "table" then
			container = Instance.new("Folder")
			for _, part in pairs(self.zoneParts) do
				part.Parent = container
			end
		end

		self.relocationContainer = self.janitor:add(container, "Destroy", "RelocationContainer")
		container.Parent = worldModel
	end
end

function Zone:_onItemCallback(eventName, shouldBeInZone, item, callback)
	local details = self.onItemDetails[item]
	if not details then
		details = {}
		self.onItemDetails[item] = details
	end

	if #details == 0 then
		self.itemsToUntrack[item] = true
	end

	table.insert(details, item)
	self:trackItem(item)

	if self:findItem(item) == shouldBeInZone then
		callback()
		if self.itemsToUntrack[item] then
			self.itemsToUntrack[item] = nil
			self:untrackItem(item)
			return
		end
	else
		local connection
		connection = self[eventName]:Connect(function(triggeredItem)
			if connection and triggeredItem == item then
				connection:Disconnect()
				connection = nil
				callback()
				if self.itemsToUntrack[item] then
					self.itemsToUntrack[item] = nil
					self:untrackItem(item)
				end
			end
		end)
	end
end

function Zone:onItemEnter(item, callback)
	self:_onItemCallback("itemEntered", true, item, callback)
end

function Zone:onItemExit(item, callback)
	self:_onItemCallback("itemExited", false, item, callback)
end

function Zone:destroy()
	self:unbindFromGroup()
	self.janitor:destroy()
end

Zone.Destroy = Zone.destroy

return Zone