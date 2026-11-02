local RapConcert = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")

local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)

local Targeted = {}
local shootTask = nil
local isActive = false

function has(animal)
	if not animal or not animal.Parent then return false end
	local traitsJson = animal:GetAttribute("Traits")
	if not traitsJson then return false end

	local success, decoded = pcall(HttpService.JSONDecode, HttpService, traitsJson)
	if not success or type(decoded) ~= "table" then return false end

	for _, trait in ipairs(decoded) do
		if trait == "Disco" then return true end
	end
	return false
end

function apply(animal)
	if not animal or not animal.Parent then return end

	if not animal.PrimaryPart or not SharedEventUtils.isPointInCarpet(animal.PrimaryPart.Position) then
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
		if trait == "Disco" then return end
	end

	table.insert(traits, "Disco")
	animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
end

function pick()
	local roadAnimals = CollectionService:GetTagged("Animal")
	local candidates = {}

	for _, animal in ipairs(roadAnimals) do
		if animal.PrimaryPart and not has(animal) then
			table.insert(candidates, animal)
		end
	end

	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
end

function startEventLoop()
	shootTask = task.spawn(function()
		while isActive do
			task.wait(math.random(4, 7))
			if not isActive then break end

			local targetAnimal = pick()
			if targetAnimal then
				apply(targetAnimal)
			end
		end
	end)
end

function RapConcert.OnStart(data)
	if isActive then return end
	isActive = true

	local startTime = data.startedAt or data.StartedAt or workspace:GetServerTimeNow()
	ReplicatedStorage:SetAttribute("RapConcertEvent", true)

	local eventDelay = (startTime + 10) - workspace:GetServerTimeNow()
	task.delay(math.max(0, eventDelay), function()
		if isActive then startEventLoop() end
	end)
end

function RapConcert.OnStop()
	isActive = false
	ReplicatedStorage:SetAttribute("RapConcertEvent", nil)
	if shootTask then
		task.cancel(shootTask)
		shootTask = nil
	end
end

return RapConcert