local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)

local Shoot = Net:RemoteEvent("EventService/RainingTacos/Shoot")

local RainingTacos = {}

local isActive = false
local eventTrove = nil
local recentlyTargeted = {}

local MULTI_SHOT_CHANCES = {
	{ shots = 3, chance = 0.15 },
	{ shots = 2, chance = 0.35 },
	{ shots = 1, chance = 1.00 },
}

local function getShotCount()
	local roll = math.random()
	for _, entry in ipairs(MULTI_SHOT_CHANCES) do
		if roll <= entry.chance then
			return entry.shots
		end
	end
	return 1
end

local function tryShootAnimal(selected)
	if not selected or not selected.Parent then
		return
	end

	if not selected.PrimaryPart or not SharedEventUtils.isPointInCarpet(selected.PrimaryPart.Position) then
		return
	end

	local now = workspace:GetServerTimeNow()
	Shoot:FireAllClients(selected.Name, now)
	recentlyTargeted[selected.Name] = now

	local delayTrove = eventTrove:Extend()

	delayTrove:Add(task.delay(2.5, function()
		if not selected or not selected.Parent then
			delayTrove:Clean()
			return
		end

		local currentTraitsJson = selected:GetAttribute("Traits")
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
			if trait == "Taco" then
				delayTrove:Clean()
				return
			end
		end

		table.insert(currentTraits, "Taco")
		selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))

		delayTrove:Clean()
	end))
end

local function getValidCandidates()
	local roadAnimals = CollectionService:GetTagged("Animal")
	local currentTime = workspace:GetServerTimeNow()

	for animalName, lastTime in pairs(recentlyTargeted) do
		if (currentTime - lastTime) > 20 then
			recentlyTargeted[animalName] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(roadAnimals) do
		if animal.PrimaryPart then
			local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
			local hasTaco = false

			local currentTraitsJson = animal:GetAttribute("Traits")
			if currentTraitsJson then
				local success, decoded = pcall(function()
					return HttpService:JSONDecode(currentTraitsJson)
				end)
				if success and type(decoded) == "table" then
					for _, trait in ipairs(decoded) do
						if trait == "Taco" then
							hasTaco = true
							break
						end
					end
				end
			end

			if not isRecentlyTargeted and not hasTaco then
				table.insert(candidates, animal)
			end
		end
	end

	return candidates
end

function RainingTacos.OnStart()
	if isActive then
		return
	end

	isActive = true
	eventTrove = Trove.new()
	ReplicatedStorage:SetAttribute("RainingTacosEvent", true)

	eventTrove:Add(task.spawn(function()
		while isActive do
			local waitTime = math.random(700, 1200) / 100

			if ReplicatedStorage:GetAttribute("3RoadsEvent") == true then
				waitTime = waitTime / 3
			end

			task.wait(waitTime)

			if not isActive then
				break
			end

			local shotCount = getShotCount()

			for i = 1, shotCount do
				local candidates = getValidCandidates()

				if #candidates > 0 then
					local selected = candidates[math.random(1, #candidates)]
					tryShootAnimal(selected)
				end

				if i < shotCount then
					task.wait(1)

					if not isActive then
						break
					end
				end
			end
		end
	end))
end

function RainingTacos.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("RainingTacosEvent", false)

	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
	end

	recentlyTargeted = {}
end

return RainingTacos