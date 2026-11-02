-- Anti-fly : un joueur qui vole autrement que monté sur un dragon est réinitialisé et réapparaît sur le Spawn de sa base.
-- Tout est vérifié côté serveur (un exploiteur ne peut pas désactiver ce script) et sans se fier à ce que le client déclare :
-- la hauteur est mesurée par un raycast du serveur, et la seule exemption est le siège d'un dragon dont DragonServer
-- a déclaré le joueur comme cavalier (attribut Rider). Pas d'exemption escalade/nage : la map n'a ni échelle ni eau.
local Players = game:GetService("Players")

local CHECK_INTERVAL = 0.1
local GROUND_HEIGHT = 6   -- racine du perso au-dessus du sol : à pied ~3, au-delà de 6 on est en l'air
local MIN_HEIGHT = 12     -- un saut normal (7,2 studs + ~3 de hanche) n'atteint jamais cette hauteur
local FLOAT_TIME = 0.8    -- secondes haut au-dessus du sol sans vraiment tomber avant sanction
local FALL_SPEED = -30    -- en dessous de cette vitesse verticale (studs/s), le joueur tombe réellement
local RISE_SPEED = 25     -- monter plus vite que ça (hors saut, qui retombe en 0,15 s)...
local RISE_TIME = 0.5     -- ...pendant plus de 0,5 s = vol
local MAX_AIR_TIME = 2.5  -- secondes max d'affilée en l'air sans dragon, quelle que soit la hauteur (vol rasant)
local DRAGON_GRACE = 1.0  -- tolérance juste après être descendu d'un dragon
local SPAWN_GRACE = 4     -- tolérance après un spawn ou une sanction (le temps d'être replacé sur la base)
local BASE_SPAWN_HEIGHT = 3.5 -- comme BaseServer

local state = {} -- [player] = {last, air, float, rise, dragonAt, graceUntil}

local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude

-- vrai si le joueur est assis sur le siège d'un dragon dont il est le cavalier déclaré par DragonServer
local function onDragon(player, seatPart)
	local node = seatPart
	while node and node ~= workspace do
		if node:GetAttribute("Rider") == player.UserId then return true end
		node = node.Parent
	end
	return false
end

local function heightAboveGround(character, root)
	local ignore = {character}
	for _, other in Players:GetPlayers() do
		if other.Character then table.insert(ignore, other.Character) end
	end
	local dragons = workspace:FindFirstChild("Dragons")
	if dragons then table.insert(ignore, dragons) end
	rayParams.FilterDescendantsInstances = ignore
	local hit = workspace:Raycast(root.Position, Vector3.new(0, -300, 0), rayParams)
	return hit and (root.Position.Y - hit.Position.Y) or math.huge
end

-- Spawn de la base du joueur (même calcul que BaseServer)
local function baseSpawnCFrame(player)
	local bases = workspace:FindFirstChild("all base")
	local base = bases and bases:FindFirstChild("base " .. tostring(player:GetAttribute("BaseNumber")))
	local spawnPart = base and base:FindFirstChild("Spawn")
	return spawnPart and CFrame.new(spawnPart.Position + Vector3.new(0, BASE_SPAWN_HEIGHT, 0))
end

local function punish(player, s, reason)
	s.air, s.float, s.rise = 0, 0, 0
	s.graceUntil = os.clock() + SPAWN_GRACE
	warn(("[AntiFly] %s réinitialisé (%s)"):format(player.Name, reason))
	task.spawn(function()
		if not player.Parent then return end
		-- LoadCharacter : BaseServer replace le joueur sur sa base et DragonServer lui redonne son dragon, comme après une mort
		local ok = pcall(function() player:LoadCharacter() end)
		if not ok then
			local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then humanoid.Health = 0 end
		end
		-- filet de sécurité : si le joueur n'a pas atterri sur sa base, on l'y téléporte
		task.wait(0.6)
		local character, target = player.Character, baseSpawnCFrame(player)
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if root and target and (root.Position - target.Position).Magnitude > 60 then
			character:PivotTo(target)
		end
	end)
end

local function check(player, s, now)
	local dt = math.min(now - s.last, 1)
	s.last = now
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root or humanoid.Health <= 0 then
		s.air, s.float, s.rise = 0, 0, 0
		return
	end

	local seat = humanoid.SeatPart
	if onDragon(player, seat) then
		s.dragonAt = now
		s.air, s.float, s.rise = 0, 0, 0
		return
	end
	if now < s.graceUntil or now - s.dragonAt < DRAGON_GRACE then
		s.air, s.float, s.rise = 0, 0, 0
		return
	end

	-- hauteur mesurée par le serveur (pas de confiance dans FloorMaterial, que le client peut falsifier).
	-- Sol introuvable par raycast mais contact réel (surface non interrogeable) : on considère le joueur au sol.
	local height = heightAboveGround(character, root)
	if height == math.huge and humanoid.FloorMaterial ~= Enum.Material.Air then height = 0 end
	local vy = root.AssemblyLinearVelocity.Y

	-- règle 1 : trop longtemps en l'air d'affilée (assis sur un autre siège = pas en l'air)
	local airborne = height > GROUND_HEIGHT and seat == nil
	s.air = airborne and s.air + dt or 0

	-- règle 2 : haut au-dessus du sol et sans tomber vite (vol stationnaire, montée, descente lente)
	local floating = height > MIN_HEIGHT and vy > FALL_SPEED
	s.float = floating and s.float + dt or 0

	-- règle 3 : montée soutenue (un saut ne dépasse pas RISE_SPEED plus de ~0,15 s)
	s.rise = (vy > RISE_SPEED and height > GROUND_HEIGHT) and s.rise + dt or 0

	if s.float > FLOAT_TIME then
		punish(player, s, "vol stationnaire")
	elseif s.rise > RISE_TIME then
		punish(player, s, "montée soutenue")
	elseif s.air > MAX_AIR_TIME then
		punish(player, s, "trop longtemps en l'air")
	end
end

local function onPlayer(player)
	local now = os.clock()
	local s = {last = now, air = 0, float = 0, rise = 0, dragonAt = -math.huge, graceUntil = now + SPAWN_GRACE}
	state[player] = s
	player.CharacterAdded:Connect(function()
		s.air, s.float, s.rise = 0, 0, 0
		s.graceUntil = os.clock() + SPAWN_GRACE
	end)
end

Players.PlayerAdded:Connect(onPlayer)
for _, player in Players:GetPlayers() do onPlayer(player) end
Players.PlayerRemoving:Connect(function(player) state[player] = nil end)

while true do
	task.wait(CHECK_INTERVAL)
	local now = os.clock()
	for player, s in state do
		check(player, s, now)
	end
end
