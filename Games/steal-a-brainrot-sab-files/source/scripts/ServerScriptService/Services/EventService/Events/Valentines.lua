local Valentines = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")

local Net = require(ReplicatedStorage.Packages.Net)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local ValentinesHit = Net:RemoteEvent("EventService/Valentines/Hit")

local recentlyTargeted = {}
local hitboxes = {}
local sTask = nil
local startTime = nil
local isActive = false

function hasValentinesTrait(animalTemplate)
	if not animalTemplate or not animalTemplate.Parent then
		return false
	end

	local currentTraitsJson = animalTemplate:GetAttribute("Traits")
	if currentTraitsJson then
		local success, decoded = pcall(function()
			return HttpService:JSONDecode(currentTraitsJson)
		end)
		if success and type(decoded) == "table" then
			for _, trait in ipairs(decoded) do
				if trait == "Chocolate" then
					return true
				end
			end
		end
	end

	return false
end

function pickTarget()
	local roadAnimals = CollectionService:GetTagged("Animal")
	local currentTime = workspace:GetServerTimeNow()

	for animalId, lastTime in pairs(recentlyTargeted) do
		if (currentTime - lastTime) > 25 then
			recentlyTargeted[animalId] = nil
		end
	end

	local candidates = {}
	for _, animal in ipairs(roadAnimals) do
		if animal.PrimaryPart and not recentlyTargeted[animal.Name] and not hasValentinesTrait(animal) then
			table.insert(candidates, animal)
		end
	end

	if #candidates == 0 then return nil end
	return candidates[math.random(1, #candidates)]
end

function applyTrait(animalTemplate)
	if not animalTemplate or not animalTemplate.Parent then return end

	local currentTraits = {}
	local currentTraitsJson = animalTemplate:GetAttribute("Traits")

	if currentTraitsJson then
		pcall(function()
			currentTraits = HttpService:JSONDecode(currentTraitsJson)
		end)
	end

	table.insert(currentTraits, "Chocolate")
	animalTemplate:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
end

function triggerHit(targetAnimal)
	if not targetAnimal or not targetAnimal.PrimaryPart then return end

	if not SharedEventUtils.isPointInCarpet(targetAnimal.PrimaryPart.Position) then
		return
	end

	local animalId = targetAnimal.Name
	local animalPosition = targetAnimal.PrimaryPart.Position

	local hitboxPart = Instance.new("Part")
	hitboxPart.Name = "ValentinesHitbox_" .. animalId
	hitboxPart.Size = Vector3.new(1, 1, 1)
	hitboxPart.Transparency = 1
	hitboxPart.Anchored = true
	hitboxPart.CanCollide = false
	hitboxPart.CFrame = CFrame.new(animalPosition)
	hitboxPart.Parent = workspace

	hitboxes[animalId] = hitboxPart
	recentlyTargeted[animalId] = workspace:GetServerTimeNow()

	task.spawn(function()
		applyTrait(targetAnimal)
		ValentinesHit:FireAllClients(animalId)

		task.wait(2)
		if hitboxes[animalId] then
			hitboxes[animalId]:Destroy()
			hitboxes[animalId] = nil
		end
	end)
end

function runEventLoop()
	if sTask then task.cancel(sTask) end

	sTask = task.spawn(function()
		task.wait(5)

		while isActive do
			local currentTime = workspace:GetServerTimeNow()
			local eventRunTime = currentTime - startTime

			if eventRunTime >= 5 and eventRunTime <= 80 then
				task.wait(math.random(3, 6))
				local target = pickTarget()
				if target then triggerHit(target) end
			elseif eventRunTime > 80 then
				task.wait(math.random(7, 10))
				local target = pickTarget()
				if target then triggerHit(target) end
			else
				task.wait(1)
			end
		end
	end)
end

function Valentines.OnStart()
	if isActive then return end
	isActive = true

	startTime = workspace:GetServerTimeNow()

	ReplicatedStorage:SetAttribute("ValentinesEvent", true)
	ReplicatedStorage:SetAttribute("ValentinesEventLastTime", os.time())

	runEventLoop()
end

function Valentines.OnStop()
	if not isActive then return end
	isActive = false

	if sTask then
		task.cancel(sTask)
		sTask = nil
	end

	for _, hitbox in pairs(hitboxes) do
		if hitbox then hitbox:Destroy() end
	end
	hitboxes = {}

	ReplicatedStorage:SetAttribute("ValentinesEvent", nil)
end

return Valentines