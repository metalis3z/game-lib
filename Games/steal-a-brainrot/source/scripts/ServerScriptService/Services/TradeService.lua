local TradeService = {}

local ReplicatedStorage   = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Players             = game:GetService("Players")
local HttpService         = game:GetService("HttpService")
local MessagingService    = game:GetService("MessagingService")
local DataStoreService    = game:GetService("DataStoreService")

local NotificationService = require(game.ServerScriptService.Services.NotificationService)
local Net                 = require(ReplicatedStorage.Packages.Net)
local Synchronizer        = require(ReplicatedStorage.Packages.Synchronizer)

-- ─── Remotes ──────────────────────────────────────────────────────────────────
local CreateInvite   = Net:RemoteEvent("TradeService/CreateInvite")
local DeclineInvite  = Net:RemoteEvent("TradeService/DeclineInvite")
local AcceptInvite   = Net:RemoteFunction("TradeService/AcceptInvite")
local SearchUser     = Net:RemoteFunction("TradeService/SearchUser")
local InviteRemote   = Net:RemoteFunction("TradeService/Invite")
local CancelTrade    = Net:RemoteEvent("TradeService/CancelTrade")
local AddBrainrot    = Net:RemoteFunction("TradeService/AddBrainrot")
local RemoveBrainrot = Net:RemoteFunction("TradeService/RemoveBrainrot")
local TradeCompleted = Net:RemoteEvent("TradeService/TradeCompleted")
local ReadyRemote    = Net:RemoteEvent("TradeService/Ready")
local AcceptRemote   = Net:RemoteEvent("TradeService/Accept")

-- ─── DataStore ────────────────────────────────────────────────────────────────
local DataStore = DataStoreService:GetDataStore("DATA-FOR-EVERYONE")

-- ─── Constantes ───────────────────────────────────────────────────────────────
local INVITE_TTL          = 30
local MAX_OFFER           = 100   -- Plus de limite ridicule (8)
local READY_DELAY         = 8  -- augmenté de 5 à 8s pour éviter les accepts involontaires
local BRAINROT_COOLDOWN   = 2
local INVITE_COOLDOWN     = 2
local MAX_PENDING_INVITES = 3
local MAX_RETRIES         = 5

-- Topics MessagingService
local TOPIC_LOCATE   = "Trade_Locate"
local TOPIC_INVITE   = "Trade_Invite"
local TOPIC_RESPONSE = "Trade_Response"
local TOPIC_SYNC     = "Trade_Sync"
local TOPIC_COMMIT   = "Trade_Commit"

-- ─── State ────────────────────────────────────────────────────────────────────
local Invites      = {}
local CrossInvites = {}
local Trades       = {}
local InTrade      = {}
local CrossTrades  = {}
local InCrossTrade = {}

local BrainrotCooldown = {}
local InviteCooldown   = {}
local locateCallbacks  = {}
local prepareCallbacks = {}

local ReplicatorRemote

-- ─── Copie profonde (indispensable pour la réplication fiable) ────────────────
local function deepCopy(t)
	if type(t) ~= "table" then return t end
	local copy = {}
	for k, v in pairs(t) do
		copy[k] = deepCopy(v)
	end
	return copy
end

-- ─── Utilitaires ──────────────────────────────────────────────────────────────

local function checkBrainrotCooldown(player)
	local now  = workspace:GetServerTimeNow()
	local last = BrainrotCooldown[player.UserId]
	if last and now < last then return false end
	BrainrotCooldown[player.UserId] = now + BRAINROT_COOLDOWN
	return true
end

local function getReplicator()
	if ReplicatorRemote then return ReplicatorRemote end
	local internal = ReplicatedStorage:FindFirstChild("__ReplicatorInternal")
	if internal then ReplicatorRemote = internal:FindFirstChild("RemoteEvent") end
	return ReplicatorRemote
end

local function playerById(id)
	for _, p in ipairs(Players:GetPlayers()) do
		if p.UserId == id then return p end
	end
end

local function getChannel(player)
	return Synchronizer:Get(player)
end

local function getPodiums(player)
	local ch = getChannel(player)
	return (ch and ch:Get("AnimalPodiums")) or {}
end

local function getSlot(trade, userId)
	for slot, uid in pairs(trade.users) do
		if uid == userId then return slot end
	end
end

local function resetReadyState(playerData)
	for _, pd in pairs(playerData) do
		pd.ready    = false
		pd.accepted = false
	end
end

-- ─── Détection de vol ─────────────────────────────────────────────────────────

local function isAnimalBeingStolen(userId, indexOnPlot)
	local plot = _G.playerPlots and _G.playerPlots[userId]
	if not plot then return false end
	local plotChannel = Synchronizer:Get(plot.Name)
	if not plotChannel then return false end
	local animalList = plotChannel:Get("AnimalList")
	if not animalList then return false end
	local entry = animalList[indexOnPlot]
	if not entry or type(entry) ~= "table" then return false end
	return entry.Steal and entry.Steal ~= false
end

local function hasAnyAnimalBeingStolen(userId)
	local plot = _G.playerPlots and _G.playerPlots[userId]
	if not plot then return false end
	local plotChannel = Synchronizer:Get(plot.Name)
	if not plotChannel then return false end
	local animalList = plotChannel:Get("AnimalList")
	if not animalList then return false end
	for _, entry in pairs(animalList) do
		if type(entry) == "table" and entry.Steal and entry.Steal ~= false then
			return true
		end
	end
	return false
end

-- ─── Réplication UI locale (avec COPIE PROFONDE) ──────────────────────────────

local function replicate(userId, data)
	local remote = getReplicator()
	if not remote then return end
	local token = "Trade_" .. userId
	remote:FireAllClients({ { utf8.char(0), token, token, data } })
end

local function clearTradeUI(userId)
	replicate(userId, {})
end

local function syncTrade(trade)
	-- Copie profonde pour forcer la détection de changement
	local playersCopy = deepCopy(trade.playerData)
	local snapshot = {
		active = {
			data = {
				tradeId      = trade.tradeId,
				users        = trade.users,
				players      = playersCopy,
				lastChange   = trade.lastChange,
				isProcessing = trade.isProcessing or false,
				isCross      = false,
			}
		}
	}
	for _, uid in pairs(trade.users) do
		replicate(uid, snapshot)
	end
end

local function syncCrossTrade(ct)
	local playersCopy = deepCopy(ct.playerData)
	local snapshot = {
		active = {
			data = {
				tradeId      = ct.tradeId,
				users        = { [ct.localSlot] = ct.localUserId, [ct.remoteSlot] = ct.remoteUserId },
				players      = playersCopy,
				lastChange   = ct.lastChange,
				isProcessing = ct.isProcessing or false,
				isCross      = true,
			}
		}
	}
	replicate(ct.localUserId, snapshot)

	if _G.MessagingHub then
		_G.MessagingHub.Publish("Trade_Sync", {
			tradeId      = ct.tradeId,
			playerData   = playersCopy,
			lastChange   = ct.lastChange,
			isProcessing = ct.isProcessing or false,
			targetUserId = ct.remoteUserId,
		})
	end
end

-- ─── buildEntry ───────────────────────────────────────────────────────────────

local function buildEntry(player)
	local Bases    = require(ReplicatedStorage.Datas.Bases)
	local pods     = getPodiums(player)
	local ch       = getChannel(player)
	local rebirth  = ch and ch:Get("Rebirth") or 0
	local baseData = Bases[rebirth] or Bases[0]
	local total    = baseData.MaxAnimals
	local empty    = 0
	for i = 1, total do
		local v = pods[i]
		if v == "Empty" or v == nil then empty += 1 end
	end
	return {
		username   = player.Name,
		userId     = player.UserId,
		ready      = false,
		readyTime  = 0,
		accepted   = false,
		offer      = { brainrots = {} },
		maxSlots   = total,
		emptySlots = empty,
	}
end

-- ─── Trade LOCAL ──────────────────────────────────────────────────────────────

local function createTrade(p1, p2)
	local id = HttpService:GenerateGUID(false)
	local trade = {
		tradeId      = id,
		users        = { [1] = p1.UserId, [2] = p2.UserId },
		playerData   = { [1] = buildEntry(p1), [2] = buildEntry(p2) },
		lastChange   = workspace:GetServerTimeNow(),
		isProcessing = false,
	}
	Trades[id]         = trade
	InTrade[p1.UserId] = id
	InTrade[p2.UserId] = id
	syncTrade(trade)
end

local function cancelTrade(id, cancelUserId)
	local trade = Trades[id]
	if not trade then return end
	for _, uid in pairs(trade.users) do
		InTrade[uid] = nil
		clearTradeUI(uid)
	end
	if cancelUserId then
		local cancelPlayer = playerById(cancelUserId)
		if cancelPlayer then
			for _, uid in pairs(trade.users) do
				local p = playerById(uid)
				if p then NotificationService.Error(p, ("@%s canceled"):format(cancelPlayer.Name)) end
			end
		end
	end
	Trades[id] = nil
end

-- ─── Helpers invites ──────────────────────────────────────────────────────────

local function hasPendingInvite(fromId, toId)
	for _, inv in pairs(Invites) do
		if inv.from == fromId and inv.to == toId and inv.expires > workspace:GetServerTimeNow() then
			return true
		end
	end
	return false
end

local function countOutgoingInvites(userId)
	local n = 0
	for _, inv in pairs(Invites) do
		if inv.from == userId and inv.expires > workspace:GetServerTimeNow() then n += 1 end
	end
	return n
end

local function cancelCrossTrade(ct, reason, notifyLocal)
	if _G.MessagingHub then
		_G.MessagingHub.Publish("Trade_Commit", {
			action       = "cancel",
			tradeId      = ct.tradeId,
			targetUserId = ct.remoteUserId,
			reason       = reason,
		})
	end
	InCrossTrade[ct.localUserId] = nil
	CrossTrades[ct.tradeId]      = nil
	clearTradeUI(ct.localUserId)
	prepareCallbacks[ct.tradeId] = nil
	if notifyLocal then
		local p = playerById(ct.localUserId)
		if p then NotificationService.Error(p, reason or "Trade annulé.") end
	end
end

-- ─── MessagingService ─────────────────────────────────────────────────────────

local function setupMessagingSubscriptions()
	if not _G.MessagingHub then
		warn("[TradeService] MessagingHub non disponible!")
		return
	end

	_G.MessagingHub.Register("Trade_Locate", function(data)
		local target = playerById(data.targetUserId)
		if not target then return end
		_G.MessagingHub.Publish("Trade_Invite", {
			action       = "found",
			inviteId     = data.inviteId,
			senderUserId = data.senderUserId,
			targetUserId = data.targetUserId,
			foundJobId   = game.JobId,
		})
	end)

	_G.MessagingHub.Register("Trade_Invite", function(data)
		if data.action == "found" then
			local cb = locateCallbacks[data.inviteId]
			if cb then
				locateCallbacks[data.inviteId] = nil
				cb(data)
			end
		elseif data.action == "invite" then
			local target = playerById(data.targetUserId)
			if not target then return end
			if InTrade[data.targetUserId] or InCrossTrade[data.targetUserId] then return end
			if hasAnyAnimalBeingStolen(data.targetUserId) then return end

			CrossInvites[data.inviteId] = {
				from      = data.senderUserId,
				fromName  = data.senderName,
				fromJobId = data.fromJobId,
				to        = data.targetUserId,
				expires   = workspace:GetServerTimeNow() + INVITE_TTL,
			}
			CreateInvite:FireClient(target, data.inviteId, {
				from     = data.senderUserId,
				to       = data.targetUserId,
				expires  = workspace:GetServerTimeNow() + INVITE_TTL,
				isCross  = true,
				fromName = data.senderName,
			})
			task.delay(INVITE_TTL, function() CrossInvites[data.inviteId] = nil end)
		elseif data.action == "decline" then
			local sender = playerById(data.senderUserId)
			if sender then
				NotificationService.Error(sender, ("@%s a refusé le trade."):format(data.targetName or "?"))
			end
			locateCallbacks[data.inviteId] = nil
		end
	end)

	_G.MessagingHub.Register("Trade_Response", function(data)
		if data.action ~= "accepted" then return end
		local sender = playerById(data.senderUserId)
		if not sender then return end
		if InTrade[data.senderUserId] or InCrossTrade[data.senderUserId] then return end

		local entry = buildEntry(sender)
		local remoteEntry = {
			username   = data.targetName,
			userId     = data.targetUserId,
			ready      = false,
			readyTime  = 0,
			accepted   = false,
			offer      = { brainrots = {} },
			maxSlots   = data.targetMaxSlots or 8,
			emptySlots = data.targetEmptySlots or 0,
		}
		local ct = {
			tradeId      = data.tradeId,
			localUserId  = data.senderUserId,
			remoteUserId = data.targetUserId,
			localSlot    = 1,
			remoteSlot   = 2,
			isMaster     = true,
			playerData   = { [1] = entry, [2] = remoteEntry },
			lastChange   = workspace:GetServerTimeNow(),
			isProcessing = false,
		}
		CrossTrades[data.tradeId]       = ct
		InCrossTrade[data.senderUserId] = data.tradeId
		syncCrossTrade(ct)
	end)

	_G.MessagingHub.Register("Trade_Sync", function(data)
		local localPlayer = playerById(data.targetUserId)
		if not localPlayer then return end
		local ct = CrossTrades[data.tradeId]
		if not ct then return end
		ct.playerData = data.playerData
		ct.lastChange = data.lastChange
		replicate(ct.localUserId, {
			active = {
				data = {
					tradeId      = ct.tradeId,
					users        = { [ct.localSlot] = ct.localUserId, [ct.remoteSlot] = ct.remoteUserId },
					players      = ct.playerData,
					lastChange   = ct.lastChange,
					isProcessing = ct.isProcessing,
					isCross      = true,
				}
			}
		})
	end)

	_G.MessagingHub.Register("Trade_Commit", function(data)
		local localPlayer = playerById(data.targetUserId)
		if not localPlayer then return end
		local ct = CrossTrades[data.tradeId]
		if not ct then return end

		if data.action == "cancel" then
			InCrossTrade[ct.localUserId] = nil
			CrossTrades[data.tradeId]    = nil
			clearTradeUI(ct.localUserId)
			prepareCallbacks[data.tradeId] = nil
			NotificationService.Error(localPlayer, data.reason or "Trade annulé.")
			return
		end

		if data.action == "prepare" then
			if ct.isProcessing then
				if _G.MessagingHub then
					_G.MessagingHub.Publish("Trade_Commit", {
						action       = "cancel",
						tradeId      = ct.tradeId,
						targetUserId = ct.remoteUserId,
						reason       = "Trade déjà en cours de traitement.",
					})
				end
				return
			end
			ct.isProcessing = true
			local localPods = getPodiums(localPlayer)
			local offer     = ct.playerData[ct.localSlot].offer.brainrots
			local toSend    = {}
			for _, item in ipairs(offer) do
				local animal = localPods[item.IndexOnPlot]
				if not animal or animal == "Empty" or isAnimalBeingStolen(ct.localUserId, item.IndexOnPlot) then
					if _G.MessagingHub then
						_G.MessagingHub.Publish("Trade_Commit", {
							action       = "ready",
							tradeId      = ct.tradeId,
							targetUserId = ct.remoteUserId,
							success      = false,
							reason       = "Un animal est indisponible ou en cours de vol.",
						})
					end
					ct.isProcessing  = false
					InCrossTrade[ct.localUserId] = nil
					CrossTrades[ct.tradeId]      = nil
					clearTradeUI(ct.localUserId)
					NotificationService.Error(localPlayer, "Trade annulé : un animal était indisponible.")
					return
				end
				table.insert(toSend, {
					Index       = animal.Index,
					Mutation    = animal.Mutation,
					Traits      = animal.Traits,
					UUID        = animal.UUID,
					LastCollect = workspace:GetServerTimeNow(),
				})
			end
			if _G.MessagingHub then
				_G.MessagingHub.Publish("Trade_Commit", {
					action       = "ready",
					tradeId      = ct.tradeId,
					targetUserId = ct.remoteUserId,
					success      = true,
					animalsToA   = toSend,
				})
			end
			return
		end

		if data.action == "ready" then
			local cb = prepareCallbacks[data.tradeId]
			if cb then
				prepareCallbacks[data.tradeId] = nil
				cb(data.success, data.animalsToA, data.reason)
			end
			return
		end

		if data.action == "execute" then
			task.spawn(function()
				local localPods = getPodiums(localPlayer)
				local offer     = ct.playerData[ct.localSlot].offer.brainrots
				local toReceive = data.animalsToB or {}
				for _, item in ipairs(offer) do
					localPods[item.IndexOnPlot] = "Empty"
				end
				local maxSlotsB = #localPods
				for _, animal in ipairs(toReceive) do
					if animal and type(animal) == "table" then
						animal.Machine = nil
						animal.Steal   = nil
						animal.Stolen  = nil
						local inserted = false
						for i = 1, maxSlotsB do
							if localPods[i] == "Empty" or localPods[i] == nil then
								localPods[i] = animal
								inserted = true
								break
							end
						end
						if not inserted then
							warn("[TradeService] Cross B: impossible d'insérer un animal, pods pleins")
						end
					end
				end
				local ch = getChannel(localPlayer)
				ch:Set("AnimalPodiums", localPods)
				ch:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
				NotificationService.Success(localPlayer, ("Trade avec @%s complété ! 🎉"):format(data.remoteName or "?"))
				TradeCompleted:FireClient(localPlayer)
				InCrossTrade[ct.localUserId] = nil
				CrossTrades[ct.tradeId]      = nil
				clearTradeUI(ct.localUserId)
			end)
			return
		end
	end)
end

-- ─── InviteRemote ─────────────────────────────────────────────────────────────

InviteRemote.OnServerInvoke = function(sender, targetUserId)
	local now = workspace:GetServerTimeNow()
	if InviteCooldown[sender.UserId] and now < InviteCooldown[sender.UserId] then
		NotificationService.Error(sender, "Please wait before sending another trade.")
		return false
	end
	InviteCooldown[sender.UserId] = now + INVITE_COOLDOWN

	if sender.UserId == targetUserId then
		return false, "You cannot trade with yourself."
	end
	if InTrade[sender.UserId] or InCrossTrade[sender.UserId] then
		return false, "You are already in a trade."
	end

	local target = playerById(targetUserId)
	if target then
		if countOutgoingInvites(sender.UserId) >= MAX_PENDING_INVITES then
			NotificationService.Error(sender, "You already sent too many trade invites.")
			return false
		end
		if hasPendingInvite(sender.UserId, targetUserId) then
			return false, "Pending invite already exists."
		end
		if InTrade[targetUserId] or InCrossTrade[targetUserId] then
			return false, "That player is already trading."
		end
		local id = HttpService:GenerateGUID(false)
		Invites[id] = { from = sender.UserId, to = targetUserId, expires = now + INVITE_TTL }
		CreateInvite:FireClient(target, id, Invites[id])
		task.delay(INVITE_TTL, function() Invites[id] = nil end)
		return true
	end

	local inviteId = HttpService:GenerateGUID(false)
	local resolved = false
	locateCallbacks[inviteId] = function(foundData)
		resolved = true
		local ch       = getChannel(sender)
		local rebirth  = ch and ch:Get("Rebirth") or 0
		local Bases    = require(ReplicatedStorage.Datas.Bases)
		local baseData = Bases[rebirth] or Bases[0]
		if _G.MessagingHub then
			_G.MessagingHub.Publish("Trade_Invite", {
				action       = "invite",
				inviteId     = inviteId,
				senderUserId = sender.UserId,
				senderName   = sender.Name,
				targetUserId = targetUserId,
				fromJobId    = game.JobId,
				maxSlots     = baseData.MaxAnimals,
			})
		end
		NotificationService.Success(sender, "Invite de trade envoyée !")
	end
	if not _G.MessagingHub then
		warn("[TradeService] MessagingHub non disponible")
		NotificationService.Error(sender, "Impossible de localiser le joueur.")
		locateCallbacks[inviteId] = nil
		return false
	end
	_G.MessagingHub.Publish("Trade_Locate", {
		inviteId     = inviteId,
		senderUserId = sender.UserId,
		senderName   = sender.Name,
		targetUserId = targetUserId,
	})
	task.delay(6, function()
		if not resolved then
			locateCallbacks[inviteId] = nil
			NotificationService.Error(sender, "Joueur introuvable ou hors ligne.")
		end
	end)
	return true
end

-- ─── AcceptInvite ─────────────────────────────────────────────────────────────

AcceptInvite.OnServerInvoke = function(player, inviteId)
	local invite = Invites[inviteId]
	if invite then
		if invite.to ~= player.UserId then return false, "Invalid invite." end
		local sender = playerById(invite.from)
		if not sender then return false, "Player left." end
		createTrade(sender, player)
		Invites[inviteId] = nil
		return true
	end

	local crossInvite = CrossInvites[inviteId]
	if crossInvite then
		if crossInvite.to ~= player.UserId then return false, "Invalid invite." end
		if workspace:GetServerTimeNow() > crossInvite.expires then
			CrossInvites[inviteId] = nil
			return false, "Invite expired."
		end
		if InTrade[player.UserId] or InCrossTrade[player.UserId] then
			return false, "Already in a trade."
		end
		local tradeId    = HttpService:GenerateGUID(false)
		local localEntry = buildEntry(player)
		local ct = {
			tradeId      = tradeId,
			localUserId  = player.UserId,
			remoteUserId = crossInvite.from,
			localSlot    = 2,
			remoteSlot   = 1,
			isMaster     = false,
			remoteJobId  = crossInvite.fromJobId,
			playerData   = {
				[1] = {
					username   = crossInvite.fromName or "?",
					userId     = crossInvite.from,
					ready      = false,
					readyTime  = 0,
					accepted   = false,
					offer      = { brainrots = {} },
					maxSlots   = 8,
					emptySlots = 0,
				},
				[2] = localEntry,
			},
			lastChange   = workspace:GetServerTimeNow(),
			isProcessing = false,
		}
		CrossTrades[tradeId]        = ct
		InCrossTrade[player.UserId] = tradeId
		CrossInvites[inviteId]      = nil
		if _G.MessagingHub then
			_G.MessagingHub.Publish("Trade_Response", {
				action           = "accepted",
				tradeId          = tradeId,
				senderUserId     = crossInvite.from,
				targetUserId     = player.UserId,
				targetName       = player.Name,
				targetJobId      = game.JobId,
				targetMaxSlots   = localEntry.maxSlots,
				targetEmptySlots = localEntry.emptySlots,
			})
		end
		syncCrossTrade(ct)
		return true
	end
	return false, "Invite not found."
end

-- ─── DeclineInvite ────────────────────────────────────────────────────────────

DeclineInvite.OnServerEvent:Connect(function(player, id)
	local invite = Invites[id]
	if invite and invite.to == player.UserId then
		Invites[id] = nil
		return
	end
	local crossInvite = CrossInvites[id]
	if crossInvite and crossInvite.to == player.UserId then
		CrossInvites[id] = nil
		if _G.MessagingHub then
			_G.MessagingHub.Publish("Trade_Invite", {
				action       = "decline",
				inviteId     = id,
				senderUserId = crossInvite.from,
				targetName   = player.Name,
			})
		end
	end
end)

-- ─── SearchUser ───────────────────────────────────────────────────────────────

SearchUser.OnServerInvoke = function(_, userId)
	local p         = playerById(userId)
	local inGame    = p ~= nil
	if not inGame then
		local ok, info = pcall(function()
			return game:GetService("Players"):GetNameFromUserIdAsync(userId)
		end)
		if ok and info then inGame = true end
	end
	local canInvite = not InTrade[userId] and not InCrossTrade[userId]
	return true, inGame, canInvite
end

-- ─── AddBrainrot (sans limite) ────────────────────────────────────────────────

AddBrainrot.OnServerInvoke = function(player, index)
	if not checkBrainrotCooldown(player) then
		NotificationService.Error(player, "Please wait before adding another brainrot")
		return false
	end
	if isAnimalBeingStolen(player.UserId, index) then
		NotificationService.Error(player, "Cet animal est en train d'être volé.")
		return false
	end
	local pods   = getPodiums(player)
	local animal = pods[index]
	if not animal or animal == "Empty" then return false, "No animal." end

	local tradeId = InTrade[player.UserId]
	if tradeId then
		local trade = Trades[tradeId]
		if not trade then return false end
		local slot  = getSlot(trade, player.UserId)
		local offer = trade.playerData[slot].offer
		-- AUCUNE LIMITE
		table.insert(offer.brainrots, {
			IndexOnPlot = index,
			Index       = animal.Index,
			Mutation    = animal.Mutation,
			Traits      = animal.Traits,
			UUID        = animal.UUID,
		})
		trade.lastChange = workspace:GetServerTimeNow()
		resetReadyState(trade.playerData)
		syncTrade(trade)
		return true
	end

	local ctId = InCrossTrade[player.UserId]
	if ctId then
		local ct    = CrossTrades[ctId]
		if not ct then return false end
		local offer = ct.playerData[ct.localSlot].offer
		table.insert(offer.brainrots, {
			IndexOnPlot = index,
			Index       = animal.Index,
			Mutation    = animal.Mutation,
			Traits      = animal.Traits,
			UUID        = animal.UUID,
		})
		ct.lastChange = workspace:GetServerTimeNow()
		resetReadyState(ct.playerData)
		syncCrossTrade(ct)
		return true
	end
	return false
end

-- ─── RemoveBrainrot ───────────────────────────────────────────────────────────

RemoveBrainrot.OnServerInvoke = function(player, index)
	if not checkBrainrotCooldown(player) then
		NotificationService.Error(player, "Please wait before removing another brainrot")
		return false
	end
	local tradeId = InTrade[player.UserId]
	if tradeId then
		local trade = Trades[tradeId]
		if not trade then return false end
		local slot  = getSlot(trade, player.UserId)
		local offer = trade.playerData[slot].offer
		for i, item in ipairs(offer.brainrots) do
			if item.IndexOnPlot == index then
				table.remove(offer.brainrots, i)
				trade.lastChange = workspace:GetServerTimeNow()
				resetReadyState(trade.playerData)
				syncTrade(trade)
				return true
			end
		end
		return false
	end
	local ctId = InCrossTrade[player.UserId]
	if ctId then
		local ct    = CrossTrades[ctId]
		if not ct then return false end
		local offer = ct.playerData[ct.localSlot].offer
		for i, item in ipairs(offer.brainrots) do
			if item.IndexOnPlot == index then
				table.remove(offer.brainrots, i)
				ct.lastChange = workspace:GetServerTimeNow()
				resetReadyState(ct.playerData)
				syncCrossTrade(ct)
				return true
			end
		end
		return false
	end
	return false
end

-- ─── ReadyRemote (avec lastChange) ────────────────────────────────────────────

ReadyRemote.OnServerEvent:Connect(function(player)
	local id = InTrade[player.UserId]
	if id then
		local trade = Trades[id]
		if not trade then return end
		local slot = getSlot(trade, player.UserId)
		local pd   = trade.playerData[slot]
		if pd.ready then return end
		pd.ready     = true
		pd.accepted  = false
		pd.readyTime = workspace:GetServerTimeNow()
		trade.lastChange = workspace:GetServerTimeNow()
		syncTrade(trade)
		return
	end
	local ctId = InCrossTrade[player.UserId]
	if ctId then
		local ct = CrossTrades[ctId]
		if not ct then return end
		local pd = ct.playerData[ct.localSlot]
		if pd.ready then return end
		pd.ready     = true
		pd.accepted  = false
		pd.readyTime = workspace:GetServerTimeNow()
		ct.lastChange = workspace:GetServerTimeNow()
		syncCrossTrade(ct)
	end
end)

-- ─── AcceptRemote (avec copie et lastChange) ──────────────────────────────────

AcceptRemote.OnServerEvent:Connect(function(player)
	-- LOCAL
	local id = InTrade[player.UserId]
	if id then
		local trade = Trades[id]
		if not trade or trade.isProcessing then return end
		local slot = getSlot(trade, player.UserId)
		local pd   = trade.playerData[slot]
		if not pd.ready then return end
		local elapsed = workspace:GetServerTimeNow() - pd.readyTime
		if elapsed < READY_DELAY then
			NotificationService.Error(player, "Please wait " .. math.ceil(READY_DELAY - elapsed) .. "s before accepting")
			return
		end
		trade.playerData[slot].accepted = true
		trade.lastChange = workspace:GetServerTimeNow()
		-- Copie superficielle pour forcer la réplication
		trade.playerData = { [1] = trade.playerData[1], [2] = trade.playerData[2] }

		-- Vérifier si les deux ont accepté
		for _, p in pairs(trade.playerData) do
			if not p.accepted then
				syncTrade(trade)
				return
			end
		end

		trade.isProcessing = true
		syncTrade(trade)

		task.spawn(function()
			local snaps = {}
			for s, uid in pairs(trade.users) do
				snaps[s] = getPodiums(playerById(uid))
			end
			for s, uid in pairs(trade.users) do
				for _, item in ipairs(trade.playerData[s].offer.brainrots) do
					local animal = snaps[s][item.IndexOnPlot]
					if not animal or animal == "Empty" or isAnimalBeingStolen(uid, item.IndexOnPlot) then
						for _, cancelUid in pairs(trade.users) do
							local p = playerById(cancelUid)
							if p then NotificationService.Error(p, "Trade annulé : un animal était indisponible.") end
						end
						trade.isProcessing = false
						cancelTrade(id)
						return
					end
				end
			end
			local giving = { [1] = {}, [2] = {} }
			for s, uid in pairs(trade.users) do
				local plot        = _G.playerPlots[uid]
				local plotChannel = plot and Synchronizer:Get(plot.Name)
				for _, item in ipairs(trade.playerData[s].offer.brainrots) do
					table.insert(giving[s], snaps[s][item.IndexOnPlot])
					if plotChannel then
						plotChannel:Set(string.format("AnimalList.%d.Machine", item.IndexOnPlot), { Type = "Trade", Active = true })
					end
					snaps[s][item.IndexOnPlot] = "Empty"
				end
			end
			for s, uid in pairs(trade.users) do
				local p    = playerById(uid)
				local ch   = getChannel(p)
				local pods = snaps[s]
				local maxSlots = #pods
				for _, animal in ipairs(giving[s == 1 and 2 or 1]) do
					if animal and type(animal) == "table" then
						animal.Machine = nil
						animal.Steal   = nil
						animal.Stolen  = nil
						local inserted = false
						for i = 1, maxSlots do
							if pods[i] == "Empty" or pods[i] == nil then
								pods[i] = animal
								inserted = true
								break
							end
						end
						if not inserted then
							warn("[TradeService] Impossible d'insérer un animal, pods pleins pour userId:", uid)
						end
					end
				end
				ch:Set("AnimalPodiums", pods)
				ch:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
			end
			for slot, uid in pairs(trade.users) do
				local p = playerById(uid)
				if p then
					local otherPlayer = playerById(trade.users[slot == 1 and 2 or 1])
					if otherPlayer then
						NotificationService.Success(p, ("Trade avec @%s complété ! 🎉"):format(otherPlayer.Name))
					end
					TradeCompleted:FireClient(p)
				end
			end
			cancelTrade(id)
		end)
		return
	end

	-- CROSS
	local ctId = InCrossTrade[player.UserId]
	if not ctId then return end
	local ct = CrossTrades[ctId]
	if not ct or ct.isProcessing then return end
	local pd = ct.playerData[ct.localSlot]
	if not pd.ready then return end
	local elapsed = workspace:GetServerTimeNow() - pd.readyTime
	if elapsed < READY_DELAY then
		NotificationService.Error(player, "Please wait " .. math.ceil(READY_DELAY - elapsed) .. "s before accepting")
		return
	end
	pd.accepted = true
	ct.lastChange = workspace:GetServerTimeNow()
	ct.playerData = { [1] = ct.playerData[1], [2] = ct.playerData[2] }
	syncCrossTrade(ct)

	if not ct.isMaster then
		return
	end

	print("[TradeService] AcceptRemote: A est maître, début du handshake")
	ct.isProcessing = true
	syncCrossTrade(ct)

	task.spawn(function()
		local localPods = getPodiums(player)
		local offerA    = ct.playerData[ct.localSlot].offer.brainrots
		local animalsToB = {}
		for _, item in ipairs(offerA) do
			local animal = localPods[item.IndexOnPlot]
			if not animal or animal == "Empty" or isAnimalBeingStolen(ct.localUserId, item.IndexOnPlot) then
				NotificationService.Error(player, "Trade annulé : un de tes animaux est indisponible.")
				cancelCrossTrade(ct, "Trade annulé par le serveur maître.", false)
				return
			end
			table.insert(animalsToB, {
				Index       = animal.Index,
				Mutation    = animal.Mutation,
				Traits      = animal.Traits,
				UUID        = animal.UUID,
				LastCollect = workspace:GetServerTimeNow(),
			})
		end
		local prepareOk = false
		local animalsToA = {}
		prepareCallbacks[ct.tradeId] = function(success, animals, reason)
			prepareOk  = success
			animalsToA = animals or {}
			if not success then warn("[TradeService] B not ready:", reason) end
		end
		if _G.MessagingHub then
			_G.MessagingHub.Publish("Trade_Commit", {
				action       = "prepare",
				tradeId      = ct.tradeId,
				targetUserId = ct.remoteUserId,
			})
		end
		local timeout = os.clock() + 10
		while prepareCallbacks[ct.tradeId] and os.clock() < timeout do
			task.wait(0.1)
		end
		if not prepareOk then
			NotificationService.Error(player, "Trade annulé : l'autre joueur n'a pas pu valider.")
			ct.isProcessing = false
			cancelCrossTrade(ct, "Trade annulé : validation échouée.", false)
			return
		end
		for _, item in ipairs(offerA) do
			localPods[item.IndexOnPlot] = "Empty"
		end
		local maxSlotsA = #localPods
		for _, animal in ipairs(animalsToA) do
			if animal and type(animal) == "table" then
				animal.Machine = nil
				animal.Steal   = nil
				animal.Stolen  = nil
				local inserted = false
				for i = 1, maxSlotsA do
					if localPods[i] == "Empty" or localPods[i] == nil then
						localPods[i] = animal
						inserted = true
						break
					end
				end
				if not inserted then
					warn("[TradeService] Cross A: impossible d'insérer un animal, pods pleins")
				end
			end
		end
		local ch = getChannel(player)
		ch:Set("AnimalPodiums", localPods)
		ch:Set("AnimalAddedOrRemoved", workspace:GetServerTimeNow())
		if _G.MessagingHub then
			_G.MessagingHub.Publish("Trade_Commit", {
				action       = "execute",
				tradeId      = ct.tradeId,
				targetUserId = ct.remoteUserId,
				animalsToB   = animalsToB,
				remoteName   = player.Name,
			})
		end
		NotificationService.Success(player, ("Trade avec @%s complété ! 🎉"):format(ct.playerData[ct.remoteSlot].username or "?"))
		TradeCompleted:FireClient(player)
		InCrossTrade[ct.localUserId] = nil
		CrossTrades[ctId]            = nil
		clearTradeUI(ct.localUserId)
	end)
end)

-- ─── CancelTrade ──────────────────────────────────────────────────────────────

CancelTrade.OnServerEvent:Connect(function(player)
	local id = InTrade[player.UserId]
	if id then
		cancelTrade(id, player.UserId)
		return
	end
	local ctId = InCrossTrade[player.UserId]
	if ctId then
		local ct = CrossTrades[ctId]
		if ct then
			cancelCrossTrade(ct, ("@%s a annulé le trade."):format(player.Name), false)
		end
		NotificationService.Error(player, "Trade annulé.")
	end
end)

-- ─── PlayerRemoving ───────────────────────────────────────────────────────────

Players.PlayerRemoving:Connect(function(player)
	local id = InTrade[player.UserId]
	if id then cancelTrade(id) end
	local ctId = InCrossTrade[player.UserId]
	if ctId then
		local ct = CrossTrades[ctId]
		if ct then
			cancelCrossTrade(ct, ("@%s a quitté le jeu."):format(player.Name), false)
		end
	end
end)

-- Retarder les abonnements MessagingService pour éviter le lag au démarrage
task.delay(4, function()
	print("[TradeService] Setting up MessagingService subscriptions...")
	setupMessagingSubscriptions()
	print("[TradeService] MessagingService subscriptions ready")
end)

return TradeService