--!native
local WinterHour = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Net = require(ReplicatedStorage.Packages.Net)
local SharedEventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)
local DropModel = ReplicatedStorage.Controllers.EventController.Events["Winter Hour"]:FindFirstChild("Drop")
local Burst = Net:RemoteEvent("EventService/Winter Hour/Burst")
local SpawnCandyCane = Net:RemoteEvent("EventService/Winter Hour/SpawnCandyCane")
local DestroyCandyCane = Net:RemoteEvent("EventService/Winter Hour/DestroyCandyCane")
local ClaimCandyCane = Net:RemoteEvent("EventService/Winter Hour/ClaimCandyCane")
local AnimalService = require(game:GetService("ServerScriptService").Services.AnimalService)
local Animals = require(ReplicatedStorage.Datas.Animals)

local SPAWN_TABLE = {
	{name = "Ballerina Peppermintina", weight = 65},
	{name = "Reindeer Tralala",        weight = 25},
	{name = "Santteo",                 weight = 10},
	{name = "List List List Sahur",    weight = 5},
}

local function getWeightedAnimalName()
	local totalWeight = 0
	for _, entry in ipairs(SPAWN_TABLE) do
		totalWeight = totalWeight + entry.weight
	end

	local roll = math.random(1, totalWeight)
	local currentSum = 0

	for _, entry in ipairs(SPAWN_TABLE) do
		currentSum = currentSum + entry.weight
		if roll <= currentSum then
			return entry.name
		end
	end
end

local function spawnRandomEventAnimal()
	local selectedName = getWeightedAnimalName()
	local targetAnimal = Animals[selectedName]

	if targetAnimal then
		print("Spawning Event Animal: " .. selectedName)
		AnimalService.spawnAnimalCustom(targetAnimal, nil, {}, nil, nil, nil)
	else
		warn("WinterHour: Could not find data for " .. tostring(selectedName))
	end
end
local isActive = false
local strikeTask = nil
local mapDropTask = nil
local recentlyTargeted = {}
local candyCanes = {}
local candyCaneCounter = 0

local winterate = workspace.Events["Winter Hour"].Model
local hatIdleAnimation = nil
local sequenceAnimation = nil

local STRIKE_INTERVAL = {6, 12}
local STRIKE_RANGE = 50
local COOLDOWN_TIME = 15
local CANDY_DROP_HEIGHT = 20
local CANDY_FALL_TIME = 1.5
local MAP_DROP_INTERVAL = 5
local MAP_DROP_AMOUNT = {3, 8}

local RaycastParams = RaycastParams.new()
RaycastParams.FilterType = Enum.RaycastFilterType.Include
RaycastParams.FilterDescendantsInstances = {workspace.Map}

local function setupIdleAnimation()
	local sammy = winterate:FindFirstChild("Sammy")
	if sammy then
		local humanoid = sammy:FindFirstChildOfClass("Humanoid")
		if humanoid then
			local animator = humanoid:FindFirstChildOfClass("Animator")
			if not animator then
				animator = Instance.new("Animator")
				animator.Parent = humanoid
			end

			local hatIdleAnim = ReplicatedStorage.Controllers.EventController.Events["Winter Hour"]:FindFirstChild("HatIdle")
			if hatIdleAnim and hatIdleAnim:IsA("Animation") then
				if hatIdleAnimation then
					hatIdleAnimation:Stop()
				end
				hatIdleAnimation = animator:LoadAnimation(hatIdleAnim)
				hatIdleAnimation.Looped = true
				hatIdleAnimation.Priority = Enum.AnimationPriority.Idle
				hatIdleAnimation:Play()
			end
		end
	end
end

local function playSequenceAnimation()
	local sammy = winterate:FindFirstChild("Sammy")
	if sammy then
		local humanoid = sammy:FindFirstChildOfClass("Humanoid")
		if humanoid then
			local animator = humanoid:FindFirstChildOfClass("Animator")
			if not animator then
				animator = Instance.new("Animator")
				animator.Parent = humanoid
			end

			local sequenceAnim = ReplicatedStorage.Controllers.EventController.Events["Winter Hour"]:FindFirstChild("Sequence")
			if sequenceAnim and sequenceAnim:IsA("Animation") then
				if hatIdleAnimation then
					hatIdleAnimation:Stop()
				end
				if sequenceAnimation then
					sequenceAnimation:Stop()
				end
				sequenceAnimation = animator:LoadAnimation(sequenceAnim)
				sequenceAnimation.Looped = false
				sequenceAnimation.Priority = Enum.AnimationPriority.Action
				sequenceAnimation:Play()

				sequenceAnimation.Stopped:Connect(function()
					setupIdleAnimation()
				end)
			end
		end
	end
end

local function setSantaHatVisibility(visible)
	local sammy = winterate:FindFirstChild("Sammy")
	if sammy then
		local santaHat = sammy:FindFirstChild("Santa's Hat")
		if santaHat then
			for _, child in ipairs(santaHat:GetDescendants()) do
				if child:IsA("BasePart") or child:IsA("MeshPart") then
					child.Transparency = visible and 0 or 1
				end
			end
		end
	end
end

local function getRandomMapPosition()
	local map = workspace:FindFirstChild("Map")
	if not map then
		return Vector3.new(0, 50, 0)
	end

	local groundParts = {}
	for _, obj in ipairs(map:GetDescendants()) do
		if obj:IsA("BasePart") and (obj.Name == "Baseplate" or obj.Name == "Ground" or obj.Name == "Carpet") then
			table.insert(groundParts, obj)
		end
	end

	if #groundParts == 0 then
		local allParts = {}
		for _, obj in ipairs(map:GetDescendants()) do
			if obj:IsA("BasePart") then
				table.insert(allParts, obj)
			end
		end
		if #allParts > 0 then
			groundParts = allParts
		else
			return Vector3.new(0, 50, 0)
		end
	end

	local randomPart = groundParts[math.random(1, #groundParts)]
	local size = randomPart.Size
	local pos = randomPart.Position

	local randomX = pos.X + math.random(-size.X/2, size.X/2)
	local randomZ = pos.Z + math.random(-size.Z/2, size.Z/2)
	local spawnPos = Vector3.new(randomX, pos.Y + 50, randomZ)

	local rayResult = workspace:Raycast(spawnPos, Vector3.new(0, -100, 0), RaycastParams)
	if rayResult then
		return rayResult.Position
	end

	return spawnPos
end


setupIdleAnimation()
setSantaHatVisibility(false)

function WinterHour.OnStart()
	if isActive then
		return
	end
	spawnRandomEventAnimal()
	winterate:PivotTo(CFrame.new(-384.384, 24.267, -12.957))
	isActive = true
	ReplicatedStorage:SetAttribute("WinterHourEvent", true)

	setupIdleAnimation()
	setSantaHatVisibility(true)


	if strikeTask then
		task.cancel(strikeTask)
	end

	strikeTask = task.spawn(function()
		while isActive do
			local waitTime = math.random(STRIKE_INTERVAL[1] * 10, STRIKE_INTERVAL[2] * 10) / 10
			task.wait(waitTime)

			if not isActive then
				break
			end

			local sammy = winterate:FindFirstChild("Sammy")
			if not sammy or not sammy.PrimaryPart then
				continue
			end

			local sammyPos = sammy.PrimaryPart.Position
			local roadAnimals = CollectionService:GetTagged("Animal")
			local currentTime = workspace:GetServerTimeNow()

			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > COOLDOWN_TIME then
					recentlyTargeted[animalName] = nil
				end
			end

			local closestAnimal = nil
			local closestDistance = math.huge

			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local animalPos = animal.PrimaryPart.Position
					local distance = (animalPos - sammyPos).Magnitude

					if distance <= STRIKE_RANGE then
						local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
						local hasWitchHat = false
						local currentTraitsJson = animal:GetAttribute("Traits")

						if currentTraitsJson then
							local success, decoded = pcall(function()
								return HttpService:JSONDecode(currentTraitsJson)
							end)
							if success and type(decoded) == "table" then
								for _, trait in ipairs(decoded) do
									if trait == "Santa Hat" then
										hasWitchHat = true
										break
									end
								end
							end
						end

						if not isRecentlyTargeted and not hasWitchHat and distance < closestDistance then
							closestAnimal = animal
							closestDistance = distance
						end
					end
				end
			end

			if closestAnimal then
				local selected = closestAnimal

				if not selected.PrimaryPart or not SharedEventUtils.isPointInCarpet(selected.PrimaryPart.Position) then
					continue
				end

				local now = workspace:GetServerTimeNow()
				recentlyTargeted[selected.Name] = now

				playSequenceAnimation()

				task.delay(0.5, function()
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
						if trait == "Santa Hat" then
							return
						end
					end

					table.insert(currentTraits, "Santa Hat")
					selected:SetAttribute("Traits", HttpService:JSONEncode(currentTraits))
					Burst:FireAllClients(selected.Name)

					if selected.PrimaryPart then
						local dropPos = selected.PrimaryPart.Position
						local candyAmount = math.random(5, 15)
					end
				end)
			end
		end
	end)

	if mapDropTask then
		task.cancel(mapDropTask)
	end

	mapDropTask = task.spawn(function()
		while isActive do
			task.wait(MAP_DROP_INTERVAL)

			if not isActive then
				break
			end

			local randomPos = getRandomMapPosition()
			local candyAmount = math.random(MAP_DROP_AMOUNT[1], MAP_DROP_AMOUNT[2])
		end
	end)
end

function WinterHour.OnStop()
	if not isActive then
		return
	end

	if hatIdleAnimation then
		hatIdleAnimation:Stop()
		hatIdleAnimation = nil
	end

	if sequenceAnimation then
		sequenceAnimation:Stop()
		sequenceAnimation = nil
	end

	setSantaHatVisibility(false)

	candyCanes = {}
	candyCaneCounter = 0

	winterate:PivotTo(CFrame.new(0, 100000, 0))
	isActive = false
	ReplicatedStorage:SetAttribute("WinterHourEvent", false)

	if strikeTask then
		task.cancel(strikeTask)
		strikeTask = nil
	end

	if mapDropTask then
		task.cancel(mapDropTask)
		mapDropTask = nil
	end

	recentlyTargeted = {}
	setupIdleAnimation()
end

return WinterHour