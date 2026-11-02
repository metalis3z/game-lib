-- Cinématique "The Hollow Reaper" (panneau admin > Cutscenes) : feu de camp la nuit, la Faucheuse sort de terre, les trois
-- dégainent (rexydev1 le feu, kinoshi112 la glace, Nono275er le vent). Le serveur prépare les 3 avatars (vrais skins, en R15) dans
-- ReplicatedStorage.ReaperCutscene.Rigs puis demande aux clients de jouer la scène (StarterPlayerScripts.ReaperFilmClient,
-- qui lance ReplicatedStorage.FightFilm.ReaperFilm).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = require(game:GetService("ServerScriptService"):WaitForChild("GlobalBus")) -- (un seul abonnement pour tout le jeu : voir GlobalBus)

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local startRemote = remotes:WaitForChild("StartReaperCutscene")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")
local folder = ReplicatedStorage:WaitForChild("ReaperCutscene")
local playRemote = folder:WaitForChild("Play")
local rigs = folder:WaitForChild("Rigs")

local TOPIC = "AdminReaperCutscene"
local LENGTH = 108 -- durée de la cinématique (s) : 92 s de film (avec le combat dans le ciel), le noir d'ouverture et une marge
local CAST = {
	Rex = {Name = "rexydev1", UserId = 2709850193},
	Kino = {Name = "kinoshi112", UserId = 11323571606},
	Nono = {Name = "Nono275er"}, -- id retrouvé à partir du pseudo
}

local loading = false
local function loadRigs()
	while loading do task.wait(0.2) end
	if #rigs:GetChildren() >= 3 then return end
	loading = true
	for role, who in CAST do
		if not rigs:FindFirstChild(role) then
			local ok, model = pcall(function()
				local id = who.UserId or Players:GetUserIdFromNameAsync(who.Name)
				return Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(id), Enum.HumanoidRigType.R15)
			end)
			if not ok then
				warn("[ReaperCutscene] skin de " .. who.Name .. " introuvable : " .. tostring(model))
				ok, model = pcall(function() return Players:CreateHumanoidModelFromDescription(Instance.new("HumanoidDescription"), Enum.HumanoidRigType.R15) end)
			end
			if ok and model then
				model.Name = role
				model:SetAttribute("DisplayName", who.Name)
				for _, d in model:GetDescendants() do
					if d:IsA("Script") or d:IsA("LocalScript") or d:IsA("Animator") then d:Destroy() end
				end
				model.Parent = rigs
			end
		end
	end
	loading = false
end
task.spawn(loadRigs)

local busyUntil = 0
local function play(only)
	if os.clock() < busyUntil and not only then return end
	loadRigs()
	if only then
		playRemote:FireClient(only)
	else
		busyUntil = os.clock() + LENGTH
		playRemote:FireAllClients()
	end
end

pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function() task.spawn(play) end)
end)

-- scope : "me" = seulement l'admin (pour tester), "server" = ce serveur, sinon tous les serveurs
startRemote.OnServerEvent:Connect(function(player, scope)
	if not table.find(AdminConfig.AdminIds, player.UserId) then return end
	if scope == "me" then
		task.spawn(play, player)
		return
	end
	if os.clock() < busyUntil then
		notifyRemote:FireClient(player, "The cutscene is already playing")
		return
	end
	local sent = scope ~= "server" and pcall(function() MessagingService:PublishAsync(TOPIC, {t = os.time()}) end)
	if not sent then task.spawn(play) end
	notifyRemote:FireClient(player, sent and "Reaper cutscene started on ALL servers" or "Reaper cutscene started on this server")
end)
