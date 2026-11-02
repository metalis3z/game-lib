local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Net = require(ReplicatedStorage.Packages.Net)
local Burst = Net:RemoteEvent("EventService/Mexico/Burst")

local STBANCAL = {}



local isActive = false
local attackTask = nil
local wanderTask = nil
local playerAttackTask = nil
local recentlyTargeted = {}
local recentlyTargetedPlayers = {}
local spawnedRoaches = {}
local activeAttacks = {}

local WANDER_FOLDER = workspace.Events:FindFirstChild("Wander")

local RAY_PARAMS = RaycastParams.new()
RAY_PARAMS.FilterType = Enum.RaycastFilterType.Include
RAY_PARAMS.FilterDescendantsInstances = {workspace.Map, workspace.Terrain}

local function stickToGround(Position)
	local Origin = Position + Vector3.new(0, 10, 0)
	local Direction = Vector3.new(0, -20, 0)
	local Result = workspace:Raycast(Origin, Direction, RAY_PARAMS)
	if Result then
		return Result.Position + Vector3.new(0, 5, 0)
	end
	local BackupParams = RaycastParams.new()
	BackupParams.FilterType = Enum.RaycastFilterType.Blacklist
	BackupParams.FilterDescendantsInstances = {}
	local BackupResult = workspace:Raycast(Origin, Direction, BackupParams)
	if BackupResult then
		return BackupResult.Position + Vector3.new(0, 5, 0)
	end
	return Position
end

local function getRandomWanderPosition(wanderPart)
	local size = wanderPart.Size
	local cf = wanderPart.CFrame
	local randomX = math.random(-size.X/2, size.X/2)
	local randomZ = math.random(-size.Z/2, size.Z/2)
	local rayOrigin = (cf * CFrame.new(randomX, size.Y/2 + 10, randomZ)).Position
	local rayDirection = Vector3.new(0, -200, 0)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {}
	local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
	if result then
		return result.Position + Vector3.new(0, 5, 0)
	else
		return (cf * CFrame.new(randomX, -size.Y/2, randomZ)).Position + Vector3.new(0, 5, 0)
	end
end

local function createCockroach(position)
	local roach = Instance.new("Model")
	roach.Name = "Roach"
	local rootPart = Instance.new("Part")
	rootPart.Name = "HumanoidRootPart"
	rootPart.Size = Vector3.new(2, 2, 2)
	rootPart.Transparency = 1
	rootPart.CanCollide = false
	rootPart.Anchored = true
	rootPart.CFrame = CFrame.new(position)
	rootPart.Parent = roach
	roach.PrimaryPart = rootPart
	CollectionService:AddTag(roach, "Roach")
	return roach
end

local function spawnRoaches()
	if not WANDER_FOLDER then
		warn("Wander folder not found at workspace.Events.Wander")
		return
	end
	for _, wanderPart in ipairs(WANDER_FOLDER:GetChildren()) do
		if wanderPart:IsA("BasePart") then
			local numRoaches = math.random(1, 3)
			for i = 1, numRoaches do
				local spawnPos = getRandomWanderPosition(wanderPart)
				spawnPos = stickToGround(spawnPos)
				local roach = createCockroach(spawnPos)
				roach.Parent = workspace
				local instruments = {"Violin", "Maracas", "Trumpet", "Sombrero"}
				roach:SetAttribute("Instrument", instruments[math.random(1, #instruments)])
				roach:SetAttribute("Dance", true)
				roach:SetAttribute("IsRunning", false)
				roach:SetAttribute("Shuffle", false)
				table.insert(spawnedRoaches, {
					Model = roach,
					WanderPart = wanderPart,
					LastWander = 0
				})
			end
		end
	end
end

local function followAndAttackAnimal(roachData, target)
	local roach = roachData.Model
	if not (roach and roach.PrimaryPart and target and target.PrimaryPart) then return end
	local attackId = HttpService:GenerateGUID(false)
	activeAttacks[attackId] = true
	roach:SetAttribute("IsRunning", true)
	roach:SetAttribute("Dance", false)
	task.spawn(function()
		local speed = 20
		local stopDistance = 6
		local reached = false
		while isActive and activeAttacks[attackId] and target.Parent and target.PrimaryPart do
			local rPos, tPos = roach.PrimaryPart.Position, target.PrimaryPart.Position
			local dist = (tPos - rPos).Magnitude
			if dist <= stopDistance then
				reached = true
				break
			end
			local dir = (tPos - rPos).Unit
			local step = dir * (speed * RunService.Heartbeat:Wait())
			local newPos = stickToGround(rPos + step)
			roach:PivotTo(CFrame.new(newPos, newPos + dir))
		end
		roach:SetAttribute("IsRunning", false)
		if reached and target and target.PrimaryPart then
			roach:SetAttribute("AttackAnimation", true)
			task.wait(0.3)
			Burst:FireAllClients(target.Name)
			task.wait(0.5)
			local traitsJson = target:GetAttribute("Traits")
			local traits = {}
			if traitsJson then
				local ok, decoded = pcall(function() return HttpService:JSONDecode(traitsJson) end)
				if ok and type(decoded) == "table" then traits = decoded end
			end
			if not table.find(traits, "STBANCAL") then
					table.insert(traits, "STBANCAL")
					target:SetAttribute("Traits", HttpService:JSONEncode(traits))
			end
			task.wait(0.5)
			roach:SetAttribute("AttackAnimation", false)
			local backDir = (roach.PrimaryPart.Position - target.PrimaryPart.Position).Unit
			local retreatPos = stickToGround(roach.PrimaryPart.Position + backDir * 10)
			roach:PivotTo(CFrame.new(retreatPos))
			task.wait(0.5)
			roach:SetAttribute("Dance", true)
		end
		activeAttacks[attackId] = nil
	end)
end

local function moveRoachToTarget(roachData, targetPosition)
	local roach = roachData.Model
	if not roach or not roach.Parent or not roach.PrimaryPart then return end
	roach:SetAttribute("IsRunning", true)
	roach:SetAttribute("Dance", true)
	local startPos = roach.PrimaryPart.Position
	local direction = (targetPosition - startPos).Unit
	local distance = (targetPosition - startPos).Magnitude
	local speed = 30
	local duration = distance / speed
	local startTime = os.clock()
	while os.clock() - startTime < duration do
		if not isActive or not roach.Parent then break end
		local alpha = (os.clock() - startTime) / duration
		local currentPos = startPos:Lerp(targetPosition, alpha)
		currentPos = stickToGround(currentPos)
		roach:PivotTo(CFrame.new(currentPos, currentPos + direction))
		task.wait()
	end
	roach:SetAttribute("IsRunning", false)
end

function STBANCAL.OnStart()
	if isActive then return end
	isActive = true
	ReplicatedStorage:SetAttribute("STBANCALEvent", true)
	spawnRoaches()

	wanderTask = task.spawn(function()
		while isActive do
			task.wait(1)
			for _, roachData in ipairs(spawnedRoaches) do
				local roach = roachData.Model
				local currentTime = os.clock()
				if roach and roach.Parent and (currentTime - roachData.LastWander) > math.random(5, 10) then
					if not roach:GetAttribute("IsRunning") then
						local wanderPos = getRandomWanderPosition(roachData.WanderPart)
						task.spawn(function()
							moveRoachToTarget(roachData, wanderPos)
						end)
						roachData.LastWander = currentTime
					end
				end
			end
		end
	end)

	if attackTask then task.cancel(attackTask) end
	attackTask = task.spawn(function()
		while isActive do
			task.wait(math.random(12, 22))
			if not isActive or #spawnedRoaches == 0 then break end
			local roadAnimals = CollectionService:GetTagged("Animal")
			local currentTime = workspace:GetServerTimeNow()
			for animalName, lastTime in pairs(recentlyTargeted) do
				if (currentTime - lastTime) > 15 then
					recentlyTargeted[animalName] = nil
				end
			end
			local candidates = {}
			for _, animal in ipairs(roadAnimals) do
				if animal.PrimaryPart then
					local isRecentlyTargeted = recentlyTargeted[animal.Name] ~= nil
					local hasSTBANCAL = false
					local currentTraitsJson = animal:GetAttribute("Traits")
					if currentTraitsJson then
						local success, decoded = pcall(function()
							return HttpService:JSONDecode(currentTraitsJson)
						end)
						if success and type(decoded) == "table" then
							for _, trait in ipairs(decoded) do
								if trait == "STBANCAL" then
									hasSTBANCAL = true
									break
								end
							end
						end
					end
					if not isRecentlyTargeted and not hasSTBANCAL then
						table.insert(candidates, animal)
					end
				end
			end
			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local roachData = spawnedRoaches[math.random(1, #spawnedRoaches)]
				if roachData.Model and roachData.Model.Parent then
					followAndAttackAnimal(roachData, selected)
					recentlyTargeted[selected.Name] = currentTime
				end
			end
		end
	end)

	if playerAttackTask then task.cancel(playerAttackTask) end
	playerAttackTask = task.spawn(function()
		while isActive do
			task.wait(math.random(8, 12))
			if not isActive or #spawnedRoaches == 0 then break end
			local currentTime = workspace:GetServerTimeNow()
			for playerName, lastTime in pairs(recentlyTargetedPlayers) do
				if (currentTime - lastTime) > 30 then
					recentlyTargetedPlayers[playerName] = nil
				end
			end
			local candidates = {}
			for _, player in ipairs(Players:GetPlayers()) do
				local character = player.Character
				if character and character:FindFirstChild("HumanoidRootPart") then
					if not recentlyTargetedPlayers[player.Name] then
						table.insert(candidates, player)
					end
				end
			end
			if #candidates > 0 then
				local selected = candidates[math.random(1, #candidates)]
				local roachData = spawnedRoaches[math.random(1, #spawnedRoaches)]
				if roachData.Model and roachData.Model.Parent then
					recentlyTargetedPlayers[selected.Name] = currentTime
				end
			end
		end
	end)
end

function STBANCAL.OnStop()
	if not isActive then return end
	isActive = false
	ReplicatedStorage:SetAttribute("STBANCALEvent", false)
	if attackTask then task.cancel(attackTask) attackTask = nil end
	if wanderTask then task.cancel(wanderTask) wanderTask = nil end
	if playerAttackTask then task.cancel(playerAttackTask) playerAttackTask = nil end
	activeAttacks = {}
	for _, roachData in ipairs(spawnedRoaches) do
		if roachData.Model and roachData.Model.Parent then
			roachData.Model:Destroy()
		end
	end
	spawnedRoaches = {}
	recentlyTargeted = {}
	recentlyTargetedPlayers = {}
end

return STBANCAL