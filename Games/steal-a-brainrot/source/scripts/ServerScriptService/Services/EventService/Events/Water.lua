local Water = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local ServerStorage = game:GetService("ServerStorage")
local TweenService = game:GetService("TweenService")
local Net = require(ReplicatedStorage.Packages.Net)
local SharedAnimals = require(ReplicatedStorage.Shared.Animals)

local WaterHitRemote = Net:RemoteEvent("EventService/Water/Burst")

local COOLDOWN_TIME = 15	
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local NPC_NAME = "Orcalero Orcala"
local NUM_ORCALEROS = 3
local SHARKS_FOLDER_NAME = "Sharks"
local ROUTE_FOLDER = Workspace:WaitForChild("Events"):WaitForChild("Water")
local ORCALERO_SPEED = 2

local ORIGINAL_GRAVITY = Workspace.Gravity
local ORIGINAL_AMBIENT = Lighting.Ambient
local ORIGINAL_OUTDOOR_AMBIENT = Lighting.OutdoorAmbient
local ORIGINAL_CLOCKTIME = Lighting.ClockTime
local BLUE_AMBIENT = Color3.fromRGB(50, 120, 200)
local BLUE_OUTDOOR = Color3.fromRGB(80, 120, 220)
local LOW_GRAVITY = 50
local ANIMAL_POS
local NIGHT_CLOCKTIME = 0

local isActive
local NPCState = {}
local BodyMoverRefs = {}
local SpawnedNPCs = {}
local npcShootConnections = {}
local movementTasks = {}

local function stopAnims(rig)
	local controller = rig:FindFirstChildOfClass("Humanoid") or rig:FindFirstChildOfClass("AnimationController")
	if controller then
		local animator = controller:FindFirstChildOfClass("Animator")
		if animator then
			for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
				track:Stop()
			end
		else
			warn("Animator not found in controller")
		end
	else
		warn("No Humanoid or AnimationController found in rig")
	end
end

function Water:_addWetTrait(animal)
	local traitsJson = animal:GetAttribute("Traits")
	local traits = {}
	if traitsJson then
		local ok, decoded = pcall(function() return HttpService:JSONDecode(traitsJson) end)
		if ok and type(decoded) == "table" then traits = decoded end
	end

	for _, trait in ipairs(traits) do
		if trait == "Shark Fin" then return end
	end

	table.insert(traits, "Shark Fin")
	animal:SetAttribute("Traits", HttpService:JSONEncode(traits))
end


function Water:_hasWetTrait(animal)
	local traitsJson = animal:GetAttribute("Traits")
	local traits = {}
	if traitsJson then
		local ok, decoded = pcall(function() return HttpService:JSONDecode(traitsJson) end)
		if ok and type(decoded) == "table" then traits = decoded end
	end
	for _, trait in ipairs(traits) do
		if trait == "Shark Fin" then
			return true
		end
	end
	return false
end

local function playWaterMusic()
	local music = Workspace:FindFirstChild("Sound")
		and Workspace.Sound:FindFirstChild("Events")
		and Workspace.Sound.Events:FindFirstChild("Water2")
		and Workspace.Sound.Events.Water2:FindFirstChild("WaterMusic")
	if music then
		music.Looped = true
		music.Volume = 1
		music:Play()
	end
end

local function stopWaterMusic()
	local music = Workspace:FindFirstChild("Sound")
		and Workspace.Sound:FindFirstChild("Events")
		and Workspace.Sound.Events:FindFirstChild("Water2")
		and Workspace.Sound.Events.Water2:FindFirstChild("WaterMusic")
	if music then
		music:Stop()
	end
end

local function getRouteParts()
	local routePoints = {}
	local wanderPart = workspace:FindFirstChild("Events") and workspace.Events:FindFirstChild("Water") and workspace.Events.Water:FindFirstChild("Wander")
	if not wanderPart or not wanderPart:IsA("BasePart") then
		warn("[WaterEvent] Wander part not found or invalid")
		return {}
	end

	local size = wanderPart.Size
	local center = wanderPart.Position
	local count = 7

	for _ = 1, count do
		local offset = Vector3.new(
			(math.random() - 0.5) * size.X,
			(math.random() - 0.5) * size.Y,
			(math.random() - 0.5) * size.Z
		)
		local point = center + offset
		table.insert(routePoints, point)
	end

	return routePoints
end

local function getAnimals()
	local movingAnimalsFolder = Workspace:FindFirstChild("MovingAnimals")
	local animals = {}
	if movingAnimalsFolder then
		for _, animal in ipairs(movingAnimalsFolder:GetChildren()) do
			if animal:IsA("Model") and animal.PrimaryPart then
				table.insert(animals, animal)
			end
		end
	end
	return animals
end

local function setAtmosphere(activate)
	if activate then
		Lighting.Ambient = BLUE_AMBIENT
		Lighting.OutdoorAmbient = BLUE_OUTDOOR
		Workspace.Gravity = LOW_GRAVITY
		Lighting.ClockTime = NIGHT_CLOCKTIME
	else
		Lighting.Ambient = ORIGINAL_AMBIENT
		Lighting.OutdoorAmbient = ORIGINAL_OUTDOOR_AMBIENT
		Workspace.Gravity = ORIGINAL_GRAVITY
		Lighting.ClockTime = ORIGINAL_CLOCKTIME
	end
end

local function spawnNPCs()
	local sharksFolder = Workspace:FindFirstChild(SHARKS_FOLDER_NAME)
	if not sharksFolder then
		sharksFolder = Instance.new("Folder")
		sharksFolder.Name = SHARKS_FOLDER_NAME
		sharksFolder.Parent = Workspace
	end
	SpawnedNPCs = {}

	for i = 1, NUM_ORCALEROS do
		local template = SharedAnimals.GetAnimatedModel(nil, "Orcalero Orcala", "Walk")
		template.Parent = sharksFolder
		template:SetAttribute("Orcalero", true)
		template.Name = template.Name..tostring(i)
		for i, part in pairs(template:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Anchored = true
			end
		end

		for i, emitter in pairs(template:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				emitter.Enabled = false
			end
		end

		SpawnedNPCs[template.Name] = template
	end

	for i = 1, NUM_ORCALEROS do
		local tralaleroTemplate = SharedAnimals.GetAnimatedModel(nil, "Tralalero Tralala", "Walk")
		tralaleroTemplate.Parent = sharksFolder
		tralaleroTemplate.Name = tralaleroTemplate.Name..tostring(i)
		tralaleroTemplate:SetAttribute("Tralalero", true)
		for i, part in pairs(tralaleroTemplate:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Anchored = true
			end
		end

		for i, emitter in pairs(tralaleroTemplate:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				emitter.Enabled = false
			end
		end

		SpawnedNPCs[tralaleroTemplate.Name] = tralaleroTemplate
	end

	for i, v in pairs(SpawnedNPCs) do
		if v:IsA("Model") then
			for i, emitters in pairs(v:GetDescendants()) do
				if emitters:IsA("ParticleEmitter") then
					emitters.Enabled = false
				end
			end
		end
	end

	return sharksFolder
end

local function wander(npcModel, waypoints)
	if not npcModel or not npcModel.PrimaryPart then return end
	if not waypoints or #waypoints == 0 then
		warn("[wander] Invalid waypoints for", npcModel.Name)
		return
	end

	if movementTasks[npcModel] then
		movementTasks[npcModel]:Disconnect()
	end

	local idx = 1

	local conn
	conn = RunService.Heartbeat:Connect(function(dt)
		if not npcModel or not npcModel.PrimaryPart then
			conn:Disconnect()
			movementTasks[npcModel] = nil
			return
		end

		local currentPos = npcModel.PrimaryPart.Position
		local target = waypoints[idx]
		local dir = target - currentPos
		local dist = dir.Magnitude

		if dist < 0.5 then
			idx += 1
			if idx > #waypoints then
				idx = 1
			end
			target = waypoints[idx]
			dir = target - currentPos
			dist = dir.Magnitude
			if dist == 0 then return end
		end

		if dist == 0 then return end

		local dirUnit = dir.Unit
		local speed = 30
		local moveDelta = dirUnit * speed * dt

		local nextPos = (moveDelta.Magnitude >= dist) and target or (currentPos + moveDelta)

		local lookCFrame = CFrame.lookAt(nextPos, nextPos + dirUnit)
		npcModel:SetPrimaryPartCFrame(lookCFrame)
	end)

	movementTasks[npcModel] = conn
end

local function struckVFX(animal)
	local assetsFolder = ReplicatedStorage:FindFirstChild("Assets")
	local waterFolder = assetsFolder and assetsFolder:FindFirstChild("Water")
	local struckTemplate = waterFolder and waterFolder:FindFirstChild("StruckVFX")
	if struckTemplate and animal.PrimaryPart then
		local vfx = struckTemplate:Clone()
		vfx.Parent = animal.PrimaryPart
		if vfx:IsA("ParticleEmitter") then
			vfx:Emit(vfx:GetAttribute("EmitCount") or 100)
		end
		game:GetService("Debris"):AddItem(vfx, 1)
	end
end

local function _impactAnimal()
	local animals = workspace.MovingAnimals:GetChildren()
	if #animals == 0 then return end

	local animal = animals[math.random(1, #animals)]
	if not animal or not animal.PrimaryPart then return end

	local availableSharks = {}
	for _, npcData in pairs(NPCState) do
		local shark = npcData.Model
		if shark and shark.PrimaryPart then
			table.insert(availableSharks, shark)
		end
	end

	if #availableSharks == 0 then
		warn("[WaterEvent] No available sharks to attack.")
		return
	end

	local shark = availableSharks[math.random(1, #availableSharks)]

	if movementTasks[shark] then
		movementTasks[shark]:Disconnect()
		movementTasks[shark] = nil
	end

	local connection
	connection = RunService.Heartbeat:Connect(function(dt)
		if not shark or not shark.Parent or not animal or not animal.Parent then
			connection:Disconnect()
			movementTasks[shark] = nil
			return
		end

		local sharkBody = shark.PrimaryPart
		local targetPos = animal.PrimaryPart.Position
		local currentPos = sharkBody.Position
		local dir = targetPos - currentPos
		local distance = dir.Magnitude
		local HIT_DISTANCE = 1

		if distance < HIT_DISTANCE then
			connection:Disconnect()
			movementTasks[shark] = nil

			local animController = shark:FindFirstChildWhichIsA("AnimationController")
			if animController then
				local attackAnim = shark:GetAttribute("Orcalero") and game.ReplicatedStorage.Controllers.EventController.Events.Water.OrcaleroAttack
					or shark:GetAttribute("Tralalero") and game.ReplicatedStorage.Controllers.EventController.Events.Water.TralaleroAttack

				if attackAnim then
					local anim = animController:LoadAnimation(attackAnim)
					anim:Play()
					struckVFX(animal)
					Net:RemoteEvent("EventService/Water/Burst"):FireAllClients(animal, animal.Name)
					Water:_addWetTrait(animal)
					task.wait(anim.Length)
					anim:Stop()
				end
			end

			task.wait(0.3)

			local routePoints = getRouteParts() 
			wander(shark, routePoints)
			return
		end

		local dirUnit = dir.Unit
		local speed = 70
		local moveDelta = dirUnit * speed * dt
		local nextPos = (moveDelta.Magnitude >= distance) and targetPos or (currentPos + moveDelta)

		local lookCFrame = CFrame.lookAt(nextPos, nextPos + dirUnit)
		shark:SetPrimaryPartCFrame(lookCFrame)
	end)

	return true
end

local function activateNPCs()
	local sharksFolder = spawnNPCs()
	local routes = getRouteParts()
	local swimAnim = game.ReplicatedStorage.Controllers.EventController.Events.Water.OrcaleroSwim
	local swim2Anim = game.ReplicatedStorage.Controllers.EventController.Events.Water.TralaleroSwim
	local usedIndices = {}
	local i = 1
	for npcName, npc in pairs(SpawnedNPCs) do
		if npc and npc.PrimaryPart then
			local routeIndex
			repeat
				routeIndex = math.random(1, #routes)
			until not usedIndices[routeIndex]
			usedIndices[routeIndex] = true
			npc:SetPrimaryPartCFrame(CFrame.new(routes[routeIndex]))
			NPCState[npcName] = {Model = npc, OriginalPosition = routes[routeIndex]}
			stopAnims(npc)

			if npc:GetAttribute("Orcalero") == true then
				npc:FindFirstChildWhichIsA("AnimationController"):LoadAnimation(swimAnim):Play()
			end

			if npc:GetAttribute("Tralalero") == true then
				npc:FindFirstChildWhichIsA("AnimationController"):LoadAnimation(swim2Anim):Play()
			end

			local routePoints = getRouteParts()
			wander(npc, routePoints)
		end
		i = i + 1
	end
end

local function deactivateNPCs()
	for npcName, data in pairs(NPCState) do
		local npc = data.Model
		if npc and data.OriginalPosition then
			npc.PrimaryPart.Position = data.OriginalPosition
			npc:Destroy()
		end
	end
	NPCState = {}
	for _, conn in ipairs(npcShootConnections) do
		if conn then conn:Disconnect() end
	end
	npcShootConnections = {}
	for _, taskObj in ipairs(movementTasks) do
		if taskObj then task.cancel(taskObj) end
	end
	movementTasks = {}
	local sharksFolder = Workspace:FindFirstChild(SHARKS_FOLDER_NAME)

	for _, taskObj in pairs(movementTasks) do
		if taskObj then task.cancel(taskObj) end
	end
	movementTasks = {}
	if sharksFolder then sharksFolder:Destroy() end
end

local function startevent()
	while isActive do
		task.wait(1.5)
		_impactAnimal()
		task.wait(math.random(5,10))
		if not isActive then
			break
		end
	end
end

function Water.OnStart()
	isActive = true
	activateNPCs()
	task.spawn(function()
		startevent()
	end)
end

function Water.OnStop()
	isActive = false
	deactivateNPCs()
end

return Water