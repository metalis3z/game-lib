-- ScriptServeur: GlobalPlayerCounter - RAFRAÎCHISSEMENT RAPIDE
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

-- Variables
local remoteEvent = nil
local universeId = nil
local globalCount = 0
local isUpdating = false

-- Création du RemoteEvent
local function setupRemoteEvent()
	remoteEvent = ReplicatedStorage:FindFirstChild("GlobalPlayerCount")
	if not remoteEvent then
		remoteEvent = Instance.new("RemoteEvent")
		remoteEvent.Name = "GlobalPlayerCount"
		remoteEvent.Parent = ReplicatedStorage
		print("[SERVER] ✅ RemoteEvent créé")
	end
end

-- Récupération de l'UniverseId
local function getUniverseId()
	local success, result = pcall(function()
		return HttpService:GetAsync("https://apis.roproxy.com/universes/v1/places/" .. game.PlaceId .. "/universe")
	end)

	if success and result then
		local data = HttpService:JSONDecode(result)
		if data and data.universeId then
			return data.universeId
		end
	end
	return nil
end

-- Récupération du nombre global de joueurs (TOUS LES SERVEURS)
local function getGlobalCount()
	if not universeId then return 0 end

	local success, result = pcall(function()
		return HttpService:GetAsync("https://games.roproxy.com/v1/games?universeIds=" .. universeId, 3)
	end)

	if success and result then
		local data = HttpService:JSONDecode(result)
		if data and data.data and data.data[1] then
			return data.data[1].playing or 0
		end
	end
	return 0
end

-- Envoi à tous les joueurs
local lastSentCount = nil
local function sendToAll()
	if remoteEvent and globalCount ~= lastSentCount then
		lastSentCount = globalCount
		pcall(function()
			remoteEvent:FireAllClients(globalCount)
		end)
	end
end

-- Envoi à un joueur spécifique
local function sendToPlayer(player)
	if player and remoteEvent then
		pcall(function()
			remoteEvent:FireClient(player, globalCount)
		end)
	end
end

-- Mise à jour du compteur global (uniquement si changé)
local function updateGlobalCount()
	if isUpdating then return end
	isUpdating = true

	if universeId then
		local newCount = getGlobalCount()
		if newCount > 0 and newCount ~= globalCount then
			globalCount = newCount
			print(string.format("[SERVER] 🌍 Mise à jour: %d joueurs globaux", globalCount))
			sendToAll()
		end
	end

	isUpdating = false
end

-- Mise à jour IMMÉDIATE sans attendre
local function forceUpdate()
	task.spawn(function()
		updateGlobalCount()
	end)
end

-- Quand un joueur rejoint
local function onPlayerAdded(player)
	print(string.format("[SERVER] ✅ %s a rejoint", player.Name))
	forceUpdate()
	task.wait(0.1)
	sendToPlayer(player)
end

-- Boucle de mise à jour (toutes les 30 secondes)
local function startQuickUpdateLoop()
	print("[SERVER] 🔄 Boucle de rafraîchissement démarrée (toutes les 30 secondes)")
	while true do
		forceUpdate()
		task.wait(30)
	end
end

-- Initialisation
local function init()
	print("[SERVER] 🚀 Démarrage du compteur global (rafraîchissement 2s)...")
	setupRemoteEvent()

	universeId = getUniverseId()
	if universeId then
		print("[SERVER] Universe ID trouvé:", universeId)
		globalCount = getGlobalCount()
		print(string.format("[SERVER] 🌍 Nombre initial: %d joueurs globaux", globalCount))
	else
		print("[SERVER] ⚠️ Universe ID non trouvé, réessai dans 3 secondes...")
		task.wait(3)
		universeId = getUniverseId()
		globalCount = getGlobalCount()
	end

	-- Envoi aux joueurs existants
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(function() sendToPlayer(player) end)
	end

	-- Connexion des événements
	Players.PlayerAdded:Connect(onPlayerAdded)

	-- Démarrage de la boucle rapide
	task.spawn(startQuickUpdateLoop)

	print("[SERVER] ✅ Système opérationnel - Rafraîchissement toutes les 30 secondes")
end

pcall(init)