-- Cinématique "Samouraï contre la horde" (panneau admin > Cutscenes). Tout est joué côté client (FightFilm.SamuraiFilm) :
-- le serveur vérifie seulement que la demande vient d'un admin, puis prévient les clients.
-- À la fin du film, le portail aspire tout le monde : le combat contre le Headless commence dans l'arène (BossArenaServer).
-- scope : "me" = seulement l'admin (pour tester, l'arène aussi), "server" = ce serveur, sinon tous les serveurs.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local MessagingService = game:GetService("MessagingService")
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local startRemote = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes"):WaitForChild("StartSamuraiFilm")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")
local film = ReplicatedStorage:WaitForChild("FightFilm")
local playRemote = film:WaitForChild("Play")
local doneRemote = film:WaitForChild("Done") -- un client a fini le film
local startArena = ServerStorage:WaitForChild("GameBindables"):WaitForChild("StartBossArena")

-- le héros du film : ton avatar en R6 (comme en jeu). Les articulations sont refaites au format des cinématiques (FightFilm.Kit :
-- Root, Neck, RightShoulder, LeftShoulder, RightHip, LeftHip, sans rotation de base) ; rangé dans ReaperCutscene.Rigs.RexR6
local HERO_ID = 2709850193 -- rexydev1
local function buildHeroR6()
	local rigs = ReplicatedStorage:WaitForChild("ReaperCutscene"):WaitForChild("Rigs")
	if rigs:FindFirstChild("RexR6") then return end
	local ok, model = pcall(function()
		return Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(HERO_ID), Enum.HumanoidRigType.R6)
	end)
	if not ok or not model then warn("[SamuraiFilm] avatar R6 introuvable : " .. tostring(model)) return end
	for _, d in model:GetDescendants() do
		if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("Animator") then d:Destroy() end
	end
	local hrp, torso = model:FindFirstChild("HumanoidRootPart"), model:FindFirstChild("Torso")
	local function joint(name, part0, part1, c0, c1)
		if not part0 or not part1 then return end
		local m = Instance.new("Motor6D")
		m.Name = name
		m.Part0, m.Part1 = part0, part1
		m.C0, m.C1 = CFrame.new(c0), CFrame.new(c1)
		m.Parent = part1
	end
	for _, d in model:GetDescendants() do if d:IsA("Motor6D") then d:Destroy() end end
	torso.CFrame = hrp.CFrame
	joint("Root", hrp, torso, Vector3.zero, Vector3.zero)
	joint("Neck", torso, model:FindFirstChild("Head"), Vector3.new(0, 1, 0), Vector3.new(0, -0.5, 0))
	joint("RightShoulder", torso, model:FindFirstChild("Right Arm"), Vector3.new(1, 0.5, 0), Vector3.new(-0.5, 0.5, 0))
	joint("LeftShoulder", torso, model:FindFirstChild("Left Arm"), Vector3.new(-1, 0.5, 0), Vector3.new(0.5, 0.5, 0))
	joint("RightHip", torso, model:FindFirstChild("Right Leg"), Vector3.new(0.5, -1, 0), Vector3.new(0, 1, 0))
	joint("LeftHip", torso, model:FindFirstChild("Left Leg"), Vector3.new(-0.5, -1, 0), Vector3.new(0, 1, 0))
	model.Name = "RexR6"
	model:SetAttribute("Scale", 1)
	model.Parent = rigs
end
task.spawn(buildHeroR6)

local TOPIC = "AdminSamuraiFilm"
local LENGTH = 85 -- au plus (s) : le film dure ~70 s, plus l'attente du début ; l'arène démarre au premier client qui a fini
local busyUntil = 0
local waiting -- {players, done}

doneRemote.OnServerEvent:Connect(function(player)
	if waiting and waiting.players[player] then waiting.done = true end
end)

local function playFor(list)
	local set = {}
	for _, p in list do set[p] = true end
	local w = {players = set, done = false}
	waiting = w
	for _, p in list do playRemote:FireClient(p) end
	task.spawn(function()
		local t0 = os.clock()
		while not w.done and os.clock() - t0 < LENGTH do task.wait(0.25) end
		if waiting == w then waiting = nil end
		local still = {}
		for _, p in list do if p.Parent then table.insert(still, p) end end
		startArena:Fire(still)
	end)
end

local function play()
	if os.clock() < busyUntil then return end
	busyUntil = os.clock() + LENGTH
	playFor(Players:GetPlayers())
end
pcall(function() MessagingService:SubscribeAsync(TOPIC, function() task.spawn(play) end) end)

startRemote.OnServerEvent:Connect(function(player, scope)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	if scope == "me" then
		playFor({player})
		return
	end
	if os.clock() < busyUntil then
		notifyRemote:FireClient(player, "The cutscene is already playing")
		return
	end
	local sent = scope ~= "server" and pcall(function() MessagingService:PublishAsync(TOPIC, {t = os.time()}) end)
	if not sent then task.spawn(play) end
	notifyRemote:FireClient(player, sent and "Samurai cutscene started on ALL servers" or "Samurai cutscene started on this server")
end)
