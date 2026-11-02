-- ============================================
-- SCRIPT SERVEUR - GESTION RESPAWN SANS FREEZE
-- À placer dans ServerScriptService
-- ============================================

local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

-- DataStore (à adapter selon ton système de sauvegarde)
local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("PlayerData")

-- Cache mémoire pour éviter de recharger le DataStore à chaque respawn
local playerDataCache = {}

-- ============================
-- CHARGEMENT DES DONNÉES (une seule fois, au join, PAS à chaque respawn)
-- ============================
local function loadPlayerData(player)
	local success, data = pcall(function()
		return playerDataStore:GetAsync("Player_" .. player.UserId)
	end)

	if success and data then
		playerDataCache[player.UserId] = data
	else
		playerDataCache[player.UserId] = {
			coins = 0,
			wpm = 0,
			-- ajoute tes stats ici
		}
		if not success then
			warn("⚠️ Erreur chargement data pour " .. player.Name .. " : " .. tostring(data))
		end
	end
end

-- ============================
-- SETUP DU PERSONNAGE (rapide, sans blocage)
-- ============================
local function onCharacterAdded(player, character)
	-- Timeout de sécurité sur toutes les parties du personnage
	local humanoid = character:WaitForChild("Humanoid", 5)
	local rootPart = character:WaitForChild("HumanoidRootPart", 5)

	if not humanoid or not rootPart then
		warn("⚠️ Personnage incomplet pour " .. player.Name)
		return
	end

	-- Exemple : appliquer les stats depuis le cache (pas de DataStore ici = pas de freeze)
	local data = playerDataCache[player.UserId]
	if data then
		-- applique tes stats stockées en mémoire, ex :
		-- leaderstats.Coins.Value = data.coins
	end

	-- Tout traitement lourd (animations, accessoires, etc.) doit être async
	task.spawn(function()
		local success, err = pcall(function()
			-- ex: charger accessoires, effets, animations custom
		end)
		if not success then
			warn("⚠️ Erreur setup personnage : " .. tostring(err))
		end
	end)
end

-- ============================
-- LEADERSTATS (créés une seule fois au join)
-- ============================
local function setupLeaderstats(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Value = playerDataCache[player.UserId] and playerDataCache[player.UserId].coins or 0
	coins.Parent = leaderstats

	-- ajoute d'autres stats (WPM, score...) ici de la même façon
end

-- ============================
-- SAUVEGARDE (async, jamais bloquant)
-- ============================
local function savePlayerData(player)
	local data = playerDataCache[player.UserId]
	if not data then return end

	task.spawn(function()
		local success, err = pcall(function()
			playerDataStore:SetAsync("Player_" .. player.UserId, data)
		end)
		if not success then
			warn("⚠️ Erreur sauvegarde pour " .. player.Name .. " : " .. tostring(err))
		end
	end)
end

-- ============================
-- EVENTS PRINCIPAUX
-- ============================
Players.PlayerAdded:Connect(function(player)
	-- Chargement des données UNE SEULE FOIS (pas à chaque respawn)
	task.spawn(function()
		loadPlayerData(player)
		setupLeaderstats(player)
	end)

	-- À chaque respawn, setup rapide sans recharger le DataStore
	player.CharacterAdded:Connect(function(character)
		onCharacterAdded(player, character)
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	savePlayerData(player)
	playerDataCache[player.UserId] = nil
end)

-- ============================
-- SAUVEGARDE AUTO PÉRIODIQUE (sécurité anti-perte de données)
-- ============================
task.spawn(function()
	while true do
		task.wait(300) -- toutes les 5 minutes
		for _, player in pairs(Players:GetPlayers()) do
			savePlayerData(player)
		end
	end
end)

print("✅ Script respawn/anti-freeze chargé avec succès")