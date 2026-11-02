local Backrooms = {}
local PhysicsService = game:GetService("PhysicsService")
local charAddedConns_BR = {}
local BACKROOMS_GROUP = "BackroomsWalls"
local PLAYER_NOCLIP   = "PlayerNoG"
local PLAYER_GROUP    = "Player"

local function setupBackroomsCollisionGroups()
	pcall(PhysicsService.RegisterCollisionGroup, PhysicsService, BACKROOMS_GROUP)
	pcall(PhysicsService.RegisterCollisionGroup, PhysicsService, PLAYER_NOCLIP)
	pcall(PhysicsService.CollisionGroupSetCollidable, PhysicsService, PLAYER_GROUP,  BACKROOMS_GROUP, true)
	pcall(PhysicsService.CollisionGroupSetCollidable, PhysicsService, PLAYER_NOCLIP, BACKROOMS_GROUP, false)
	pcall(PhysicsService.CollisionGroupSetCollidable, PhysicsService, PLAYER_NOCLIP, PLAYER_NOCLIP,   false)
	pcall(PhysicsService.CollisionGroupSetCollidable, PhysicsService, "Animal",      BACKROOMS_GROUP, false)
	pcall(PhysicsService.CollisionGroupSetCollidable, PhysicsService, "Default",     BACKROOMS_GROUP, true)
end

local function setCharGroupBR(character, group)
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			pcall(PhysicsService.SetPartCollisionGroup, PhysicsService, part, group)
		end
	end
end

local function enableNoclipBR(player)
	if player.Character then setCharGroupBR(player.Character, PLAYER_NOCLIP) end
	if charAddedConns_BR[player] then charAddedConns_BR[player]:Disconnect() end
	charAddedConns_BR[player] = player.CharacterAdded:Connect(function(char)
		task.wait(0.1); setCharGroupBR(char, PLAYER_NOCLIP)
	end)
end

local function disableNoclipBR(player)
	if charAddedConns_BR[player] then charAddedConns_BR[player]:Disconnect(); charAddedConns_BR[player] = nil end
	if player.Character then setCharGroupBR(player.Character, PLAYER_GROUP) end
end



local Workspace           = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local CollectionService   = game:GetService("CollectionService")
local RunService          = game:GetService("RunService")
local Players             = game:GetService("Players")

local AnimalService       = require(ServerScriptService.Services.AnimalService)
local StealService        = require(ServerScriptService.Services.StealService)
local Animals             = require(ReplicatedStorage.Datas.Animals)
local SharedAnimals       = require(ReplicatedStorage.Shared.Animals)
local Rarities            = require(ReplicatedStorage.Datas.Rarities)
local NumberUtils         = require(ReplicatedStorage.Utils.NumberUtils)
local NotificationService = require(ServerScriptService.Services.NotificationService)

local Net = require(ReplicatedStorage.Packages.Net)

local inBackroomsRemote = Net:RemoteEvent("BackroomsService/SetInBackrooms")
local collectZoneRemote = Net:RemoteEvent("BackroomsService/CollectZoneEffect")

local SPAWN_POOL = {
	"To To To Sahur","Secret Lucky Block","Boatito Auratito","Chachechi",
	"Job Job Job Sahur","Brainrot God Lucky Block","Las Tralalaeritas",
	"Cacasito Satalito","Cocofanto Elefanto","Piccione Macchina",
	"Karkerkar Kurkur","La Vacca Saturno Saturnita","Urubini Flamenguini",
	"Tartaruga Cisterna","Girafa Celestre","Trippi Troppi Troppa Trippa",
	"Trenostruzzo Turbo 3000","Tralalero Tralala","Esperso Signora",
	"Pakrahmatmamat","Los Tralalaritos","Matteo","Lumaca Malefica",
	"Chicleterina Bicicleteirina","Dul Dul Dul","La Cucaracha",
	"Robo Grafito","Admin Lucky Block","Odin Din Din Dun","Graipuss Medusi",
}

local TIMER_COLOR = Color3.fromRGB(180, 0, 0)

local MONSTER_SPAWNS = {
	["Monster 1"] = Vector3.new(-572.8, -37.0, -430.8),
	["Monster 2"] = Vector3.new(-414.3, -37.0, -459.3),
	["Monster 3"] = Vector3.new(-328.7, -37.0, -859.3),
}

local collectZoneConnection = nil
local activeDisplays        = {}
local secretSpawnThread     = nil
local secretSpawnActive     = false
local monsterThreads        = {}
local clonedMap             = nil
local disabledParts         = {}

local MONSTER_DETECT_RANGE = 100
local MONSTER_KILL_RANGE   = 12
local MONSTER_CHASE_SPEED  = 28
local MONSTER_PATROL_SPEED = 6
local MONSTER_UPDATE_RATE  = 0.1
local MONSTER_DAMAGE       = 40
local MONSTER_HIT_COOLDOWN = 0.8

local function isCarryingBrainrot(player)
	-- Steal depuis Sammy's base
	local sammyStealing = player:GetAttribute("SammyStealing") == true
		and player:GetAttribute("StealingIndex") ~= nil
		and player:GetAttribute("StealingIndex") ~= ""
	-- Steal normal dans les Backrooms
	local normalStealing = player:GetAttribute("Stealing") == true
	return sammyStealing or normalStealing
end

local function isPlayerInBackrooms(player)
	return player:GetAttribute("InBackrooms") == true
end

local function damagePlayer(player, damage)
	if not player or not player.Character then return end
	local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid and humanoid.Health > 0 then
		humanoid:TakeDamage(damage)
		if humanoid.Health <= 0 then
			pcall(function() StealService:CancelHold(player) end)
		end
	end
end

local function getBackroomsWaypoints()
	local br = Workspace:FindFirstChild("Backrooms")
	if not br then return nil end
	local map = br:FindFirstChild("BackroomsMap")
	if not map then return nil end
	local folder = map:FindFirstChild("BrainrotWaypoints")
	if not folder then return nil end
	local list = {}
	for _, part in ipairs(folder:GetChildren()) do
		if part:IsA("BasePart") then table.insert(list, part) end
	end
	return #list > 0 and list or nil
end

local function getMonsterRoot(monsterModel)
	return monsterModel:FindFirstChild("HumanoidRootPart")
		or monsterModel:FindFirstChild("RootPart")
		or monsterModel:FindFirstChild("Root")
		or monsterModel.PrimaryPart
		or monsterModel:FindFirstChildWhichIsA("BasePart", true)
end

local function moveMonsterTo(root, targetPos, speed, dt)
	if not root or not root.Parent then return end
	local myPos    = root.Position
	local toTarget = Vector3.new(targetPos.X - myPos.X, 0, targetPos.Z - myPos.Z)
	local dist     = toTarget.Magnitude
	if dist < 1 then return end
	local direction = toTarget.Unit
	local step      = math.min(speed * dt, dist)
	local newPos    = Vector3.new(myPos.X + direction.X * step, myPos.Y, myPos.Z + direction.Z * step)
	root.CFrame     = CFrame.lookAt(newPos, newPos + direction)
end

local function loadMonsterAnimations(monsterModel)
	local animController = monsterModel:FindFirstChildOfClass("AnimationController")
	if not animController then return nil end
	local animator = animController:FindFirstChildOfClass("Animator")
	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = animController
	end
	local animFolder = monsterModel:FindFirstChild("Animations")
	if not animFolder then return nil end

	local tracks = {}
	local function loadAnim(name)
		local anim = animFolder:FindFirstChild(name)
		if not anim then return nil end
		local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
		return ok and track or nil
	end

	tracks.idle   = loadAnim("Idle")
	tracks.walk   = loadAnim("Walk")
	tracks.chase  = loadAnim("Chase") or loadAnim("Walk")
	tracks.attack = loadAnim("Attack")
	tracks.current = nil

	function tracks:Play(name)
		local track = self[name]
		if self.current == track then return end
		for _, t in pairs({"idle","walk","chase","attack"}) do
			if self[t] and self[t].IsPlaying then self[t]:Stop() end
		end
		if track then track:Play() end
		self.current = track
	end

	return tracks
end

local function startMonsterAI(monsterModel, active)
	local root = getMonsterRoot(monsterModel)
	if not root then
		warn("[Monster] Aucune BasePart racine trouvée pour : " .. monsterModel.Name)
		return nil
	end

	if not monsterModel.PrimaryPart then
		monsterModel.PrimaryPart = root
	end

	for _, part in ipairs(monsterModel:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored   = false
			part.CanCollide = false
			part.Massless   = true
		end
	end

	for _, part in ipairs(monsterModel:GetDescendants()) do
		if part:IsA("BasePart") and part ~= root then
			local alreadyWelded = false
			for _, c in ipairs(root:GetChildren()) do
				if c:IsA("WeldConstraint") and (c.Part0 == part or c.Part1 == part) then
					alreadyWelded = true; break
				end
			end
			if not alreadyWelded then
				local w = Instance.new("WeldConstraint")
				w.Part0 = root; w.Part1 = part; w.Parent = root
			end
		end
	end

	root.Anchored   = true
	root.CanCollide = false

	local spawnPos = MONSTER_SPAWNS[monsterModel.Name]
	if spawnPos then
		root.CFrame = CFrame.new(spawnPos + Vector3.new(0, 3, 0))
		print("[Monster] " .. monsterModel.Name .. " spawné à sa zone : " .. tostring(spawnPos))
	else
		
		local waypoints = getBackroomsWaypoints()
		if waypoints and #waypoints > 0 then
			local wp = waypoints[math.random(#waypoints)]
			root.CFrame = CFrame.new(wp.Position + Vector3.new(0, 3, 0))
			print("[Monster] " .. monsterModel.Name .. " spawné sur waypoint (fallback)")
		else
			warn("[Monster] Pas de position de spawn pour : " .. monsterModel.Name)
		end
	end

	local anims         = loadMonsterAnimations(monsterModel)
	local patrolTarget  = nil
	local isChasing     = false
	local currentSpeed  = MONSTER_PATROL_SPEED
	local killCooldowns = {}
	local lastUpdate    = 0

	if anims and anims.idle then anims:Play("idle") end

	local thread = task.spawn(function()
		while active[1] do
			local dt = RunService.Heartbeat:Wait()
			if not monsterModel or not monsterModel.Parent then break end
			if not root or not root.Parent then break end

			if patrolTarget then
				local tPos = typeof(patrolTarget) == "Vector3" and patrolTarget
					or (typeof(patrolTarget) == "Instance" and patrolTarget:IsA("BasePart") and patrolTarget.Position)
				if tPos then
					moveMonsterTo(root, tPos, currentSpeed, dt)
				end
			end

			lastUpdate += dt
			if lastUpdate < MONSTER_UPDATE_RATE then continue end
			lastUpdate = 0

			local myPos         = root.Position
			local closestPlayer = nil
			local closestDist   = math.huge

			for _, player in ipairs(Players:GetPlayers()) do
				if not isPlayerInBackrooms(player) then continue end
				local char = player.Character
				if not char then continue end
				local hrp = char:FindFirstChild("HumanoidRootPart")
				if not hrp then continue end
				local d = (hrp.Position - myPos).Magnitude
				if d < closestDist then closestDist = d; closestPlayer = player end
			end

			if closestPlayer and closestDist <= MONSTER_DETECT_RANGE then
				if not isChasing then
					isChasing    = true
					currentSpeed = MONSTER_CHASE_SPEED
					if anims then anims:Play("chase") end
				end
				local targetHRP = closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart")
				if targetHRP then
					patrolTarget = targetHRP.Position
					if closestDist <= MONSTER_KILL_RANGE then
						local now = tick()
						local uid = closestPlayer.UserId
						if not killCooldowns[uid] or (now - killCooldowns[uid]) > MONSTER_HIT_COOLDOWN then
							killCooldowns[uid] = now
							if anims and anims.attack then
								anims:Play("attack")
								task.delay(0.4, function()
									if active[1] then damagePlayer(closestPlayer, MONSTER_DAMAGE) end
								end)
							else
								damagePlayer(closestPlayer, MONSTER_DAMAGE)
							end
						end
					end
				end

			else
				if isChasing then
					isChasing    = false
					currentSpeed = MONSTER_PATROL_SPEED
					if anims then anims:Play("walk") end
				end

				local basePos = MONSTER_SPAWNS[monsterModel.Name] or root.Position
				local needNew = true
				if patrolTarget then
					local tPos = typeof(patrolTarget) == "Vector3" and patrolTarget
						or (typeof(patrolTarget) == "Instance" and patrolTarget:IsA("BasePart") and patrolTarget.Position)
					if tPos then
						needNew = (Vector3.new(tPos.X, myPos.Y, tPos.Z) - myPos).Magnitude < 4
					end
				end
				if needNew then
					local angle   = math.random() * math.pi * 2
					local radius  = math.random(10, 40)
					patrolTarget  = Vector3.new(
						basePos.X + math.cos(angle) * radius,
						basePos.Y,
						basePos.Z + math.sin(angle) * radius
					)
					if anims then anims:Play("walk") end
				end
			end
		end
	end)

	return thread
end

local function spawnMonsters()
	local br = Workspace:FindFirstChild("Backrooms")
	if not br then warn("[Backrooms] Workspace.Backrooms introuvable!"); return end

	local map = br:FindFirstChild("BackroomsMap")
	if not map then warn("[Backrooms] BackroomsMap introuvable!"); return end

	local monstersFolder = map:FindFirstChild("Monsters")
	if not monstersFolder then
		warn("[Backrooms] Dossier 'Monsters' introuvable!")
		return
	end

	print("[Backrooms] -> Monsters Folder")

	local count = 0
	for _, monster in ipairs(monstersFolder:GetChildren()) do
		if monster:IsA("Model") then
			local active = {true}
			local thread = startMonsterAI(monster, active)
			if thread then
				table.insert(monsterThreads, {thread = thread, active = active})
				count += 1
				print("[Backrooms] Monstre démarré : " .. monster.Name)
			end
		end
	end

	if count == 0 then
		warn("[Backrooms] Aucun Model trouvé dans Monsters!")
	else
		print("[Backrooms] " .. count .. " monstres actifs")
	end
end

local function stopMonsters()
	for _, entry in ipairs(monsterThreads) do
		entry.active[1] = false
		pcall(task.cancel, entry.thread)
	end
	monsterThreads = {}
end

local GRADIENT_TAG_MAP = {
	Rainbow="rainbow", Zebra="zebra", OG="og",
	YellowRed="yellowred", Greenred="greenred",
	Meme="meme", SlowGreenRed="slowgreenred",
}

local function buildAnimalText(animalName)
	local data = Animals[animalName]
	if not data then return animalName .. " added to the Spawn Portal", nil end
	local displayName    = data.DisplayName or animalName
	local rarityData     = Rarities[data.Rarity]
	local gradientPreset = rarityData and rarityData.GradientPreset
	local coloredName
	if gradientPreset then
		local tag = GRADIENT_TAG_MAP[gradientPreset]
		coloredName = tag
			and string.format("<%s>%s</%s>", tag, displayName, tag)
			or string.format('<font color="#FFFFFF"><b>%s</b></font>', displayName)
	else
		local color = rarityData and rarityData.Color or Color3.fromRGB(255,255,255)
		local hex = string.format("%02X%02X%02X",
			math.floor(color.R*255), math.floor(color.G*255), math.floor(color.B*255))
		coloredName = string.format('<font color="#%s"><b>%s</b></font>', hex, displayName)
	end
	return coloredName .. '<font color="#FFFFFF"> added to the Spawn Portal</font>', gradientPreset
end

local function getCollectZonePart()
	local br = Workspace:FindFirstChild("Backrooms")
	if not br then return nil end
	local map = br:FindFirstChild("BackroomsMap")
	if not map then return nil end
	local pad = map:FindFirstChild("Pad")
	if not pad then return nil end
	return pad:FindFirstChild("ChaseHitbox") or pad:FindFirstChild("DeliveryHitbox")
end

local function startCollectZoneDetection()
	if collectZoneConnection then collectZoneConnection:Disconnect(); collectZoneConnection = nil end
	local lastCollect = {}
	collectZoneConnection = RunService.Heartbeat:Connect(function()
		local collectPart = getCollectZonePart()
		if not collectPart then return end
		for _, player in ipairs(Players:GetPlayers()) do
			if not player:GetAttribute("SammyStealing") then continue end
			local animalName = player:GetAttribute("StealingIndex")
			if not animalName or animalName == "" then continue end
			if lastCollect[player] == animalName then continue end
			local char = player.Character
			if not char then continue end
			local root = char:FindFirstChild("HumanoidRootPart")
			if not root then continue end
			local pp = OverlapParams.new()
			pp.FilterDescendantsInstances = {char}
			pp.FilterType = Enum.RaycastFilterType.Include
			if #Workspace:GetPartsInPart(collectPart, pp) == 0 then continue end
			lastCollect[player] = animalName
			local puffSoundPath = "Sounds.Sfx." .. ((math.random(2)==1) and "Puff3" or "Puff2")
			local notifText, _  = buildAnimalText(animalName)
			local playerCFrame  = root.CFrame
			for _, p in ipairs(Players:GetPlayers()) do
				collectZoneRemote:FireClient(p, puffSoundPath, playerCFrame)
			end
			StealService:CancelHold(player)
			task.spawn(function()
				if AnimalService.CaveSpawnActive then
					local animalData = Animals[animalName]
					if animalData then AnimalService.spawnAnimal(animalData) end
				end
			end)
			for _, p in ipairs(Players:GetPlayers()) do
				NotificationService.Notify(p, notifText, 6, nil, nil, nil)
			end
		end
		for p in pairs(lastCollect) do
			if not p:GetAttribute("SammyStealing") then lastCollect[p] = nil end
		end
	end)
end

local function stopCollectZoneDetection()
	if collectZoneConnection then collectZoneConnection:Disconnect(); collectZoneConnection = nil end
end

local function getTimer(animalName)
	local data = Animals[animalName]
	if data then
		if data.Rarity == "Secret" or data.Rarity == "Admin" then return 120
		elseif data.Rarity == "Brainrot God" then return 60 end
	end
	return 60
end

local function clearDisplay(spawnPart)
	local d = activeDisplays[spawnPart]
	if not d then return end
	if d.conn   then d.conn:Disconnect() end
	if d.prompt and d.prompt.Parent then d.prompt:Destroy() end
	if d.model  and d.model.Parent  then d.model:Destroy() end
	activeDisplays[spawnPart] = nil
end

local function placeAnimalOnPart(spawnPart, animalName)
	clearDisplay(spawnPart)
	local animalData = Animals[animalName]
	if not animalData then return end
	local animalTemplate = ReplicatedStorage.Models.Animals:FindFirstChild(animalName)
	if not animalTemplate then warn("[Backrooms] Animal model introuvable : " .. animalName); return end
	local displayModel = animalTemplate:Clone()
	if not displayModel.PrimaryPart then
		local p = displayModel:FindFirstChildWhichIsA("BasePart", true)
		if p then displayModel.PrimaryPart = p end
	end
	if not displayModel.PrimaryPart then displayModel:Destroy(); return end
	spawnPart.Transparency = 1; spawnPart.CanCollide = false; spawnPart.CanTouch = false
	displayModel:PivotTo(spawnPart.CFrame)
	displayModel.Parent = Workspace
	local primaryPart = displayModel.PrimaryPart
	for _, part in ipairs(displayModel:GetDescendants()) do
		if part:IsA("BasePart") then
			part:SetAttribute("DefaultTransparency", part.Transparency)
			part.Anchored = false; part.CanCollide = false; part.Massless = true
			if part ~= primaryPart then
				local w = Instance.new("WeldConstraint")
				w.Part0 = primaryPart; w.Part1 = part; w.Parent = primaryPart
			end
		end
	end
	local aw = Instance.new("WeldConstraint")
	aw.Part0 = spawnPart; aw.Part1 = primaryPart; aw.Parent = spawnPart
	primaryPart.Anchored = false; spawnPart.Anchored = true
	local animFolder = ReplicatedStorage.Animations.Animals:FindFirstChild(animalName)
	local idleAnim   = animFolder and animFolder:FindFirstChild("Idle")
	local animCtrl   = displayModel:FindFirstChild("AnimationController")
	if idleAnim and animCtrl then
		local anim = animCtrl:FindFirstChildWhichIsA("Animator") or Instance.new("Animator", animCtrl)
		anim:LoadAnimation(idleAnim):Play()
	end
	local displayName   = animalData.DisplayName or animalName
	local timerDuration = getTimer(animalName)
	local overhead      = ReplicatedStorage.Overheads.AnimalOverhead:Clone()
	overhead.DisplayName.Text  = displayName
	overhead.Price.Text        = "$" .. NumberUtils:ToString(animalData.Price or 0)
	overhead.Generation.Text   = "$" .. NumberUtils:ToString(SharedAnimals:GetGeneration(animalName) or 0) .. "/s"
	overhead.Rarity.Text       = animalData.Rarity
	overhead.Mutation.Visible  = false; overhead.Stolen.Visible = true
	overhead.Stolen.Text       = timerDuration .. "s"; overhead.Stolen.TextColor3 = TIMER_COLOR
	overhead.Traits.Visible    = false
	local rarityData = Rarities[animalData.Rarity]
	if rarityData then
		overhead.Rarity.TextColor3 = rarityData.Color
		if rarityData.StrokeColor then overhead.Rarity.UIStroke.Color = rarityData.StrokeColor end
	end
	local attachment = displayModel:FindFirstChild("OVERHEAD_ATTACHMENT", true)
	if not attachment then
		attachment = Instance.new("Attachment")
		attachment.Name = "OVERHEAD_ATTACHMENT"; attachment.CFrame = CFrame.new(0,0,0)
		overhead.ExtentsOffsetWorldSpace = Vector3.new(0, 5, 0)
		attachment.Parent = primaryPart
	end
	overhead.Adornee = primaryPart; overhead.Parent = attachment
	if rarityData and rarityData.GradientPreset then
		CollectionService:AddTag(overhead.Rarity, "Gradients_" .. rarityData.GradientPreset)
		if animalData.Rarity == "Brainrot God" or animalData.Rarity == "Secret" then
			CollectionService:AddTag(overhead.DisplayName, "Gradients_" .. rarityData.GradientPreset)
		end
	end
	local grabbed = false; local remainingTime = timerDuration
	task.spawn(function()
		while remainingTime > 0 do
			task.wait(1)
			if grabbed then repeat task.wait(0.5) until not grabbed or not displayModel.Parent end
			if not displayModel.Parent or not overhead.Parent then return end
			remainingTime -= 1; overhead.Stolen.Text = remainingTime .. "s"
			if remainingTime <= 0 then
				if not secretSpawnActive or not spawnPart or not spawnPart.Parent then return end
				clearDisplay(spawnPart)
				placeAnimalOnPart(spawnPart, SPAWN_POOL[math.random(#SPAWN_POOL)])
			end
		end
	end)
	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Grab"; prompt.ObjectText = animalName
	prompt.HoldDuration = 1.5; prompt.MaxActivationDistance = 10
	prompt.RequiresLineOfSight = false; prompt.Style = Enum.ProximityPromptStyle.Custom
	prompt.Parent = primaryPart
	local conn
	conn = prompt.Triggered:Connect(function(player)
		if not player or not player:IsA("Player") then return end
		if StealService:IsStealing(player) then return end
		if grabbed then return end
		grabbed = true; prompt.Enabled = false
		local ok = StealService:SimulateSteal(player.Name, animalName, displayModel, overhead, prompt, nil, true)
		if not ok then grabbed = false; prompt.Enabled = true; return end
		local stealInfo = StealService:GetActiveSteal(player)
		if stealInfo and stealInfo.Model then stealInfo.Model:SetAttribute("DropRemainingTime", remainingTime) end
		task.spawn(function()
			repeat task.wait(0.2) until not player:GetAttribute("SammyStealing")
			grabbed = false
		end)
		activeDisplays[spawnPart] = nil
		task.delay(math.random(8, 20), function()
			if not secretSpawnActive or not spawnPart or not spawnPart.Parent then return end
			placeAnimalOnPart(spawnPart, SPAWN_POOL[math.random(#SPAWN_POOL)])
		end)
	end)
	activeDisplays[spawnPart] = {model = displayModel, prompt = prompt, conn = conn}
end

local function stopSecretSpawns()
	secretSpawnActive = false
	if secretSpawnThread then task.cancel(secretSpawnThread); secretSpawnThread = nil end
	for part in pairs(activeDisplays) do clearDisplay(part) end
	activeDisplays = {}
end

local function startSecretSpawns(spawnPartsList)
	if not spawnPartsList or #spawnPartsList == 0 then warn("[Backrooms] Aucun SpawnPart"); return end
	secretSpawnActive = true
	secretSpawnThread = task.spawn(function()
		for _, part in ipairs(spawnPartsList) do
			if not secretSpawnActive then break end
			placeAnimalOnPart(part, SPAWN_POOL[math.random(#SPAWN_POOL)])
			task.wait(1)
		end
	end)
end

local function disableRoadCollisions()
	disabledParts = {}
	local map = Workspace:FindFirstChild("Map")
	if not map then return end
	local function disableFolder(folder)
		if not folder then return end
		for _, part in ipairs(folder:GetDescendants()) do
			if (part:IsA("BasePart") or part:IsA("UnionOperation")) and part.CanCollide then
				part.CanCollide = false; part.CanTouch = false
				table.insert(disabledParts, part)
			end
		end
	end
	disableFolder(map:FindFirstChild("Collisions"))
	local cave = map:FindFirstChild("Cave")
	if cave then disableFolder(cave); disableFolder(cave:FindFirstChild("Collisions")) end
end

local function enableRoadCollisions()
	for _, part in ipairs(disabledParts) do
		if part and part.Parent then part.CanCollide = true; part.CanTouch = true end
	end
	disabledParts = {}
end

local BACKROOMS_SHOW_POS = Vector3.new(-378.455, -4.978, 20.6)
local BACKROOMS_HIDE_POS = Vector3.new(-378.455, -21.935, 20.6)

local function setBackroomsModelPosition(pos)
	local events = Workspace:FindFirstChild("Events")
	local model  = events and events:FindFirstChild("Backrooms")
	if model and model:IsA("Model") then
		local pivot = model:GetPivot()
		model:PivotTo(CFrame.new(pos) * CFrame.fromMatrix(Vector3.zero, pivot.XVector, pivot.YVector, pivot.ZVector))
	else
		warn("[Backrooms] Workspace.Events.Backrooms introuvable")
	end
end

function Backrooms.OnStart()
	inBackroomsRemote.OnServerEvent:Connect(function(player, inside)
		if typeof(inside) == "boolean" then player:SetAttribute("InBackrooms", inside) end
	end)

	setBackroomsModelPosition(BACKROOMS_SHOW_POS)
	ReplicatedStorage:SetAttribute("BackroomsEvent", true)
	setupBackroomsCollisionGroups()
	for _, player in ipairs(Players:GetPlayers()) do
		enableNoclipBR(player)
		player:SetAttribute("InBackrooms", true) -- set côté serveur directement
	end
	-- Nouveaux joueurs pendant l'event
	Players.PlayerAdded:Connect(function(player)
		if ReplicatedStorage:GetAttribute("BackroomsEvent") then
			player:SetAttribute("InBackrooms", true)
		end
	end)

	local mapTemplate = ServerScriptService.Services.EventService.Events.Backrooms:FindFirstChild("BackroomsMap")
	if not mapTemplate then warn("[Backrooms] BackroomsMap template introuvable!"); return end

	local br = Workspace:FindFirstChild("Backrooms")
	if not br then br = Instance.new("Folder"); br.Name = "Backrooms"; br.Parent = Workspace end

	clonedMap = mapTemplate:Clone()
	clonedMap.Name = "BackroomsMap"
	clonedMap.Parent = br

	local ec = ReplicatedStorage:FindFirstChild("Controllers")
		and ReplicatedStorage.Controllers:FindFirstChild("EventController")
	local wallsTemplate = ec
		and ec:FindFirstChild("Events")
		and ec.Events:FindFirstChild("Backrooms")
		and ec.Events.Backrooms:FindFirstChild("BackroomsMapWalls")
	if wallsTemplate then
		local wallsClone = wallsTemplate:Clone()
		wallsClone.Name = "BackroomsMapWalls"; wallsClone.Parent = br
		for _, obj in ipairs(wallsClone:GetDescendants()) do
			if obj:IsA("BasePart") or obj:IsA("UnionOperation") or obj:IsA("MeshPart") then
				obj.Anchored = true; obj.Transparency = 0
				pcall(PhysicsService.SetPartCollisionGroup, PhysicsService, obj, BACKROOMS_GROUP)
			end
		end
	else
		warn("[Backrooms] BackroomsMapWalls introuvable!")
	end

	for _, obj in ipairs(clonedMap:GetDescendants()) do
		if obj:IsA("BasePart") or obj:IsA("UnionOperation") then
			local inMonsters = false
			local p = obj.Parent
			while p and p ~= clonedMap do
				if p.Name == "Monsters" then inMonsters = true; break end
				p = p.Parent
			end
			if inMonsters then continue end

			obj.Anchored = true
			local n = obj.Name:lower()
			if n:find("hitbox") or n:find("collision") then
				obj.CanCollide = false; obj.CanTouch = false; obj.Transparency = 1
			end
		end
	end

	local stairsCol = clonedMap:FindFirstChild("StairsCollision")
	if stairsCol then
		stairsCol.CanCollide = true; stairsCol.CanTouch = true; stairsCol.Transparency = 1
	end

	local portalSpawn    = clonedMap:FindFirstChild("PortalBrainrotSpawn")
	local waypointFolder = clonedMap:FindFirstChild("BrainrotWaypoints")
	local carpetPad      = clonedMap:FindFirstChild("Pad")
	local carpetPart     = carpetPad and (carpetPad:FindFirstChild("ChaseHitbox") or carpetPad:FindFirstChild("DeliveryHitbox"))

	if not portalSpawn    then warn("[Backrooms] PortalBrainrotSpawn introuvable!"); return end
	if not waypointFolder then warn("[Backrooms] BrainrotWaypoints introuvable!"); return end
	if not carpetPart     then warn("[Backrooms] Pad.ChaseHitbox introuvable!"); return end

	local waypoints = {}
	for _, part in ipairs(waypointFolder:GetChildren()) do
		local num = tonumber(part.Name)
		if num and part:IsA("BasePart") then table.insert(waypoints, {num=num, part=part}) end
	end
	table.sort(waypoints, function(a,b) return a.num < b.num end)
	if #waypoints == 0 then warn("[Backrooms] Aucun waypoint!"); return end

	AnimalService.CaveSpawnActive   = true
	AnimalService.CaveWaypoints     = waypoints
	AnimalService.CustomSpawnStart  = portalSpawn
	AnimalService.CustomSpawnEnd    = carpetPart
	AnimalService.CaveCarpetPart    = carpetPart
	AnimalService.CaveSpeedOverride = 110
	AnimalService.CaveVFXPart       = clonedMap:FindFirstChild("SpawnVfxDelay")

	task.wait(2)
	disableRoadCollisions()

	local spawnPartsFolder = clonedMap:FindFirstChild("SpawnParts")
	local spawnPartsList   = {}
	if spawnPartsFolder then
		for _, part in ipairs(spawnPartsFolder:GetDescendants()) do
			if part:IsA("BasePart") then table.insert(spawnPartsList, part) end
		end
	end

	startSecretSpawns(spawnPartsList)
	startCollectZoneDetection()

	task.wait(0.5)
	spawnMonsters()

	print("[Backrooms] OnStart complet!")
end

function Backrooms.OnStop()
	stopMonsters()
	stopSecretSpawns()
	stopCollectZoneDetection()

	for _, player in ipairs(Players:GetPlayers()) do
		player:SetAttribute("InBackrooms", nil)
		disableNoclipBR(player)
		disableNoclipBR(player)
	end

	setBackroomsModelPosition(BACKROOMS_HIDE_POS)
	ReplicatedStorage:SetAttribute("BackroomsEvent", nil)

	AnimalService.CaveSpawnActive      = false
	AnimalService.CaveWaypoints        = nil
	AnimalService.CustomSpawnStart     = nil
	AnimalService.CustomSpawnEnd       = nil
	AnimalService.CaveCarpetPart       = nil
	AnimalService.CaveSpeedOverride    = nil
	AnimalService.CaveVFXPart          = nil
	AnimalService.BackroomsSpawnActive = false
	AnimalService.BackroomsSpawnStart  = nil

	local movingFolder = Workspace:FindFirstChild("MovingAnimals")
	if movingFolder then
		for _, model in ipairs(movingFolder:GetChildren()) do
			if model:GetAttribute("InCave") == true then
				model:SetAttribute("CavePaused", false)
				model:SetAttribute("InCave", false)
				model:SetAttribute("ForceIdle", false)
				local pp = model.PrimaryPart
				if pp then
					local pr = pp:FindFirstChildWhichIsA("ProximityPrompt", true)
					if pr then pr.Enabled = true; pr:SetAttribute("Disabled", false) end
				end
			end
		end
	end

	enableRoadCollisions()

	if clonedMap and clonedMap.Parent then clonedMap:Destroy(); clonedMap = nil end

	local br = Workspace:FindFirstChild("Backrooms")
	if br then
		local walls = br:FindFirstChild("BackroomsMapWalls")
		if walls then walls:Destroy() end
	end

	print("[Backrooms] OnStop complet")
	print("script by Nexoz")
end

return Backrooms