local Snow = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)

local Hit = Net:RemoteEvent("EventService/Snow/Hit")

local isActive = false
local trove = nil
local recentlyTargeted = {}
local snowyAnimals = {}

local SNOWBALL_MIN_INTERVAL = 7
local SNOWBALL_MAX_INTERVAL = 10
local TARGET_COOLDOWN = 15
local TRAIT_APPLY_DELAY = 0.1

local function getTraits(object)
	local traitsJson = object:GetAttribute("Traits")
	if not traitsJson then
		return {}
	end

	local success, decoded = pcall(function()
		return HttpService:JSONDecode(traitsJson)
	end)

	if success and type(decoded) == "table" then
		return decoded
	end

	return {}
end

local function setTraits(object, traits)
	object:SetAttribute("Traits", HttpService:JSONEncode(traits))
end

local function hasTrait(object, traitName)
	local traits = getTraits(object)
	for _, trait in ipairs(traits) do
		if trait == traitName then
			return true
		end
	end
	return false
end

local function addTrait(object, traitName)
	if not object or not object.Parent then
		return false
	end

	local traits = getTraits(object)

	for _, trait in ipairs(traits) do
		if trait == traitName then
			return false
		end
	end

	table.insert(traits, traitName)
	setTraits(object, traits)
	return true
end

local function cleanupRecentlyTargeted()
	local currentTime = workspace:GetServerTimeNow()
	for animalName, lastTime in pairs(recentlyTargeted) do
		if (currentTime - lastTime) > TARGET_COOLDOWN then
			recentlyTargeted[animalName] = nil
		end
	end
end

local function getValidCandidates()
	local roadAnimals = CollectionService:GetTagged("Animal")
	local candidates = {}

	for _, animal in ipairs(roadAnimals) do
		if animal.PrimaryPart
			and not recentlyTargeted[animal.Name]
			and not hasTrait(animal, "Snowy")
		then
			table.insert(candidates, animal)
		end
	end

	return candidates
end

function Snow.OnStart()
	if isActive then
		return
	end
	isActive = true

	if trove then
		trove:Clean()
	end

	trove = Trove.new()

	ReplicatedStorage:SetAttribute("Snow", true)
	trove:Add(function()
		ReplicatedStorage:SetAttribute("Snow", false)
	end)

	local piles = trove:Clone(ReplicatedStorage.Models.Events.Snow.Piles)
	piles.Parent = workspace

	trove:Add(function()
		table.clear(recentlyTargeted)
	end)

	trove:Add(task.spawn(function()
		while isActive do
			task.wait(math.random(SNOWBALL_MIN_INTERVAL, SNOWBALL_MAX_INTERVAL))

			if not isActive then
				break
			end

			cleanupRecentlyTargeted()

			local candidates = getValidCandidates()

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]

				if not selected.PrimaryPart or not SharedEventUtils.isPointInCarpet(selected.PrimaryPart.Position) then
					continue
				end

				Hit:FireAllClients(selected.Name)
				recentlyTargeted[selected.Name] = workspace:GetServerTimeNow()

				task.delay(TRAIT_APPLY_DELAY, function()
					if not isActive then
						return
					end

					if addTrait(selected, "Snowy") then
						snowyAnimals[selected] = true
					end
				end)
			end
		end
	end))
end

function Snow.OnStop()
	if not isActive then
		return
	end
	isActive = false
	if trove then
		trove:Destroy()
		trove = nil
	end
end

return Snow