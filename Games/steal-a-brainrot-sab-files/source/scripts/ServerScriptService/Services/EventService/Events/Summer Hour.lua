local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)

local Projectile = Net:RemoteEvent("EventService/SummerHour/Projectile")
local Burst = Net:RemoteEvent("EventService/SummerHour/Burst")

local SummerHour = {}

local isActive = false
local eventTrove = nil
local recentlyTargeted = {}

local function tryShootAnimal(selected)
	if not selected or not selected.Parent then
		warn("[SummerHour] Animal is nil or has no parent")
		return
	end

	local now = workspace:GetServerTimeNow()
	local aimDelay = 0.7

	if not (selected and selected.Parent and selected.PrimaryPart) then
		warn("[SummerHour] Animal became invalid before firing")
		return
	end

	local eventFolder = workspace.Events:FindFirstChild("Summer Hour")
	local sunTrait = nil
	if eventFolder then
		sunTrait = eventFolder:FindFirstChild("SunTrait")
	end
	
	local projectileSpeed = 90
	local travelTime = 2.0
	
	if sunTrait and sunTrait.PrimaryPart then
		local homePosition = sunTrait:GetAttribute("Home")
		if typeof(homePosition) ~= "CFrame" then
			homePosition = sunTrait:GetPivot()
		end
		
		local sunPos = homePosition.Position
		local animalPos = selected.PrimaryPart.Position + Vector3.new(0, selected:GetExtentsSize().Y, 0)
		local distance = (animalPos - sunPos).Magnitude
		travelTime = distance / projectileSpeed
		
		print("[SummerHour] Calculated travel time:", travelTime, "seconds (Distance:", distance, "studs)")
	else
		warn("[SummerHour] Could not find sun trait to calculate travel time, using default:", travelTime)
	end

	print("[SummerHour] Firing projectile at:", selected.Name, "Position:", selected.PrimaryPart.Position)

	Projectile:FireAllClients(selected, nil, nil, aimDelay, nil)
	recentlyTargeted[selected.Name] = now

	local delayTrove = eventTrove:Extend()

	delayTrove:Add(task.delay(aimDelay + travelTime, function()
		if not selected or not selected.Parent then
			delayTrove:Clean()
			return
		end

		print("[SummerHour] Firing burst at:", selected.Name)
		Burst:FireAllClients(selected)

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
			if trait == "Sun" then
				delayTrove:Clean()
				return
			end
		end

		table.insert(currentTraits, "Sun")
		selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
		print("[SummerHour] Applied Sun trait to:", selected.Name)

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
		if animal and animal.Parent and animal.PrimaryPart then
			local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
			local hasSun = false

			local currentTraitsJson = animal:GetAttribute("Traits")
			if currentTraitsJson then
				local success, decoded = pcall(function()
					return HttpService:JSONDecode(currentTraitsJson)
				end)
				if success and type(decoded) == "table" then
					for _, trait in ipairs(decoded) do
						if trait == "Sun" then
							hasSun = true
							break
						end
					end
				end
			end

			if not isRecentlyTargeted and not hasSun and SharedEventUtils.isPointInCarpet(animal.PrimaryPart.Position) then
				table.insert(candidates, animal)
			end
		end
	end

	return candidates
end

function SummerHour.OnStart()
	if isActive then
		return
	end

	isActive = true
	eventTrove = Trove.new()
	ReplicatedStorage:SetAttribute("SummerHourEvent", true)

	print("[SummerHour] Event started!")

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

			local candidates = getValidCandidates()
			print("[SummerHour] Found", #candidates, "valid candidates")

			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				tryShootAnimal(selected)
			end
		end
	end))
end

function SummerHour.OnStop()
	if not isActive then
		return
	end

	isActive = false
	ReplicatedStorage:SetAttribute("SummerHourEvent", false)

	print("[SummerHour] Event stopped!")

	if eventTrove then
		eventTrove:Clean()
		eventTrove = nil
	end

	recentlyTargeted = {}
end

return SummerHour