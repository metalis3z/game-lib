local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local Workspace = game:GetService("Workspace")

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)
local Synchronizer = require(Packages.Synchronizer)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)


local Animals = require(ReplicatedStorage.Datas.Animals)

local ConcertEvent = {}

local _eventService
local _synchronizer
local _concertSynchronizer
local _isActive = false
local _shootRemote = Net:RemoteEvent("EventService/Concert/Shoot")
local _recentlyTargeted = {}
local _shootTask = nil


local function hasDiscoTrait(animal)
	if not animal or not animal.Parent then return false end
	local traitsJson = animal:GetAttribute("Traits")
	if not traitsJson then return false end

	local success, decoded = pcall(function()
		return HttpService:JSONDecode(traitsJson)
	end)

	if not success or type(decoded) ~= "table" then return false end
	for _, trait in ipairs(decoded) do
		if trait == "Disco" then return true end
	end
	return false
end

local function applyDiscoTrait(animal)
	if not animal or not animal.Parent then
		return
	end

	local traitsJson = animal:GetAttribute("Traits")
	local traits = {}

	if traitsJson then
		local success, decoded = pcall(function()
			return HttpService:JSONDecode(traitsJson)
		end)
		if success and type(decoded) == "table" then
			traits = decoded
		end
	end

	for _, trait in ipairs(traits) do
		if trait == "Disco" then
			return
		end
	end

	table.insert(traits, "Disco")
	local encoded = HttpService:JSONEncode(traits)
	animal:SetAttribute("Traits", encoded)
end

local function handleAnimalHit(player, rigIndex, animalName, hitTime)
	if not _isActive then
		return
	end

	local targetAnimal = Workspace:FindFirstChild(animalName, true)

	if targetAnimal then
		applyDiscoTrait(targetAnimal)
	end
end

local function pickTargetAnimal()
	
	local roadAnimals = CollectionService:GetTagged("Animal")

	local currentTime = Workspace:GetServerTimeNow()
	for animalName, lastTime in pairs(_recentlyTargeted) do
		if (currentTime - lastTime) > 10 then
			_recentlyTargeted[animalName] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(roadAnimals) do
		if animal.PrimaryPart then
			if not _recentlyTargeted[animal.Name] and not hasDiscoTrait(animal) then
				table.insert(candidates, animal)
			end
		end
	end

	if #candidates == 0 then
		return nil
	end

	return candidates[math.random(1, #candidates)]
end

local function startShootingLoop()
	if not _isActive then
		return
	end
	if _shootTask then
		task.cancel(_shootTask)
	end

	_shootTask = task.spawn(function()
		if not _isActive then
			return
		end
		while _isActive do
			local waitTime = math.random(4, 7)
			task.wait(waitTime)

			if not _isActive then break end

			local targetAnimal = pickTargetAnimal()

			if targetAnimal then
				if not targetAnimal.PrimaryPart or not SharedEventUtils.isPointInCarpet(targetAnimal.PrimaryPart.Position) then
					continue
				end

				local rigIndex = math.random(1, 3)
				local currentTime = Workspace:GetServerTimeNow()

				_shootRemote:FireAllClients(rigIndex, targetAnimal.Name, currentTime + 3)

				_recentlyTargeted[targetAnimal.Name] = currentTime
			end
		end
	end)
end
local function ensureInitialized()
	if _concertSynchronizer then return end

	_concertSynchronizer = Synchronizer:Create("ConcertEvent", { IsActive = false })

	for _, player in pairs(Players:GetPlayers()) do
		_concertSynchronizer:AddListener(player)
	end

	Players.PlayerAdded:Connect(function(player)
		_concertSynchronizer:AddListener(player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		_concertSynchronizer:RemoveListener(player)
	end)

	_shootRemote.OnServerEvent:Connect(function(player, rigIndex, animalName, hitTime)
		handleAnimalHit(player, rigIndex, animalName, hitTime)
	end)
end

function ConcertEvent.OnStart(data)
	if _isActive then return end
	ensureInitialized()
	_isActive = true

	local startTime = data.startedAt
	local now = workspace:GetServerTimeNow()

	ReplicatedStorage:SetAttribute("ConcertEvent_StartedAt", startTime) 
	_concertSynchronizer:Set("IsActive", true)

	local attributeDelay = (startTime + 5) - now
	local shootingDelay = (startTime + 10) - now
	ReplicatedStorage:SetAttribute("ConcertEvent", true)
	task.delay(math.max(0, attributeDelay), function()
		ReplicatedStorage:SetAttribute("ConcertEventMusic", true)
	end)
	task.delay(math.max(0, shootingDelay), function()
		startShootingLoop()
	end)
end

function ConcertEvent.OnStop()
	if not _isActive then return end
	_isActive = false
	ReplicatedStorage:SetAttribute("ConcertEvent", nil)
	ReplicatedStorage:SetAttribute("ConcertEventMusic", nil)
	_concertSynchronizer:Set("IsActive", false)

	if _shootTask then
		task.cancel(_shootTask)
		_shootTask = nil
	end
end

return ConcertEvent