-- AdminAccessServer : donner / retirer l'accès au panneau admin depuis l'onglet "Tools".
-- La liste de départ vient de ReplicatedStorage.AdminConfig.AdminIds ; les changements sont gardés dans le DataStore
-- AdminAccess_v1 (clé "List") et envoyés à tous les serveurs. La table AdminConfig.AdminIds est modifiée sur place :
-- tous les scripts serveur qui font table.find(AdminConfig.AdminIds, ...) voient donc tout de suite la nouvelle liste.
-- Le propriétaire (OWNER_ID) ne peut jamais perdre l'accès.
-- Côté client, l'attribut joueur "IsAdmin" (true/false) affiche ou cache le panneau.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local MessagingService = require(game:GetService("ServerScriptService"):WaitForChild("GlobalBus")) -- (un seul abonnement pour tout le jeu : voir GlobalBus)

local OWNER_ID = 2709850193 -- rexydev1
local TOPIC = "AdminAccessChanged"

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

local function remote(name)
	local r = remotes:FindFirstChild(name)
	if not r then
		r = Instance.new("RemoteEvent")
		r.Name = name
		r.Parent = remotes
	end
	return r
end
local setAccess = remote("SetAdminAccess") -- client -> serveur : (pseudo, true/false)
local listRemote = remote("AdminList")     -- client -> serveur : demande ; serveur -> client : liste

local BASE = table.clone(AdminConfig.AdminIds)
if not table.find(BASE, OWNER_ID) then table.insert(BASE, 1, OWNER_ID) end
local data = {added = {}, removed = {}} -- added[tostring(id)] = pseudo ; removed[tostring(id)] = true (admins de la config retirés)
local names = {[OWNER_ID] = "rexydev1"}

local store
pcall(function() store = DataStoreService:GetDataStore("AdminAccess_v1") end)

local function nameOf(userId)
	if names[userId] then return names[userId] end
	local online = Players:GetPlayerByUserId(userId)
	if online then names[userId] = online.Name return online.Name end
	local ok, name = pcall(function() return Players:GetNameFromUserIdAsync(userId) end)
	names[userId] = ok and name or tostring(userId)
	return names[userId]
end

local function isAdminId(userId) return table.find(AdminConfig.AdminIds, userId) ~= nil end

local function clean(raw)
	local result = {added = {}, removed = {}}
	if type(raw) == "table" then
		if type(raw.added) == "table" then for k, v in raw.added do if tonumber(k) then result.added[tostring(k)] = tostring(v) end end end
		if type(raw.removed) == "table" then for k, v in raw.removed do if tonumber(k) and v then result.removed[tostring(k)] = true end end end
	end
	result.removed[tostring(OWNER_ID)] = nil
	return result
end

local function sendList(player)
	local list = {}
	for _, id in AdminConfig.AdminIds do
		table.insert(list, {UserId = id, Name = nameOf(id), Owner = id == OWNER_ID})
	end
	listRemote:FireClient(player, list, player.UserId == OWNER_ID)
end

-- reconstruit AdminConfig.AdminIds sur place puis met à jour les joueurs de ce serveur
local function apply()
	local ids = {}
	for _, id in BASE do
		if id == OWNER_ID or not data.removed[tostring(id)] then table.insert(ids, id) end
	end
	for key, name in data.added do
		local id = tonumber(key)
		if id and not table.find(ids, id) then
			table.insert(ids, id)
			if name ~= "" then names[id] = name end
		end
	end
	table.clear(AdminConfig.AdminIds)
	for _, id in ids do table.insert(AdminConfig.AdminIds, id) end
	for _, player in Players:GetPlayers() do
		local now = isAdminId(player.UserId)
		local before = player:GetAttribute("IsAdmin")
		player:SetAttribute("IsAdmin", now)
		if before ~= nil and before ~= now then
			notifyRemote:FireClient(player, now and "You are now an ADMIN! Press F2 or the ADMIN button." or "Your admin access has been removed.")
		end
	end
	for _, player in Players:GetPlayers() do
		if isAdminId(player.UserId) then task.spawn(sendList, player) end
	end
end

local function load()
	if not store then return end
	local ok, raw = pcall(function() return store:GetAsync("List") end)
	if ok then data = clean(raw) end
end

local function save(change)
	change(data) -- tout de suite sur ce serveur (et en Studio, où le DataStore ne marche pas)
	apply()
	if not store then return end
	task.spawn(function()
		local ok = pcall(function()
			store:UpdateAsync("List", function(old)
				local fresh = clean(old)
				change(fresh)
				return fresh
			end)
		end)
		if ok then
			load()
			apply()
			pcall(function() MessagingService:PublishAsync(TOPIC, {jobId = game.JobId}) end)
		end
	end)
end

load()
apply()

pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		if type(message.Data) == "table" and message.Data.jobId == game.JobId then return end
		load()
		apply()
	end)
end)

Players.PlayerAdded:Connect(function(player)
	player:SetAttribute("IsAdmin", isAdminId(player.UserId))
end)
for _, player in Players:GetPlayers() do
	if player:GetAttribute("IsAdmin") == nil then player:SetAttribute("IsAdmin", isAdminId(player.UserId)) end
end

listRemote.OnServerEvent:Connect(function(player)
	if isAdminId(player.UserId) then sendList(player) end
end)

local function notify(player, text) notifyRemote:FireClient(player, text) end

setAccess.OnServerEvent:Connect(function(player, name, grant)
	if not isAdminId(player.UserId) then return end
	if type(name) ~= "string" or name == "" then return end
	name = string.gsub(name, "^@", "")
	local online
	for _, p in Players:GetPlayers() do
		if string.lower(p.Name) == string.lower(name) then online = p end
	end
	local userId, realName
	if online then
		userId, realName = online.UserId, online.Name
	else
		local ok, id = pcall(function() return Players:GetUserIdFromNameAsync(name) end)
		if not ok or not id then notify(player, "Player @" .. name .. " not found") return end
		userId, realName = id, nameOf(id)
	end
	local key = tostring(userId)
	if grant then
		if isAdminId(userId) then notify(player, "@" .. realName .. " is already an admin") return end
		save(function(d) d.added[key] = realName d.removed[key] = nil end)
		notify(player, "@" .. realName .. " is now an admin")
	else
		if userId == OWNER_ID then notify(player, "You cannot remove the owner's admin") return end
		if not isAdminId(userId) then notify(player, "@" .. realName .. " is not an admin") return end
		save(function(d)
			d.added[key] = nil
			if table.find(BASE, userId) then d.removed[key] = true end
		end)
		notify(player, "@" .. realName .. " is no longer an admin")
	end
end)
