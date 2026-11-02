local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)

local Strike = Net:RemoteEvent("EventService/RainingBurgers/Strike")

local RainingBurgers = {}

local isActive = false
local eventTrove = nil
local recentlyTargeted = {}

local MULTI_STRIKE_CHANCES = {
	{ strikes = 3, chance = 0.15 },
	{ strikes = 2, chance = 0.35 },
	{ strikes = 1, chance = 1.00 },
}

local function getStrikeCount()
	local roll = math.random()
	for _, entry in ipairs(MULTI_STRIKE_CHANCES) do
		if roll <= entry.chance then
			return entry.strikes
		end
	end
	return 1
end

local function tryStrikeAnimal(selected)
	if not selected or not selected.Parent then
		return
	end

	if not selected.PrimaryPart or not SharedEventUtils.isPointInCarpet(selected.PrimaryPart.Position) then
		return
	end

	local now = workspace:GetServerTimeNow()
	Strike:FireAllClients(selected.Name)
	recentlyTargeted[selected.Name] = now

	local delayTrove = eventTrove:Extend()

	delayTrove:Add(task.delay(1.0, function()
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
			if trait == "Burger" then
				delayTrove:Clean()
				return
			end
		end

		table.insert(currentTraits, "Burger")
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
			local hasBurger = false

			local currentTraitsJson = animal:GetAttribute("Traits")
			if currentTraitsJson then
				local success, decoded = pcall(function()
					return HttpService:JSONDecode(currentTraitsJson)
				end)
				if success and type(decoded) == "table" then
					for _, trait in ipairs(decoded) do
						if trait == "Burger" then
							hasBurger = true
							break
						end
					end
				end
			end

			if not isRecentlyTargeted and not hasBurger then
				table.insert(candidates, animal)
			end
		end
	end

	return candidates
end

function RainingBurgers.OnStart()
	if isActive then
		return
	end

	isActive = true
	eventTrove = Trove.new()
	ReplicatedStorage:SetAttribute("RainingBurgersEvent", true)

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

			local strikeCount = getStrikeCount()

			for i = 1, strikeCount do
				local candidates = getValidCandidates()

				if #candidates > 0 then
					local selected = candidates[math.random(1, #candidates)]
					tryStrikeAnimal(selected)
				end

				if i < strikeCount then
					task.wait(1)

					if not isActive then
						break
					end
				end
			end
		end
	end))
end

function RainingBurgers.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("RainingBurgersEvent", false)

	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
	end

	recentlyTargeted = {}
end

return RainingBurgers