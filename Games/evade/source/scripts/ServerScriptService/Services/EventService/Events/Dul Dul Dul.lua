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
local recentlyTargeted = {}

local BUILD_DURATION = 13
local HEIGHT_OFFSET = 5

local eventsFolder = Workspace:FindFirstChild("Events") or Instance.new("Folder", Workspace)
eventsFolder.Name = "Events"

local function createDulDulDulCharacter(index)
	local character = Instance.new("Model")
	character.Name = HttpService:GenerateGUID(false)

	local humanoidRootPart = Instance.new("Part")
	humanoidRootPart.Name = "HumanoidRootPart"
	humanoidRootPart.Size = Vector3.new(2, 2, 1)
	humanoidRootPart.CanCollide = true
	humanoidRootPart.Anchored = true
	humanoidRootPart.Transparency = 1
	humanoidRootPart.Parent = character

	local humanoid = Instance.new("Humanoid")
	humanoid.Parent = character
	humanoid.PlatformStand = false
	humanoid.WalkSpeed = 22.5

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
	if not model or not model.Parent then return end

	local roadEnd = Workspace:FindFirstChild("Road") and Workspace.Road:FindFirstChild("End")
	if not roadEnd then return end

	local path = PathfindingService:CreatePath({
		AgentRadius = 2,
		AgentHeight = 5,
		AgentCanJump = false,
		AgentMaxSlope = 45
	})

	local primary = model.PrimaryPart
	if not primary or not primary.Position then
		warn("[DulDulDul] Missing PrimaryPart or Position for model:", model.Name)
		return
	end
	path:ComputeAsync(primary.Position, roadEnd.Position)

	local waypoints = path:GetWaypoints()
	if #waypoints == 0 then return end

	model:SetAttribute("IsBuilding", nil)
	model:SetAttribute("IsRunning", true)
	primary.Anchored = true

	task.spawn(function()
		for _, waypoint in ipairs(waypoints) do
			if not model.Parent then return end

			local targetPos = waypoint.Position + Vector3.new(0, HEIGHT_OFFSET, 0)
			local currentPos = primary.Position
			local distance = (targetPos - currentPos).Magnitude
			local travelTime = distance / 15 -- controls speed
			local facingCFrame = CFrame.lookAt(currentPos, targetPos)

			local tween = TweenService:Create(
				primary,
				TweenInfo.new(travelTime, Enum.EasingStyle.Linear),
				{ CFrame = facingCFrame + facingCFrame.LookVector * distance }
			)

			tween:Play()
			tween.Completed:Wait()
		end

		if model.Parent then
			model:SetAttribute("IsRunning", false)
			model:Destroy()
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

	local primary = character.PrimaryPart
	primary.Anchored = true
	character:SetAttribute("IsBuilding", false)
	character:SetAttribute("IsRunning", true)

	task.spawn(function()
		for i, targetPos in ipairs(waypoints) do
			if not character.Parent then return end
			local currentPos = primary.Position
			local distance = (targetPos - currentPos).Magnitude
			local travelTime = distance / 15
			local facingCFrame = CFrame.lookAt(currentPos, targetPos)

			local tween = TweenService:Create(
				primary,
				TweenInfo.new(travelTime, Enum.EasingStyle.Linear),
				{ CFrame = facingCFrame + facingCFrame.LookVector * distance }
			)
			tween:Play()
			tween.Completed:Wait()

			if i == #waypoints then
				local finalCFrame = CFrame.lookAt(primary.Position, roadEnd.Position)
				local faceTween = TweenService:Create(primary, TweenInfo.new(0.25), {CFrame = finalCFrame})
				faceTween:Play()
				faceTween.Completed:Wait()
				character:SetAttribute("IsRunning", false)
				character:SetAttribute("Gesture", true)
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

			local roadAnimals = CollectionService:GetTagged("Animal")
			local candidates = {}
			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasGalactic = false
					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "Tie" then
									BurstRemote:FireAllClients(animal)
									hasGalactic = true
									break
								end
							end
						end
					end

					if not isRecentlyTargeted and not hasGalactic then
						table.insert(candidates, animal)
					end
				end
			end
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
	AnimalService.spawnAnimal("Noo my examine")
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
end

return DulDulDul