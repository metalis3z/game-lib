-- PrivateServerServer : le SERVEUR PRIVÉ de chaque admin (onglet "Private Server" du panneau admin).
--   * JOIN : l'admin est téléporté dans SON serveur réservé (créé la première fois, toujours le même ensuite).
--   * ALLOW @pseudo : ajoute un joueur à sa liste d'autorisés (même hors ligne). REMOVE : le retire (et l'expulse
--     s'il est dedans).
--   * TP : envoie un joueur AUTORISÉ dans le serveur privé, qu'il soit dans ce serveur ou dans un autre (MessagingService).
--   * Dans le serveur privé : quiconque n'est ni le propriétaire ni dans la liste est expulsé dès qu'il arrive.
-- Données : DataStore "PrivateServers_v1" ("owner_<id>" = {Code, ServerId, Allowed}, "server_<PrivateServerId>" = id du proprio).
-- Tout est vérifié ici : le client ne fait que demander (attribut IsAdmin donné par le serveur, AdminAccessServer).
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local TeleportService = game:GetService("TeleportService")
local MessagingService = game:GetService("MessagingService")
local ServerScriptService = game:GetService("ServerScriptService")

local TOPIC_BRING, TOPIC_UPDATE = "PrivateServerBring", "PrivateServerUpdate"
local KICK_MESSAGE = "This is a private server: you need the owner's permission to join."

local remotes = ReplicatedStorage:WaitForChild("AdminSystem"):WaitForChild("Remotes")
local request = remotes:FindFirstChild("PrivateServer") or Instance.new("RemoteFunction")
request.Name = "PrivateServer"
request.Parent = remotes
local notifyRemote = ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("Remotes"):WaitForChild("Notify")

local okStore, store = pcall(function() return DataStoreService:GetDataStore("PrivateServers_v1") end)
if not okStore then store = nil end
-- Studio sans accès aux données : une mémoire temporaire, pour pouvoir essayer l'onglet (les téléportations, elles,
-- ne marchent jamais dans Studio)
if store and game:GetService("RunService"):IsStudio() then
	local okProbe, probeErr = pcall(function() return store:GetAsync("probe") end)
	if not okProbe and string.find(tostring(probeErr), "Studio", 1, true) then
		local memory = {}
		store = {
			GetAsync = function(_, key) return memory[key] end,
			SetAsync = function(_, key, value) memory[key] = value end,
			UpdateAsync = function(_, key, fn) memory[key] = fn(memory[key]) return memory[key] end,
		}
	end
end

local function isAdmin(player) return player:GetAttribute("IsAdmin") == true end
local function notify(player, text) if player.Parent then notifyRemote:FireClient(player, text) end end

local function readOwner(ownerId)
	if not store then return nil, "Data not available (Studio without API access?)" end
	local ok, value = pcall(function() return store:GetAsync("owner_" .. ownerId) end)
	if not ok then return nil, tostring(value) end
	return value or {Allowed = {}}
end
local function writeOwner(ownerId, change)
	if not store then return nil, "Data not available (Studio without API access?)" end
	local result
	local ok, err = pcall(function()
		store:UpdateAsync("owner_" .. ownerId, function(old)
			old = old or {Allowed = {}}
			old.Allowed = old.Allowed or {}
			change(old)
			result = old
			return old
		end)
	end)
	if not ok then return nil, tostring(err) end
	return result
end

-- serveur réservé de l'admin (créé une seule fois)
local function ensureServer(ownerId)
	local data, err = readOwner(ownerId)
	if not data then return nil, err end
	if data.Code then return data end
	local ok, code, serverId = pcall(function() return TeleportService:ReserveServer(game.PlaceId) end)
	if not ok then return nil, "Could not create the private server (" .. tostring(code) .. ")" end
	data, err = writeOwner(ownerId, function(d) if not d.Code then d.Code, d.ServerId = code, serverId end end)
	if not data then return nil, err end
	pcall(function() store:SetAsync("server_" .. data.ServerId, ownerId) end)
	return data
end

-- sauvegarde des animaux avant de partir (le serveur d'arrivée attend aussi la fin de la sauvegarde : PetServer)
local tradeSave = ServerScriptService:FindFirstChild("PetServer") and ServerScriptService.PetServer:FindFirstChild("TradeSave")
local function sendTo(players, code)
	for _, p in players do if tradeSave then pcall(function() tradeSave:Invoke(p) end) end end
	local options = Instance.new("TeleportOptions")
	options.ReservedServerAccessCode = code
	local ok, err = pcall(function() TeleportService:TeleportAsync(game.PlaceId, players, options) end)
	return ok, err
end

---------------------------------------------------------------- dans un serveur privé : la porte d'entrée
local myOwnerId, allowed = nil, {}
local isPrivate = game.PrivateServerId ~= "" and game.PrivateServerOwnerId == 0
local function allowedHere(player)
	return player.UserId == myOwnerId or allowed[tostring(player.UserId)] ~= nil
end
local function refreshAllowed()
	local data = myOwnerId and readOwner(myOwnerId)
	if data then allowed = data.Allowed or {} end
	for _, p in Players:GetPlayers() do
		if not allowedHere(p) then p:Kick(KICK_MESSAGE) end
	end
end
if isPrivate and store then
	local ok, owner = pcall(function() return store:GetAsync("server_" .. game.PrivateServerId) end)
	if ok and owner then
		myOwnerId = owner
		workspace:SetAttribute("PrivateServerOwner", owner) -- (le panneau admin affiche "tu es dans ton serveur privé")
		local data = readOwner(owner)
		allowed = data and data.Allowed or {}
		Players.PlayerAdded:Connect(function(player)
			if allowedHere(player) then return end
			refreshAllowed() -- (ajouté il y a quelques secondes ? on relit la liste avant d'expulser)
			if player.Parent and not allowedHere(player) then player:Kick(KICK_MESSAGE) end
		end)
		for _, p in Players:GetPlayers() do if not allowedHere(p) then p:Kick(KICK_MESSAGE) end end
		pcall(function()
			MessagingService:SubscribeAsync(TOPIC_UPDATE, function(message)
				if type(message.Data) == "table" and message.Data.Owner == myOwnerId then refreshAllowed() end
			end)
		end)
	end
end

---------------------------------------------------------------- TP demandé depuis un autre serveur
pcall(function()
	MessagingService:SubscribeAsync(TOPIC_BRING, function(message)
		local d = message.Data
		if type(d) ~= "table" or type(d.UserId) ~= "number" or type(d.Code) ~= "string" then return end
		local target = Players:GetPlayerByUserId(d.UserId)
		if not target or (myOwnerId and myOwnerId == d.Owner) then return end -- (déjà dans le bon serveur)
		notify(target, "You are invited to " .. tostring(d.OwnerName) .. "'s private server: teleporting...")
		sendTo({target}, d.Code)
	end)
end)

---------------------------------------------------------------- demandes du panneau admin
local function stateFor(player)
	local data, err = readOwner(player.UserId)
	local list = {}
	for id, name in data and data.Allowed or {} do
		table.insert(list, {Id = tonumber(id), Name = name, Online = Players:GetPlayerByUserId(tonumber(id)) ~= nil})
	end
	table.sort(list, function(a, b) return string.lower(a.Name) < string.lower(b.Name) end)
	return {Ok = data ~= nil, Message = err, HasServer = data and data.Code ~= nil, Allowed = list, InMine = myOwnerId == player.UserId,
		InPrivate = myOwnerId ~= nil, OwnerHere = myOwnerId}
end

local busy = {}
request.OnServerInvoke = function(player, action, arg)
	if not isAdmin(player) then return {Ok = false, Message = "Admins only."} end
	if busy[player] then return {Ok = false, Message = "Wait a moment..."} end
	busy[player] = true
	local ok, result = pcall(function()
		if action == "GetState" then
			return stateFor(player)

		elseif action == "Join" then
			if myOwnerId == player.UserId then return {Ok = false, Message = "You are already in your private server!"} end
			local data, err = ensureServer(player.UserId)
			if not data then return {Ok = false, Message = err} end
			local sent, terr = sendTo({player}, data.Code)
			return {Ok = sent, Message = sent and "Teleporting to your private server..." or ("Teleport failed: " .. tostring(terr))}

		elseif action == "Allow" then
			local name = type(arg) == "string" and string.gsub(arg, "^%s*@", ""):gsub("%s+$", "") or ""
			if name == "" then return {Ok = false, Message = "Type the player's @username."} end
			local okId, userId = pcall(function() return Players:GetUserIdFromNameAsync(name) end)
			if not okId or not userId then return {Ok = false, Message = "@" .. name .. " doesn't exist."} end
			local okName, realName = pcall(function() return Players:GetNameFromUserIdAsync(userId) end)
			realName = okName and realName or name
			if userId == player.UserId then return {Ok = false, Message = "That's you: you can always join."} end
			local data, err = writeOwner(player.UserId, function(d) d.Allowed[tostring(userId)] = realName end)
			if not data then return {Ok = false, Message = err} end
			pcall(function() MessagingService:PublishAsync(TOPIC_UPDATE, {Owner = player.UserId}) end)
			if myOwnerId == player.UserId then allowed = data.Allowed end
			local state = stateFor(player)
			state.Message = "@" .. realName .. " can now join your private server."
			return state

		elseif action == "Remove" then
			local userId = tonumber(arg)
			if not userId then return {Ok = false, Message = "Invalid player."} end
			local data, err = writeOwner(player.UserId, function(d) d.Allowed[tostring(userId)] = nil end)
			if not data then return {Ok = false, Message = err} end
			pcall(function() MessagingService:PublishAsync(TOPIC_UPDATE, {Owner = player.UserId}) end)
			if myOwnerId == player.UserId then
				allowed = data.Allowed
				local inside = Players:GetPlayerByUserId(userId)
				if inside then inside:Kick(KICK_MESSAGE) end
			end
			local state = stateFor(player)
			state.Message = "Removed from your private server."
			return state

		elseif action == "Bring" then
			local userId = tonumber(arg)
			local data, err = readOwner(player.UserId)
			if not data then return {Ok = false, Message = err} end
			local name = userId and data.Allowed[tostring(userId)]
			if not name then return {Ok = false, Message = "Add this player to your list first."} end
			data, err = ensureServer(player.UserId)
			if not data then return {Ok = false, Message = err} end
			if myOwnerId == player.UserId and Players:GetPlayerByUserId(userId) then return {Ok = false, Message = "@" .. name .. " is already here."} end
			local here = Players:GetPlayerByUserId(userId)
			if here then
				notify(here, "You are invited to " .. player.DisplayName .. "'s private server: teleporting...")
				local sent, terr = sendTo({here}, data.Code)
				return {Ok = sent, Message = sent and ("Teleporting @" .. name .. "...") or ("Teleport failed: " .. tostring(terr))}
			end
			local published = pcall(function()
				MessagingService:PublishAsync(TOPIC_BRING, {UserId = userId, Code = data.Code, Owner = player.UserId, OwnerName = player.DisplayName})
			end)
			return {Ok = published, Message = published and ("Teleport sent to @" .. name .. " (if they are in a server of the game).") or "Could not reach the other servers."}
		end
		return {Ok = false, Message = "Unknown action."}
	end)
	busy[player] = nil
	if not ok then
		warn("[PrivateServer] " .. tostring(action) .. " : " .. tostring(result))
		return {Ok = false, Message = "Error: " .. tostring(result)}
	end
	return result
end
Players.PlayerRemoving:Connect(function(p) busy[p] = nil end)
