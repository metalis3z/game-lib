local Phase = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local Net = require(ReplicatedStorage.Packages.Net)
local burst = Net:RemoteEvent("EventService/Phase 1: Sleepy/PlaySleepVFX")
local TRAIT_NAME = "Sleepy"
local TICK_RATE = {min = 4, max = 7}

local isActive = false
local loopTask = nil
local recentlyTargeted = {}

local function hasTrait(animal)
	if not animal or not animal.Parent then return false end

	local traitsJson = animal:GetAttribute("Traits")
	if not traitsJson then return false end

	local success, traits = pcall(HttpService.JSONDecode, HttpService, traitsJson)
	if not success or type(traits) ~= "table" then return false end

	for _, trait in ipairs(traits) do
		if trait == TRAIT_NAME then return true end
	end
	return false
end

local function applyTrait(animal)
	local traitsJson = animal:GetAttribute("Traits")
	local traits = {}

	if traitsJson then
		pcall(function() traits = HttpService:JSONDecode(traitsJson) end)
	end

	table.insert(traits, TRAIT_NAME)
	animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
end

local function pickTarget()
	local animals = CollectionService:GetTagged("Animal")
	local currentTime = workspace:GetServerTimeNow()
	local candidates = {}

	for _, animal in ipairs(animals) do
		local id = animal.Name
		if recentlyTargeted[id] and (currentTime - recentlyTargeted[id] > 30) then
			recentlyTargeted[id] = nil
		end

		if animal.PrimaryPart and not recentlyTargeted[id] and not hasTrait(animal) then
			table.insert(candidates, animal)
		end
	end

	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
end

local function startLoop()
	loopTask = task.spawn(function()
		while isActive do
			task.wait(math.random(TICK_RATE.min, TICK_RATE.max))

			local target = pickTarget()
			if target then
				recentlyTargeted[target.Name] = workspace:GetServerTimeNow()
				applyTrait(target)

				burst:FireAllClients(target.Name)
			end
		end
	end)
end

function Phase.OnStart()
	if isActive then return end
	isActive = true
	startLoop()
end

function Phase.OnStop()
	isActive = false
	if loopTask then
		task.cancel(loopTask)
		loopTask = nil
	end
	recentlyTargeted = {}
end

return Phase