-- Game: trade-system
-- Original: UNGROUP ME - Trade System/UNGROUP ME ON SSS-BOOSTRAP-SERVER/TradeService.lua  (590 lines)
-- What it does: Server trade service that works ACROSS servers: trade sessions live in a MemoryStore sorted map, players find each other through a presence map, and MessagingService pushes updates. Each server only edits its own local player's data. Comments are in Spanish.

-- TradeService
-- Sistema de trades ENTRE SERVIDORES (nadie se teletransporta). El estado del trade vive
-- en un MemoryStore compartido; cada servidor sincroniza vía MessagingService y aplica el
-- resultado SOLO a su propio jugador local (nunca toca los datos de un jugador ajeno).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MemoryStoreService = game:GetService("MemoryStoreService")
local MessagingService = game:GetService("MessagingService")
local HttpService = game:GetService("HttpService")

local FeatureConfigs = ReplicatedStorage:WaitForChild("FeatureConfigs")
local ItemsCatalog = require(FeatureConfigs:WaitForChild("Items"))

local TradeService = {}
local DataService, Remotes

-- OJO: Remotes.get(name) tira error si el nombre no está pre-registrado en la lista central
-- (ReEventsNames de Boostrap.Server.Remotes). Los remotes de Trade se crean directo acá
-- adentro (ensureEvent/ensureFunction), así que los buscamos directo en la carpeta,
-- no a través de Remotes.get().
local remotesFolderCache
local function getRemote(name)
	remotesFolderCache = remotesFolderCache or ReplicatedStorage:WaitForChild("Remotes")
	local r = remotesFolderCache:FindFirstChild(name)
	if not r then
		warn("[TradeService] No se encontró el remote '" .. name .. "' todavía")
	end
	return r
end

-- ===== Presencia entre servidores (para poder buscar gente sin importar el server) =====
local PRESENCE_EXPIRATION = 45
local presenceMap = MemoryStoreService:GetSortedMap("TradePresenceV1")

local function updatePresence(player)
	pcall(function()
		presenceMap:SetAsync(tostring(player.UserId), {
			userId = player.UserId,
			name = player.Name,
			displayName = player.DisplayName,
			jobId = game.JobId,
		}, PRESENCE_EXPIRATION, 0)
	end)
end

local function removePresence(player)
	pcall(function()
		presenceMap:RemoveAsync(tostring(player.UserId))
	end)
end

-- ===== Sesiones de trade (compartidas entre servidores) =====
local tradeSessionsMap = MemoryStoreService:GetSortedMap("TradeSessionsV1")
local SESSION_EXPIRATION = 600 -- 10 minutos de vida máxima por trade

local pendingRequests = {} -- [targetUserId] = {fromUserId, fromName} (mismo server o de otro)
local myActiveTradeId = {} -- [player.UserId] = tradeId (solo trackea MI jugador local)
local appliedLocally = {} -- [tradeId] = true (para no aplicar el resultado dos veces)
local subscribedTopics = {} -- [tradeId] = true
local localSessionCache = {} -- [tradeId] = session (respaldo cuando MemoryStore no está disponible, ej. Studio)

local function itemDef(itemKey)
	return ItemsCatalog.ITEMS[itemKey]
end

local function availableCount(player, offeredKeys, itemKey)
	local data = DataService.get(player)
	if not data or not data.Items then return 0 end
	local owned = 0
	for _, k in ipairs(data.Items) do
		if k == itemKey then owned += 1 end
	end
	local offered = 0
	for _, k in ipairs(offeredKeys or {}) do
		if k == itemKey then offered += 1 end
	end
	return owned - offered
end

local function mySlot(session, userId)
	if session.a.userId == userId then return "a" end
	if session.b.userId == userId then return "b" end
	return nil
end

local function otherSlot(slot)
	return slot == "a" and "b" or "a"
end

-- Le manda el estado actual a MI jugador local, si está en este servidor
local function pushToOneSlot(session, slot, player)
	local other = slot == "a" and session.b or session.a
	getRemote("TradeUpdate"):FireClient(player, {
		tradeId = session.id,
		myOffer = session["offer" .. slot:upper()],
		theirOffer = session["offer" .. otherSlot(slot):upper()],
		myReady = session["ready" .. slot:upper()],
		theirReady = session["ready" .. otherSlot(slot):upper()],
		otherPlayerName = other.name,
		status = session.status,
	})

	if session.status == "completed" and not appliedLocally[session.id .. "_" .. player.UserId] then
		appliedLocally[session.id .. "_" .. player.UserId] = true
		local data = DataService.get(player)
		if data then
			data.Items = data.Items or {}
			for _, key in ipairs(session["offer" .. slot:upper()]) do
				for i, k in ipairs(data.Items) do
					if k == key then table.remove(data.Items, i) break end
				end
			end
			for _, key in ipairs(session["offer" .. otherSlot(slot):upper()]) do
				table.insert(data.Items, key)
			end
			if DataService.save then DataService.save(player) end
		end
		getRemote("TradeCompleted"):FireClient(player)
		myActiveTradeId[player.UserId] = nil
	elseif session.status == "cancelled" then
		getRemote("TradeCancelled"):FireClient(player, session.cancelReason or "Trade cancelado")
		myActiveTradeId[player.UserId] = nil
	end
end

-- Le avisa a CUALQUIERA de los dos jugadores que esté en ESTE servidor (pueden estar los dos)
local function pushToLocalPlayer(session)
	local pA = Players:GetPlayerByUserId(session.a.userId)
	local pB = Players:GetPlayerByUserId(session.b.userId)
	if pA then pushToOneSlot(session, "a", pA) end
	if pB then pushToOneSlot(session, "b", pB) end
end

local function subscribeToTrade(tradeId)
	if subscribedTopics[tradeId] then return end
	subscribedTopics[tradeId] = true
	pcall(function()
		MessagingService:SubscribeAsync("TradeSync_" .. tradeId, function(message)
			localSessionCache[tradeId] = message.Data
			pushToLocalPlayer(message.Data)
		end)
	end)
end

local function broadcastSession(session)
	pcall(function()
		MessagingService:PublishAsync("TradeSync_" .. session.id, session)
	end)
	-- también reflejar localmente al toque (por si el jugador está en este mismo server)
	pushToLocalPlayer(session)
end

local function saveSession(session)
	localSessionCache[session.id] = session
	pcall(function()
		tradeSessionsMap:SetAsync(session.id, session, SESSION_EXPIRATION, 0)
	end)
end

local function updateSession(tradeId, mutateFn)
	local newSession
	local usedMemoryStore = false

	local ok = pcall(function()
		newSession = tradeSessionsMap:UpdateAsync(tradeId, function(session)
			if not session then return nil end
			local ok2 = mutateFn(session)
			if ok2 == false then return nil end -- aborta si mutateFn devuelve false
			return session
		end, SESSION_EXPIRATION)
	end)

	if ok and newSession then
		usedMemoryStore = true
	end

	-- Si MemoryStore no funcionó (ej. Studio) o no encontró la sesión ahí, usar la
	-- copia local como respaldo para que el trade igual funcione entre 2 del mismo server.
	if not usedMemoryStore then
		local cached = localSessionCache[tradeId]
		if cached then
			local result = mutateFn(cached)
			if result ~= false then
				newSession = cached
			end
		end
	end

	if newSession then
		localSessionCache[tradeId] = newSession
		broadcastSession(newSession)
	end

	return (usedMemoryStore or newSession ~= nil), newSession
end

-- ===== API =====

function TradeService.sendRequest(fromPlayer, toUserIdOrName)
	if myActiveTradeId[fromPlayer.UserId] then
		local stuckId = myActiveTradeId[fromPlayer.UserId]
		local cached = localSessionCache[stuckId]
		if cached and (cached.status == "completed" or cached.status == "cancelled") then
			-- ya terminó, solo que no se limpió; lo soltamos en vez de bloquear
			myActiveTradeId[fromPlayer.UserId] = nil
		else
			getRemote("TradeRequestResult"):FireClient(fromPlayer, false, "Ya estás en un trade activo. Cancelalo primero si querés mandar otro.")
			return
		end
	end

	local targetUserId, targetName

	local localTarget = Players:FindFirstChild(tostring(toUserIdOrName))
	if localTarget then
		targetUserId, targetName = localTarget.UserId, localTarget.Name
	else
		local numericId = tonumber(toUserIdOrName)
		local ok, entries = pcall(function() return presenceMap:GetRangeAsync(Enum.SortDirection.Ascending, 200) end)
		if ok then
			for _, e in ipairs(entries) do
				local v = e.value
				if v and (v.userId == numericId or tostring(v.name):lower() == tostring(toUserIdOrName):lower()) then
					targetUserId, targetName = v.userId, v.name
					break
				end
			end
		end
	end

	if not targetUserId then
		getRemote("TradeRequestResult"):FireClient(fromPlayer, false, "Ese jugador no está conectado")
		return
	end
	if targetUserId == fromPlayer.UserId then
		getRemote("TradeRequestResult"):FireClient(fromPlayer, false, "No podés mandarte un trade a vos mismo")
		return
	end

	-- Si el destinatario está EN ESTE MISMO SERVIDOR, avisarle directo (no depende de
	-- MessagingService, que no funciona en Studio y puede fallar en producción también)
	local localTargetPlayer = Players:GetPlayerByUserId(targetUserId)
	if localTargetPlayer then
		if myActiveTradeId[localTargetPlayer.UserId] then
			getRemote("TradeRequestResult"):FireClient(fromPlayer, false, "Ese jugador ya está en otro trade")
			return
		end
		pendingRequests[localTargetPlayer.UserId] = { fromUserId = fromPlayer.UserId, fromName = fromPlayer.Name }
		getRemote("TradeRequestReceived"):FireClient(localTargetPlayer, fromPlayer.Name)
		getRemote("TradeRequestResult"):FireClient(fromPlayer, true, "Pedido de trade enviado a " .. targetName)
		return
	end

	-- Si no, mandarlo por MessagingService para que lo agarre el servidor donde esté
	local ok = pcall(function()
		MessagingService:PublishAsync("TradeCrossServerRequest", {
			targetUserId = targetUserId,
			fromUserId = fromPlayer.UserId,
			fromName = fromPlayer.Name,
		})
	end)

	if ok then
		getRemote("TradeRequestResult"):FireClient(fromPlayer, true, "Pedido de trade enviado a " .. targetName)
	else
		getRemote("TradeRequestResult"):FireClient(fromPlayer, false, "No se pudo enviar el pedido (¿estás en Studio? MessagingService no funciona ahí)")
	end
end

function TradeService.respondRequest(player, accept)
	local info = pendingRequests[player.UserId]
	pendingRequests[player.UserId] = nil
	if not info then
		getRemote("TradeRequestResult"):FireClient(player, false, "Ese pedido ya no es válido (expiró o ya fue respondido)")
		return
	end

	if not accept then
		pcall(function()
			MessagingService:PublishAsync("TradeCrossServerRequestResult", {
				toUserId = info.fromUserId,
				accepted = false,
				byName = player.Name,
			})
		end)
		return
	end

	-- Si quedó un trade "activo" pegado de antes (por ejemplo si el otro se desconectó
	-- a mitad de camino y no se limpió bien), lo soltamos en vez de bloquear todo en silencio.
	if myActiveTradeId[player.UserId] then
		warn("[TradeService] " .. player.Name .. " tenía un trade viejo pegado (" .. tostring(myActiveTradeId[player.UserId]) .. "), lo libero para poder aceptar este nuevo")
		myActiveTradeId[player.UserId] = nil
	end

	local tradeId = HttpService:GenerateGUID(false)
	local session = {
		id = tradeId,
		a = { userId = info.fromUserId, name = info.fromName },
		b = { userId = player.UserId, name = player.Name },
		offerA = {},
		offerB = {},
		readyA = false,
		readyB = false,
		status = "active",
	}

	saveSession(session) -- best-effort; si falla (Studio) el trade igual funciona si están en el mismo server
	subscribeToTrade(tradeId)
	myActiveTradeId[player.UserId] = tradeId

	getRemote("TradeStarted"):FireClient(player, info.fromName)

	-- Si el que mandó el pedido está EN ESTE MISMO SERVIDOR, arrancarle el trade directo
	local localRequester = Players:GetPlayerByUserId(info.fromUserId)
	if localRequester then
		myActiveTradeId[localRequester.UserId] = tradeId
		getRemote("TradeStarted"):FireClient(localRequester, player.Name)
	else
		-- si no, avisarle a su servidor por MessagingService
		pcall(function()
			MessagingService:PublishAsync("TradeCrossServerRequestResult", {
				toUserId = info.fromUserId,
				accepted = true,
				byName = player.Name,
				tradeId = tradeId,
			})
		end)
	end

	broadcastSession(session)
end

function TradeService.addItem(player, itemKey)
	local tradeId = myActiveTradeId[player.UserId]
	if not tradeId then return end
	if not itemDef(itemKey) then return end

	updateSession(tradeId, function(session)
		local slot = mySlot(session, player.UserId)
		if not slot then return false end
		if session["ready" .. slot:upper()] then return false end
		if availableCount(player, session["offer" .. slot:upper()], itemKey) <= 0 then return false end

		table.insert(session["offer" .. slot:upper()], itemKey)
		session.readyA = false
		session.readyB = false
	end)
end

function TradeService.removeItem(player, itemKey)
	local tradeId = myActiveTradeId[player.UserId]
	if not tradeId then return end

	updateSession(tradeId, function(session)
		local slot = mySlot(session, player.UserId)
		if not slot then return false end
		if session["ready" .. slot:upper()] then return false end

		local offer = session["offer" .. slot:upper()]
		for i, k in ipairs(offer) do
			if k == itemKey then table.remove(offer, i) break end
		end
		session.readyA = false
		session.readyB = false
	end)
end

function TradeService.setReady(player, ready)
	local tradeId = myActiveTradeId[player.UserId]
	if not tradeId then return end

	updateSession(tradeId, function(session)
		local slot = mySlot(session, player.UserId)
		if not slot then return false end
		session["ready" .. slot:upper()] = ready
		if session.readyA and session.readyB then
			session.status = "completed"
		end
	end)
end

function TradeService.cancelTrade(player)
	local tradeId = myActiveTradeId[player.UserId]
	if not tradeId then return end

	updateSession(tradeId, function(session)
		session.status = "cancelled"
		session.cancelReason = player.Name .. " canceló el trade"
	end)
end

-- ===== Búsqueda (cross-server) =====
function TradeService.searchPlayers(searcherPlayer, query)
	local rawQuery = tostring(query or "")
	query = rawQuery:lower()
	local entries = {}
	pcall(function()
		entries = presenceMap:GetRangeAsync(Enum.SortDirection.Ascending, 200)
	end)

	local results = {}
	local foundUserIds = {}

	for _, entry in ipairs(entries) do
		local data = entry.value
		if data and data.userId ~= searcherPlayer.UserId then
			if query == "" or tostring(data.name):lower():find(query, 1, true) or tostring(data.displayName):lower():find(query, 1, true) then
				table.insert(results, {
					name = data.name,
					displayName = data.displayName,
					userId = data.userId,
					online = true,
					sameServer = (data.jobId == game.JobId),
				})
				foundUserIds[data.userId] = true
			end
		end
	end

	-- Si escribió un nombre exacto y no lo encontramos entre los conectados, fijarse si es
	-- un usuario real de Roblox (aunque esté desconectado) para mostrarlo igual, marcado como offline.
	local trimmedQuery = rawQuery:gsub("^%s+", ""):gsub("%s+$", "")
	if trimmedQuery ~= "" then
		local alreadyMatchedExact = false
		for _, r in ipairs(results) do
			if r.name:lower() == trimmedQuery:lower() then
				alreadyMatchedExact = true
				break
			end
		end

		if not alreadyMatchedExact then
			local ok, userId = pcall(function()
				return Players:GetUserIdFromNameAsync(trimmedQuery)
			end)
			if ok and userId and userId ~= searcherPlayer.UserId and not foundUserIds[userId] then
				local okName, actualName = pcall(function()
					return Players:GetNameFromUserIdAsync(userId)
				end)
				table.insert(results, {
					name = okName and actualName or trimmedQuery,
					displayName = okName and actualName or trimmedQuery,
					userId = userId,
					online = false,
					sameServer = false,
				})
			end
		end
	end

	return results
end

-- ===== Inventario =====
function TradeService.getInventory(player)
	local data = DataService.get(player)
	if not data or not data.Items then return {} end

	local counts = {}
	for _, key in ipairs(data.Items) do
		counts[key] = (counts[key] or 0) + 1
	end

	local result = {}
	for key, count in pairs(counts) do
		local def = itemDef(key)
		if def then
			table.insert(result, { key = key, name = def.name, icon = def.icon, rarity = def.rarity, count = count })
		end
	end
	return result
end

-- ===== Init =====
function TradeService.init(deps)
	DataService = deps.DataService
	Remotes = deps.Remotes

	local remotesFolder = ReplicatedStorage:WaitForChild("Remotes")

	local function ensureEvent(name)
		local ev = remotesFolder:FindFirstChild(name)
		if not ev then
			ev = Instance.new("RemoteEvent")
			ev.Name = name
			ev.Parent = remotesFolder
		end
		return ev
	end

	local function ensureFunction(name)
		local fn = remotesFolder:FindFirstChild(name)
		if not fn then
			fn = Instance.new("RemoteFunction")
			fn.Name = name
			fn.Parent = remotesFolder
		end
		return fn
	end

	for _, name in ipairs({ "TradeRequestResult", "TradeRequestReceived", "TradeStarted", "TradeUpdate", "TradeCancelled", "TradeCompleted" }) do
		ensureEvent(name)
	end

	ensureEvent("TradeSendRequest").OnServerEvent:Connect(function(player, targetName)
		TradeService.sendRequest(player, targetName)
	end)
	ensureEvent("TradeRespondRequest").OnServerEvent:Connect(function(player, accept)
		TradeService.respondRequest(player, accept)
	end)
	ensureEvent("TradeAddItem").OnServerEvent:Connect(function(player, itemKey)
		TradeService.addItem(player, itemKey)
	end)
	ensureEvent("TradeRemoveItem").OnServerEvent:Connect(function(player, itemKey)
		TradeService.removeItem(player, itemKey)
	end)
	ensureEvent("TradeSetReady").OnServerEvent:Connect(function(player, ready)
		TradeService.setReady(player, ready)
	end)
	ensureEvent("TradeCancel").OnServerEvent:Connect(function(player)
		TradeService.cancelTrade(player)
	end)

	ensureFunction("TradeSearchPlayers").OnServerInvoke = function(player, query)
		return TradeService.searchPlayers(player, query)
	end
	ensureFunction("TradeGetInventory").OnServerInvoke = function(player)
		return TradeService.getInventory(player)
	end

	-- Pedidos de trade que llegan de OTRO servidor
	pcall(function()
		MessagingService:SubscribeAsync("TradeCrossServerRequest", function(message)
			local data = message.Data
			local target = Players:GetPlayerByUserId(data.targetUserId)
			if not target then return end
			if myActiveTradeId[target.UserId] then
				pcall(function()
					MessagingService:PublishAsync("TradeCrossServerRequestResult", {
						toUserId = data.fromUserId, accepted = false, byName = target.Name .. " (ya está en otro trade)",
					})
				end)
				return
			end
			pendingRequests[target.UserId] = { fromUserId = data.fromUserId, fromName = data.fromName }
			getRemote("TradeRequestReceived"):FireClient(target, data.fromName)
		end)
	end)

	-- Resultado del pedido (aceptado/rechazado) volviendo de otro servidor
	pcall(function()
		MessagingService:SubscribeAsync("TradeCrossServerRequestResult", function(message)
			local data = message.Data
			local me = Players:GetPlayerByUserId(data.toUserId)
			if not me then return end
			getRemote("TradeRequestResult"):FireClient(me, data.accepted, data.byName .. (data.accepted and " aceptó el trade" or " rechazó el trade"))
			if data.accepted and data.tradeId then
				myActiveTradeId[me.UserId] = data.tradeId
				subscribeToTrade(data.tradeId)
				getRemote("TradeStarted"):FireClient(me, data.byName)
			end
		end)
	end)

	-- Presencia: publicar al entrar, cada 20s, y borrar al salir
	for _, p in ipairs(Players:GetPlayers()) do
		updatePresence(p)
	end
	Players.PlayerAdded:Connect(function(p)
		updatePresence(p)
	end)
	Players.PlayerRemoving:Connect(function(p)
		removePresence(p)
		pendingRequests[p.UserId] = nil
		myActiveTradeId[p.UserId] = nil
	end)

	task.spawn(function()
		while true do
			task.wait(20)
			for _, p in ipairs(Players:GetPlayers()) do
				updatePresence(p)
			end
		end
	end)
end

return TradeService
