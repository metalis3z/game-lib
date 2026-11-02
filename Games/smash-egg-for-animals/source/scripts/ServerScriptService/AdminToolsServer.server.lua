-- Outils admin (onglet "Tools" du panneau) : reset des données, kick, ban.
--   ResetData(pseudo)      : ce joueur perd tout (argent, animaux, œufs, améliorations, dragons, plantes...), où qu'il soit
--   ResetDataGlobal()      : TOUS les joueurs perdent tout, sur tous les serveurs, même ceux qui ne sont pas connectés (au prochain chargement)
--   KickPlayer(pseudo) / KickAll(scope) / BanPlayer(pseudo) / UnbanPlayer(pseudo)
-- Après un reset, les joueurs concernés sont téléportés à leur base.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local DataStoreService = game:GetService("DataStoreService")
local MessagingService = require(game:GetService("ServerScriptService"):WaitForChild("GlobalBus")) -- (un seul abonnement pour tout le jeu : voir GlobalBus)

local AdminConfig = require(ReplicatedStorage:WaitForChild("AdminConfig"))
local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")
local bindables = ServerStorage:WaitForChild("GameBindables")
local wipeEvent = bindables:WaitForChild("WipePlayer")

local PLAYER_STORES = {"PlayerData_v3", "PlantData_v3"} -- sauvegardes par joueur (clé "u_<UserId>")
local TOPIC_RESET_ALL, TOPIC_RESET_USER, TOPIC_KICK_ALL = "AdminResetAll", "AdminResetUser", "AdminKickAll"

local function isAdminId(userId) return table.find(AdminConfig.AdminIds, userId) ~= nil end
local function notify(player, text) notifyRemote:FireClient(player, text) end

local resetStore
pcall(function() resetStore = DataStoreService:GetDataStore("GlobalReset_v1") end)
task.spawn(function()
	if resetStore then
		local ok, value = pcall(function() return resetStore:GetAsync("Epoch") end)
		if ok and type(value) == "number" then bindables:SetAttribute("ResetEpoch", value) end
	end
	bindables:SetAttribute("ResetEpochReady", true)
end)

local function toBase(player)
	local bases = workspace:FindFirstChild("all base")
	local base = bases and bases:FindFirstChild("base " .. tostring(player:GetAttribute("BaseNumber")))
	local spot = base and (base:FindFirstChild("Spawn") or base:FindFirstChild("animaux"))
	if not spot then return end
	local position = (spot:IsA("Model") and spot:GetPivot().Position or spot.Position) + Vector3.new(0, 6, 0)
	local dragons = workspace:FindFirstChild("Dragons")
	for _, dragon in dragons and dragons:GetChildren() or {} do
		if dragon:GetAttribute("Rider") == player.UserId and dragon.PrimaryPart then
			dragon:PivotTo(CFrame.new(position))
			dragon.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
			return
		end
	end
	local character = player.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		character:PivotTo(CFrame.new(position))
	end
end

local function resetPlayer(player)
	wipeEvent:Fire(player)
	notify(player, "Your data has been reset by an admin.")
	task.delay(1, toBase, player)
end

local function resetEveryoneHere(epoch)
	if type(epoch) == "number" and epoch > (bindables:GetAttribute("ResetEpoch") or 0) then bindables:SetAttribute("ResetEpoch", epoch) end
	for _, player in Players:GetPlayers() do resetPlayer(player) end
end

local function findPlayer(name)
	name = string.lower(string.gsub(tostring(name), "^@", ""))
	for _, player in Players:GetPlayers() do
		if string.lower(player.Name) == name then return player end
	end
end
local function userIdOf(name)
	local online = findPlayer(name)
	if online then return online.UserId, online.Name end
	local clean = string.gsub(tostring(name), "^@", "")
	local ok, id = pcall(function() return Players:GetUserIdFromNameAsync(clean) end)
	return ok and id or nil, clean
end

pcall(function()
	MessagingService:SubscribeAsync(TOPIC_RESET_ALL, function(message)
		resetEveryoneHere(type(message.Data) == "table" and message.Data.epoch or nil)
	end)
	MessagingService:SubscribeAsync(TOPIC_RESET_USER, function(message)
		local userId = type(message.Data) == "table" and message.Data.userId
		local player = userId and Players:GetPlayerByUserId(userId)
		if player then resetPlayer(player) end
	end)
	MessagingService:SubscribeAsync(TOPIC_KICK_ALL, function(message)
		local reason = type(message.Data) == "table" and message.Data.reason or "Kicked by an admin."
		for _, player in Players:GetPlayers() do
			if not isAdminId(player.UserId) then player:Kick(reason) end
		end
	end)
end)

local function guard(player) return table.find(AdminConfig.AdminIds, player.UserId) ~= nil end
local function reasonOf(text, default)
	if type(text) ~= "string" or text == "" then return default end
	return string.sub(text, 1, 120)
end

remotes:WaitForChild("ResetData").OnServerEvent:Connect(function(player, targetName)
	if not guard(player) or type(targetName) ~= "string" or targetName == "" then return end
	local target = findPlayer(targetName)
	if target then
		resetPlayer(target)
		notify(player, "Data reset: " .. target.Name)
		return
	end
	local userId, clean = userIdOf(targetName)
	if not userId then notify(player, "Player not found: " .. clean) return end
	-- pas dans ce serveur : on efface ses sauvegardes, et son serveur (s'il joue ailleurs) le remet à zéro
	for _, name in PLAYER_STORES do
		pcall(function() DataStoreService:GetDataStore(name):RemoveAsync("u_" .. userId) end)
	end
	pcall(function() MessagingService:PublishAsync(TOPIC_RESET_USER, {userId = userId}) end)
	notify(player, "Data reset: " .. clean .. " (not in this server)")
end)

local lastGlobalReset = 0
remotes:WaitForChild("ResetDataGlobal").OnServerEvent:Connect(function(player)
	if not guard(player) then return end
	if os.clock() - lastGlobalReset < 10 then return end
	lastGlobalReset = os.clock()
	local epoch = os.time()
	if resetStore then pcall(function() resetStore:SetAsync("Epoch", epoch) end) end
	local sent = pcall(function() MessagingService:PublishAsync(TOPIC_RESET_ALL, {epoch = epoch}) end)
	if not sent then resetEveryoneHere(epoch) end
	notify(player, sent and "GLOBAL data reset sent to ALL servers" or "Data reset on this server (MessagingService unavailable)")
end)

---------------------------------------------------------------- KICK
local function kickMessage(reason)
	return "You have been kicked from the game by an admin.\nReason: " .. reason
end

remotes:WaitForChild("KickPlayer").OnServerEvent:Connect(function(player, targetName, reason)
	if not guard(player) then return end
	reason = reasonOf(reason, "No reason given")
	local target = findPlayer(targetName)
	if target then
		if isAdminId(target.UserId) then notify(player, "You cannot kick an admin") return end
		notify(player, "Kicked: " .. target.Name)
		target:Kick(kickMessage(reason))
		return
	end
	-- pas dans ce serveur : le serveur où il joue l'expulse
	local userId, clean = userIdOf(targetName)
	if not userId then notify(player, "Player not found: " .. clean) return end
	if isAdminId(userId) then notify(player, "You cannot kick an admin") return end
	local sent = pcall(function() MessagingService:PublishAsync("AdminKickUser", {userId = userId, reason = reason}) end)
	notify(player, sent and ("Kick sent to every server: " .. clean) or "Kick failed: MessagingService unavailable")
end)
pcall(function()
	MessagingService:SubscribeAsync("AdminKickUser", function(message)
		local data = message.Data
		local target = type(data) == "table" and Players:GetPlayerByUserId(data.userId)
		if target and not isAdminId(target.UserId) then target:Kick(kickMessage(tostring(data.reason))) end
	end)
end)

pcall(function()
	MessagingService:SubscribeAsync("AdminKickAll2", function(message)
		local reason = type(message.Data) == "table" and message.Data.reason or "No reason given"
		for _, player in Players:GetPlayers() do
			if not isAdminId(player.UserId) then player:Kick(kickMessage(reason)) end
		end
	end)
end)
remotes:WaitForChild("KickAll").OnServerEvent:Connect(function(player, scope, reason)
	if not guard(player) then return end
	reason = reasonOf(reason, "No reason given")
	local sent = scope ~= "server" and pcall(function() MessagingService:PublishAsync("AdminKickAll2", {reason = reason}) end)
	if not sent then
		for _, other in Players:GetPlayers() do
			if not isAdminId(other.UserId) then other:Kick(kickMessage(reason)) end
		end
	end
	notify(player, sent and "Everyone kicked on ALL servers (admins stay)" or "Everyone kicked on this server (admins stay)")
end)

---------------------------------------------------------------- BAN (liste sauvegardée : un joueur banni est expulsé dès qu'il rejoint n'importe quel serveur)
local banStore
pcall(function() banStore = DataStoreService:GetDataStore("Bans_v1") end)
local function banMessage(reason)
	return "You are banned from this game.\nReason: " .. tostring(reason)
end
local function checkBan(player)
	if not banStore or isAdminId(player.UserId) then return end
	local ok, entry = pcall(function() return banStore:GetAsync("u_" .. player.UserId) end)
	if ok and type(entry) == "table" then player:Kick(banMessage(entry.Reason or "No reason given")) end
end
Players.PlayerAdded:Connect(checkBan)
for _, player in Players:GetPlayers() do task.spawn(checkBan, player) end

pcall(function()
	MessagingService:SubscribeAsync("AdminBan", function(message)
		local data = message.Data
		local target = type(data) == "table" and Players:GetPlayerByUserId(data.userId)
		if target then target:Kick(banMessage(data.reason)) end
	end)
end)

remotes:WaitForChild("BanPlayer").OnServerEvent:Connect(function(player, targetName, reason)
	if not guard(player) then return end
	local userId, clean = userIdOf(targetName)
	if not userId then notify(player, "Player not found: " .. clean) return end
	if isAdminId(userId) then notify(player, "You cannot ban an admin") return end
	if not banStore then notify(player, "Ban failed: DataStore unavailable (enable API access in Game Settings)") return end
	reason = reasonOf(reason, "No reason given")
	local ok, err = pcall(function() banStore:SetAsync("u_" .. userId, {Reason = reason, By = player.Name, At = os.time(), Name = clean}) end)
	if not ok then notify(player, "Ban failed: " .. tostring(err)) return end
	local here = Players:GetPlayerByUserId(userId)
	if here then here:Kick(banMessage(reason)) end
	pcall(function() MessagingService:PublishAsync("AdminBan", {userId = userId, reason = reason}) end)
	notify(player, "Banned: " .. clean)
end)

remotes:WaitForChild("UnbanPlayer").OnServerEvent:Connect(function(player, targetName)
	if not guard(player) then return end
	local userId, clean = userIdOf(targetName)
	if not userId then notify(player, "Player not found: " .. clean) return end
	if not banStore then notify(player, "Unban failed: DataStore unavailable") return end
	local ok, err = pcall(function() banStore:RemoveAsync("u_" .. userId) end)
	notify(player, ok and ("Unbanned: " .. clean) or ("Unban failed: " .. tostring(err)))
end)
