--credit to prince games studio
--[[
	MailboxService (servidor)  ·  MODDED
	--------------------------------------------------------------------
	El cliente (MailboxController / PlayerSelectClient) ya trae toda la UI de
	correo/regalos, pero el lado servidor (handlers de Networking.Mailbox.*)
	NUNCA se exportó en el dump. Este script lo implementa.

	FASE 1: LookupPlayer (búsqueda de usuarios).
	FASE 2 (este script): envío/recibo REAL de SEMILLAS.
	  • Transferencia real: las semillas se QUITAN del que envía (RemoveSeed)
	    y se guardan en la bandeja PERSISTENTE del que recibe (DataStore), así
	    le llegan aunque esté offline y las ve al volver.
	  • Reclamar: pasa las semillas de la bandeja al inventario (GiveSeed) y
	    borra el regalo (se quita primero para no duplicar).
	  • Solo SEMILLAS por ahora: pets y frutas requieren reestructurar el
	    inventario (riesgoso) y quedan para una fase posterior.

	NOTA: en Studio el DataStore necesita "Enable Studio Access to API
	Services" (Game Settings > Security). Sin eso, los envíos fallan con un
	aviso claro y se REEMBOLSAN las semillas (no se pierden).
]]

local Players            = game:GetService("Players")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local ServerScriptService= game:GetService("ServerScriptService")
local DataStoreService   = game:GetService("DataStoreService")
local HttpService        = game:GetService("HttpService")

local Networking    = require(ReplicatedStorage.SharedModules.Networking)
local GameServerAPI = require(ServerScriptService.GameServerAPI)
local Mail = Networking.Mailbox

local MAILBOX_STORE = DataStoreService:GetDataStore("Mailbox_v1")
local MAX_GIFTS = 50            -- tope de regalos sin reclamar por jugador
local MAX_ITEMS_PER_GIFT = 20   -- tope de items por regalo

-- Cache en memoria de la bandeja de los jugadores ONLINE. [userId] = { [giftId] = gift }
local mailboxByUserId = {}

----------------------------------------------------------------------
-- Categorías regalables soportadas + sus funciones de inventario.
-- (Seeds y Pets se manejan por conteo; frutas pendientes.)
----------------------------------------------------------------------
local SUPPORTED_CATEGORIES = { Seeds = true, Pets = true }
local function invGetCount(player, cat, key)
	if cat == "Seeds" then return GameServerAPI.WaitFor("GetSeedCount")(player, key) end
	if cat == "Pets" then return GameServerAPI.WaitFor("GetOwnedPetCount")(player, key) end
	return 0
end
local function invRemove(player, cat, key, count)
	if cat == "Seeds" then return GameServerAPI.WaitFor("RemoveSeed")(player, key, count) end
	if cat == "Pets" then return GameServerAPI.WaitFor("RemovePet")(player, key, count) end
	return false
end
local function invGive(player, cat, key, count)
	if cat == "Seeds" then
		GameServerAPI.WaitFor("GiveSeed")(player, key, count)
	elseif cat == "Pets" then
		for _ = 1, count do
			GameServerAPI.WaitFor("AddPet")(player, key)
		end
	end
end

----------------------------------------------------------------------
-- Utilidades
----------------------------------------------------------------------
local function keyFor(userId)
	return "mb_" .. tostring(userId)
end

local function countGifts(mb)
	local n = 0
	if type(mb) == "table" then
		for _ in pairs(mb) do
			n += 1
		end
	end
	return n
end

local function loadMailbox(userId)
	local ok, data = pcall(function()
		return MAILBOX_STORE:GetAsync(keyFor(userId))
	end)
	if ok and type(data) == "table" then
		return data
	end
	return {}
end

local function cleanUsername(name)
	if type(name) ~= "string" then
		return nil
	end
	name = name:gsub("^%s*@?(.-)%s*$", "%1")
	if #name < 3 or #name > 20 or not name:match("^[%w_]+$") then
		return nil
	end
	return name
end

----------------------------------------------------------------------
-- LookupPlayer: nombre -> (userId, displayName). userId <= 0 = no encontrado.
----------------------------------------------------------------------
local lookupCache = {}
Mail.LookupPlayer.OnServerInvoke = function(player, name)
	local clean = cleanUsername(name)
	if not clean then
		return 0, ""
	end
	local lower = clean:lower()
	local cached = lookupCache[lower]
	if cached then
		return cached.userId, cached.displayName
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if p.Name:lower() == lower or p.DisplayName:lower() == lower then
			lookupCache[lower] = { userId = p.UserId, displayName = p.DisplayName }
			return p.UserId, p.DisplayName
		end
	end
	local ok, userId = pcall(function()
		return Players:GetUserIdFromNameAsync(clean)
	end)
	if not ok or type(userId) ~= "number" or userId <= 0 then
		return 0, ""
	end
	local displayName = clean
	local ok2, info = pcall(function()
		return Players:GetNameFromUserIdAsync(userId)
	end)
	if ok2 and type(info) == "string" and info ~= "" then
		displayName = info
	end
	lookupCache[lower] = { userId = userId, displayName = displayName }
	return userId, displayName
end

----------------------------------------------------------------------
-- Carga / descarga de la bandeja
----------------------------------------------------------------------
local function onPlayerAdded(player)
	mailboxByUserId[player.UserId] = loadMailbox(player.UserId)
end
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(function(player)
	mailboxByUserId[player.UserId] = nil
end)
for _, p in ipairs(Players:GetPlayers()) do
	task.spawn(onPlayerAdded, p)
end

----------------------------------------------------------------------
-- Leer bandeja (OpenInbox / List / IndexProbe)
----------------------------------------------------------------------
Mail.OpenInbox.OnServerInvoke = function(player)
	return mailboxByUserId[player.UserId] or {}
end
Mail.List.OnServerInvoke = function(player)
	return mailboxByUserId[player.UserId] or {}
end
Mail.IndexProbe.OnServerInvoke = function(player)
	return countGifts(mailboxByUserId[player.UserId])
end

----------------------------------------------------------------------
-- Enviar (SendBatch) — solo SEMILLAS. Transferencia real + persistente.
----------------------------------------------------------------------
Mail.SendBatch.OnServerInvoke = function(sender, targetUserId, items, message)
	targetUserId = tonumber(targetUserId)
	if not targetUserId or targetUserId <= 0 then
		return false, "Destinatario inválido"
	end
	if targetUserId == sender.UserId then
		return false, "No puedes enviarte a ti mismo"
	end
	if type(items) ~= "table" or #items == 0 then
		return false, "No hay nada para enviar"
	end
	if #items > MAX_ITEMS_PER_GIFT then
		return false, "Demasiados items"
	end

	-- Validar (Seeds y Pets) y que tenga suficientes.
	local toSend = {}
	for _, it in ipairs(items) do
		if type(it) ~= "table" then
			return false, "Item inválido"
		end
		local cat = it.Category
		if not SUPPORTED_CATEGORIES[cat] then
			return false, "Por ahora solo se pueden regalar semillas y pets"
		end
		local key = it.ItemKey
		local count = math.floor(tonumber(it.Count) or 0)
		if type(key) ~= "string" or count <= 0 then
			return false, "Item inválido"
		end
		if invGetCount(sender, cat, key) < count then
			return false, "No tienes suficientes para enviar"
		end
		toSend[#toSend + 1] = { Category = cat, ItemName = key, Count = count }
	end

	-- Quitar del que envía (con reembolso si algo falla).
	local removed = {}
	local function refund()
		for _, r in ipairs(removed) do
			invGive(sender, r.Category, r.ItemName, r.Count)
		end
	end
	for _, it in ipairs(toSend) do
		if invRemove(sender, it.Category, it.ItemName, it.Count) then
			removed[#removed + 1] = it
		else
			refund()
			return false, "No se pudo enviar (tu inventario cambió)"
		end
	end

	-- Construir el regalo.
	local giftId = HttpService:GenerateGUID(false)
	local gift = {
		From = sender.UserId,
		FromName = sender.Name,
		Note = (type(message) == "string" and #message <= 200) and message or "",
		SentAt = os.time(),
		Items = toSend,
	}

	-- Guardar en la bandeja del destinatario (DataStore -> funciona offline).
	local added = false
	local okStore = pcall(function()
		MAILBOX_STORE:UpdateAsync(keyFor(targetUserId), function(old)
			old = (type(old) == "table") and old or {}
			if countGifts(old) >= MAX_GIFTS then
				return nil  -- bandeja llena: cancela la escritura
			end
			old[giftId] = gift
			added = true
			return old
		end)
	end)

	if not okStore or not added then
		refund()
		if not okStore then
			return false, "No se pudo guardar el regalo (DataStore)"
		end
		return false, "La bandeja del destinatario está llena"
	end

	-- Si el destinatario está online: refrescar su cache y avisarle al instante.
	local target = Players:GetPlayerByUserId(targetUserId)
	if target then
		local mb = mailboxByUserId[targetUserId]
		if type(mb) ~= "table" then
			mb = {}
			mailboxByUserId[targetUserId] = mb
		end
		mb[giftId] = gift
		pcall(function()
			Mail.Updated:FireClient(target, mb)
		end)
	end

	if GameServerAPI.PlaySFX then
		GameServerAPI.PlaySFX(sender, "Purchase")
	end
	return true, "Regalo enviado"
end

----------------------------------------------------------------------
-- Reclamar (Claim) — quita el regalo PRIMERO (anti-dupe) y luego entrega.
----------------------------------------------------------------------
Mail.Claim.OnServerInvoke = function(player, giftId)
	if type(giftId) ~= "string" then
		return false, "Regalo inválido"
	end
	local claimed
	local ok = pcall(function()
		MAILBOX_STORE:UpdateAsync(keyFor(player.UserId), function(old)
			old = (type(old) == "table") and old or {}
			claimed = old[giftId]
			if claimed then
				old[giftId] = nil
			end
			return old
		end)
	end)
	if not ok then
		return false, "No se pudo reclamar (DataStore)"
	end
	-- sincronizar cache
	local mb = mailboxByUserId[player.UserId]
	if type(mb) == "table" then
		mb[giftId] = nil
	end
	if not claimed then
		return false, "Ese regalo ya no está"
	end
	-- entregar (Seeds y Pets)
	for _, it in ipairs(claimed.Items or {}) do
		if SUPPORTED_CATEGORIES[it.Category] and type(it.ItemName) == "string" then
			invGive(player, it.Category, it.ItemName, math.max(1, math.floor(tonumber(it.Count) or 1)))
		end
	end
	if GameServerAPI.PlaySFX then
		GameServerAPI.PlaySFX(player, "Purchase")
	end
	return true, "Reclamado"
end

----------------------------------------------------------------------
-- Rechazar (Decline) — borra el regalo sin entregar.
----------------------------------------------------------------------
Mail.Decline.OnServerEvent:Connect(function(player, giftId)
	if type(giftId) ~= "string" then
		return
	end
	pcall(function()
		MAILBOX_STORE:UpdateAsync(keyFor(player.UserId), function(old)
			old = (type(old) == "table") and old or {}
			old[giftId] = nil
			return old
		end)
	end)
	local mb = mailboxByUserId[player.UserId]
	if type(mb) == "table" then
		mb[giftId] = nil
	end
end)

-- Send (evento de una vía) — no usado por la UI de batch; no-op.
if Mail.Send and Mail.Send.OnServerEvent then
	Mail.Send.OnServerEvent:Connect(function() end)
end

print("[MailboxService] listo — búsqueda + regalo de semillas y pets (offline, transferencia real).")
