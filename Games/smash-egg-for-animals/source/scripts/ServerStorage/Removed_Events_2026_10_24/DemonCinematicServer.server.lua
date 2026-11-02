-- DemonCinematicServer : la cinématique "Demon City" (panneau admin F2 > onglet Cutscene-Event, via CutsceneEventServer).
--   GameBindables.PlayDemonCity:Fire()        film pour tout le serveur, puis le combat contre le TRUE DEMON (DemonBossController)
--   GameBindables.PlayDemonCity:Fire(joueur)  test : le film seul pour ce joueur, sans combat
-- Le film est joué côté client (DemonCinematicClient -> FightFilm.DemonFilm) ; ici :
--   * les avatars R15 de kinoshi112 et rexydev1 sont récupérés par leur nom d'utilisateur (tenue actuelle) dans FightFilm.DemonRigs
--     (si Roblox ne répond pas : identifiants connus, puis les copies d'AlienRigs, puis un personnage en blocs côté film)
--   * la ville est sortie de ServerStorage pendant l'event (DemonCityBuilder.show)
--   * le combat commence quand le premier joueur a fini le film (remote DemonCity.CinematicEvent "done"), ou au plus tard après
--     Config.Film.MaxWait secondes (film interrompu, joueur parti...) : personne ne reste bloqué
--   * une seule séance à la fois sur le serveur, jamais pendant un combat
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local shared = ReplicatedStorage:WaitForChild("DemonCity")
local Config = require(shared:WaitForChild("CinematicConfig"))
local Builder = require(ServerStorage:WaitForChild("DemonCityBuilder"))
local remote = shared:WaitForChild("CinematicEvent")
local bindables = ServerStorage:WaitForChild("GameBindables")
local startArena = bindables:WaitForChild("StartDemonArena")

---------------------------------------------------------------- avatars (R15, tenue actuelle), par nom d'utilisateur
local CAST = {
	Kino = {name = "kinoshi112", id = 11323571606},
	Rex = {name = "rexydev1", id = 2709850193},
}
local function buildRigs()
	local film = ReplicatedStorage:WaitForChild("FightFilm")
	local folder = film:FindFirstChild("DemonRigs")
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = "DemonRigs"
		folder.Parent = film
	end
	for key, info in CAST do
		local userId = info.id
		local okId, found = pcall(function() return Players:GetUserIdFromNameAsync(info.name) end)
		if okId and typeof(found) == "number" then userId = found end
		local ok, model = pcall(function()
			return Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(userId), Enum.HumanoidRigType.R15)
		end)
		if ok and model then
			for _, d in model:GetDescendants() do
				if d:IsA("LuaSourceContainer") or d:IsA("Animator") then d:Destroy() end
			end
			model.Name = key
			model:SetAttribute("UserId", userId)
			model:SetAttribute("Username", info.name)
			local old = folder:FindFirstChild(key)
			model.Parent = folder
			if old and old ~= model then old:Destroy() end
		else
			warn("[DemonCity] avatar de " .. info.name .. " introuvable, copie de secours utilisée : " .. tostring(model))
		end
	end
end
task.spawn(buildRigs)

---------------------------------------------------------------- séances
local session -- {players = {[player] = true}, t0, done, withFight}
local busy = false

remote.OnServerEvent:Connect(function(player, action)
	if action ~= "done" then return end
	local s = session
	if not s or s.done or not s.players[player] then return end
	if os.clock() - s.t0 < 30 then return end -- (jamais trop tôt : le film dure environ une minute)
	s.done = true
end)

local function playFor(list, withFight)
	local set, n = {}, 0
	for _, p in list do
		if p.Parent then set[p] = true n += 1 end
	end
	if n == 0 then return end
	Builder.setCollapsed(false)
	Builder.show(true)
	local s = {players = set, t0 = os.clock(), done = false, withFight = withFight}
	session = s
	task.wait(0.5) -- (le temps que la ville parte vers les joueurs)
	for p in set do
		if p.Parent then
			if withFight then p:SetAttribute("EventSpeed", Config.Boss.EventSpeed) end
			remote:FireClient(p, "play", withFight)
		end
	end
	while not s.done and os.clock() - s.t0 < Config.Film.MaxWait do task.wait(0.25) end
	if session == s then session = nil end
	if withFight then
		local still = {}
		for p in set do if p.Parent then table.insert(still, p) end end
		startArena:Fire(still)
		-- ceux qui n'entrent pas dans le combat retrouvent leur vitesse
		task.delay(4, function()
			for _, p in still do
				if p.Parent and not p:GetAttribute("InDemonArena") then p:SetAttribute("EventSpeed", nil) end
			end
		end)
	else
		task.wait(2)
		if not shared:GetAttribute("FightActive") and not session then Builder.show(false) end
	end
end

bindables:WaitForChild("PlayDemonCity").Event:Connect(function(onlyFor)
	if typeof(onlyFor) == "Instance" and onlyFor:IsA("Player") then
		-- test (le film seul) : pas pendant un vrai event, ni pour un joueur déjà dans une arène
		if busy or shared:GetAttribute("FightActive") or session then return end
		if onlyFor:GetAttribute("InDemonArena") or onlyFor:GetAttribute("InBossArena") then return end
		task.spawn(playFor, {onlyFor}, false)
		return
	end
	if busy or shared:GetAttribute("FightActive") then
		warn("[DemonCity] déjà en cours sur ce serveur")
		return
	end
	busy = true
	task.spawn(function()
		local list = {}
		for _, p in Players:GetPlayers() do
			if not p:GetAttribute("InBossArena") and not p:GetAttribute("InDemonArena") then table.insert(list, p) end
		end
		local ok, err = pcall(playFor, list, true)
		if not ok then warn("[DemonCity] " .. tostring(err)) end
		busy = false
	end)
end)
