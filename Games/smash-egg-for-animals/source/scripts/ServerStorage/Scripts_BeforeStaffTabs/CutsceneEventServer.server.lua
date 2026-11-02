-- Cutscene-Event : des cinématiques qui lancent un event (ou un mini-jeu) quand elles se terminent.
-- Panneau admin (F2) > onglet "Cutscene-Event" (StarterPlayerScripts.AdminCutsceneEventsTab).
-- Pour en ajouter une : une entrée dans COMBOS (Play lance la cinématique sur ce serveur, Length = sa durée, puis Then).
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local MessagingService = require(game:GetService("ServerScriptService"):WaitForChild("GlobalBus")) -- (un seul abonnement pour tout le jeu : voir GlobalBus)

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local bindables = ServerStorage:WaitForChild("GameBindables")
local startRemote = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes"):WaitForChild("StartCutsceneEvent")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")
local TOPIC = "AdminCutsceneEvent"

local COMBOS = {
	-- Hacker Infiltration (34 s + 2 s de chargement) : le hacker pirate le système... puis l'event HACKER ATTACK commence
	HackerInfiltration = {
		Name = "Hacker Infiltration -> HACKER ATTACK",
		Length = 36,
		Play = function() bindables:WaitForChild("PlayHackerCutscene"):Fire() end,
		Then = function(duration) bindables:WaitForChild("RunSkyEvent"):Fire("Hacker", "start", duration) end,
	},
	-- Samouraï contre le Headless (~70 s) : à la fin, le trou noir aspire tout le monde dans l'arène du boss (SamuraiFilmServer
	-- attend la fin du film lui-même, puis BossArenaServer). Me = test pour l'admin seul.
	SamuraiArena = {
		Name = "Samurai vs The Headless -> BOSS ARENA",
		Length = 0,
		Play = function() bindables:WaitForChild("PlaySamuraiArena"):Fire() end,
		Then = function() end,
		Me = function(player) bindables:WaitForChild("PlaySamuraiArena"):Fire(player) end,
	},
	-- Alien Invasion (~2 min) : enlèvement, combat contre l'alien, crash dans la Safe Zone, collision de deux galaxies... et le
	-- GALAXY EVENT commence au moment de la collision (AlienFilmServer s'en charge). Me = le film seul pour l'admin, sans event.
	AlienInvasion = {
		Name = "Alien Invasion -> GALAXY EVENT",
		Length = 0,
		Play = function(duration) bindables:WaitForChild("PlayAlienFilm"):Fire(nil, duration) end,
		Then = function() end,
		Me = function(player) bindables:WaitForChild("PlayAlienFilm"):Fire(player) end,
	},
	-- Demon City (~1 min) : combat contre le démon dans la ville détruite, puis PHASE 2 : tout le monde est téléporté sur la place
	-- pour affronter le TRUE DEMON (DemonCinematicServer attend la fin du film, puis DemonBossController). Me = le film seul.
	DemonCity = {
		Name = "Demon City -> THE TRUE DEMON",
		Length = 0,
		Play = function() bindables:WaitForChild("PlayDemonCity"):Fire() end,
		Then = function() end,
		Me = function(player) bindables:WaitForChild("PlayDemonCity"):Fire(player) end,
	},
}

local busy = {}
local function run(id, duration)
	local combo = COMBOS[id]
	if not combo or busy[id] then return false end
	busy[id] = true
	combo.Play(duration) -- (durée de l'event : utile si la cinématique lance l'event elle-même, comme Alien Invasion)
	task.delay(combo.Length, function()
		busy[id] = nil
		combo.Then(duration)
	end)
	return true
end

-- tous les serveurs
pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) == "table" and data.JobId ~= game.JobId then run(data.Id, data.Duration) end
	end)
end)

startRemote.OnServerEvent:Connect(function(player, id, scope, duration)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	local combo = COMBOS[id]
	if not combo then return end
	duration = math.clamp(tonumber(duration) or 600, 60, 86400)
	if scope == "me" then
		if combo.Me then
			combo.Me(player)
			notifyRemote:FireClient(player, combo.Name .. " started (only for you)")
		end
		return
	end
	if not run(id, duration) then
		notifyRemote:FireClient(player, combo.Name .. " is already playing")
		return
	end
	if scope == "global" then
		pcall(function() MessagingService:PublishAsync(TOPIC, {Id = id, Duration = duration, JobId = game.JobId}) end)
	end
	notifyRemote:FireClient(player, combo.Name .. " started" .. (scope == "global" and " on ALL servers" or ""))
end)
