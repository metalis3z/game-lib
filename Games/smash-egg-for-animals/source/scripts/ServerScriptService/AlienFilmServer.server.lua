-- Cinématique "Alien Invasion" -> GALAXY EVENT (panneau admin > onglet Cutscene-Event, via CutsceneEventServer).
-- Le film est joué côté client (FightFilm.AlienFilm). Ici :
--   * les avatars R15 de kinoshi112 et rexydev1 sont reconstruits au démarrage (tenue actuelle) dans FightFilm.AlienRigs
--     (si Roblox ne répond pas, les copies enregistrées dans le jeu servent de secours)
--   * GameBindables.PlayAlienFilm:Fire(nil, durée) : film pour tout le serveur, puis le VRAI Galaxy Event commence au moment
--     où les galaxies se percutent (premier client qui atteint ce moment, ou au plus tard COLLIDE_AT + 25 s)
--   * GameBindables.PlayAlienFilm:Fire(joueur) : test, film pour ce joueur seulement, SANS lancer l'event
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local film = ReplicatedStorage:WaitForChild("FightFilm")
local playRemote = film:WaitForChild("AlienPlay")
local collideRemote = film:WaitForChild("AlienCollide")
local bindables = ServerStorage:WaitForChild("GameBindables")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

local COLLIDE_AT = 108 -- seconde du film où les galaxies se percutent (FightFilm.AlienFilm.COLLIDE_AT)
local LENGTH = 130     -- durée max d'une séance (film ~123 s + chargement)
local CAST = {Kino = 3160444354, Rex = 3160444354} -- kinoshi112, rexydev1

---------------------------------------------------------------- avatars (R15, tenue actuelle)
local function buildRigs()
	local folder = film:WaitForChild("AlienRigs")
	for name, userId in CAST do
		local ok, model = pcall(function()
			return Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(userId), Enum.HumanoidRigType.R15)
		end)
		if ok and model then
			for _, d in model:GetDescendants() do
				if d:IsA("LuaSourceContainer") or d:IsA("Animator") then d:Destroy() end
			end
			model.Name = name
			model:SetAttribute("UserId", userId)
			local old = folder:FindFirstChild(name)
			model.Parent = folder
			if old and old ~= model then old:Destroy() end
		else
			warn("[AlienFilm] avatar " .. name .. " introuvable, copie de secours utilisée : " .. tostring(model))
		end
	end
end
task.spawn(buildRigs)

---------------------------------------------------------------- séances
local busyUntil = 0
local session -- {players = {[player] = true}, startEvent, duration, t0, triggered}

local function trigger(s, why)
	if s.triggered then return end
	s.triggered = true
	if s.startEvent then
		bindables:WaitForChild("RunSkyEvent"):Fire("Galaxy", "start", s.duration)
	end
end

local function playFor(list, startEvent, duration)
	local set = {}
	for _, p in list do set[p] = true end
	local s = {players = set, startEvent = startEvent, duration = duration, t0 = os.clock(), triggered = false}
	session = s
	for _, p in list do playRemote:FireClient(p, startEvent) end
	-- sécurité : si aucun client n'a prévenu (film interrompu, joueur parti...), l'event commence quand même
	task.delay(COLLIDE_AT + 25, function() trigger(s, "timeout") end)
end

-- un client a atteint la collision : le premier déclenche l'event (une seule fois par séance, jamais trop tôt)
collideRemote.OnServerEvent:Connect(function(player)
	local s = session
	if not s or s.triggered or not s.players[player] then return end
	if os.clock() - s.t0 < COLLIDE_AT - 20 then return end
	trigger(s, "client")
end)

bindables:WaitForChild("PlayAlienFilm").Event:Connect(function(onlyFor, duration)
	if typeof(onlyFor) == "Instance" and onlyFor:IsA("Player") then
		playRemote:FireClient(onlyFor, false) -- test : le film seul, pas d'event
		return
	end
	if os.clock() < busyUntil then
		warn("[AlienFilm] déjà en cours sur ce serveur")
		return
	end
	busyUntil = os.clock() + LENGTH
	playFor(Players:GetPlayers(), true, math.clamp(tonumber(duration) or 600, 60, 86400))
end)
