local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local MathUtils = require(ReplicatedStorage.Utils.MathUtils)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)

local CreateFirework = Net:RemoteEvent("EventService/4th of July/CreateFirework")
local ExplodeTraitEffect = Net:RemoteEvent("EventService/4th of July/ExplodeTraitEffect")

local FourthOfJuly = {}
local isActive = false
local fireworkTask = nil
local fireworkPositions = {}

local FALLOFF_COUNT_MIN = 6
local FALLOFF_COUNT_MAX = 9
local FALLOFF_SPREAD_RADIUS = 70
local FALLOFF_HIT_RADIUS = 10
local FALLOFF_TRAVEL_TIME = 2.3
local FIREWORK_HEIGHT_MIN = 80
local FIREWORK_HEIGHT_MAX = 120
local FIREWORK_EFFECT_COUNT = 3

local FireworkRaycastParams = RaycastParams.new()
FireworkRaycastParams.FilterType = Enum.RaycastFilterType.Include
FireworkRaycastParams.FilterDescendantsInstances = {
	workspace.Map,
	workspace.Plots
}

local function addTrait(animal, traitName)
	local currentTraitsJson = animal:GetAttribute("Traits")
	local currentTraits = {}

	if currentTraitsJson then
		local success, decoded = pcall(HttpService.JSONDecode, HttpService, currentTraitsJson)
		if success and type(decoded) == "table" then
			currentTraits = decoded
		end
	end

	for _, trait in ipairs(currentTraits) do
		if trait == traitName then
			return false
		end
	end

	table.insert(currentTraits, traitName)
	animal:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
	return true
end

local function hasTrait(animal, traitName)
	local currentTraitsJson = animal:GetAttribute("Traits")
	if not currentTraitsJson then
		return false
	end

	local success, decoded = pcall(HttpService.JSONDecode, HttpService, currentTraitsJson)
	if not success or type(decoded) ~= "table" then
		return false
	end

	for _, trait in ipairs(decoded) do
		if trait == traitName then
			return true
		end
	end

	return false
end

local function getAnimalsNearPosition(position, radius)
	local hit = {}
	local animals = CollectionService:GetTagged("Animal")

	for _, animal in ipairs(animals) do
		if animal.PrimaryPart then
			local dist = (animal.PrimaryPart.Position - position).Magnitude
			if dist <= radius then
				table.insert(hit, animal)
			end
		end
	end

	return hit
end

local function generateFalloffTargets(peakPosition, originPosition)
	local falloffCount = math.random(FALLOFF_COUNT_MIN, FALLOFF_COUNT_MAX)
	local falloffs = {}
	local worldTargets = {}

	for _ = 1, falloffCount do
		local angle = math.random() * math.pi * 2
		local radius = math.random() * FALLOFF_SPREAD_RADIUS

		local offsetX = math.cos(angle) * radius
		local offsetZ = math.sin(angle) * radius

		local rayOrigin = peakPosition + Vector3.new(offsetX, 0, offsetZ)
		local raycastResult = workspace:Raycast(rayOrigin, Vector3.new(0, -200, 0), FireworkRaycastParams)

		local landingPosition
		if raycastResult then
			landingPosition = raycastResult.Position
		else
			landingPosition = originPosition + Vector3.new(offsetX, 0, offsetZ)
		end

		local clientOffset = Vector3.new(offsetX, 0, offsetZ)
		table.insert(falloffs, clientOffset)
		table.insert(worldTargets, landingPosition)
	end

	return falloffs, worldTargets
end

local function scheduleHitDetection(worldTargets, peakPosition, travelDelay)
	task.delay(travelDelay, function()
		if not isActive then
			return
		end

		for _, landingPos in ipairs(worldTargets) do
			local hitAnimals = getAnimalsNearPosition(landingPos, FALLOFF_HIT_RADIUS)

			for _, animal in ipairs(hitAnimals) do
				if not hasTrait(animal, "Fireworks") then
					ExplodeTraitEffect:FireAllClients(animal.Name)
					addTrait(animal, "Fireworks")
				end
			end
		end
	end)
end
function FourthOfJuly.OnStart()
	if isActive then
		return
	end

	isActive = true
	ReplicatedStorage:SetAttribute("4thOfJulyEvent", true)

	local fireworksFolder = ReplicatedStorage.Models.Events["4th of July"].Fireworks
	local fireworkModels = fireworksFolder:GetChildren()

	table.sort(fireworkModels, function(a, b)
		return tonumber(a.Name) < tonumber(b.Name)
	end)

	for i, model in ipairs(fireworkModels) do
		local cframe = nil

		if model:IsA("Model") and model.PrimaryPart then
			cframe = model.PrimaryPart.CFrame
		elseif model:IsA("BasePart") then
			cframe = model.CFrame
		end

		if cframe then
			fireworkPositions[i] = cframe
		end
	end

	fireworkTask = task.spawn(function()
		while isActive do
			task.wait(math.random(20, 40) / 10)

			if not isActive then
				break
			end

			local fireworkDataList = {}
			local numFireworks = math.random(1, 3)

			local validIndices = {}
			for index in pairs(fireworkPositions) do
				table.insert(validIndices, index)
			end

			if #validIndices == 0 then
				continue
			end

			for _ = 1, numFireworks do
				local chosenIndex = validIndices[math.random(1, #validIndices)]
				local launcherCFrame = fireworkPositions[chosenIndex]
				local height = math.random(FIREWORK_HEIGHT_MIN, FIREWORK_HEIGHT_MAX)
				local peakPosition = launcherCFrame.Position + Vector3.new(0, height, 0)

				local originPosition = launcherCFrame.Position

				local falloffOffsets, worldTargets = generateFalloffTargets(peakPosition, originPosition)

				local fireworkEffect = math.random(1, FIREWORK_EFFECT_COUNT)
				local travelDuration = height / 20

				local totalDelay = travelDuration * 0.8 + FALLOFF_TRAVEL_TIME

				scheduleHitDetection(worldTargets, peakPosition, totalDelay)

				table.insert(fireworkDataList, {
					Chosen = chosenIndex,
					Height = height,
					FireworkEffect = fireworkEffect,
					Falloffs = falloffOffsets,
				})
			end

			if #fireworkDataList > 0 then
				CreateFirework:FireAllClients(fireworkDataList)
			end
		end
	end)
end

function FourthOfJuly.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("4thOfJulyEvent", false)

	if fireworkTask then
		task.cancel(fireworkTask)
		fireworkTask = nil
	end

	fireworkPositions = {}
end

return FourthOfJuly