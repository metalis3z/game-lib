-- AntiCheatServer (v2) : anti-triche côté SERVEUR (un exploiteur ne peut pas le désactiver).
-- Un tricheur n'est PAS expulsé : il est RAMENÉ (rollback) au dernier endroit propre où il touchait le sol, puis figé une
-- demi-seconde (le serveur reprend la main sur son personnage : un script d'exploit ne peut plus le tenir en l'air).
-- Tout est mesuré par le serveur à partir des positions réelles du personnage, avec des exemptions pour ce que le JEU fait
-- lui-même :
--   * VITESSE  : distance parcourue (à plat) sur 0,5 s comparée à la WalkSpeed que le SERVEUR a donnée (+15 %, + marge).
--                3 fois de suite (1,5 s) au-dessus = ramené là où il a commencé à aller trop vite.
--   * TÉLÉPORT : saut de position impossible d'une mesure à l'autre (vitesse et ping pris en compte) = ramené.
--                Les téléportations faites par le serveur (commandes admin, retour à la base, arènes...) sont reconnues
--                automatiquement : le serveur voit quand c'est LUI qui déplace le personnage.
--   * VOL      : "blockcast" vers le sol. Rester en l'air haut sans tomber (1,2 s) ou monter bien plus haut qu'un saut
--                = ramené au dernier sol touché, dès le début du vol.
--   * MURS     : traverser un mur / sol solide (noclip) = ramené de l'autre côté, d'où il venait.
--   * COUPS    : un joueur frappé par un boss, la batte, une commande du Creator Panel... reçoit une période de grâce
--                (ServerStorage.GameBindables.AntiCheatGrace:Fire(joueur, secondes)) : aller 2x plus vite ou voler parce
--                qu'on a été tapé ne fait JAMAIS revenir en arrière.
--   * GARDIEN  : un script client (ClientPerformance) signale ce que seul un exploit fait sur SON personnage (WalkSpeed /
--                JumpPower en local, forces de vol ajoutées en local, gravité changée). Le serveur passe alors ce joueur en
--                surveillance stricte (contrôles plus sévères) et remet ses vraies valeurs. Gardien supprimé = stricte à vie.
--   * PIÈGES   : des RemoteEvents que le jeu n'utilise JAMAIS (AddMoney, GiveAllPets...) : seuls un exécuteur / remote spy
--                les déclenchent. Ceux-là sont ramenés et surveillés strictement jusqu'à leur départ (aucun kick).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")

local CFG = {
	ROLLBACK = true,            -- false = seulement écrire dans la sortie (pour régler les seuils)
	TRAP_KICK = false,          -- remotes pièges : ramené + surveillance stricte à vie (true = expulsé)
	EXEMPT = {},                -- [UserId] = true : jamais ramené (seulement signalé)
	SPEED_MARGIN = 1.15,        -- +15 % au-dessus de la WalkSpeed donnée par le serveur
	SPEED_FLAT = 6,             -- + 6 studs/s de marge
	MIN_WALK = 16,              -- vitesse de référence minimale (la WalkSpeed de Roblox)
	SPEED_WINDOW = 0.5,         -- fenêtre de mesure (s)
	SPEED_STRIKES = 3,          -- fenêtres de suite au-dessus = ramené (1 en surveillance stricte)
	TP_BASE = 25,               -- saut de position toléré en plus de la vitesse (studs)
	TP_LAG = 0.35,              -- secondes de rattrapage tolérées (lag réseau)
	GROUND = 6,                 -- racine au-dessus du sol : au sol ~3
	FLY_HEIGHT = 12,            -- un saut (7,2 studs + hanches) n'atteint jamais cette hauteur
	FLY_HOVER = 1.2,            -- secondes en l'air haut sans tomber vraiment = vol (0,6 en surveillance stricte)
	FALL_SPEED = -25,           -- en dessous : il tombe réellement
	FLY_RISE = 22,              -- monter de plus que ça au-dessus du dernier sol touché = vol / super saut
	WALL_DEPTH = 0.6,           -- épaisseur de mur traversée à partir de laquelle c'est du noclip (studs)
	HOLD = 0.5,                 -- secondes figé après un retour en arrière
	STRICT_TIME = 30,           -- secondes de surveillance stricte après un signalement
	JOIN_GRACE = 90,            -- cinématique d'arrivée (le client la déclare finie avant : la grâce s'arrête alors)
	SPAWN_GRACE = 3,
	TELEPORT_GRACE = 1.5,       -- après une téléportation faite par le serveur
	GUARD_TIMEOUT = 60,         -- gardien client silencieux plus que ça pendant que le joueur bouge = surveillance stricte
}

local bindables = ServerStorage:WaitForChild("GameBindables")
local graceEvent = bindables:FindFirstChild("AntiCheatGrace") or Instance.new("BindableEvent")
graceEvent.Name = "AntiCheatGrace"
graceEvent.Parent = bindables
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

local state = {} -- [player] = état

local function grace(player, seconds)
	local s = state[player]
	if not s then return end
	s.GraceUntil = math.max(s.GraceUntil, os.clock() + (tonumber(seconds) or 3))
	s.Strikes, s.Hover = 0, 0
	s.Reset = true
end
graceEvent.Event:Connect(grace)

local function log(player, reason, detail)
	warn(("[AntiCheat] %s (%d) : %s — %s"):format(player.Name, player.UserId, reason, detail or ""))
	local s = state[player]
	local t = os.clock()
	if s and t - (s.AdminNoticeAt or -99) < 20 then return end
	if s then s.AdminNoticeAt = t end
	for _, p in Players:GetPlayers() do
		if p ~= player and p:GetAttribute("IsAdmin") == true then notifyRemote:FireClient(p, "[Anti-cheat] " .. player.DisplayName .. ": " .. reason) end
	end
end

local function strict(s, seconds)
	s.StrictUntil = math.max(s.StrictUntil, os.clock() + seconds)
end

-- RETOUR EN ARRIÈRE : au dernier endroit propre, vitesse remise à zéro, figé un court instant (le serveur reprend la main)
local function rollback(player, s, reason, detail)
	log(player, reason, detail)
	strict(s, CFG.STRICT_TIME)
	s.Rollbacks += 1
	if CFG.EXEMPT[player.UserId] or not CFG.ROLLBACK then return end
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not root then return end
	s.OwnMoveUntil = os.clock() + 0.4 -- ce déplacement-ci ne doit pas compter comme une téléportation "du jeu"
	root.AssemblyLinearVelocity, root.AssemblyAngularVelocity = Vector3.zero, Vector3.zero
	-- (pas encore de point au sol connu : la dernière position mesurée avant la triche)
	character:PivotTo(s.Safe or (s.LastPos and CFrame.new(s.LastPos) * root.CFrame.Rotation) or root.CFrame)
	if not root.Anchored then
		root.Anchored = true
		local token = {}
		s.HoldToken = token
		task.delay(CFG.HOLD, function()
			if s.HoldToken == token and root.Parent then root.Anchored = false end
		end)
	end
	s.Reset, s.Strikes, s.Hover = true, 0, 0
	local t = os.clock()
	if t - (s.NoticeAt or -99) > 3 then
		s.NoticeAt = t
		notifyRemote:FireClient(player, "Anti-cheat: you were moved back (" .. reason .. ").")
	end
end

-- remotes pièges (impossible à déclencher sans exécuteur) : ramené + surveillance stricte à vie (kick seulement si CFG.TRAP_KICK)
local function kick(player, reason, detail)
	local s = state[player]
	if not s or s.Kicked then return end
	log(player, reason, detail)
	if CFG.EXEMPT[player.UserId] then return end
	if not CFG.TRAP_KICK then rollback(player, s, reason, detail) strict(s, math.huge) return end
	s.Kicked = true
	player:Kick("Anti-cheat: " .. reason .. ". If this is a mistake, rejoin the game.")
end

---------------------------------------------------------------- sol, murs (paramètres partagés, préparés une fois par contrôle)
local castParams = RaycastParams.new()
castParams.FilterType = Enum.RaycastFilterType.Exclude
castParams.RespectCanCollide = true
local wallParams = RaycastParams.new()
wallParams.FilterType = Enum.RaycastFilterType.Exclude
wallParams.RespectCanCollide = true

-- tapis de course : la glissade sur la bande déplace le personnage en local, on ne les compte pas comme murs
local treadmillParts = {}
local function refreshTreadmills()
	local list = {}
	for _, d in workspace:GetDescendants() do
		if (d.Name == "Treadmill" and d:IsA("Model")) or d.Name == "TreadmillSpot" then table.insert(list, d) end
	end
	treadmillParts = list
end
task.spawn(refreshTreadmills)

local function heightAboveGround(root)
	local hit = workspace:Blockcast(CFrame.new(root.Position), Vector3.new(3.6, 1, 3.6), Vector3.new(0, -500, 0), castParams)
	return hit and (root.Position.Y - hit.Position.Y) or math.huge
end

local function solidHit(from, to)
	local r = workspace:Raycast(from, to - from, wallParams)
	return r and r.Instance.Anchored and r or nil
end
-- traversée d'un mur : touché en allant ET en revenant (un rayon qui part de l'intérieur d'une pièce ne la voit pas :
-- un mur apparu autour du joueur ne compte donc pas), avec une vraie épaisseur entre les deux faces (pas un coin frôlé)
local function throughWall(a, b)
	if (b - a).Magnitude < 0.5 then return nil end
	local enter = solidHit(a, b)
	if not enter then return nil end
	local exit = solidHit(b, a)
	if not exit then return nil end
	if (exit.Position - enter.Position).Magnitude < CFG.WALL_DEPTH then return nil end
	return enter.Instance
end

-- centre du personnage DANS une pièce solide (noclip lent : on entre petit à petit dans un mur épais). Une petite sphère
-- au centre de la racine : un personnage normal ne peut jamais l'enfoncer dans un mur (la racine fait 2 x 2 x 1).
local probe = Instance.new("Part")
probe.Name = "AntiCheatProbe"
probe.Shape = Enum.PartType.Ball
probe.Size = Vector3.one * 0.6
probe.Anchored, probe.CanCollide, probe.CanQuery, probe.CanTouch = true, false, false, false
probe.Transparency = 1
probe.Parent = workspace
local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Exclude
overlapParams.RespectCanCollide = true
local function insideSolid(pos)
	probe.CFrame = CFrame.new(pos)
	for _, part in workspace:GetPartsInPart(probe, overlapParams) do
		if part.Anchored then return part end
	end
	return nil
end

local function exemptNow(player, s, humanoid, root)
	if os.clock() < s.GraceUntil then return true end
	if root.Anchored then return true end                                  -- figé par le serveur (freeze, rocket, cinématique, retour)
	if humanoid.SeatPart then return true end
	if player:GetAttribute("InBossArena") or player:GetAttribute("InDemonArena") then return true end -- arènes : coups, sauts, téléportations
	return false
end

---------------------------------------------------------------- personnages
local function watchCharacter(player, character)
	local s = state[player]
	if not s then return end
	s.GraceUntil = math.max(s.GraceUntil, os.clock() + CFG.SPAWN_GRACE)
	s.Reset, s.Safe = true, nil
	local root = character:WaitForChild("HumanoidRootPart", 10)
	if not root then return end
	-- une téléportation faite par un script du SERVEUR déclenche ce signal (pas les mouvements venus du client) : autorisée
	root:GetPropertyChangedSignal("CFrame"):Connect(function()
		if os.clock() < s.OwnMoveUntil then return end
		s.GraceUntil = math.max(s.GraceUntil, os.clock() + CFG.TELEPORT_GRACE)
		s.Reset, s.Safe = true, nil
	end)
end

local function onPlayer(player)
	local now = os.clock()
	state[player] = {GraceUntil = now + CFG.JOIN_GRACE, Strikes = 0, Hover = 0, Reset = true, JoinedAt = now, IntroDone = false,
		LastGuard = nil, MaxWalk = CFG.MIN_WALK, MaxWalkAt = now, StrictUntil = 0, OwnMoveUntil = 0, Rollbacks = 0, TreadmillAt = -99}
	player.CharacterAdded:Connect(function(c) watchCharacter(player, c) end)
	if player.Character then task.spawn(watchCharacter, player, player.Character) end
end
Players.PlayerAdded:Connect(onPlayer)
for _, p in Players:GetPlayers() do onPlayer(p) end
Players.PlayerRemoving:Connect(function(p) state[p] = nil end)

---------------------------------------------------------------- contrôles (10 fois par seconde)
local acc, refreshAt = 0, os.clock() + 30
RunService.Heartbeat:Connect(function(dt)
	acc += dt
	if acc < 0.1 then return end
	local step = acc
	acc = 0
	local now = os.clock()
	if now > refreshAt then refreshAt = now + 30 task.spawn(refreshTreadmills) end
	-- listes d'exclusion préparées une seule fois pour tous les joueurs
	local characters = {}
	for _, p in Players:GetPlayers() do if p.Character then table.insert(characters, p.Character) end end
	castParams.FilterDescendantsInstances = characters
	local wallIgnore = table.clone(characters)
	for _, t in treadmillParts do table.insert(wallIgnore, t) end
	wallParams.FilterDescendantsInstances = wallIgnore
	overlapParams.FilterDescendantsInstances = wallIgnore

	for player, s in state do
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if not humanoid or not root or humanoid.Health <= 0 or s.Kicked then
			s.Reset = true
			continue
		end
		local pos = root.Position
		if player:GetAttribute("OnTreadmill") then s.TreadmillAt = now end
		-- vitesse autorisée : la plus grande WalkSpeed donnée par le serveur dans les 2 dernières secondes
		local walk = math.max(humanoid.WalkSpeed, CFG.MIN_WALK)
		if walk >= s.MaxWalk or now - s.MaxWalkAt > 2 then s.MaxWalk, s.MaxWalkAt = walk, now end
		local allowed = math.max(s.MaxWalk, walk)
		local height = heightAboveGround(root)
		local inside = now - s.TreadmillAt > 2 and insideSolid(pos) or nil
		if s.Reset or exemptNow(player, s, humanoid, root) then
			s.Reset = false
			s.LastPos, s.WinPos, s.WinT, s.GroundY = pos, pos, now, pos.Y
			s.Strikes, s.Hover = 0, 0
			s.OutsidePos = pos
			s.StuckInside = inside ~= nil -- (déjà dedans : une pièce apparue sur lui, ou déposé là par le serveur : pas puni)
			if height <= CFG.GROUND and not root.Anchored and not inside then s.Safe = root.CFrame end
			continue
		end
		local isStrict = now < s.StrictUntil
		local ping = math.clamp(player:GetNetworkPing(), 0, 1)

		-- MURS : enfoncé dans une pièce solide (plus de 1,5 stud depuis le dernier point hors des murs : collé contre un mur,
		-- la physique n'enfonce que de quelques centièmes), ou passé à travers depuis le dernier point hors des murs
		if now - s.TreadmillAt > 2 then
			local wall
			if inside then
				if not s.StuckInside and (pos - s.OutsidePos).Magnitude > 1.5 then wall = inside end
			else
				s.StuckInside = false
				wall = throughWall(s.OutsidePos, pos)
				if not wall then s.OutsidePos = pos end
			end
			if wall then
				rollback(player, s, "noclip", "went through " .. wall:GetFullName())
				continue
			end
		else
			s.OutsidePos = pos
		end
		-- TÉLÉPORT : saut impossible depuis la dernière mesure
		local flat = Vector3.new(pos.X - s.LastPos.X, 0, pos.Z - s.LastPos.Z).Magnitude
		local limit = CFG.TP_BASE + allowed * (step + 2 * ping + CFG.TP_LAG) * 1.3
		if flat > limit then
			rollback(player, s, "teleport", ("%.0f studs in %.2fs (limit %.0f)"):format(flat, step, limit))
			continue
		end
		s.LastPos = pos
		local max = allowed * CFG.SPEED_MARGIN + CFG.SPEED_FLAT + allowed * ping * 0.5
		-- vitesse sur ce seul dixième de seconde : trop vite = pas un point de retour ; en surveillance stricte = ramené tout de suite
		-- (marge x1,6 pour la sanction : les positions arrivent parfois par paquets à cause du réseau)
		local nearTreadmill = now - s.TreadmillAt < 2 -- (glissade sur la bande : déplacée en local, quelques studs)
		local tickFast = flat / step > max * 1.3
		if nearTreadmill then s.Strikes, s.WinPos, s.WinT = 0, pos, now end
		if isStrict and not nearTreadmill and flat / step > max * 1.6 then
			rollback(player, s, "speed", ("%.0f studs/s (allowed %.0f)"):format(flat / step, max))
			continue
		end
		-- VITESSE : sur une fenêtre de 0,5 s
		if now - s.WinT >= CFG.SPEED_WINDOW then
			local elapsed = now - s.WinT
			local dist = Vector3.new(pos.X - s.WinPos.X, 0, pos.Z - s.WinPos.Z).Magnitude
			local speed = dist / elapsed
			if speed > max then
				s.Strikes += 1
				if s.Strikes >= (isStrict and 1 or CFG.SPEED_STRIKES) then
					rollback(player, s, "speed", ("%.0f studs/s for %.1fs (allowed %.0f)"):format(speed, s.Strikes * CFG.SPEED_WINDOW, max))
					continue
				end
			else
				s.Strikes = 0
			end
			s.WinPos, s.WinT = pos, now
		end
		-- VOL
		local vy = root.AssemblyLinearVelocity.Y
		if height <= CFG.GROUND then
			s.GroundY, s.Hover = pos.Y, 0
		else
			if height > CFG.FLY_HEIGHT and vy > CFG.FALL_SPEED then s.Hover += step else s.Hover = 0 end
			if s.Hover > (isStrict and CFG.FLY_HOVER / 2 or CFG.FLY_HOVER) then
				rollback(player, s, "fly", ("%.1fs in the air %.0f studs above the ground"):format(s.Hover, height))
				continue
			end
			local rise = math.max(CFG.FLY_RISE, humanoid.JumpHeight * 1.4 + 10)
			if height ~= math.huge and pos.Y - (s.GroundY or pos.Y) > rise then
				rollback(player, s, "fly", ("rose %.0f studs above the last ground"):format(pos.Y - s.GroundY))
				continue
			end
		end
		-- tout est propre et il touche le sol : c'est le nouveau point de retour
		if s.Strikes == 0 and s.Hover == 0 and not tickFast and height <= CFG.GROUND and not inside then s.Safe = root.CFrame end
	end
end)

---------------------------------------------------------------- pièges (remotes jamais utilisés par le jeu)
local trapFolder = ReplicatedStorage:FindFirstChild("ServerRemotes") or Instance.new("Folder")
trapFolder.Name = "ServerRemotes"
trapFolder.Parent = ReplicatedStorage
for _, name in {"AddMoney", "SetMoney", "GiveAllPets", "UnlockAllPasses", "SetWalkSpeed", "ExecuteCommand", "DupePet", "InstantHatch", "GodMode", "FreeRobux"} do
	local r = trapFolder:FindFirstChild(name) or Instance.new("RemoteEvent")
	r.Name = name
	r.Parent = trapFolder
	r.OnServerEvent:Connect(function(player) kick(player, "exploit detected", "fired trap remote " .. name) end)
	local f = trapFolder:FindFirstChild(name .. "Func") or Instance.new("RemoteFunction")
	f.Name = name .. "Func"
	f.Parent = trapFolder
	f.OnServerInvoke = function(player) kick(player, "exploit detected", "invoked trap remote " .. name) return nil end
end

---------------------------------------------------------------- gardien client (ClientPerformance)
local guardRemote = ReplicatedStorage:FindFirstChild("ClientPerformance") or Instance.new("RemoteEvent")
guardRemote.Name = "ClientPerformance"
guardRemote.Parent = ReplicatedStorage
-- forces qui DÉPLACENT le personnage (celles qui ne font que le tourner sont ignorées : la caméra VR de Roblox en ajoute une)
local MOVERS = {BodyVelocity = true, BodyPosition = true, BodyForce = true, BodyThrust = true, LinearVelocity = true, AlignPosition = true, VectorForce = true}
-- remet sur le client la vraie valeur du serveur (une valeur identique ne serait pas renvoyée : on la change un instant)
local function reassert(humanoid, prop)
	local v = humanoid[prop]
	humanoid[prop] = v + 0.01
	task.defer(function() if humanoid.Parent and humanoid[prop] == v + 0.01 then humanoid[prop] = v end end)
end
guardRemote.OnServerEvent:Connect(function(player, kind, a, b)
	local s = state[player]
	if not s then return end
	-- 20 signalements par seconde au plus (un tricheur qui spamme ce remote ne bloque rien)
	local t = os.clock()
	if not s.RateT or t - s.RateT > 1 then s.RateT, s.RateN = t, 0 end
	s.RateN += 1
	if s.RateN > 20 then return end
	if kind == "alive" then
		s.LastGuard = os.clock()
	elseif kind == "intro" then
		-- fin de la cinématique d'arrivée : la grâce d'arrivée s'arrête (accepté une seule fois)
		if not s.IntroDone then
			s.IntroDone = true
			s.GraceUntil = math.min(s.GraceUntil, os.clock() + 3)
		end
	elseif kind == "walk" then
		-- WalkSpeed / JumpHeight du personnage changées EN LOCAL : surveillance stricte + vraies valeurs remises
		local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if not humanoid or type(a) ~= "number" or type(b) ~= "number" then return end
		local serverWalk = math.max(humanoid.WalkSpeed, s.MaxWalk or 0)
		if a > serverWalk * CFG.SPEED_MARGIN + 2 then
			log(player, "speed hack", ("local WalkSpeed %.0f, server gave %.0f"):format(a, serverWalk))
			strict(s, CFG.STRICT_TIME)
			reassert(humanoid, "WalkSpeed")
		elseif b > math.max(humanoid.JumpHeight, 7.2) * 1.5 + 1 then
			log(player, "jump hack", ("local JumpHeight %.1f"):format(b))
			strict(s, CFG.STRICT_TIME)
			reassert(humanoid, humanoid.UseJumpPower and "JumpPower" or "JumpHeight")
		end
	elseif kind == "mover" then
		-- une force de déplacement dans le personnage : le jeu n'en crée que côté serveur. Absente du serveur = exploit
		if type(a) ~= "string" or not MOVERS[a] or type(b) ~= "string" then return end
		task.wait(0.5) -- (le temps qu'une création du serveur soit bien là)
		local character = player.Character
		local found = false
		for _, d in character and character:GetDescendants() or {} do
			if d.ClassName == a and d.Name == b then found = true break end
		end
		if not found then rollback(player, s, "fly exploit", "local " .. a .. " '" .. b .. "' in the character") end
	elseif kind == "gravity" then
		if type(a) == "number" and a < workspace.Gravity * 0.9 then
			log(player, "gravity exploit", ("local gravity %.0f"):format(a))
			strict(s, CFG.STRICT_TIME)
		end
	end
end)

-- gardien supprimé : plus aucun signe de vie alors que le joueur bouge -> surveillance stricte jusqu'à son départ
task.spawn(function()
	while true do
		task.wait(5)
		local now = os.clock()
		for player, s in state do
			local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if s.LastGuard and root and now - s.LastGuard > CFG.GUARD_TIMEOUT and s.StrictUntil ~= math.huge then
				local moved = s.GuardCheckPos and (root.Position - s.GuardCheckPos).Magnitude > 20
				if moved then
					log(player, "anti-cheat removed", ("no guard signal for %.0fs while moving"):format(now - s.LastGuard))
					strict(s, math.huge)
				end
			end
			s.GuardCheckPos = root and root.Position or nil
		end
	end
end)
