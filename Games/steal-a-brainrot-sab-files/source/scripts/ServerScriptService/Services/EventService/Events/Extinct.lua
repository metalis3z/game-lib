local Extinct = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local Burst = Net:RemoteEvent("EventService/Extinct/Burst")
local Animals = require(ReplicatedStorage.Datas.Animals)
local AnimalService = require(game:GetService("ServerScriptService").Services.AnimalService)
local PIVOT_POSITION = CFrame.new(-381.939, -9.341, 20.176)
local COOLDOWN_DURATION = 15
local MIN_WAIT = 4
local MAX_WAIT = 9

local eventTrove = nil
local recentlyTargeted = {}
local originalModelCFrame = nil

local function hasSkeletonTrait(animal)
	local traitsJson = animal:GetAttribute("Traits")
	if not traitsJson then
		return false
	end

	local success, traits = pcall(HttpService.JSONDecode, HttpService, traitsJson)
	if not success or type(traits) ~= "table" then
		return false
	end

	for _, trait in ipairs(traits) do
		if trait == "Skeleton" then
			return true
		end
	end
	return false
end

local function addSkeletonTrait(animal)
	if not animal or not animal.Parent then
		return
	end

	local traitsJson = animal:GetAttribute("Traits")
	local traits = {}

	if traitsJson then
		local success, decoded = pcall(HttpService.JSONDecode, HttpService, traitsJson)
		if success and type(decoded) == "table" then
			traits = decoded
		end
	end

	for _, trait in ipairs(traits) do
		if trait == "Skeleton" then
			return
		end
	end

	table.insert(traits, "Skeleton")
	animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
end

local function cleanupRecentlyTargeted(currentTime)
	for animalName, lastTime in pairs(recentlyTargeted) do
		if (currentTime - lastTime) > COOLDOWN_DURATION then
			recentlyTargeted[animalName] = nil
		end
	end
end

local function getValidCandidates()
	local candidates = {}
	local roadAnimals = CollectionService:GetTagged("Animal")

	for _, animal in ipairs(roadAnimals) do
		if animal.PrimaryPart 
			and not recentlyTargeted[animal.Name] 
			and not hasSkeletonTrait(animal) then
			table.insert(candidates, animal)
		end
	end

	return candidates
end

local function pivotModel(model, targetCFrame)
	if model and model:IsA("Model") then
		model:PivotTo(targetCFrame)
	end
end

function Extinct.OnStart()
	if eventTrove then
		return
	end

	eventTrove = Trove.new()
	ReplicatedStorage:SetAttribute("ExtinctEvent", true)

	local extinctModel = workspace
		:WaitForChild("Events")
		:WaitForChild("Extinct")
		:WaitForChild("Model")

	if extinctModel then
		originalModelCFrame = extinctModel:GetPivot()
		pivotModel(extinctModel, PIVOT_POSITION)

		eventTrove:Add(function()
			if extinctModel and extinctModel.Parent and originalModelCFrame then
				pivotModel(extinctModel, originalModelCFrame)
			end
			originalModelCFrame = nil
		end)
	end

	local choices = {
		"Extinct Ballerina",
		"Extinct Tralalero",
		"Extinct Matteo"
	}

	local randomIndex = math.random(1, #choices)

	local selectedChoice = choices[randomIndex]

	AnimalService.spawnAnimalCustom(Animals[selectedChoice])
	
	eventTrove:Add(task.spawn(function()
		while eventTrove do
			task.wait(math.random(MIN_WAIT, MAX_WAIT))

			if not eventTrove then
				break
			end

			local currentTime = workspace:GetServerTimeNow()
			cleanupRecentlyTargeted(currentTime)

			local candidates = getValidCandidates()

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]

				if not selected.PrimaryPart or not SharedEventUtils.isPointInCarpet(selected.PrimaryPart.Position) then
					continue
				end

				Burst:FireAllClients(selected.Name)
				recentlyTargeted[selected.Name] = currentTime

				task.delay(0.1, function()
					addSkeletonTrait(selected)
				end)
			end
		end
	end))
end

function Extinct.OnStop()
	if not eventTrove then
		return
	end

	ReplicatedStorage:SetAttribute("ExtinctEvent", false)

	eventTrove:Clean()
	eventTrove = nil

	table.clear(recentlyTargeted)
end

return Extinct