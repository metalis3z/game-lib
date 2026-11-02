-- Classement du REVENU DE LA BASE par seconde (top 99), mis à jour toutes les 2 minutes.
-- Le revenu par seconde de chaque joueur connecté (attribut Income, posé par PetServer : animaux posés x rebirth x VIP)
-- est enregistré dans un OrderedDataStore, puis le top 99 est publié dans ReplicatedStorage.MoneyLeaderboard (JSON) ;
-- le panneau du Workspace l'affiche côté client.
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local REFRESH = 120 -- secondes entre deux mises à jour
local TOP = 99
local output = ReplicatedStorage:WaitForChild("MoneyLeaderboard")
-- les comptes admin (AdminConfig.AdminIds) n'apparaissent jamais dans le classement (ils ont des sommes de test)
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local function banned(userId) return table.find(AdminConfig.AdminIds, userId) ~= nil end
local ok, store = pcall(function() return DataStoreService:GetOrderedDataStore("IncomeTop_v2") end) -- v2 : classement remis à zéro avec le reset des données (v1 n'est plus utilisé)
if not ok then
	warn("[LeaderboardServer] DataStore indisponible : " .. tostring(store))
	store = nil
end

local names = {"eduardloke12345"} -- [userId] = nom (cache)
local function nameOf(userId)
	if names[userId] then return names[userId] end
	local player = Players:GetPlayerByUserId(userId)
	local success, name = true, player and player.Name
	if not name then success, name = pcall(function() return Players:GetNameFromUserIdAsync(userId) end) end
	names[userId] = success and name or "Player"
	return names[userId]
end

-- dernier revenu connu de chaque joueur connecté, relevé souvent : quand un joueur part, ses animaux sont retirés et
-- son revenu retombe à 0 avant qu'on ait pu le lire. On n'enregistre jamais 0 (données pas encore chargées, ou départ).
local lastIncome = {} -- [userId] = revenu
local function sample(player)
	local income = player:GetAttribute("Income")
	if income and income > 0 then lastIncome[player.UserId] = income end
end
task.spawn(function()
	while true do
		for _, player in Players:GetPlayers() do sample(player) end
		task.wait(5)
	end
end)

local function record(player)
	if not store or banned(player.UserId) then return end
	sample(player)
	local income = lastIncome[player.UserId]
	if not income then return end
	pcall(function() store:SetAsync(tostring(player.UserId), math.floor(math.clamp(income, 1, 9e15))) end)
end

local function refresh()
	local list = {}
	if store then
		for _, player in Players:GetPlayers() do record(player) end
		local success, pages = pcall(function() return store:GetSortedAsync(false, TOP) end)
		if success then
			for rank, entry in pages:GetCurrentPage() do
				local userId = tonumber(entry.key)
				if userId and entry.value > 0 and not banned(userId) then table.insert(list, {Rank = #list + 1, UserId = userId, Name = nameOf(userId), Income = entry.value}) end
			end
		else
			warn("[LeaderboardServer] lecture du classement ratée : " .. tostring(pages))
			return
		end
	else -- sans DataStore (Studio sans accès API) : classement des joueurs connectés
		for _, player in Players:GetPlayers() do
			if not banned(player.UserId) then table.insert(list, {UserId = player.UserId, Name = player.Name, Income = math.floor(player:GetAttribute("Income") or 0)}) end
		end
		table.sort(list, function(a, b) return a.Income > b.Income end)
		for rank, entry in list do entry.Rank = rank end
	end
	output.Value = HttpService:JSONEncode(list)
	output:SetAttribute("NextUpdate", workspace:GetServerTimeNow() + REFRESH)
end

Players.PlayerRemoving:Connect(function(player) -- le score d'un joueur qui part est gardé : il reste dans le classement
	record(player)
	lastIncome[player.UserId] = nil
end)
task.wait(12) -- laisse le temps aux données des premiers joueurs de se charger
while true do
	refresh()
	task.wait(REFRESH)
end
