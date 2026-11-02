-- ============================================
-- LEADERBOARD PANEL SERVER
-- À placer dans ServerScriptService (Script normal)
-- Fusionne les joueurs EN LIGNE (données live, affichage immédiat)
-- avec l'OrderedDataStore (source globale, cross-serveur, pour les hors-ligne)
-- ============================================

print("🟢 [LBPanel] Le script démarre.")

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local requireOk, DataHandler = pcall(function()
	return require(ServerScriptService:WaitForChild("DataService"):WaitForChild("DataHandler"))
end)

if not requireOk then
	print("🔴 [LBPanel] ECHEC require DataHandler : " .. tostring(DataHandler))
	return
end
print("🟢 [LBPanel] DataHandler chargé.")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- ============================
-- ACCES : accessible à TOUT LE MONDE désormais
-- ============================
local function hasAccess(player)
	return true
end

local checkAccessRemote = Instance.new("RemoteFunction")
checkAccessRemote.Name = "CheckLeaderboardPanelAccess"
checkAccessRemote.Parent = Remotes

checkAccessRemote.OnServerInvoke = function(player)
	return hasAccess(player)
end

local getLeaderboardRemote = Instance.new("RemoteFunction")
getLeaderboardRemote.Name = "GetLeaderboardPanelData"
getLeaderboardRemote.Parent = Remotes

local TOP_COUNT = 50
local REFRESH_INTERVAL = 5

local cache = {
	Wins = { data = {} },
	TotalXP = { data = {} },
}

local playerNameCache = {}
local function getPlayerName(userId)
	if playerNameCache[userId] then
		return playerNameCache[userId]
	end
	local success, name = pcall(function()
		return Players:GetNameFromUserIdAsync(userId)
	end)
	if success and name then
		playerNameCache[userId] = name
		return name
	end
	return "Player_" .. tostring(userId)
end

-- ============================
-- CONSTRUIT LE CLASSEMENT : fusionne OrderedDataStore + joueurs en ligne
-- ============================
local function buildLeaderboard(dataKey)
	-- 1) Récupère le classement "officiel" depuis l'OrderedDataStore (global, cross-serveur)
	local success, topEntries = pcall(function()
		return DataHandler.GetTopEntries(dataKey, TOP_COUNT)
	end)

	local entryMap = {} -- [userId] = { userId, value }

	if success and topEntries then
		for _, entry in ipairs(topEntries) do
			entryMap[entry.userId] = { userId = entry.userId, value = entry.value }
		end
		print("🟢 [LBPanel] GetTopEntries(" .. dataKey .. ") -> " .. #topEntries .. " entrée(s) depuis le DataStore.")
	else
		print("🟡 [LBPanel] GetTopEntries(" .. dataKey .. ") indisponible ou vide pour l'instant : " .. tostring(topEntries))
	end

	-- 2) Écrase/ajoute avec les valeurs LIVE des joueurs en ligne (affichage immédiat,
	--    même si le DataStore n'a pas encore fini d'indexer leur dernière valeur)
	for _, plr in ipairs(Players:GetPlayers()) do
		local data = DataHandler.Get(plr)
		if data then
			local value = data[dataKey] or 0
			entryMap[plr.UserId] = { userId = plr.UserId, value = value }
		end
	end

	-- 3) Transforme en liste triée
	local list = {}
	for _, entry in pairs(entryMap) do
		table.insert(list, entry)
	end
	table.sort(list, function(a, b)
		return a.value > b.value
	end)

	-- 4) Découpe au Top N et résout les noms
	local result = {}
	for i = 1, math.min(TOP_COUNT, #list) do
		local entry = list[i]
		table.insert(result, {
			rank = i,
			userId = entry.userId,
			username = getPlayerName(entry.userId),
			value = entry.value,
		})
	end

	return result
end

-- ============================
-- POUSSE LES JOUEURS EN LIGNE VERS L'ORDEREDDATASTORE (persistance globale)
-- ============================
local function pushPlayer(plr)
	local data = DataHandler.Get(plr)
	if not data then return false end

	local ok, err = pcall(function()
		DataHandler.UpdateOrderedStores(plr)
	end)
	if not ok then
		print("🔴 [LBPanel] Erreur UpdateOrderedStores pour " .. plr.Name .. " : " .. tostring(err))
		return false
	end
	return true
end

local function refreshAll()
	for _, plr in ipairs(Players:GetPlayers()) do
		pushPlayer(plr)
	end
	for dataKey, _ in pairs(cache) do
		cache[dataKey].data = buildLeaderboard(dataKey)
	end
end

-- ============================
-- QUAND UN JOUEUR REJOINT : il doit apparaître IMMEDIATEMENT (même à 0)
-- ============================
Players.PlayerAdded:Connect(function(plr)
	task.spawn(function()
		local attempts = 0
		while attempts < 20 do
			local data = DataHandler.Get(plr)
			if data then
				break
			end
			attempts += 1
			task.wait(0.5)
		end

		-- Que les données soient trouvées ou non après 10s, on reconstruit le cache :
		-- si trouvées, le joueur apparaît avec sa vraie valeur (même 0).
		pushPlayer(plr)
		for dataKey, _ in pairs(cache) do
			cache[dataKey].data = buildLeaderboard(dataKey)
		end
		print("🟢 [LBPanel] Cache reconstruit après l'arrivée de " .. plr.Name)
	end)
end)

Players.PlayerRemoving:Connect(function(plr)
	-- Sauvegarde une dernière fois sa valeur au DataStore avant qu'il ne soit plus "en ligne"
	pushPlayer(plr)
end)

-- ============================
-- REFRESH AUTOMATIQUE
-- ============================
task.spawn(function()
	-- Premier cycle immédiat
	refreshAll()

	while true do
		task.wait(REFRESH_INTERVAL)
		refreshAll()
	end
end)

-- ============================
-- HANDLER
-- ============================
getLeaderboardRemote.OnServerInvoke = function(player, category)
	if not hasAccess(player) then
		return {}
	end
	if category ~= "Wins" and category ~= "TotalXP" then
		return {}
	end
	return cache[category].data
end

print("✅ [LBPanel] Script entièrement chargé et prêt.")