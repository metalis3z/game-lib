local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local AnimalService = require(ServerScriptService.Services.AnimalService)
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)

local NyanCats = {}
local isActive = false
local sTask = {}
local traitApplyTask = nil

local SpawnEffect = Net:RemoteEvent("EventService/NyanCats/SpawnEffect")
local Strike = Net:RemoteEvent("EventService/NyanCats/Struck")
local recentlyTargeted = {}

function has(animalTemplate)
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
		if trait == "Nyan" then
			return true
		end
	end

	return false
end

function apply(animalTemplate)
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
		if trait == "Nyan" then
			return
		end
	end

	table.insert(currentTraits, "Nyan")
	animalTemplate:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
end

function pick()
	local CollectionService = game:GetService("CollectionService")
	local roadAnimals = CollectionService:GetTagged("Animal")
	local movingAnimalsFolder = workspace:FindFirstChild("MovingAnimals")
	local currentTime = workspace:GetServerTimeNow()

	for animalName, lastTime in pairs(recentlyTargeted) do
		if (currentTime - lastTime) > 15 then
			recentlyTargeted[animalName] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(roadAnimals) do
		if animal.Parent == movingAnimalsFolder and animal.PrimaryPart then
			if not recentlyTargeted[animal.Name] and not has(animal) then
				table.insert(candidates, animal)
			end
		end
	end

	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
end

function event()
	if next(sTask) ~= nil then
		task.cancel(sTask)
	end

	sTask = task.spawn(function()
		while isActive do
			task.wait(math.random(2,4))

			local targetAnimal = pick()
			if targetAnimal then
				local catIndex = math.random(1,30)
				local currentTime = workspace:GetServerTimeNow()

				Strike:FireAllClients(catIndex, targetAnimal.Name, currentTime)

				recentlyTargeted[targetAnimal.Name] = currentTime

				task.delay(3.1, function()
					apply(targetAnimal)
				end)
			end
		end
	end)
end

function NyanCats.OnStart()
	if isActive then
		return
	end

	local 
	
	isActive = true
	ReplicatedStorage:SetAttribute("NyanCatsEvent", true)

	local spawnTime = workspace:GetServerTimeNow() + 1
	for _, player in pairs(Players:GetPlayers()) do
		SpawnEffect:FireClient(player, spawnTime)
	end
	
	event()
end

function NyanCats.OnStop()
	if not isActive then
		return
	end

	isActive = false

	ReplicatedStorage:SetAttribute("NyanCatsEvent", false)

	if next(sTask) ~= nil then
		task.cancel(sTask)
		sTask = nil
	end
end

return NyanCats