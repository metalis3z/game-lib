--!strict

local LosMatteos = {}

local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local CollectionService   = game:GetService("CollectionService")
local HttpService         = game:GetService("HttpService")

local Net   = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)

local CreateLightningBolt = Net:RemoteEvent("EventService/Los Matteos/CreateLightningBolt")

local LIGHTNING_START_DELAY = 8

local mainTrove: any = nil
local strikesSinceLastHit = 0
local recentlyTargeted: { [string]: number } = {}
local strikeId = 0

local function animalHasMatteoHat(animal: Instance): boolean
	local json = animal:GetAttribute("Traits")
	if type(json) ~= "string" then
		return false
	end
	local ok, decoded = pcall(HttpService.JSONDecode, HttpService, json)
	if not ok or type(decoded) ~= "table" then
		return false
	end
	for _, trait in ipairs(decoded) do
		if trait == "Matteo Hat" then
			return true
		end
	end
	return false
end

local function giveAnimalMatteoHat(animal: Instance)
	if not animal or not animal.Parent then
		return
	end
	local traits = {}
	local json = animal:GetAttribute("Traits")
	if type(json) == "string" then
		local ok, decoded = pcall(HttpService.JSONDecode, HttpService, json)
		if ok and type(decoded) == "table" then
			traits = decoded
		end
	end
	table.insert(traits, "Matteo Hat")
	animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
end

local function runLightningStrike()
	local rainArea = workspace.Events["Los Matteos"].RainArea
	local areaSize, areaCFrame = rainArea.Size, rainArea.CFrame
	local strikeCount = math.random(1, 2)

	for i = 1, strikeCount do
		strikeId += 1

		local randomX = math.random(-areaSize.X / 2, areaSize.X / 2)
		local randomZ = math.random(-areaSize.Z / 2, areaSize.Z / 2)
		local strikePos = (areaCFrame * CFrame.new(randomX, 0, randomZ)).Position

		local forceHit       = strikesSinceLastHit >= 10
		local shouldHitAnimal = forceHit or (math.random(1, 100) <= 5)
		local targetAnimal: Model? = nil

		if shouldHitAnimal then
			local now = workspace:GetServerTimeNow()
			for name, lastTime in pairs(recentlyTargeted) do
				if (now - lastTime) > 15 then
					recentlyTargeted[name] = nil
				end
			end

			local candidates = {}
			for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
				if animal:IsA("Model") and animal.PrimaryPart then
					if recentlyTargeted[animal.Name] then continue end
					if animalHasMatteoHat(animal) then continue end

					local distance = (animal.PrimaryPart.Position - strikePos).Magnitude
					if forceHit or distance <= 150 then
						table.insert(candidates, { animal = animal, distance = distance })
					end
				end
			end

			if #candidates > 0 then
				table.sort(candidates, function(a, b) return a.distance < b.distance end)
				targetAnimal = candidates[1].animal :: Model

				local pp = (targetAnimal :: any).PrimaryPart
				local hatPos = pp.Position + Vector3.new(0, targetAnimal:GetExtentsSize().Y * 0.5, 0)
				CreateLightningBolt:FireAllClients(strikeId, hatPos, targetAnimal.Name)

				recentlyTargeted[targetAnimal.Name] = workspace:GetServerTimeNow()
				strikesSinceLastHit = 0

				task.delay(0.15, giveAnimalMatteoHat, targetAnimal)
			else
				CreateLightningBolt:FireAllClients(strikeId, strikePos, nil)
				strikesSinceLastHit += 1
			end
		else
			CreateLightningBolt:FireAllClients(strikeId, strikePos, nil)
			strikesSinceLastHit += 1
		end

		if i < strikeCount then
			task.wait(0.3)
		end
	end
end

function LosMatteos.OnStart()
	if mainTrove then return end
	mainTrove = Trove.new()

	strikesSinceLastHit = 0
	recentlyTargeted    = {}
	strikeId            = 0

	ReplicatedStorage:SetAttribute("LosMatteosEvent", true)
	mainTrove:Add(function()
		ReplicatedStorage:SetAttribute("LosMatteosEvent", nil)
		strikesSinceLastHit = 0
		recentlyTargeted    = {}
		strikeId            = 0
	end)
	local roots = script.Roots:Clone()
	local mapCenterGround = workspace:FindFirstChild("MapCenterGround")
	local mapCenterPos = mapCenterGround and mapCenterGround.Position or Vector3.new(0, 0, 0)

	local partsWithDistances = {}
	for _, descendant in roots:GetDescendants() do
		if descendant:IsA("BasePart") then
			local distance = (descendant.Position - mapCenterPos).Magnitude
			table.insert(partsWithDistances, { part = descendant, distance = distance })
		end
	end

	table.sort(partsWithDistances, function(a, b)
		return a.distance < b.distance
	end)

	local minDist = partsWithDistances[1] and partsWithDistances[1].distance or 0
	local maxDist = #partsWithDistances > 0 and partsWithDistances[#partsWithDistances].distance or 1
	local distRange = maxDist - minDist
	if distRange == 0 then distRange = 1 end

	for _, entry in partsWithDistances do
		entry.part.Parent = nil
	end

	roots.Parent = workspace

	local START_DELAY = 7
	local DURATION = 5

	for i, entry in partsWithDistances do
		local normalizedDist = (entry.distance - minDist) / distRange
		entry.delay = normalizedDist * DURATION
	end

	for i, entry in partsWithDistances do
		local nextEntry = partsWithDistances[i + 1]
		if nextEntry then
			entry.part:SetAttribute("TweenDuration", nextEntry.delay - entry.delay)
		else
			entry.part:SetAttribute("TweenDuration", 0.1)
		end
	end

	mainTrove:Add(task.delay(START_DELAY, function()
		for _, entry in partsWithDistances do
			mainTrove:Add(task.delay(entry.delay, function()
				entry.part.Parent = roots
			end))
		end
	end))

	mainTrove:Add(function()
		roots:Destroy()
	end)
	mainTrove:Add(task.delay(LIGHTNING_START_DELAY, function()
		while true do
			task.wait(0.5)
			runLightningStrike()
		end
	end))
end

function LosMatteos.OnStop()
	if mainTrove then
		mainTrove:Destroy()
		mainTrove = nil
	end
end

return LosMatteos