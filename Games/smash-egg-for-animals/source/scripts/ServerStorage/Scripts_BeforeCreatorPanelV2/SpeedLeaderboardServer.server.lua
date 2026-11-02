-- Classement du MEILLEUR SPEED (top 99), mis à jour toutes les 5 minutes, à côté du classement de l'argent.
-- Le speed peut dépasser ce qu'un OrderedDataStore sait ranger (entiers jusqu'à 9e18) : on y range log10(speed) x 1e6,
-- ce qui garde le même ordre, et on retrouve le speed en relisant. Le top est publié dans ReplicatedStorage.SpeedLeaderboard (JSON).
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local REFRESH = 300
local TOP = 99
local SCALE = 1e6
local output = ReplicatedStorage:WaitForChild("SpeedLeaderboard")
-- les comptes admin (AdminConfig.AdminIds) n'apparaissent jamais dans le classement (ils ont des sommes de test)
local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local function banned(userId) return table.find(AdminConfig.AdminIds, userId) ~= nil end
local ok, store = pcall(function() return DataStoreService:GetOrderedDataStore("SpeedTop_v3") end) -- v3 : remis à zéro avec le reset du speed de tous les joueurs
if not ok then
	warn("[SpeedLeaderboardServer] DataStore indisponible : " .. tostring(store))
	store = nil
end

local names = {}
local function nameOf(userId)
	if names[userId] then return names[userId] end
	local player = Players:GetPlayerByUserId(userId)
	local success, name = true, player and player.Name
	if not name then success, name = pcall(function() return Players:GetNameFromUserIdAsync(userId) end) end
	names[userId] = success and name or "Player"
	return names[userId]
end

local function record(player)
	local speed = player:GetAttribute("Speed")
	if not store or not speed or speed < 1 or banned(player.UserId) then return end
	pcall(function() store:SetAsync(tostring(player.UserId), math.floor(math.log10(speed + 1) * SCALE)) end)
end

local function refresh()
	local list = {}
	if store then
		for _, player in Players:GetPlayers() do record(player) end
		local success, pages = pcall(function() return store:GetSortedAsync(false, TOP) end)
		if not success then
			warn("[SpeedLeaderboardServer] lecture du classement ratée : " .. tostring(pages))
			return
		end
		for _, entry in pages:GetCurrentPage() do
			local userId = tonumber(entry.key)
			if userId and entry.value > 0 and not banned(userId) then table.insert(list, {Rank = #list + 1, UserId = userId, Name = nameOf(userId), Speed = 10 ^ (entry.value / SCALE) - 1}) end
		end
	else -- sans DataStore (Studio sans accès API) : classement des joueurs connectés
		for _, player in Players:GetPlayers() do
			if not banned(player.UserId) then table.insert(list, {UserId = player.UserId, Name = player.Name, Speed = player:GetAttribute("Speed") or 0}) end
		end
		table.sort(list, function(a, b) return a.Speed > b.Speed end)
		for rank, entry in list do entry.Rank = rank end
	end
	output.Value = HttpService:JSONEncode(list)
	output:SetAttribute("NextUpdate", workspace:GetServerTimeNow() + REFRESH)
end

Players.PlayerRemoving:Connect(record)
task.wait(12)
while true do
	refresh()
	task.wait(REFRESH)
end
