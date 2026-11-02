local Anniversary = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local NotificationService = require(ServerScriptService.Services.NotificationService)
local LuckService = require(ServerScriptService.Services.LuckService)
local AnimalService = require(ServerScriptService.Services.AnimalService)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)

local FireworkBurst = Net:RemoteEvent("EventService/Anniversary/FireworkBurst")

local isActive = false
local currentMapInstance = nil
local spawnedObjects = {}
local fireworkTask = nil
local cleanupTask = nil

local AnniversaryAnimals = {
	{Name = "Sammy", Chance = 30},
	{Name = "DJ Sammy", Chance = 20},
	{Name = "Anniversary Sammy", Chance = 15},
	{Name = "Golden Sammy", Chance = 10},
	{Name = "Diamond Sammy", Chance = 8},
	{Name = "Rainbow Sammy", Chance = 5},
	{Name = "Divine Sammy", Chance = 3},
	{Name = "1 Year Sammy", Chance = 1},
}

local ANNIVERSARY_MAP = ReplicatedStorage.Models.Events["1 Year"].AnniversaryMap
local FIREWORKS_FOLDER = ReplicatedStorage.Models.Events["1 Year"].Fireworks

local function RollAnniversaryAnimal()
	local totalWeight = 0
	for _, animal in ipairs(AnniversaryAnimals) do
		totalWeight += animal.Chance
	end

	local roll = math.random(1, totalWeight)
	local currentWeight = 0

	for _, animal in ipairs(AnniversaryAnimals) do
		currentWeight += animal.Chance
		if roll <= currentWeight then
			return animal.Name
		end
	end
	return AnniversaryAnimals[1].Name
end

local function getAnimalData(animalName)
	for _, data in pairs(AnimalsData) do
		if data.DisplayName == animalName or data.Name == animalName then
			return data
		end
	end
	return nil
end

local function spawnAnniversaryMap()
	if not ANNIVERSARY_MAP then
		warn("[1 Year Event] AnniversaryMap not found in ReplicatedStorage")
		return nil
	end

	local mapClone = ANNIVERSARY_MAP:Clone()
	mapClone.Name = "AnniversaryMap"
	mapClone.Parent = workspace

	local spawnPosition = Vector3.new(0, 0, 0)
	if mapClone:FindFirstChild("SpawnPosition") then
		spawnPosition = mapClone.SpawnPosition.Position
	elseif mapClone:FindFirstChildWhichIsA("BasePart", true) then
		spawnPosition = mapClone:GetPivot().Position
	end

	mapClone:PivotTo(CFrame.new(spawnPosition))

	CollectionService:AddTag(mapClone, "AnniversaryEvent")

	return mapClone
end

local function startFireworks()
	fireworkTask = task.spawn(function()
		while isActive do
			task.wait(math.random(2, 5))

			if not isActive then break end

			local positions = {
				Vector3.new(-50, 50, -50),
				Vector3.new(50, 50, -50),
				Vector3.new(-50, 50, 50),
				Vector3.new(50, 50, 50),
				Vector3.new(0, 60, 0),
			}

			local randomPos = positions[math.random(1, #positions)]

			FireworkBurst:FireAllClients(randomPos)
		end
	end)
end

local function spawnAnniversaryAnimals()
	local count = math.random(3, 6)

	for _ = 1, count do
		task.spawn(function()
			local animalName = RollAnniversaryAnimal()
			local animalData = getAnimalData(animalName)

			if animalData then
				local success, err = pcall(function()
					AnimalService.spawnAnimalCustom(animalData, nil, nil, nil, nil, nil)
				end)

				if not success then
					warn("[1 Year Event] Failed to spawn", animalName .. ":", err)
				end
			else

				local randomAnimal = AnimalService.randomAnimal and AnimalService.randomAnimal()
				if randomAnimal then
					AnimalService.spawnAnimalCustom(randomAnimal, nil, nil, nil, nil, nil)
				end
			end
		end)
	end
end

local function startCleanupLoop()
	cleanupTask = task.spawn(function()
		while isActive do
			task.wait(5)

			local filtered = {}
			for _, obj in ipairs(spawnedObjects) do
				if obj and obj.Parent then
					table.insert(filtered, obj)
				end
			end
			spawnedObjects = filtered
		end
	end)
end

function Anniversary.OnStart()
	if isActive then
		return
	end

	isActive = true

	ReplicatedStorage:SetAttribute("AnniversaryEvent", true)
	ReplicatedStorage:SetAttribute("1YearEvent", true)

	LuckService:SetLuck(10)

	currentMapInstance = spawnAnniversaryMap()
	if currentMapInstance then
		table.insert(spawnedObjects, currentMapInstance)
	end

	startFireworks()

	startCleanupLoop()

	spawnAnniversaryAnimals()

	local GradientTag = "rainbow"
	for _, player in ipairs(Players:GetPlayers()) do
		NotificationService.Notify(
			player,
			"<font color='#FFD700'><b>🎉 1 YEAR ANNIVERSARY! 🎉</b></font>\n" ..
				string.format("<%s>%s</%s>", GradientTag, "10x Luck Active!", GradientTag) ..
				"\nSpecial anniversary animals are spawning!",
			8,
			"Sounds.Sfx.Success"
		)
	end
end

function Anniversary.OnStop()
	if not isActive then
		return
	end

	isActive = false

	ReplicatedStorage:SetAttribute("AnniversaryEvent", false)
	ReplicatedStorage:SetAttribute("1YearEvent", false)

	LuckService:SetLuck(4)

	if fireworkTask then
		task.cancel(fireworkTask)
		fireworkTask = nil
	end

	if cleanupTask then
		task.cancel(cleanupTask)
		cleanupTask = nil
	end

	for _, obj in ipairs(spawnedObjects) do
		if obj and obj.Parent then
			obj:Destroy()
		end
	end
	spawnedObjects = {}

	if currentMapInstance and currentMapInstance.Parent then
		currentMapInstance:Destroy()
	end
	currentMapInstance = nil

	local strayMap = workspace:FindFirstChild("AnniversaryMap")
	if strayMap then
		strayMap:Destroy()
	end
end

return Anniversary