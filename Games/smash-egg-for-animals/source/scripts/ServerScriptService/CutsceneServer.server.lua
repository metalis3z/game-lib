local StaffAccess = require(game:GetService("ServerScriptService"):WaitForChild("StaffAccess")) -- (Give / cinématiques : tags DEV / Creator)
-- CutsceneServer : cinématique "Point Zéro" (commande admin StartPointZero, ce serveur ou tous les serveurs)
-- Charge les skins Roblox des 3 acteurs (en R15) et les met dans ReplicatedStorage.CutsceneAssets.Actors,
-- puis demande à tous les clients de jouer la cinématique (CutsceneClient).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = require(game:GetService("ServerScriptService"):WaitForChild("GlobalBus")) -- (un seul abonnement pour tout le jeu : voir GlobalBus)

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local startRemote = remotes:WaitForChild("StartPointZero") -- (StartCutscene est déjà utilisé par l'autre cinématique du jeu)
local playRemote = ReplicatedStorage:WaitForChild("CutscenePlay")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")
local assets = ReplicatedStorage:WaitForChild("CutsceneAssets")

local TOPIC = "AdminPointZero" -- canal à part (avant : le même que la cinématique Dev Studio, qui se lançait donc en même temps)
local DURATION = 66 -- durée de la cinématique (s)
-- rôle -> pseudo Roblox dont on prend le skin
local ACTORS = {
	Prisoner = "elifSheLuvs", -- agenouillé dans la sphère
	Flyer = "eduardloke12345",      -- vole et coupe la sphère
	Slapper = "bot83819109",   -- arrive à pied et met la gifle
}

local actorsFolder = assets:FindFirstChild("Actors") or Instance.new("Folder")
actorsFolder.Name = "Actors"
actorsFolder.Parent = assets

local loading = false
local function loadActors()
	while loading do task.wait(0.2) end
	if #actorsFolder:GetChildren() == 3 then return true end
	loading = true
	actorsFolder:ClearAllChildren()
	local okAll = true
	for role, name in ACTORS do
		local ok, model = pcall(function()
			local id = Players:GetUserIdFromNameAsync(name)
			local desc = Players:GetHumanoidDescriptionFromUserId(id)
			local m = Players:CreateHumanoidModelFromDescription(desc, Enum.HumanoidRigType.R15)
			m:SetAttribute("DisplayName", name)
			return m
		end)
		if not ok then
			warn("[Cutscene] skin de " .. name .. " introuvable : " .. tostring(model))
			-- avatar par défaut pour ne pas bloquer la cinématique
			ok, model = pcall(function() return Players:CreateHumanoidModelFromDescription(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15) end)
			if ok then model:SetAttribute("DisplayName", name) end
		end
		if ok and model then
			model.Name = role
			for _, d in model:GetDescendants() do
				if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("Animator") then d:Destroy() end
			end
			model.Parent = actorsFolder
		else
			okAll = false
		end
	end
	loading = false
	return okAll
end
task.spawn(loadActors) -- on prépare les skins dès le démarrage du serveur

local playingUntil = 0
local function play()
	if os.clock() < playingUntil then return end
	if not loadActors() then warn("[Cutscene] acteurs incomplets") end
	playingUntil = os.clock() + DURATION
	ReplicatedStorage:SetAttribute("CutsceneEnd", workspace:GetServerTimeNow() + DURATION)
	playRemote:FireAllClients("play")
	task.delay(DURATION, function() ReplicatedStorage:SetAttribute("CutsceneEnd", nil) end)
end

pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		if type(message.Data) == "table" and message.Data.action == "play" then task.spawn(play) end
	end)
end)

startRemote.OnServerEvent:Connect(function(player, action, scope) if not StaffAccess.isStaff(player) then return end -- scope "server" = ce serveur seulement ; (réservé aux tags DEV / Creator : StaffAccess)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	if action ~= "play" then return end
	if os.clock() < playingUntil then
		notifyRemote:FireClient(player, "The cutscene is already playing")
		return
	end
	local ok = scope ~= "server" and pcall(function() MessagingService:PublishAsync(TOPIC, {action = "play"}) end)
	if not ok then task.spawn(play) end
	notifyRemote:FireClient(player, "Cutscene started")
end)

-- un joueur qui arrive pendant la cinématique ne la voit pas (il joue normalement)
-- CutsceneServer : event "Dev Studio" (panneau admin F2 > Events > Cutscene).
-- Prépare les avatars de kinoshi112, rexydev1 et Nono275er (vrais skins Roblox) et lance la cutscene chez tous les joueurs
-- (ce serveur ou tous les serveurs). Toute la mise en scène est jouée côté client : StarterPlayerScripts.CutsceneClient
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = require(game:GetService("ServerScriptService"):WaitForChild("GlobalBus")) -- (un seul abonnement pour tout le jeu : voir GlobalBus)

local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local startRemote = remotes:WaitForChild("StartCutscene")
local playRemote = remotes:WaitForChild("PlayCutscene")
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local folder = ReplicatedStorage:WaitForChild("Cutscene")

local TOPIC = "AdminCutscene"
local CAST = {
	{Name = "eduardloke12345", UserId = 3160444354},
	{Name = "bot83819109", UserId = 4596856585},
	{Name = "Elifsheluvs"}, -- id retrouvé à partir du pseudo
}
local LENGTH = 82 -- durée de la cutscene (s), pour ne pas la relancer pendant qu'elle tourne

local rigs = folder:FindFirstChild("Rigs") or Instance.new("Folder")
rigs.Name = "Rigs"
rigs.Parent = folder

local function isAdmin(player)
	return table.find(AdminConfig.AdminIds, player.UserId) ~= nil
end

-- avatar R15 avec le vrai skin du joueur (même s'il n'est pas connecté)
local function buildRig(entry)
	if rigs:FindFirstChild(entry.Name) then return end
	local id = entry.UserId
	if not id then
		local ok, result = pcall(function() return Players:GetUserIdFromNameAsync(entry.Name) end)
		if ok then id = result end
	end
	local rig
	if id then
		local ok, result = pcall(function()
			local description = Players:GetHumanoidDescriptionFromUserId(id)
			return Players:CreateHumanoidModelFromDescription(description, Enum.HumanoidRigType.R15)
		end)
		if ok then rig = result else warn("[CutsceneServer] skin introuvable pour " .. entry.Name .. " : " .. tostring(result)) end
	end
	if not rig then -- secours : avatar par défaut
		local ok, result = pcall(function() return Players:CreateHumanoidModelFromDescription(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15) end)
		if not ok then return end
		rig = result
	end
	rig.Name = entry.Name
	for _, d in rig:GetDescendants() do
		if d:IsA("Script") or d:IsA("LocalScript") then d:Destroy() end
		if d:IsA("BasePart") then d.CanCollide, d.CanQuery, d.CanTouch = false, false, false end
	end
	local humanoid = rig:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
	end
	rig.HumanoidRootPart.Anchored = true
	rig:PivotTo(CFrame.new(0, 2000, 0)) -- rangé hors de vue (jamais affiché : il est dans ReplicatedStorage)
	rig.Parent = rigs
end

local function prepare()
	for _, entry in CAST do buildRig(entry) end
end
task.spawn(prepare) -- prêt dès le démarrage du serveur

-- "dev" = Dev Studio (cafés, PC en feu) ; "safe" = Halloween Talk (safe zone, verres d'eau)
local LENGTHS = {dev = LENGTH, safe = 40}
local busyUntil = 0
local function play(which)
	which = LENGTHS[which] and which or "dev"
	if os.clock() < busyUntil then return end
	busyUntil = os.clock() + LENGTHS[which]
	prepare()
	local startAt = workspace:GetServerTimeNow() + 2.5 -- laisse le temps aux joueurs de charger le décor
	ReplicatedStorage:SetAttribute("CutsceneStart", startAt)
	playRemote:FireAllClients(startAt, which)
end

startRemote.OnServerEvent:Connect(function(player, scope, which) if not StaffAccess.isStaff(player) then return end -- (réservé aux tags DEV / Creator : StaffAccess)
	if not isAdmin(player) then return end
	which = LENGTHS[which] and which or "dev"
	if scope == "global" then
		pcall(function() MessagingService:PublishAsync(TOPIC, {JobId = game.JobId, Which = which}) end)
	end
	play(which)
end)

pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local data = message.Data
		if type(data) == "table" and data.JobId == game.JobId then return end
		play(type(data) == "table" and data.Which or "dev")
	end)
end)
