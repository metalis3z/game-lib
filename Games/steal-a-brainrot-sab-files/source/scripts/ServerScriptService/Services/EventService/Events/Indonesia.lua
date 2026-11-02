local Indonesia = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = require(ReplicatedStorage.Packages.Net)
local Trove = require(ReplicatedStorage.Packages.Trove)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local Burst = Net:RemoteEvent("EventService/Indonesia/Burst")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")

local recentlyTargeted = {}
local hitboxes = {}
local startTime = nil
local isActive = false
local strikeCount = 0

local eventTrove = Trove.new()

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
		if trait == "Indonesia" then
			return true
		end
	end

	return false
end

function pick()
	local roadAnimals = CollectionService:GetTagged("Animal")
	local currentTime = workspace:GetServerTimeNow()

	for animalId, lastTime in pairs(recentlyTargeted) do
		if (currentTime - lastTime) > 20 then
			recentlyTargeted[animalId] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(roadAnimals) do
		if animal.PrimaryPart then
			local animalId = animal.Name
			if not recentlyTargeted[animalId] and not has(animal) then
				table.insert(candidates, animal)
			end
		end
	end

	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
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
		if trait == "Indonesia" then
			return
		end
	end

	table.insert(currentTraits, "Indonesia")
	animalTemplate:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
end

function delete(animalId)
	local hitboxPart = hitboxes[animalId]
	if hitboxPart then
		hitboxPart:Destroy()
		hitboxes[animalId] = nil
	end
end

function hit(targetAnimal)
	if not targetAnimal or not targetAnimal.PrimaryPart then
		return
	end

	strikeCount += 1
	if strikeCount > 4 then
		if not SharedEventUtils.isPointInCarpet(targetAnimal.PrimaryPart.Position) then
			return
		end
	end

	local animalId = targetAnimal.Name
	local animalPosition = targetAnimal.PrimaryPart.Position

	local hitboxTrove = eventTrove:Extend()

	local hitboxPart = hitboxTrove:Add(Instance.new("Part"))
	hitboxPart.Name = "IndonesiaHitbox_" .. animalId
	hitboxPart.Size = Vector3.new(1, 1, 1)
	hitboxPart.Transparency = 1
	hitboxPart.Anchored = true
	hitboxPart.CanCollide = false
	hitboxPart.CFrame = CFrame.new(animalPosition.X, animalPosition.Y + 9, animalPosition.Z)
	hitboxPart.Parent = workspace

	hitboxes[animalId] = hitboxPart
	recentlyTargeted[animalId] = workspace:GetServerTimeNow()

	hitboxTrove:Add(task.spawn(function()
		local focusTime = workspace:GetServerTimeNow() + 1
		hitboxPart:SetAttribute("Focused", focusTime)

		apply(targetAnimal)
		Burst:FireAllClients(animalId)

		task.wait(2)

		hitboxes[animalId] = nil
		hitboxTrove:Clean()
	end))
end

local function burstOnStart()
	for i = 1, 4 do
		local targetAnimal = pick()
		if targetAnimal then
			hit(targetAnimal)
		end
	end
end

function event()
	eventTrove:Add(task.spawn(function()
		task.wait(5)

		while isActive do
			local currentTime = workspace:GetServerTimeNow()
			local eventRunTime = currentTime - startTime

			if eventRunTime >= 6 and eventRunTime <= 90 then
				task.wait(math.random(4, 7))

				local targetAnimal = pick()
				if targetAnimal then
					hit(targetAnimal)
				end
			elseif eventRunTime > 85 then
				task.wait(math.random(8, 12))

				local targetAnimal = pick()
				if targetAnimal then
					hit(targetAnimal)
				end
			else
				task.wait(1)
			end
		end
	end))
end

function Indonesia.OnStart()
	if isActive then return end
	isActive = true

	startTime = workspace:GetServerTimeNow()
	burstOnStart()
	event()

	eventTrove:Add(task.spawn(function()
		task.wait(12)
		script.Event:Fire()
	end))

	ReplicatedStorage:SetAttribute("IndonesiaEventLastTime", os.time())
	ReplicatedStorage:SetAttribute("IndonesiaEvent", true)
end

function Indonesia.OnStop()
	if not isActive then return end
	isActive = false

	eventTrove:Clean()

	hitboxes = {}
	recentlyTargeted = {}
	strikeCount = 0

	ReplicatedStorage:SetAttribute("IndonesiaEvent", nil)
end

return Indonesia