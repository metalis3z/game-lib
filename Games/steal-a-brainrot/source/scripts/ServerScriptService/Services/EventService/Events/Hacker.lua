local Hacker = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/Hacker/Hit")

local recentlyTargeted = {}
local hitboxes = {}
local sTask = nil
local startTime = nil
local isActive = false

local function has(animalTemplate)
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
		if trait == "Hacked" then
			return true
		end
	end

	return false
end

local function apply(animalTemplate)
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
		if trait == "Hacked" then
			return
		end
	end

	table.insert(currentTraits, "Hacked")
	animalTemplate:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))

	-- Ajouter un effet visuel de hacking sur l'animal
	local highlight = Instance.new("Highlight")
	highlight.Name = "HackerHighlight"
	highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Vert néon
	highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
	highlight.Parent = animalTemplate

	-- Supprimer le highlight après un certain temps
	task.delay(5, function()
		if highlight and highlight.Parent then
			highlight:Destroy()
		end
	end)
end

local function pick()
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
			if not recentlyTargeted[animalId]
				and not has(animal)
				and not hitboxes[animalId] then
				table.insert(candidates, animal)
			end
		end
	end

	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
end

local function delete(animalId)
	local hitboxPart = hitboxes[animalId]
	if hitboxPart then
		hitboxPart:Destroy()
		hitboxes[animalId] = nil
	end
end

local function hit(targetAnimal)
	if not targetAnimal or not targetAnimal.PrimaryPart then
		return
	end

	local animalId = targetAnimal.Name
	local animalPosition = targetAnimal.PrimaryPart.Position

	-- Hitbox avec effet hacker (vert néon)
	local hitboxPart = Instance.new("Part")
	hitboxPart.Name = "HackerHitbox_" .. animalId
	hitboxPart.Size = Vector3.new(1, 1, 1)
	hitboxPart.Transparency = 0.5
	hitboxPart.Color = Color3.fromRGB(0, 255, 0)
	hitboxPart.Material = Enum.Material.Neon
	hitboxPart.Anchored = true
	hitboxPart.CanCollide = false
	hitboxPart.CFrame = CFrame.new(animalPosition.X, animalPosition.Y + 9, animalPosition.Z)
	hitboxPart.Parent = workspace

	hitboxes[animalId] = hitboxPart
	recentlyTargeted[animalId] = workspace:GetServerTimeNow()

	task.spawn(function()
		local focusTime = workspace:GetServerTimeNow() + 1
		hitboxPart:SetAttribute("Focused", focusTime)

		apply(targetAnimal)

		Burst:FireAllClients(animalId)

		task.wait(2)
		delete(animalId)
	end)
end

local function event()
	if sTask then
		task.cancel(sTask)
	end

	sTask = task.spawn(function()
		task.wait(5)

		while isActive do
			local currentTime = workspace:GetServerTimeNow()
			local eventRunTime = currentTime - startTime

			if eventRunTime >= 6 and eventRunTime <= 85 then
				task.wait(math.random(3, 7))
			elseif eventRunTime > 85 then
				task.wait(math.random(8, 12))
			else
				task.wait(1)
			end

			if not isActive then break end

			local targetAnimal = pick()
			if targetAnimal then
				hit(targetAnimal)
			end
		end
	end)
end

function Hacker.OnStart()
	if isActive then return end
	isActive = true
	startTime = workspace:GetServerTimeNow()
	ReplicatedStorage:SetAttribute("HackerEvent", true)
	event()
end

function Hacker.OnStop()
	if not isActive then return end

	isActive = false
	ReplicatedStorage:SetAttribute("HackerEvent", false)

	if sTask then
		task.cancel(sTask)
		sTask = nil
	end

	for _, part in pairs(hitboxes) do
		part:Destroy()
	end
	table.clear(hitboxes)
end

return Hacker