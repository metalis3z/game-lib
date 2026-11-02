local France = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")

local isActive = false
local recentlyTargeted = {}
local hitboxes = {}
local sTask = nil
local startTime = nil

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
		if trait == "France" then
			return true
		end
	end

	return false
end

function pick()
	local roadAnimals = CollectionService:GetTagged("Animal")
	local movingAnimalsFolder = workspace:FindFirstChild("MovingAnimals")
	local currentTime = workspace:GetServerTimeNow()

	for animalId, lastTime in pairs(recentlyTargeted) do
		if (currentTime - lastTime) > 20 then
			recentlyTargeted[animalId] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(roadAnimals) do
		if animal.Parent == movingAnimalsFolder and animal.PrimaryPart then
			local animalId = animal.Name
			if not recentlyTargeted[animalId] and
				not has(animal) and
				not hitboxes[animalId] then
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
		if trait == "France" then
			return
		end
	end

	table.insert(currentTraits, "France")
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

	local animalId = targetAnimal.Name
	local animalPosition = targetAnimal.PrimaryPart.Position

	local hitboxPart = Instance.new("Part")
	hitboxPart.Name = "FranceHitbox_" .. animalId
	hitboxPart.Size = Vector3.new(1, 1, 1)
	hitboxPart.Transparency = 1
	hitboxPart.Anchored = true
	hitboxPart.CanCollide = false
	hitboxPart.CFrame = CFrame.new(animalPosition.X, animalPosition.Y + 9, animalPosition.Z)
	hitboxPart.Parent = workspace

	hitboxes[animalId] = hitboxPart
	recentlyTargeted[animalId] = workspace:GetServerTimeNow()

	local Net = require(ReplicatedStorage.Packages.Net)
	local Burst = Net:RemoteEvent("EventService/France/Burst")

	task.spawn(function()
		local focusTime = workspace:GetServerTimeNow() + 1
		hitboxPart:SetAttribute("Focused", focusTime)

		apply(targetAnimal)
		Burst:FireAllClients(animalId)

		task.wait(2)
		delete(animalId)
	end)
end

function event()
	-- BUG FIX: sTask était une table {}, task.cancel() nécessite un thread
	if sTask then
		task.cancel(sTask)
		sTask = nil
	end

	sTask = task.spawn(function()
		task.wait(5)

		while isActive do
			local currentTime = workspace:GetServerTimeNow()
			local eventRunTime = currentTime - startTime

			if eventRunTime >= 6 and eventRunTime <= 85 then
				task.wait(math.random(8, 15))
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
	end)
end

function France.OnStart()
	if isActive then return end
	isActive = true

	startTime = workspace:GetServerTimeNow()
	event()

	ReplicatedStorage:SetAttribute("FranceEvent", true)
	ReplicatedStorage:SetAttribute("FranceEventLastTime", os.time())
end

function France.OnStop()
	if not isActive then return end
	isActive = false

	-- BUG FIX: on ne met plus false PUIS nil, juste nil directement
	ReplicatedStorage:SetAttribute("FranceEvent", nil)
	ReplicatedStorage:SetAttribute("FranceEventLastTime", nil)

	-- BUG FIX: sTask était une table {} non annulable
	if sTask then
		task.cancel(sTask)
		sTask = nil
	end

	-- BUG FIX: nil correctement chaque entrée de hitboxes
	for animalId, hitboxPart in pairs(hitboxes) do
		if hitboxPart then
			hitboxPart:Destroy()
		end
		hitboxes[animalId] = nil
	end
	hitboxes = {}
end

return France
