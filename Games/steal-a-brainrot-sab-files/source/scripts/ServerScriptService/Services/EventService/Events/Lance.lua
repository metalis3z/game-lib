local Lance = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")

local Net = require(ReplicatedStorage.Packages.Net)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local Burst = Net:RemoteEvent("EventService/Lance/Burst") 

local recentlyTargeted = {}
local hitboxes = {}
local sTask = nil
local startTime = nil
local isActive = false

local function hasRose(animalTemplate)
	if not animalTemplate or not animalTemplate.Parent then
		return false
	end

	local currentTraitsJson = animalTemplate:GetAttribute("Traits")
	local currentTraits = {}
	if currentTraitsJson then
		local success, decoded = pcall(function()
			return HttpService:JSONDecode(currentTraitsJson)
		end)
		if success and type(decoded) == "table" then
			currentTraits = decoded
		end
	end

	for _, trait in ipairs(currentTraits) do
		if trait == "Rose" then
			return true
		end
	end

	return false
end

local function pickTarget()
	local roadAnimals = CollectionService:GetTagged("Animal")
	local currentTime = workspace:GetServerTimeNow()

	for animalId, lastTime in pairs(recentlyTargeted) do
		if (currentTime - lastTime) > 20 then
			recentlyTargeted[animalId] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(roadAnimals) do
		if animal.PrimaryPart and not recentlyTargeted[animal.Name] and not hasRose(animal) then
			table.insert(candidates, animal)
		end
	end

	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
end

local function applyRose(animalTemplate)
	if not animalTemplate or not animalTemplate.Parent then return end

	local currentTraitsJson = animalTemplate:GetAttribute("Traits")
	local currentTraits = {}

	if currentTraitsJson then
		local success, decoded = pcall(function()
			return HttpService:JSONDecode(currentTraitsJson)
		end)
		if success and type(decoded) == "table" then
			currentTraits = decoded
		end
	end

	for _, trait in ipairs(currentTraits) do
		if trait == "Rose" then return end
	end

	table.insert(currentTraits, "Rose")
	animalTemplate:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
end

local function deleteHitbox(animalId)
	if hitboxes[animalId] then
		hitboxes[animalId]:Destroy()
		hitboxes[animalId] = nil
	end
end

local function hit(targetAnimal)
	if not targetAnimal or not targetAnimal.PrimaryPart then return end

	if not SharedEventUtils.isPointInCarpet(targetAnimal.PrimaryPart.Position) then
		return
	end

	local animalId = targetAnimal.Name
	local animalPosition = targetAnimal.PrimaryPart.Position

	local hitboxPart = Instance.new("Part")
	hitboxPart.Name = "LanceHitbox_" .. animalId
	hitboxPart.Size = Vector3.new(1, 1, 1)
	hitboxPart.Transparency = 1
	hitboxPart.Anchored = true
	hitboxPart.CanCollide = false
	hitboxPart.CFrame = CFrame.new(animalPosition.X, animalPosition.Y + 9, animalPosition.Z)
	hitboxPart.Parent = workspace

	hitboxes[animalId] = hitboxPart
	recentlyTargeted[animalId] = workspace:GetServerTimeNow()

	task.spawn(function()
		local focusTime = workspace:GetServerTimeNow() + 1
		hitboxPart:SetAttribute("Focused", focusTime)

		applyRose(targetAnimal)
		Burst:FireAllClients(animalId)

		task.wait(2)
		deleteHitbox(animalId)
	end)
end

local function startEventLoop()
	if sTask then task.cancel(sTask) end

	sTask = task.spawn(function()
		task.wait(5)

		while isActive do
			task.wait(math.random(4, 7))

			local targetAnimal = pickTarget()
			if targetAnimal then
				hit(targetAnimal)
			end
		end
	end)
end

function Lance.OnStart(data)
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("LanceEvent", true)
	local startTime = data.startedAt
	local now = workspace:GetServerTimeNow()
	local attributeDelay = (startTime + 5) - now
	task.delay(math.max(0, attributeDelay), function()
		if not isActive then return end
		startEventLoop()
	end)
end

function Lance.OnStop()
	if not isActive then return end
	isActive = false

	if sTask then
		task.cancel(sTask)
		sTask = nil
	end

	for animalId, hitboxPart in pairs(hitboxes) do
		if hitboxPart then hitboxPart:Destroy() end
	end
	hitboxes = {}
	ReplicatedStorage:SetAttribute("LanceEvent", false)
end

return Lance