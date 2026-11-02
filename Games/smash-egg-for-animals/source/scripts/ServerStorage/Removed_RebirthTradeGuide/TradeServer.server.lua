-- TradeServer : échanges de pets entre joueurs, MÊME S'ILS NE SONT PAS DANS LE MÊME SERVEUR
-- 1. Un joueur cherche un pseudo et envoie une invitation (l'autre la voit en bas à droite : ACCEPT / CLOSE).
-- 2. S'il accepte, les deux ouvrent la fenêtre d'échange, posent leurs pets (9 max) et cliquent sur READY.
-- 3. Quand les deux sont prêts : 3 s de compte à rebours, puis l'échange se fait en deux temps, sûr :
--    a) chaque serveur VERROUILLE les pets offerts par son joueur (ils sortent de son inventaire),
--    b) quand les deux côtés ont verrouillé, chaque serveur LIVRE ses pets à l'autre joueur en les écrivant
--       dans le DataStore TradePending_v1 ; le serveur du receveur les récupère (tout de suite ou à sa prochaine connexion).
-- Les serveurs se parlent avec MessagingService (sujet PetTrade_v1) ; dans le même serveur, les messages passent directement.
-- Les pets sont gérés par PetServer via ServerScriptService.TradeBridge.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MessagingService = game:GetService("MessagingService")
local DataStoreService = game:GetService("DataStoreService")
local HttpService = game:GetService("HttpService")

local bridge = script.Parent:WaitForChild("TradeBridge")
local Config = require(ReplicatedStorage:WaitForChild("EggSystem"):WaitForChild("EggConfig"))
local system = ReplicatedStorage:WaitForChild("TradeSystem")
local request = system:WaitForChild("TradeRequest")
local update = system:WaitForChild("TradeUpdate")

local TOPIC = "PetTrade_v1"
local MAX_OFFER = 9
local INVITE_LIFETIME = 30 -- une invitation disparaît au bout de 30 s
local COUNTDOWN = 3
local LOCK_TIMEOUT = 15

local pendingStore
pcall(function() pendingStore = DataStoreService:GetDataStore("TradePending_v1") end)

local sessions = {} -- [userId] = échange en cours du joueur de CE serveur
local outgoing = {} -- [userId] = invitation envoyée {Id, To, At}
local incoming = {} -- [userId] = {[inviteId] = {From, FromName, At}}
local acks = {}     -- [inviteId] = "ok" / "busy" (réponse du serveur de l'invité)
local lastInvite = {}

local handle -- (défini plus bas)

---------------------------------------------------------------- outils
local function push(player, payload)
	if player and player.Parent then update:FireClient(player, payload) end
end

-- envoie un message au serveur du joueur `to` (ou directement s'il est ici)
local function send(to, msg)
	msg.to = to
	if Players:GetPlayerByUserId(to) then
		task.spawn(handle, msg)
		return true
	end
	local ok, err = pcall(function() MessagingService:PublishAsync(TOPIC, msg) end)
	if not ok then warn("[TradeServer] envoi raté : " .. tostring(err)) end
	return ok
end

local function summary(rec)
	return {p = rec.Pet, k = math.floor((rec.Kg or 0) * 100 + 0.5) / 100, m = rec.Mutation, t = rec.Trait}
end

-- empreinte d'une offre (pour vérifier que les deux côtés valident exactement la même chose)
local function signature(pets)
	local parts = {}
	for _, p in pets do table.insert(parts, tostring(p.p) .. ":" .. tostring(p.k) .. ":" .. tostring(p.m) .. ":" .. tostring(p.t)) end
	table.sort(parts)
	return table.concat(parts, "|")
end

local function bridgeCall(...)
	local ok, a, b = pcall(bridge.Invoke, bridge, ...)
	if not ok then warn("[TradeServer] TradeBridge : " .. tostring(a)) return nil, "Server error." end
	return a, b
end

-- état envoyé à la fenêtre d'échange du joueur
local function pushState(player)
	local s = sessions[player.UserId]
	if not s then return end
	push(player, {Type = "State", PartnerName = s.PartnerName, MyIds = s.MyIds, MyPets = s.MyPets, TheirPets = s.TheirPets,
		MyReady = s.MyReady, TheirReady = s.TheirReady, Phase = s.Phase, CountdownEnd = s.CountdownEnd})
end

local function closeSession(player, userId, reason, success)
	local s = sessions[userId]
	if not s then return end
	sessions[userId] = nil
	push(player, {Type = "Closed", Reason = reason, Success = success})
end

---------------------------------------------------------------- livraisons (DataStore)
local claiming = {}
-- récupère les pets qui attendent ce joueur (échanges livrés)
local function claimPending(player)
	if not pendingStore or claiming[player] then return end
	claiming[player] = true
	local waited = 0
	while player.Parent and not bridgeCall("Loaded", player) and waited < 60 do waited += task.wait(1) end
	if player.Parent and bridgeCall("Loaded", player) then
		local got
		local ok, err = pcall(function()
			pendingStore:UpdateAsync(tostring(player.UserId), function(old)
				got = type(old) == "table" and old or nil
				if not got or #got == 0 then return nil end -- rien à changer
				return {}
			end)
		end)
		if ok and got and #got > 0 then
			bridgeCall("Give", player, got)
			bridgeCall("Save", player)
			push(player, {Type = "Notify", Text = "You received " .. #got .. " pet" .. (#got > 1 and "s" or "") .. " from a trade!"})
		elseif not ok then
			warn("[TradeServer] récupération ratée : " .. tostring(err))
		end
	end
	claiming[player] = nil
end

-- écrit des pets dans la boîte de réception d'un joueur (3 essais)
local function deliverTo(userId, records)
	if #records == 0 then return true end
	if not pendingStore then return false end
	for attempt = 1, 3 do
		local ok = pcall(function()
			pendingStore:UpdateAsync(tostring(userId), function(old)
				local list = type(old) == "table" and old or {}
				for _, rec in records do table.insert(list, rec) end
				return list
			end)
		end)
		if ok then return true end
		task.wait(attempt)
	end
	return false
end

-- rend au joueur les pets qu'il avait verrouillés (échange raté)
local function returnEscrow(player, s)
	if s.Escrow and #s.Escrow > 0 then
		if player and player.Parent and bridgeCall("Give", player, s.Escrow) then
			bridgeCall("Save", player)
		else
			deliverTo(s.UserId, s.Escrow) -- il les retrouvera à sa prochaine connexion
		end
	end
	s.Escrow = nil
end

---------------------------------------------------------------- déroulement de l'échange
local function tryDeliver(player, s)
	if s.Delivered or not s.MyLock or s.TheirLock ~= true then return end
	s.Delivered = true
	local ok = deliverTo(s.PartnerId, s.Escrow or {})
	if not ok then
		-- livraison impossible : on rend les pets et on prévient l'autre
		returnEscrow(player, s)
		send(s.PartnerId, {t = "cancel", id = s.Id, from = s.UserId, reason = "Trade failed (server error). Your pets were returned."})
		closeSession(player, s.UserId, "Trade failed (server error). Your pets were returned.", false)
		return
	end
	s.Escrow = nil
	bridgeCall("Save", player)
	send(s.PartnerId, {t = "delivered", id = s.Id, from = s.UserId})
	closeSession(player, s.UserId, "Trade completed with " .. s.PartnerName .. "!", true)
	task.spawn(claimPending, player)
end

local function doLock(player, s, expectMine, expectTheirs)
	if s.Phase == "locking" then return end
	s.Phase = "locking"
	pushState(player)
	local count, max = bridgeCall("Count", player)
	local ok, reason = true, nil
	if expectMine and (expectMine ~= signature(s.MyPets) or expectTheirs ~= signature(s.TheirPets)) then
		ok, reason = false, "An offer changed at the last second. Trade cancelled, try again!"
	elseif not count then
		ok, reason = false, player.DisplayName .. "'s data is unavailable."
	elseif count - #s.MyIds + #s.TheirPets > (max or 0) then
		ok, reason = false, player.DisplayName .. " does not have enough inventory space."
	else
		local records, err = bridgeCall("Take", player, s.MyIds)
		if not records then
			ok, reason = false, err or "A pet is no longer available."
		else
			s.Escrow = records
		end
	end
	s.MyLock = ok
	send(s.PartnerId, {t = "locked", id = s.Id, from = s.UserId, ok = ok, reason = reason})
	if not ok then
		closeSession(player, s.UserId, reason, false)
		return
	end
	tryDeliver(player, s)
	-- sécurité : si l'autre ne répond jamais, on rend les pets
	task.delay(LOCK_TIMEOUT, function()
		if sessions[s.UserId] == s and not s.Delivered then
			returnEscrow(player, s)
			send(s.PartnerId, {t = "cancel", id = s.Id, from = s.UserId, reason = "Trade timed out."})
			closeSession(player, s.UserId, "Trade timed out. Your pets were returned.", false)
		end
	end)
end

local function checkBoth(player, s)
	if not (s.MyReady and s.TheirReady and s.Phase == "trading") then return end
	s.Phase = "countdown"
	s.CountdownEnd = workspace:GetServerTimeNow() + COUNTDOWN
	pushState(player)
	local version = s.Version
	task.delay(COUNTDOWN, function()
		if sessions[s.UserId] ~= s or s.Phase ~= "countdown" or s.Version ~= version then return end
		if not (s.MyReady and s.TheirReady) then return end
		-- le joueur au plus petit UserId lance le verrouillage des deux côtés
		if s.UserId < s.PartnerId then
			-- on envoie ce qu'on a vu des deux offres : l'autre vérifie que c'est bien pareil chez lui
			send(s.PartnerId, {t = "lock", id = s.Id, from = s.UserId, theirs = signature(s.TheirPets), mine = signature(s.MyPets)})
			doLock(player, s)
		end
	end)
end

local function newSession(player, partnerId, partnerName, id)
	local s = {Id = id, UserId = player.UserId, PartnerId = partnerId, PartnerName = partnerName,
		MyIds = {}, MyPets = {}, TheirPets = {}, MyReady = false, TheirReady = false, Phase = "trading", Version = 0}
	sessions[player.UserId] = s
	outgoing[player.UserId] = nil
	incoming[player.UserId] = nil
	push(player, {Type = "Open", PartnerName = partnerName})
	pushState(player)
	return s
end

---------------------------------------------------------------- messages entre serveurs
handle = function(msg)
	local player = Players:GetPlayerByUserId(msg.to)
	if not player then return end
	local me = player.UserId
	local s = sessions[me]
	local t = msg.t

	if t == "invite" then
		if s then send(msg.from, {t = "inviteAck", id = msg.id, from = me, busy = true}) return end
		incoming[me] = incoming[me] or {}
		incoming[me][msg.id] = {From = msg.from, FromName = msg.fromName, At = os.clock()}
		send(msg.from, {t = "inviteAck", id = msg.id, from = me})
		push(player, {Type = "Invite", Id = msg.id, FromName = msg.fromName})
		task.delay(INVITE_LIFETIME, function()
			if incoming[me] and incoming[me][msg.id] then
				incoming[me][msg.id] = nil
				push(player, {Type = "InviteGone", Id = msg.id})
			end
		end)

	elseif t == "inviteAck" then
		acks[msg.id] = msg.busy and "busy" or "ok"

	elseif t == "reply" then -- l'invité a répondu à MON invitation
		local out = outgoing[me]
		if not out or out.Id ~= msg.id then
			if msg.accepted then send(msg.from, {t = "cancel", id = msg.id, from = me, reason = "The invitation expired."}) end
			return
		end
		outgoing[me] = nil
		if not msg.accepted then
			push(player, {Type = "Notify", Text = msg.fromName .. " declined your trade."})
		elseif s then
			send(msg.from, {t = "cancel", id = msg.id, from = me, reason = player.DisplayName .. " is already trading."})
		else
			newSession(player, msg.from, msg.fromName, msg.id)
			send(msg.from, {t = "started", id = msg.id, from = me, fromName = player.Name})
		end

	elseif t == "started" then -- l'échange que j'ai accepté commence
		if s then
			send(msg.from, {t = "cancel", id = msg.id, from = me, reason = player.DisplayName .. " is already trading."})
		else
			newSession(player, msg.from, msg.fromName, msg.id)
		end

	elseif not s or s.Id ~= msg.id then
		if t == "delivered" then task.spawn(claimPending, player) end
		return -- message d'un autre échange

	elseif t == "offer" then
		if s.Phase ~= "trading" and s.Phase ~= "countdown" then return end
		s.TheirPets = type(msg.pets) == "table" and msg.pets or {}
		s.MyReady, s.TheirReady = false, false
		s.Phase = "trading"
		s.Version += 1
		pushState(player)

	elseif t == "ready" then
		if s.Phase ~= "trading" and s.Phase ~= "countdown" then return end
		s.TheirReady = msg.ready == true
		if not s.TheirReady and s.Phase == "countdown" then s.Phase = "trading" s.Version += 1 end
		pushState(player)
		checkBoth(player, s)

	elseif t == "lock" then
		-- "theirs" = mon offre vue par l'autre, "mine" = son offre vue par lui
		doLock(player, s, msg.theirs or "", msg.mine or "")

	elseif t == "locked" then
		s.TheirLock = msg.ok == true
		if not s.TheirLock then
			returnEscrow(player, s)
			closeSession(player, me, msg.reason or "Trade failed.", false)
		else
			tryDeliver(player, s)
		end

	elseif t == "delivered" then
		task.spawn(claimPending, player)

	elseif t == "cancel" then
		if not s.Delivered then returnEscrow(player, s) end
		closeSession(player, me, msg.reason or (s.PartnerName .. " cancelled the trade."), false)
	end
end

pcall(function()
	MessagingService:SubscribeAsync(TOPIC, function(message)
		local msg = message.Data
		if type(msg) == "table" and msg.to and Players:GetPlayerByUserId(msg.to) then handle(msg) end
	end)
end)

---------------------------------------------------------------- demandes du joueur (fenêtres d'échange)
request.OnServerInvoke = function(player, action, a, b)
	local me = player.UserId
	local s = sessions[me]

	if action == "Invite" then
		if s then return false, "You are already trading." end
		if os.clock() - (lastInvite[me] or 0) < 3 then return false, "Wait a few seconds before inviting again." end
		lastInvite[me] = os.clock()
		local name = type(a) == "string" and string.gsub(a, "^%s*@?(.-)%s*$", "%1") or ""
		if #name < 3 or #name > 20 then return false, "Enter a valid username." end
		local ok, targetId = pcall(function() return Players:GetUserIdFromNameAsync(name) end)
		if not ok or not targetId then return false, "No player called " .. name .. "." end
		if targetId == me then return false, "You can't trade with yourself!" end
		local okName, realName = pcall(function() return Players:GetNameFromUserIdAsync(targetId) end)
		realName = okName and realName or name
		local id = HttpService:GenerateGUID(false)
		outgoing[me] = {Id = id, To = targetId, At = os.clock()}
		acks[id] = nil
		if not send(targetId, {t = "invite", id = id, from = me, fromName = player.Name}) then
			outgoing[me] = nil
			return false, "Could not send the invite. Try again."
		end
		-- on attend que le serveur de l'invité confirme qu'il est en ligne
		local waited = 0
		while not acks[id] and waited < 5 do waited += task.wait(0.1) end
		local ack = acks[id]
		acks[id] = nil
		if not ack then
			outgoing[me] = nil
			return false, realName .. " is not online."
		end
		if ack == "busy" then
			outgoing[me] = nil
			return false, realName .. " is already trading."
		end
		task.delay(INVITE_LIFETIME, function()
			if outgoing[me] and outgoing[me].Id == id then outgoing[me] = nil end
		end)
		return true, "Invite sent to " .. realName .. "!"

	elseif action == "Respond" then
		local inv = incoming[me] and incoming[me][a]
		if not inv then return false, "This invitation expired." end
		incoming[me][a] = nil
		if b and s then return false, "You are already trading." end
		send(inv.From, {t = "reply", id = a, from = me, fromName = player.Name, accepted = b == true})
		if b then
			-- si l'échange ne démarre pas (l'autre est parti...), on prévient
			task.delay(8, function()
				if not sessions[me] then push(player, {Type = "Notify", Text = "The trade could not start."}) end
			end)
		end
		return true

	elseif action == "GetTradable" then
		return bridgeCall("GetTradable", player) or {}

	elseif action == "SetOffer" then
		if not s or (s.Phase ~= "trading" and s.Phase ~= "countdown") then return false end
		if type(a) ~= "table" or #a > MAX_OFFER then return false, "You can offer " .. MAX_OFFER .. " pets max." end
		local tradable = bridgeCall("GetTradable", player) or {}
		local byId = {}
		for _, rec in tradable do byId[rec.Id] = rec end
		local ids, pets, seen = {}, {}, {}
		for _, id in a do
			local rec = byId[id]
			if rec and not seen[id] then
				seen[id] = true
				table.insert(ids, id)
				table.insert(pets, summary(rec))
			end
		end
		s.MyIds, s.MyPets = ids, pets
		s.MyReady, s.TheirReady = false, false
		s.Phase = "trading"
		s.Version += 1
		send(s.PartnerId, {t = "offer", id = s.Id, from = me, pets = pets})
		pushState(player)
		return true

	elseif action == "Ready" then
		if not s or (s.Phase ~= "trading" and s.Phase ~= "countdown") then return false end
		s.MyReady = a == true
		if not s.MyReady and s.Phase == "countdown" then s.Phase = "trading" s.Version += 1 end
		send(s.PartnerId, {t = "ready", id = s.Id, from = me, ready = s.MyReady})
		pushState(player)
		checkBoth(player, s)
		return true

	elseif action == "Cancel" then
		if not s then return true end
		if s.Phase == "locking" then return false, "Too late, the trade is being done!" end
		send(s.PartnerId, {t = "cancel", id = s.Id, from = me, reason = player.Name .. " cancelled the trade."})
		closeSession(player, me, "You cancelled the trade.", false)
		return true
	end
	return false
end

---------------------------------------------------------------- arrivées / départs
Players.PlayerAdded:Connect(function(player) task.spawn(claimPending, player) end)
for _, p in Players:GetPlayers() do task.spawn(claimPending, p) end

Players.PlayerRemoving:Connect(function(player)
	local me = player.UserId
	local s = sessions[me]
	if s then
		if s.Escrow and not s.Delivered then deliverTo(me, s.Escrow) s.Escrow = nil end -- ses pets verrouillés lui reviendront
		send(s.PartnerId, {t = "cancel", id = s.Id, from = me, reason = player.Name .. " left the game."})
		sessions[me] = nil
	end
	outgoing[me], incoming[me], lastInvite[me] = nil, nil, nil
end)
