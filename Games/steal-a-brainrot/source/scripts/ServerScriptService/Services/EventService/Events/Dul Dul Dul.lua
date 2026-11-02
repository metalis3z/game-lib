local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local PathfindingService = game:GetService("PathfindingService")
local HttpService = game:GetService("HttpService")
local Net = require(ReplicatedStorage.Packages.Net)

local AnimalService = require(game:GetService("ServerScriptService").Services.AnimalService)

local BurstRemote = Net:RemoteEvent("EventService/Dul Dul Dul/Burst")

local DulDulDul = {}
local isActive = false
local dulCharacters = {}
local runningTasks = {}
local usedDulIndices = {}
local maindul

local BUILD_DURATION = 10
local HEIGHT_OFFSET = 4.5


local eventsFolder = Workspace:FindFirstChild("Events") or Instance.new("Folder", Workspace)
eventsFolder.Name = "Events"

local function createDulDulDulCharacter(index)
	local character = Instance.new("Model")
	character.Name = HttpService:GenerateGUID(false)

	local humanoidRootPart = Instance.new("Part")
	humanoidRootPart.Name = "HumanoidRootPart"
	humanoidRootPart.Size = Vector3.new(2, 2, 1)
	humanoidRootPart.Anchored = true
	humanoidRootPart.CanCollide = false
	humanoidRootPart.Transparency = 1
	humanoidRootPart.Parent = character

	local humanoid = Instance.new("Humanoid")
	humanoid.Parent = character
	humanoid.PlatformStand = true

	character.PrimaryPart = humanoidRootPart

	CollectionService:AddTag(character, "DulDulDul")
	character:SetAttribute("IsBuilding", true)
	character:SetAttribute("IsRunning", false)
	character:SetAttribute("Gesture", false)
	character:SetAttribute("AttackAnimation", false)
	character:SetAttribute("FinishAttackAnimation", false)
	character:SetAttribute("Index", index)

	local dulFolder = eventsFolder:FindFirstChild("Dul Dul Dul")
	if dulFolder then
		local posFolder = dulFolder:FindFirstChild("Positions")
		if posFolder then
			local targetPos = posFolder:FindFirstChild(tostring(index))
			if targetPos and targetPos:IsA("BasePart") then
				humanoidRootPart.CFrame = targetPos.CFrame + Vector3.new(0, HEIGHT_OFFSET, 0)
			end
		end
	end

	character.Parent = workspace

	return character
end

local function startPathfinding(model)
	if not model.Parent then return end

	local roadEnd = Workspace:FindFirstChild("Road") and Workspace.Road:FindFirstChild("End")
	if not roadEnd then return end

	local path = PathfindingService:CreatePath({
		AgentRadius = 2,
		AgentHeight = 5,
		AgentCanJump = true,
		AgentJumpHeight = 6,
		AgentMaxSlope = 45
	})

	path:ComputeAsync(model.PrimaryPart.Position, roadEnd.Position)
	local waypoints = path:GetWaypoints()

	model:SetAttribute("IsBuilding", nil)
	model:SetAttribute("IsRunning", true)
	model.PrimaryPart.Anchored = true

	task.spawn(function()
		for _, waypoint in ipairs(waypoints) do
			if not model.Parent then return end

			local targetPosition = waypoint.Position + Vector3.new(0, HEIGHT_OFFSET, 0)
			local direction = (targetPosition - model.PrimaryPart.Position).Unit
			local distance = (targetPosition - model.PrimaryPart.Position).Magnitude
			local travelTime = distance / 22.5

			local goalCFrame = CFrame.new(targetPosition, targetPosition + direction)

			local tween = TweenService:Create(
				model.PrimaryPart,
				TweenInfo.new(travelTime, Enum.EasingStyle.Linear),
				{CFrame = goalCFrame}
			)
			tween:Play()
			tween.Completed:Wait()
		end

		if model.Parent then
			local index = model:GetAttribute("Index")
			if index ~= 1 then
				model:Destroy()
			else
				model:SetAttribute("Gesture", true)
				model:SetAttribute("IsRunning", false)
				model.PrimaryPart.Anchored = true
			end
		end

	end)
end

local function moveMainDulWithWaypoints(character, dulFolder)
	if not character or not character.Parent then return end

	local pathFolder = dulFolder:FindFirstChild("Path")
	local roadEnd = Workspace:FindFirstChild("Road") and Workspace.Road:FindFirstChild("End")
	if not pathFolder or not roadEnd then return end

	local waypoints = {}
	for i = 1, 4 do
		local wp = pathFolder:FindFirstChild(tostring(i))
		if wp and wp:IsA("BasePart") then
			table.insert(waypoints, wp.Position + Vector3.new(0, HEIGHT_OFFSET, 0))
		end
	end

	character:SetAttribute("IsBuilding", false)
	character:SetAttribute("IsRunning", true)
	character.PrimaryPart.Anchored = true

	task.spawn(function()
		for i, targetPos in ipairs(waypoints) do
			if not character.Parent then return end

			local direction = (targetPos - character.PrimaryPart.Position).Unit
			local distance = (targetPos - character.PrimaryPart.Position).Magnitude
			local travelTime = distance / 22.5

			local tween = TweenService:Create(
				character.PrimaryPart,
				TweenInfo.new(travelTime, Enum.EasingStyle.Linear),
				{CFrame = CFrame.new(targetPos, targetPos + direction)}
			)

			tween:Play()
			tween.Completed:Wait()

			if i == #waypoints then
				local finalCFrame = CFrame.lookAt(character.PrimaryPart.Position, roadEnd.Position)
				local faceTween = TweenService:Create(character.PrimaryPart, TweenInfo.new(0.25), {CFrame = finalCFrame})
				faceTween:Play()
				faceTween.Completed:Wait()

				character:SetAttribute("IsRunning", false)
				character:SetAttribute("Gesture", true)
				character.PrimaryPart.Anchored = true

			end
		end
	end)
end

local function makeCharacterGesture(character, duration)
	if not character or not character.Parent then return end

	character:SetAttribute("Gesture", true)
	task.delay(duration or 2, function()
		if character and character.Parent then
			character:SetAttribute("Gesture", false)
		end
	end)
end

local function spawnDulDulDulCharacters()
	local numCharacters = 4

	local dulFolder = eventsFolder:FindFirstChild("Dul Dul Dul")
	if not dulFolder then return end
	local posFolder = dulFolder:FindFirstChild("Positions")
	if not posFolder then return end

	local totalPositions = #posFolder:GetChildren()
	local availableIndices = {}

	for i = 1, math.min(numCharacters, totalPositions) do
		if not usedDulIndices[i] then
			table.insert(availableIndices, i)
		end
	end

	if #availableIndices == 0 then
		usedDulIndices = {}
		for i = 1, math.min(numCharacters, totalPositions) do
			table.insert(availableIndices, i)
		end
	end

	for i = 1, numCharacters do
		local index = availableIndices[i]
		if index then
			usedDulIndices[index] = true
			local character = createDulDulDulCharacter(index)
			if character then
				table.insert(dulCharacters, character)
			end
		end
	end
end

local function startRunningPhase()
	if not isActive then return end

	local dulFolder = eventsFolder:FindFirstChild("Dul Dul Dul")
	if not dulFolder then return end

	for i, character in ipairs(dulCharacters) do
		if character and character.Parent then
			local index = character:GetAttribute("Index") or i

			character:Destroy()

			local newCharacter = createDulDulDulCharacter(index)

			if newCharacter then
				local dulFolder = eventsFolder:FindFirstChild("Dul Dul Dul")
				local posFolder = dulFolder and dulFolder:FindFirstChild("Positions")
				local targetPos = posFolder and posFolder:FindFirstChild(tostring(index))

				if targetPos and targetPos:IsA("BasePart") then
					newCharacter:SetPrimaryPartCFrame(targetPos.CFrame + Vector3.new(0, HEIGHT_OFFSET, 0))
				end

				if index == 1 then
					maindul = newCharacter
					moveMainDulWithWaypoints(newCharacter, dulFolder)
				else
					startPathfinding(newCharacter)
				end
			end
		end
	end
end

local function startBuildingPhase()
	ReplicatedStorage:SetAttribute("DulDulDulConstructionStart", workspace:GetServerTimeNow())
	ReplicatedStorage:SetAttribute("DulDulDulEvent", true)

	for _, character in ipairs(dulCharacters) do
		if character and character.Parent then
			character:SetAttribute("IsBuilding", true)

			local gestureTask = task.spawn(function()
				task.wait(math.random(1, 3))
				makeCharacterGesture(character, 1.5)

				task.wait(math.random(2, 4))
				makeCharacterGesture(character, 1)
			end)
			table.insert(runningTasks, gestureTask)
		end
	end

	local buildTask = task.delay(BUILD_DURATION, function()
		if not isActive then return end
		startRunningPhase()
	end)
	table.insert(runningTasks, buildTask)
end

local function startRandomBursts()
	if not isActive then return end

	local burstTask = task.spawn(function()
		while isActive do
			task.wait(math.random(3, 8))
			if not isActive then break end

			local randomAnimalId = math.random(1, 100)
			BurstRemote:FireAllClients(randomAnimalId)
		end
	end)
	table.insert(runningTasks, burstTask)
end

function DulDulDul.OnStart()
	if isActive then return end

	isActive = true

	spawnDulDulDulCharacters()

	local startTask = task.delay(2, startBuildingPhase)
	table.insert(runningTasks, startTask)

	startRandomBursts()
	local function startAttackingAnimals()
		if not isActive then return end

		local attackTask = task.spawn(function()
			while isActive do
				task.wait(math.random(7, 12))
				if not isActive or not maindul or not maindul.Parent then break end

				local closestAnimal, closestDist
				for _, animal in pairs(Workspace:GetChildren()) do
					if animal:FindFirstChild("HumanoidRootPart") and CollectionService:HasTag(animal, "Animal") then
						local dist = (animal.HumanoidRootPart.Position - maindul.PrimaryPart.Position).Magnitude
						if dist < 25 and (not closestDist or dist < closestDist) then
							closestAnimal, closestDist = animal, dist
						end
					end
				end

				if closestAnimal then
					maindul:SetAttribute("AttackAnimation", true)
					task.wait(1.2)
					maindul:SetAttribute("FinishAttackAnimation", true)

					local animalId = closestAnimal:GetAttribute("AnimalId")
					if animalId then
						pcall(function()
							AnimalService.addTrait(animalId, "Tie")
						end)

						pcall(function()
							BurstRemote:FireAllClients(animalId)
						end)
					end

					task.wait(0.5)
					maindul:SetAttribute("AttackAnimation", false)
					maindul:SetAttribute("FinishAttackAnimation", false)
				end
			end
		end)

		table.insert(runningTasks, attackTask)
	end
	AnimalService.spawnAnimal("Dul Dul Dul")
end

function DulDulDul.OnStop()
	if not isActive then return end

	isActive = false

	for _, taskThread in ipairs(runningTasks) do
		if taskThread then
			task.cancel(taskThread)
		end
	end
	runningTasks = {}

	for _, character in ipairs(dulCharacters) do
		if character and character.Parent then
			CollectionService:RemoveTag(character, "DulDulDul")
			CollectionService:RemoveTag(character, "DulDulDulPlayerVFX")
			character:Destroy()
		end
	end
	dulCharacters = {}

	if maindul and maindul.Parent then
		maindul:Destroy()
	end
	maindul = nil
	usedDulIndices = {}

	ReplicatedStorage:SetAttribute("DulDulDulConstructionStart", nil)
	ReplicatedStorage:SetAttribute("DulDulDulEvent", nil)
end

return DulDulDul