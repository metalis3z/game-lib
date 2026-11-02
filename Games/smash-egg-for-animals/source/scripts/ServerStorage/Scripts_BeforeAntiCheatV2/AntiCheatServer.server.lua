-- AntiCheatServer : anti-triche côté SERVEUR (un exploiteur ne peut pas le désactiver). Remplace l'ancien AntiFlyServer.
-- Tout est mesuré par le serveur à partir des positions réelles du personnage, avec des exemptions pour tout ce que le JEU
-- fait lui-même (sinon des joueurs honnêtes seraient expulsés) :
--   * VITESSE  : distance parcourue (à plat) sur 0,5 s comparée à la WalkSpeed que le SERVEUR a donnée (+10 %, + petite marge).
--                3 fois de suite (1,5 s) au-dessus = expulsé. Ex. : speed 200 -> 220+ en continu = kick.
--   * TÉLÉPORT : saut de position impossible d'une image à l'autre (en tenant compte de la vitesse et du ping).
--                Les téléportations faites par le serveur (commandes admin, retour à la base, arènes...) sont reconnues
--                automatiquement : le serveur voit quand c'est LUI qui déplace le personnage.
--   * VOL      : mesuré par un "blockcast" vers le sol. Rester en l'air haut au-dessus du sol sans tomber (vol stationnaire),
--                ou monter beaucoup plus haut qu'un saut = expulsé. Un joueur lancé en l'air (rocket du Creator Panel, coup de
--                batte, coup d'un boss) a une période de grâce : il retombe normalement, il n'est pas puni.
--   * PIÈGES   : des RemoteEvents qui ont l'air intéressants pour un tricheur (AddMoney, GiveAllPets...) mais que le jeu
--                n'utilise JAMAIS : quiconque les déclenche est expulsé à l'instant (scripts d'exploit / remote spy).
--   * GARDIEN  : un script client (ClientPerformance) signale ce que seul un exploit fait sur SON propre personnage
--                (WalkSpeed / JumpPower modifiés en local, forces de vol ajoutées en local, gravité changée) ; le serveur
--                vérifie avant d'expulser. S'il est supprimé pendant que le joueur bouge, le joueur est expulsé.
-- Les autres scripts du serveur donnent une période de grâce avec : ServerStorage.GameBindables.AntiCheatGrace:Fire(joueur, secondes)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")

local CFG = {
	KICK = true,                -- false = seulement écrire dans la sortie (pour régler les seuils)
	EXEMPT = {},                -- [UserId] = true : jamais expulsé (seulement signalé)
	SPEED_MARGIN = 1.10,        -- +10 % au-dessus de la WalkSpeed donnée par le serveur
	SPEED_FLAT = 4,             -- + 4 studs/s de marge
	MIN_WALK = 16,              -- vitesse de référence minimale (la WalkSpeed de Roblox)
	SPEED_WINDOW = 0.5,         -- fenêtre de mesure (s)
	SPEED_STRIKES = 3,          -- fenêtres de suite au-dessus = expulsé
	TP_BASE = 25,               -- saut de position toléré en plus de la vitesse (studs)
	TP_LAG = 0.35,              -- secondes de rattrapage tolérées (lag réseau)
	GROUND = 6,                 -- racine au-dessus du sol : au sol ~3
	FLY_HEIGHT = 12,            -- un saut (7,2 studs + hanches) n'atteint jamais cette hauteur
	FLY_HOVER = 2.5,            -- secondes en l'air haut sans tomber vraiment = vol
	FALL_SPEED = -25,           -- en dessous : il tombe réellement
	FLY_RISE = 22,              -- monter de plus que ça au-dessus du dernier sol touché = vol / super saut
	JOIN_GRACE = 90,            -- cinématique d'arrivée (le client la déclare finie avant : la grâce s'arrête alors)
	SPAWN_GRACE = 3,
	TELEPORT_GRACE = 1.5,       -- après une téléportation faite par le serveur
	GUARD_TIMEOUT = 60,         -- gardien client silencieux plus que ça pendant que le joueur bouge = expulsé
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

local function punish(player, reason, detail)
	local s = state[player]
	if not s or s.Kicked then return end
	warn(("[AntiCheat] %s (%d) : %s — %s"):format(player.Name, player.UserId, reason, detail or ""))
	if CFG.EXEMPT[player.UserId] or not CFG.KICK then return end
	s.Kicked = true
	-- les admins présents sont prévenus
	for _, p in Players:GetPlayers() do
		if p ~= player and p:GetAttribute("IsAdmin") == true then notifyRemote:FireClient(p, "[Anti-cheat] " .. player.DisplayName .. " was kicked: " .. reason) end
	end
	player:Kick("Anti-cheat: " .. reason .. ". If this is a mistake, rejoin the game.")
end

---------------------------------------------------------------- sol sous le joueur (blockcast : marche aussi au bord d'une corniche)
local castParams = RaycastParams.new()
castParams.FilterType = Enum.RaycastFilterType.Exclude
castParams.RespectCanCollide = true
local function heightAboveGround(root)
	local ignore = {}
	for _, p in Players:GetPlayers() do if p.Character then table.insert(ignore, p.Character) end end
	castParams.FilterDescendantsInstances = ignore
	local hit = workspace:Blockcast(CFrame.new(root.Position), Vector3.new(3.6, 1, 3.6), Vector3.new(0, -500, 0), castParams)
	return hit and (root.Position.Y - hit.Position.Y) or math.huge
end

local function exemptNow(player, s, humanoid, root)
	if os.clock() < s.GraceUntil then return true end
	if root.Anchored then return true end                                  -- figé par le serveur (freeze, rocket, cinématique)
	if humanoid.SeatPart then return true end
	if player:GetAttribute("InBossArena") or player:GetAttribute("InDemonArena") then return true end -- arènes : coups, sauts, téléportations
	return false
end

---------------------------------------------------------------- personnages
local function watchCharacter(player, character)
	local s = state[player]
	if not s then return end
	s.GraceUntil = math.max(s.GraceUntil, os.clock() + CFG.SPAWN_GRACE)
	s.Reset = true
	local root = character:WaitForChild("HumanoidRootPart", 10)
	if not root then return end
	-- une téléportation faite par un script du SERVEUR déclenche ce signal (pas les mouvements venus du client) : autorisée
	root:GetPropertyChangedSignal("CFrame"):Connect(function()
		s.GraceUntil = math.max(s.GraceUntil, os.clock() + CFG.TELEPORT_GRACE)
		s.Reset = true
	end)
end

local function onPlayer(player)
	local now = os.clock()
	state[player] = {GraceUntil = now + CFG.JOIN_GRACE, Strikes = 0, Hover = 0, Reset = true, JoinedAt = now, IntroDone = false,
		LastGuard = nil, MaxWalk = CFG.MIN_WALK, MaxWalkAt = now}
	player.CharacterAdded:Connect(function(c) watchCharacter(player, c) end)
	if player.Character then task.spawn(watchCharacter, player, player.Character) end
end
Players.PlayerAdded:Connect(onPlayer)
for _, p in Players:GetPlayers() do onPlayer(p) end
Players.PlayerRemoving:Connect(function(p) state[p] = nil end)

---------------------------------------------------------------- contrôles (10 fois par seconde)
local acc = 0
RunService.Heartbeat:Connect(function(dt)
	acc += dt
	if acc < 0.1 then return end
	local step = acc
	acc = 0
	local now = os.clock()
	for player, s in state do
		local character = player.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local root = character and character:FindFirstChild("HumanoidRootPart")
		if not humanoid or not root or humanoid.Health <= 0 or s.Kicked then
			s.Reset = true
			continue
		end
		local pos = root.Position
		-- vitesse autorisée : la plus grande WalkSpeed donnée par le serveur dans les 2 dernières secondes
		local walk = math.max(humanoid.WalkSpeed, CFG.MIN_WALK)
		if walk >= s.MaxWalk or now - s.MaxWalkAt > 2 then s.MaxWalk, s.MaxWalkAt = walk, now end
		local allowed = math.max(s.MaxWalk, walk)
		if s.Reset or exemptNow(player, s, humanoid, root) then
			s.Reset = false
			s.LastPos, s.WinPos, s.WinT, s.GroundY = pos, pos, now, pos.Y
			s.Strikes, s.Hover = 0, 0
			continue
		end
		local ping = math.clamp(player:GetNetworkPing(), 0, 1)
		-- TÉLÉPORT : saut impossible depuis la dernière mesure
		local flat = Vector3.new(pos.X - s.LastPos.X, 0, pos.Z - s.LastPos.Z).Magnitude
		local limit = CFG.TP_BASE + allowed * (step + 2 * ping + CFG.TP_LAG) * 1.3
		if flat > limit then
			punish(player, "teleport", ("%.0f studs in %.2fs (limit %.0f)"):format(flat, step, limit))
			continue
		end
		s.LastPos = pos
		-- VITESSE : sur une fenêtre de 0,5 s
		if now - s.WinT >= CFG.SPEED_WINDOW then
			local elapsed = now - s.WinT
			local dist = Vector3.new(pos.X - s.WinPos.X, 0, pos.Z - s.WinPos.Z).Magnitude
			local speed = dist / elapsed
			local max = allowed * CFG.SPEED_MARGIN + CFG.SPEED_FLAT + allowed * ping * 0.5
			if speed > max then
				s.Strikes += 1
				if s.Strikes >= CFG.SPEED_STRIKES then
					punish(player, "speed hack", ("%.0f studs/s for %.1fs (allowed %.0f)"):format(speed, s.Strikes * CFG.SPEED_WINDOW, max))
					continue
				end
			else
				s.Strikes = 0
			end
			s.WinPos, s.WinT = pos, now
		end
		-- VOL
		local height = heightAboveGround(root)
		local vy = root.AssemblyLinearVelocity.Y
		if height <= CFG.GROUND then
			s.GroundY, s.Hover = pos.Y, 0
		else
			if height > CFG.FLY_HEIGHT and vy > CFG.FALL_SPEED then s.Hover += step else s.Hover = 0 end
			if s.Hover > CFG.FLY_HOVER then
				punish(player, "fly hack", ("%.1fs in the air %.0f studs above the ground"):format(s.Hover, height))
				continue
			end
			if height ~= math.huge and pos.Y - (s.GroundY or pos.Y) > CFG.FLY_RISE then
				punish(player, "fly hack", ("rose %.0f studs above the last ground"):format(pos.Y - s.GroundY))
				continue
			end
		end
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
	r.OnServerEvent:Connect(function(player) punish(player, "exploit detected", "fired trap remote " .. name) end)
	local f = trapFolder:FindFirstChild(name .. "Func") or Instance.new("RemoteFunction")
	f.Name = name .. "Func"
	f.Parent = trapFolder
	f.OnServerInvoke = function(player) punish(player, "exploit detected", "invoked trap remote " .. name) return nil end
end

---------------------------------------------------------------- gardien client (ClientPerformance)
local guardRemote = ReplicatedStorage:FindFirstChild("ClientPerformance") or Instance.new("RemoteEvent")
guardRemote.Name = "ClientPerformance"
guardRemote.Parent = ReplicatedStorage
-- forces qui DÉPLACENT le personnage (celles qui ne font que le tourner sont ignorées : la caméra VR de Roblox en ajoute une)
local MOVERS = {BodyVelocity = true, BodyPosition = true, BodyForce = true, BodyThrust = true, LinearVelocity = true, AlignPosition = true, VectorForce = true}
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
		-- WalkSpeed / JumpHeight du personnage changées EN LOCAL : comparées à celles que le serveur a données
		local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if not humanoid or type(a) ~= "number" or type(b) ~= "number" then return end
		local serverWalk = math.max(humanoid.WalkSpeed, s.MaxWalk or 0)
		if a > serverWalk * CFG.SPEED_MARGIN + 2 then
			punish(player, "speed hack", ("local WalkSpeed %.0f, server gave %.0f"):format(a, serverWalk))
		elseif b > math.max(humanoid.JumpHeight, 7.2) * 1.5 + 1 then
			punish(player, "jump hack", ("local JumpHeight %.1f"):format(b))
		end
	elseif kind == "mover" then
		-- une force de déplacement dans le personnage : le jeu n'en crée que côté serveur. Absente du serveur = ajoutée par un exploit
		if type(a) ~= "string" or not MOVERS[a] or type(b) ~= "string" then return end
		task.wait(0.5) -- (le temps qu'une création du serveur soit bien là)
		local character = player.Character
		local found = false
		for _, d in character and character:GetDescendants() or {} do
			if d.ClassName == a and d.Name == b then found = true break end
		end
		if not found then punish(player, "fly / speed exploit", "local " .. a .. " '" .. b .. "' in the character") end
	elseif kind == "gravity" then
		if type(a) == "number" and a < workspace.Gravity * 0.9 then punish(player, "gravity exploit", ("local gravity %.0f"):format(a)) end
	end
end)

-- gardien supprimé : plus aucun signe de vie alors que le joueur bouge (un client figé ou en arrière-plan ne bouge pas)
task.spawn(function()
	while true do
		task.wait(5)
		local now = os.clock()
		for player, s in state do
			local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if s.LastGuard and root and now - s.LastGuard > CFG.GUARD_TIMEOUT then
				local moved = s.GuardCheckPos and (root.Position - s.GuardCheckPos).Magnitude > 20
				if moved then punish(player, "anti-cheat removed", ("no guard signal for %.0fs while moving"):format(now - s.LastGuard)) end
			end
			s.GuardCheckPos = root and root.Position or nil
		end
	end
end)
