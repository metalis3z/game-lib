local Skibidi = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/Skibidi/Burst")

local recentlyTargeted = {}
local hitboxes = {}
local sTask = nil
local startTime = nil
local isActive = false
local seedTask = nil
local baseSeed = nil

local function has(animalTemplate)
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
		if trait == "Skibidi" then
			return true
		end
	end

	return false
end

local function apply(animalTemplate)
	if not animalTemplate or not animalTemplate.Parent then
		return
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
		if trait == "Skibidi" then
			return
		end
	end

	table.insert(currentTraits, "Skibidi")
	animalTemplate:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
end

local function pick()
	local roadAnimals = CollectionService:GetTagged("Animal")
	local movingAnimalsFolder = workspace:FindFirstChild("MovingAnimals")
	local currentTime = workspace:GetServerTimeNow()

	for animalId, lastTime in pairs(recentlyTargeted) do
		if (currentTime - lastTime) > 45 then
			recentlyTargeted[animalId] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(roadAnimals) do
		if animal.Parent == movingAnimalsFolder and animal.PrimaryPart then
			local animalId = animal.Name
			if not recentlyTargeted[animalId]
				and not has(animal)
				and not hitboxes[animalId] then
				table.insert(candidates, animal)
			end
		end
	end

	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
end

local function delete(animalId)
	local hitboxPart = hitboxes[animalId]
	if hitboxPart then
		hitboxPart:Destroy()
		hitboxes[animalId] = nil
	end
end

local function hit(targetAnimal)
	if not targetAnimal or not targetAnimal.PrimaryPart then
		return
	end

	local animalId = targetAnimal.Name
	local animalPosition = targetAnimal.PrimaryPart.Position

	local hitboxPart = Instance.new("Part")
	hitboxPart.Name = "SkibidiHitbox_" .. animalId
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

		apply(targetAnimal)

		Burst:FireAllClients(animalId)

		task.wait(2)
		delete(animalId)
	end)
end

local function event()
	if sTask then
		task.cancel(sTask)
	end

	sTask = task.spawn(function()
		task.wait(5)

		while isActive do
			local currentTime = workspace:GetServerTimeNow()
			local eventRunTime = currentTime - startTime

			if eventRunTime >= 6 and eventRunTime <= 85 then
				task.wait(math.random(6, 12))
			elseif eventRunTime > 85 then
				task.wait(math.random(8, 12))
			else
				task.wait(1)
			end

			if not isActive then break end

			local targetAnimal = pick()
			if targetAnimal then
				hit(targetAnimal)
			end
		end
	end)
end

function Skibidi.OnStart()
	if isActive then return end

	isActive = true
	startTime = workspace:GetServerTimeNow()
	ReplicatedStorage:SetAttribute("SkibidiEvent", true)

	baseSeed = math.random(1, 1_000_000)
	ReplicatedStorage:SetAttribute("SkibidiEventSeed", baseSeed)

	if seedTask then
		task.cancel(seedTask)
	end

	seedTask = task.spawn(function()
		while isActive do
			task.wait(0.25)
			if not isActive then break end

			local tick5 = math.floor(workspace:GetServerTimeNow() / 5)
			ReplicatedStorage:SetAttribute(
				"SkibidiEventSeed",
				baseSeed + tick5
			)
		end
	end)

	event()
end

function Skibidi.OnStop()
	if not isActive then return end
	if seedTask then
		task.cancel(seedTask)
		seedTask = nil
	end

	isActive = false
	ReplicatedStorage:SetAttribute("SkibidiEvent", false)

	if sTask then
		task.cancel(sTask)
		sTask = nil
	end

	for _, part in pairs(hitboxes) do
		part:Destroy()
	end
	table.clear(hitboxes)
end

return Skibidi