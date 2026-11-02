-- ============================================================
--  EVENT 1x1x1x1 — ModuleScript SERVEUR
--  Emplacement : ServerScriptService/Services/EventService/Events/1x1x1x1
--  
--  AUCUN script supplémentaire nécessaire.
--  Tout est géré ici : map, waypoints, noclip cave.
-- ============================================================

local guest = {}

local Players             = game:GetService("Players")
local PhysicsService      = game:GetService("PhysicsService")
local CollectionService   = game:GetService("CollectionService")
local ServerScriptService = game:GetService("ServerScriptService")

local AnimalService = require(ServerScriptService.Services.AnimalService)

-- ──────────────────────────────────────────────────────────────
--  CONFIGURATION
--  Noms lus directement dans tes fichiers .rbxm :
--    • "PlayerNoG"  = CollisionGroup des murs de la cave
--    • "Default"    = CollisionGroup normal des joueurs
--    • "Cave"       = nom du Model dans workspace.Map
--    • "Collisions" = dossier de parts à l'intérieur de Cave
-- ──────────────────────────────────────────────────────────────
local CAVE_GROUP    = "PlayerNoG"
local DEFAULT_GROUP = "Player" -- les joueurs sont dans le groupe "Player" dans ce jeu

local SideMap         = nil
local playerAddedConn = nil
local charAddedConns  = {}

-- ──────────────────────────────────────────────────────────────
--  Groupe de collision : initialisation unique (lazy)
-- ──────────────────────────────────────────────────────────────
local collisionReady = false

local function setupCollisionGroups()
	if collisionReady then return end
	collisionReady = true

	-- Créer le groupe si inexistant (sans erreur s'il existe déjà)
	pcall(PhysicsService.RegisterCollisionGroup, PhysicsService, CAVE_GROUP)

	-- Règle hors-event : joueurs Default BLOQUÉS par les murs PlayerNoG
	pcall(PhysicsService.CollisionGroupSetCollidable, PhysicsService, DEFAULT_GROUP, CAVE_GROUP, true)

	-- Règle en-event : joueurs mis en PlayerNoG TRAVERSENT les murs PlayerNoG
	pcall(PhysicsService.CollisionGroupSetCollidable, PhysicsService, CAVE_GROUP, CAVE_GROUP, false)

	-- Assigner les murs de la cave au groupe PlayerNoG
	local cave = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Cave", true)
		or workspace:FindFirstChild("Cave")

	if cave then
		local collisionsFolder = cave:FindFirstChild("Collisions")
		local target = collisionsFolder or cave
		local count = 0
		for _, part in ipairs(target:GetDescendants()) do
			if part:IsA("BasePart") then
				pcall(PhysicsService.SetPartCollisionGroup, PhysicsService, part, CAVE_GROUP)
				count += 1
			end
		end
		print(string.format("[1x1x1x1] %d parts cave → groupe '%s'", count, CAVE_GROUP))
	else
		warn("[1x1x1x1] Model 'Cave' introuvable ! Vérifie workspace.Map.Cave")
	end
end

-- ──────────────────────────────────────────────────────────────
--  Noclip cave : mettre le character d'un joueur dans PlayerNoG
-- ──────────────────────────────────────────────────────────────
local function setCharGroup(character, group)
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			pcall(PhysicsService.SetPartCollisionGroup, PhysicsService, part, group)
		end
	end
end

local function enableNoclip(player)
	if player.Character then
		setCharGroup(player.Character, CAVE_GROUP)
	end
	if charAddedConns[player] then charAddedConns[player]:Disconnect() end
	charAddedConns[player] = player.CharacterAdded:Connect(function(char)
		task.wait(0.1)
		setCharGroup(char, CAVE_GROUP)
	end)
end

local function disableNoclip(player)
	if charAddedConns[player] then
		charAddedConns[player]:Disconnect()
		charAddedConns[player] = nil
	end
	if player.Character then
		setCharGroup(player.Character, DEFAULT_GROUP)
	end
end

-- ──────────────────────────────────────────────────────────────
--  ON START
-- ──────────────────────────────────────────────────────────────
function guest.OnStart()
	print("[1x1x1x1] OnStart !")

	-- 1) Collision groups + cave (se fait une seule fois)
	setupCollisionGroups()

	-- 2) Cloner et placer la map de l'event
	local MapTemplate = script:FindFirstChild("1x1x1x1Map")
	if not MapTemplate then
		warn("[1x1x1x1] '1x1x1x1Map' introuvable dans le script !")
		return
	end

	SideMap = MapTemplate:Clone()
	SideMap.Name = "1x1x1x1Map"
	SideMap.Parent = workspace
	CollectionService:AddTag(SideMap, "1x1x1x1Map")

	task.wait(0.6)

	-- 3) CanQuery sur Path pour les raycasts
	local PathFolder = SideMap:FindFirstChild("Path")
	if PathFolder then
		for _, part in ipairs(PathFolder:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanQuery = true
			end
		end
	else
		warn("[1x1x1x1] Dossier 'Path' introuvable dans 1x1x1x1Map !")
	end

	-- 4) Waypoints pour AnimalService
	local waypoints = {}
	if PathFolder then
		for _, part in ipairs(PathFolder:GetChildren()) do
			local num = tonumber(part.Name)
			if num and part:IsA("BasePart") then
				table.insert(waypoints, { num = num, part = part })
			end
		end
		table.sort(waypoints, function(a, b) return a.num < b.num end)
	end

	if #waypoints > 0 then
		table.insert(waypoints, { num = math.huge, part = workspace.Road.End })
		print("[1x1x1x1] " .. (#waypoints - 1) .. " waypoints + Road.End")
		AnimalService.EventWaypoints      = waypoints
		AnimalService.EventWaypointActive = true
		AnimalService.CaveSpeedOverride   = 75 -- vitesse dans la cave 1x1x1x1
		-- Spawn start = premier waypoint de la cave
		AnimalService.CustomSpawnStart    = waypoints[1].part
		-- Spawn end = tapis à la sortie de la cave
		local carpet = SideMap:FindFirstChild("CarpetExtension", true)
		AnimalService.CustomSpawnEnd      = carpet or waypoints[#waypoints - 1].part
		print("[1x1x1x1] SpawnStart =", waypoints[1].part.Name, "| SpawnEnd =", AnimalService.CustomSpawnEnd.Name)
	else
		warn("[1x1x1x1] Aucun waypoint trouvé dans Path !")
	end

	-- 5) Noclip cave pour tous les joueurs
	for _, player in ipairs(Players:GetPlayers()) do
		enableNoclip(player)
	end

	-- 6) Nouveaux joueurs pendant l'event
	playerAddedConn = Players.PlayerAdded:Connect(function(player)
		enableNoclip(player)
	end)

	local fdPart = SideMap:FindFirstChild("fd")
	if fdPart then
		local RunService = game:GetService("RunService")
		local fdConn
		fdConn = RunService.Heartbeat:Connect(function()
			if not SideMap or not SideMap.Parent then
				fdConn:Disconnect()
				return
			end
			for _, animal in ipairs(CollectionService:GetTagged("Animal")) do
				if animal:GetAttribute("InCave") == true then
					local primary = animal.PrimaryPart
					if primary and (primary.Position - fdPart.Position).Magnitude <= 12 then
						-- Sortie de cave : mode normal
						animal:SetAttribute("InCave", false)
						animal:SetAttribute("ForceIdle", false)
						animal:SetAttribute("CavePaused", false)
						local prompt = animal:FindFirstChildWhichIsA("ProximityPrompt", true)
						if prompt then
							prompt.Enabled = true
							prompt:SetAttribute("Disabled", false)
						end
					end
				end
			end
		end)
	else
		warn("[1x1x1x1] Part 'fd' introuvable dans 1x1x1x1Map !")
	end

	print("[1x1x1x1] OnStart terminé !")
end

-- ──────────────────────────────────────────────────────────────
--  ON STOP
-- ──────────────────────────────────────────────────────────────
function guest.OnStop()
	print("[1x1x1x1] OnStop !")

	-- 1) Plus de nouveaux joueurs en noclip
	if playerAddedConn then
		playerAddedConn:Disconnect()
		playerAddedConn = nil
	end

	-- 2) Remettre tout le monde en collision normale
	for _, player in ipairs(Players:GetPlayers()) do
		disableNoclip(player)
	end
	charAddedConns = {}

	-- 3) Désactiver les waypoints
	AnimalService.EventWaypoints      = nil
	AnimalService.EventWaypointActive = false
	AnimalService.CaveSpeedOverride   = nil
	AnimalService.CustomSpawnStart    = nil
	AnimalService.CustomSpawnEnd      = nil

	-- 4) Supprimer la map
	if SideMap and SideMap.Parent then
		SideMap:Destroy()
		SideMap = nil
	end

	print("[1x1x1x1] OnStop terminé !")
end

return guest