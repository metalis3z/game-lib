local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MessagingService = require(game:GetService("ServerScriptService").Services.MessagingService)
local MemoryStoreService = game:GetService("MemoryStoreService")

local Net = require(ReplicatedStorage.Packages.Net)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Bases = require(ReplicatedStorage.Datas.Bases)
local AnimalsData = require(ReplicatedStorage.Datas.Animals)
local NotificationService = require(game:GetService("ServerScriptService").Services.NotificationService)
local ReplicatorServer = require(ReplicatedStorage.Packages.ReplicatorServer)
local Chat = game:GetService("Chat")
local TextService = game:GetService("TextService")
local BaseSkins = require(ReplicatedStorage.Shared.BaseSkins)
local Gears = require(ReplicatedStorage.Shared.Gears)
local TradingFlags = require(ReplicatedStorage.Shared.Flags.TradingFlags)

local RemoteCreateInvite = Net:RemoteEvent("TradeService/CreateInvite")
local RemoteDeclineInvite = Net:RemoteEvent("TradeService/DeclineInvite")
local RemoteAcceptInvite = Net:RemoteFunction("TradeService/AcceptInvite")
local RemoteSearchUser = Net:RemoteFunction("TradeService/SearchUser")
local RemoteInvite = Net:RemoteFunction("TradeService/Invite")
local RemoteCancelTrade = Net:RemoteEvent("TradeService/CancelTrade")
local RemoteAddBrainrot = Net:RemoteFunction("TradeService/AddBrainrot")
local RemoteRemoveBrainrot = Net:RemoteFunction("TradeService/RemoveBrainrot")
local RemoteTradeCompleted = Net:RemoteEvent("TradeService/TradeCompleted")
local RemoteReady = Net:RemoteEvent("TradeService/Ready")
local RemoteAccept = Net:RemoteEvent("TradeService/Accept")
local RemoteTradeNotification = Net:RemoteEvent("TradeService/TradeNotification")
local RemoteGetPresenceBatch = Net:RemoteFunction("TradeService/GetPresenceBatch")
local RemoteSetSignText = Net:RemoteEvent("TradeService/SetSignText")
local RemoteSendChatMessage = Net:RemoteEvent("TradeService/SendChatMessage")
local RemoteAddItem = Net:RemoteFunction("TradeService/AddItem")
local RemoteRemoveItem = Net:RemoteFunction("TradeService/RemoveItem")
local RemoteGetTradeHistory = Net:RemoteFunction("TradeService/GetTradeHistory")
local RemoteHistoryUpdated = Net:RemoteEvent("TradeService/HistoryUpdated")

local INVITE_DURATION = 30
local LOCK_DURATION = 5
local ACCEPT_LOCK_DURATION = 5
local MAX_BRAINROTS_PER_OFFER = 999
local BRAINROT_ADD_COOLDOWN = 2
local BRAINROT_REMOVE_COOLDOWN = 2
local INVITE_SEND_COOLDOWN = 5
local SIGN_MAX_LENGTH = 100
local CHAT_MAX_LENGTH = 200
local CHAT_MAX_MESSAGES = 50
local CHAT_COOLDOWN = 0.5
local ITEM_ADD_COOLDOWN = 1
local ITEM_REMOVE_COOLDOWN = 1
local MAX_ITEMS_PER_OFFER = 50

local CROSS_SERVER_TOPIC = "TradeService/CrossServer"

local TradePresenceMap = MemoryStoreService:GetHashMap("TradeService/Presence/v1")
local TradeMorphMap = MemoryStoreService:GetHashMap("TradeService/Morph/v1")

local PRESENCE_TTL = 90
local PRESENCE_REFRESH = 30
local PRESENCE_LOOKUP_CACHE_TTL = 8

local activeInvites = {}
local activeTrades = {}
local brainrotCooldowns = {}
local brainrotRemoveCooldowns = {}
local inviteSendCooldowns = {}
local chatCooldowns = {}
local itemAddCooldowns = {}
local itemRemoveCooldowns = {}

local function getData(player)
	return Synchronizer:Get(player)
end

local function getActiveTradeFilter(player)
	if not player then return nil end
	local data = getData(player)
	if not data then return nil end
	if data:Get("Settings.Only Receive Trades With") ~= true then return nil end
	local set = data:Get("TradeFilterBrainrots")
	if typeof(set) ~= "table" then return nil end
	for _ in set do return set end
	return nil
end

local function offerHasWanted(filterSet, brainrots)
	if not filterSet then return true end
	if typeof(brainrots) ~= "table" then return false end
	for _, entry in brainrots do
		if type(entry) == "table" and entry.Index and filterSet[entry.Index] then return true end
	end
	return false
end

local function getPlayerDisplayInfo(player)
	if not player then return nil, nil end
	local morphedUserId   = player:GetAttribute("MorphedUserId")
	local morphedUsername = player:GetAttribute("MorphedUsername")
	local customName      = player:GetAttribute("CustomName")

	local displayName = (typeof(morphedUsername) == "string" and #morphedUsername > 0 and morphedUsername)
		or (typeof(customName) == "string" and #customName > 0 and customName)
		or player.Name
	local displayUserId = (typeof(morphedUserId) == "number" and morphedUserId) or player.UserId
	return displayName, displayUserId
end

local function getPlayerBase(player)
	local data = getData(player)
	if not data then return nil end
	local rebirthKey = data:Get("Rebirth")
	return rebirthKey and Bases[rebirthKey] or nil
end

local function getPlayerPodiums(player)
	local data = getData(player)
	if not data then return nil end
	return data:Get("AnimalPodiums")
end

local function getMaxSlots(player)
	local base = getPlayerBase(player)
	return base and base.MaxAnimals or 50
end

local function getReceiveTradesSetting(player)
	local data = getData(player)
	if not data then return "Everyone" end
	local settings = data:Get("Settings")
	return (settings and settings["Receive Trades from"]) or "Everyone"
end

local function canReceiveTrade(targetPlayer, senderUserId)
	local setting = getReceiveTradesSetting(targetPlayer)
	if setting == "No one" then
		return false, "That player is not accepting trades."
	end
	if setting == "Friends" then
		local ok, isFriend = pcall(function()
			return targetPlayer:IsFriendsWith(senderUserId)
		end)
		if not ok or not isFriend then
			return false, "That player only accepts trades from friends."
		end
	end
	return true
end

local function countOccupiedSlots(podiums, maxAnimals)
	local count = 0
	if not podiums then return 0 end
	for i = 1, maxAnimals do
		local slot = podiums[i]
		if slot ~= nil and slot ~= "Empty" then
			count += 1
		end
	end
	return count
end

local function getEmptySlots(player)
	local base = getPlayerBase(player)
	if not base then return 0, 0 end
	local maxAnimals = base.MaxAnimals
	local podiums = getPlayerPodiums(player)
	local occupied = countOccupiedSlots(podiums, maxAnimals)
	return maxAnimals - occupied, maxAnimals
end

local function isPlayerInTrade(player)
	for tradeId, trade in activeTrades do
		for _, userId in trade.users do
			if userId == player.UserId then
				return true, tradeId, trade
			end
		end
	end
	return false, nil, nil
end

local function getTradeForPlayer(player)
	local _, tradeId, trade = isPlayerInTrade(player)
	return tradeId, trade
end

local ensureChatEligibility
local function buildClientTradeState(trade)
	return {
		tradeId = trade.tradeId,
		users = trade.users,
		players = trade.players,
		chat = trade.chat or {},
		lastChange = trade.lastChange,
		isProcessing = trade.isProcessing or false,
	}
end

local function publishTradeStateRC(trade)
	local state = buildClientTradeState(trade)
	for _, userId in trade.users do
		local p = Players:GetPlayerByUserId(userId)
		if p then
			local rep = ReplicatorServer.get("Trade_" .. userId)
			warn("[TDBG-S] publishRC -> Trade_" .. tostring(userId))
			rep:SetData({ active = { data = state } })
			rep:AddSubscriber(p)
		end
	end
end

local function clearTradeStateRC(trade)
	for _, userId in trade.users do
		local rep = ReplicatorServer.find("Trade_" .. userId)
		if rep then
			rep:SetData({ active = false })
		end
	end
end
local function broadcastTradeState(trade)
	ensureChatEligibility(trade)
	publishTradeStateRC(trade)
	for _, userId in trade.users do
		local tradePlayer = Players:GetPlayerByUserId(userId)
		if tradePlayer then
			local data = getData(tradePlayer)
			if data then
				data:Set("ActiveTrade", {
					tradeId = trade.tradeId,
					users = trade.users,
					players = trade.players,
					lastChange = trade.lastChange,
					isProcessing = trade.isProcessing or false,
				})
			end
		end
	end
end

local function clearTradeState(trade)
	clearTradeStateRC(trade)
	for _, userId in trade.users do
		local tradePlayer = Players:GetPlayerByUserId(userId)
		if tradePlayer then
			local data = getData(tradePlayer)
			if data then
				data:Set("ActiveTrade", nil)
			end
		end
	end
end

local function computeCanChat(userIdA, userIdB)
	local ok, result = pcall(function()
		return Chat:CanUsersChatAsync(userIdA, userIdB)
	end)
	if not ok then return true end
	return result == true
end

function ensureChatEligibility(trade)
	if trade._chatChecked then return end
	trade._chatChecked = true
	task.spawn(function()
		local cc = computeCanChat(trade.users[1], trade.users[2])
		for _, pd in trade.players do
			pd.canChat = cc
		end
		broadcastTradeState(trade)
	end)
end

local function getOtherUsername(trade, userId)
	for index, uid in trade.users do
		if uid ~= userId then
			return trade.players[index] and trade.players[index].username or "???"
		end
	end
	return "???"
end

local function processPlayerTrade(userId, giveOffer, receiveOffer, partnerUsername, partnerUserId)
	local p = Players:GetPlayerByUserId(userId)
	if not p then return end
	pcall(function()
		local data = getData(p)
		if not data then return end
		local ts = workspace:GetServerTimeNow()

		local podiums = data:Get("AnimalPodiums")
		if podiums then
			local maxSlots = getMaxSlots(p)
			for _, entry in (giveOffer.brainrots or {}) do
				podiums[entry.IndexOnPlot] = "Empty"
			end
			for _, entry in (receiveOffer.brainrots or {}) do
				for i = 1, maxSlots do
					local slot = podiums[i]
					if slot == nil or slot == "Empty" then
						local animalInfo = AnimalsData[entry.Index]
						podiums[i] = {
							UUID = entry.UUID, Index = entry.Index, Mutation = entry.Mutation,
							Traits = entry.Traits, LastCollect = ts,
							Timer = (animalInfo and animalInfo.LuckyBlock) and 0 or nil,
						}
						break
					end
				end
			end
			data:Set("AnimalPodiums", podiums)
			data:Set("AnimalAddedOrRemoved", ts)
		end

		for _, entry in (giveOffer.baseSkins or {}) do
			if typeof(entry) == "table" and typeof(entry.UUID) == "string" then
				if typeof(data:Get("BaseSkinInventory." .. entry.UUID)) == "table" then
					data:RemoveFromDictionary("BaseSkinInventory", entry.UUID)
				end
			end
		end
		for _, entry in (receiveOffer.baseSkins or {}) do
			if typeof(entry) == "table" and typeof(entry.SkinName) == "string" then
				BaseSkins.Grant(data, entry.SkinName, "Trade")
			end
		end

		for _, entry in (giveOffer.gears or {}) do
			if typeof(entry) == "table" then
				Gears.Escrow(data, entry)
			end
		end
		for _, entry in (receiveOffer.gears or {}) do
			if typeof(entry) == "table" and typeof(entry.GearName) == "string" then
				Gears.Grant(data, entry.GearName, "Trade")
			end
		end

		local record = {
			otherUsername = partnerUsername,
			otherUserId = partnerUserId,
			time = os.time(),
			you = { brainrots = giveOffer.brainrots or {}, baseSkins = giveOffer.baseSkins or {}, gears = giveOffer.gears or {} },
			other = { brainrots = receiveOffer.brainrots or {}, baseSkins = receiveOffer.baseSkins or {}, gears = receiveOffer.gears or {} },
		}
		local history = data:Get("TradeHistory")
		if typeof(history) ~= "table" then history = {} end
		table.insert(history, 1, record)
		while #history > 50 do table.remove(history) end
		data:Set("TradeHistory", history)

		RemoteTradeCompleted:FireClient(p)
		RemoteHistoryUpdated:FireClient(p, record)
	end)
end

local function publishCrossServerMessage(messageType, targetJobId, data)
	local payload = {
		type = messageType,
		senderJobId = game.JobId,
		targetJobId = targetJobId,
	}
	for k, v in data do
		payload[k] = v
	end
	if not MessagingService:PublishAsync(CROSS_SERVER_TOPIC, payload, targetJobId) then
		error("MessagingService rejected publish (payload too large, unknown target, or shutting down)")
	end
end

local function publishCrossServerAction(trade, action, extra)
	if not trade.crossServer then return end
	local otherJobId = nil
	for _, jobId in ipairs(trade.jobIds) do
		if jobId ~= game.JobId then
			otherJobId = jobId
			break
		end
	end
	if not otherJobId then return end
	local payload = {
		type = "trade",
		action = action,
		tradeId = trade.tradeId,
		senderJobId = game.JobId,
		targetJobId = otherJobId,
	}
	if extra then
		for k, v in extra do
			payload[k] = v
		end
	end
	pcall(MessagingService.PublishAsync, MessagingService, CROSS_SERVER_TOPIC, payload, otherJobId)
end

local function cancelTrade(tradeId, trade, cancellerName, skipSync)
	if not trade then return end
	if cancellerName then
		for _, userId in trade.users do
			local p = Players:GetPlayerByUserId(userId)
			if p then
				RemoteTradeNotification:FireClient(p, "canceled", cancellerName)
			end
		end
		if not skipSync then
			publishCrossServerAction(trade, "cancel", { cancellerName = cancellerName })
		end
	end
	clearTradeState(trade)
	activeTrades[tradeId] = nil
end

local TradeService = {}

local presenceCache = {}

local function fetchPresenceFromStore(userId)
	local key = tostring(userId)
	local ok, value = pcall(function()
		return TradePresenceMap:GetAsync(key)
	end)

	if ok and typeof(value) == "table" then
		local result = {
			jobId = value.jobId,
			displayName = value.displayName,
			displayUserId = value.displayUserId,
			fetchedAt = os.clock(),
		}
		presenceCache[userId] = result
		return result
	else
		presenceCache[userId] = { negative = true, fetchedAt = os.clock() }
		return nil
	end
end

local NEG_CACHE_TTL = 4

local function getPresence(userId)
	local cached = presenceCache[userId]
	if cached ~= nil then
		if typeof(cached) == "table" and cached.negative then
			if os.clock() - cached.fetchedAt < NEG_CACHE_TTL then
				return nil
			end
		elseif typeof(cached) == "table" and cached.jobId then
			if os.clock() - cached.fetchedAt < PRESENCE_LOOKUP_CACHE_TTL then
				return cached
			end
		end
	end
	return fetchPresenceFromStore(userId)
end

local function writePresence(player)
	local userId = player.UserId
	local displayName, displayUserId = getPlayerDisplayInfo(player)
	local payload = {
		jobId = game.JobId,
		displayName = displayName,
		displayUserId = displayUserId,
	}
	pcall(function()
		TradePresenceMap:SetAsync(tostring(userId), payload, PRESENCE_TTL)
	end)
	if displayUserId ~= userId then
		pcall(function()
			TradeMorphMap:SetAsync(tostring(displayUserId), {
				realUserId = userId,
				jobId = game.JobId,
				displayName = displayName,
			}, PRESENCE_TTL)
		end)
	end
end

local function clearPresence(player)
	local userId = player.UserId
	local _, displayUserId = getPlayerDisplayInfo(player)
	pcall(function()
		TradePresenceMap:RemoveAsync(tostring(userId))
	end)
	if displayUserId ~= userId then
		pcall(function()
			TradeMorphMap:RemoveAsync(tostring(displayUserId))
		end)
	end
	presenceCache[userId] = nil
end

local function getMorphIndirection(targetUserId)
	local cacheKey = -targetUserId
	local cached = presenceCache[cacheKey]
	if cached ~= nil then
		if typeof(cached) == "table" and cached.negative then
			if os.clock() - cached.fetchedAt < NEG_CACHE_TTL then
				return nil
			end
		elseif typeof(cached) == "table" and cached.realUserId then
			if os.clock() - cached.fetchedAt < PRESENCE_LOOKUP_CACHE_TTL then
				return cached
			end
		end
	end
	local ok, value = pcall(function()
		return TradeMorphMap:GetAsync(tostring(targetUserId))
	end)
	if ok and typeof(value) == "table" and typeof(value.realUserId) == "number" then
		local result = {
			realUserId = value.realUserId,
			jobId = value.jobId,
			displayName = value.displayName,
			fetchedAt = os.clock(),
		}
		presenceCache[cacheKey] = result
		return result
	end
	presenceCache[cacheKey] = { negative = true, fetchedAt = os.clock() }
	return nil
end

function TradeService:Start()
	local subscribeConnection
	task.spawn(function()
		local attempt = 0
		while not subscribeConnection do
			attempt += 1
			local ok, result = pcall(function()
				return MessagingService:SubscribeAsync(CROSS_SERVER_TOPIC, function(payload)
					local data = payload

					if data.type == "presence" then
						return
					end

					if data.type == "invite" then
						if data.targetJobId ~= game.JobId then return end

						local targetPlayer = Players:GetPlayerByUserId(data.to)
						if not targetPlayer then return end

						local canTrade = canReceiveTrade(targetPlayer, data.from)
						if not canTrade then
							warn(("[TradeService] Cross-server invite from %s to %s blocked by target's privacy settings"):format(tostring(data.from), tostring(data.to)))
							return
						end

						local inviteId = data.inviteId
						local expiresAt = data.expires

						activeInvites[inviteId] = {
							id = inviteId,
							from = data.from,
							to = data.to,
							expires = expiresAt,
							crossServer = true,
							senderName = data.senderName,
							senderJobId = data.senderJobId,
							senderDisplayName = data.senderDisplayName,
							senderDisplayUserId = data.senderDisplayUserId,
						}

						RemoteCreateInvite:FireClient(targetPlayer, inviteId, {
							from = data.from,
							expires = expiresAt,
							senderName = data.senderName,
							senderDisplayName = data.senderDisplayName,
							senderDisplayUserId = data.senderDisplayUserId,
						})

						task.delay(INVITE_DURATION, function()
							if activeInvites[inviteId] then
								activeInvites[inviteId] = nil
							end
						end)
						return
					end

					if data.type == "trade" then
						if data.senderJobId == game.JobId then return end
						if data.targetJobId ~= game.JobId then return end

						if data.action == "create" then
							local trade = {
								tradeId = data.tradeId,
								users = data.users,
								players = data.players,
								lastChange = data.lastChange,
								isProcessing = false,
								crossServer = true,
								jobIds = data.jobIds,
							}
							for index, userId in ipairs(trade.users) do
								local p = Players:GetPlayerByUserId(userId)
								if p then
									local emptySlots, maxSlots = getEmptySlots(p)
									trade.players[index].emptySlots = emptySlots
									trade.players[index].maxSlots = maxSlots
									local dName, dId = getPlayerDisplayInfo(p)
									trade.players[index].username = dName
									trade.players[index].displayUserId = dId
									trade.players[index].realUsername = p.Name
									publishCrossServerAction(trade, "slot_update", {
										playerIndex = index,
										emptySlots = emptySlots,
										maxSlots = maxSlots,
										username = dName,
										displayUserId = dId,
										realUsername = p.Name,
									})
									break
								end
							end
							activeTrades[data.tradeId] = trade
							broadcastTradeState(trade)

						elseif data.action == "slot_update" then
							local trade = activeTrades[data.tradeId]
							if not trade then return end
							local pd = trade.players[data.playerIndex]
							if pd then
								pd.emptySlots = data.emptySlots
								pd.maxSlots = data.maxSlots
								if data.username then pd.username = data.username end
								if data.displayUserId then pd.displayUserId = data.displayUserId end
								if data.realUsername then pd.realUsername = data.realUsername end
							end
							broadcastTradeState(trade)

						elseif data.action == "add_brainrot" then
							local trade = activeTrades[data.tradeId]
							if not trade then return end
							local offer = trade.players[data.playerIndex].offer.brainrots
							local exists = false
							for _, e in offer do
								if e.IndexOnPlot == data.entry.IndexOnPlot then
									exists = true
									break
								end
							end
							if not exists then
								table.insert(offer, data.entry)
							end
							trade.lastChange = data.lastChange
							local pd = trade.players[data.playerIndex]
							if pd then
								pd.ready = false
								pd.accepted = false
							end
							broadcastTradeState(trade)

						elseif data.action == "remove_brainrot" then
							local trade = activeTrades[data.tradeId]
							if not trade then return end
							local offer = trade.players[data.playerIndex].offer.brainrots
							for i, e in offer do
								if e.IndexOnPlot == data.indexOnPlot then
									table.remove(offer, i)
									break
								end
							end
							trade.lastChange = data.lastChange
							local pd = trade.players[data.playerIndex]
							if pd then
								pd.ready = false
								pd.accepted = false
							end
							broadcastTradeState(trade)

						elseif data.action == "add_item" then
							local trade = activeTrades[data.tradeId]
							if not trade then return end
							local offerKey = (data.itemType == "BaseSkin" and "baseSkins") or (data.itemType == "Gear" and "gears")
							if offerKey and data.ref then
								local offer = trade.players[data.playerIndex].offer[offerKey]
								local dup = false
								for _, e in offer do
									if data.itemType == "BaseSkin" then
										if e.UUID == data.ref.UUID then dup = true break end
									else
										if (data.ref.UUID and e.UUID == data.ref.UUID) or (not data.ref.UUID and not e.UUID and e.GearName == data.ref.GearName) then dup = true break end
									end
								end
								if not dup then table.insert(offer, data.ref) end
							end
							trade.lastChange = data.lastChange
							local pd = trade.players[data.playerIndex]
							if pd then pd.ready = false pd.accepted = false end
							broadcastTradeState(trade)
						elseif data.action == "remove_item" then
							local trade = activeTrades[data.tradeId]
							if not trade then return end
							local offerKey = (data.itemType == "BaseSkin" and "baseSkins") or (data.itemType == "Gear" and "gears")
							if offerKey and data.ref then
								local offer = trade.players[data.playerIndex].offer[offerKey]
								for idx, e in offer do
									local match
									if data.itemType == "BaseSkin" then
										match = e.UUID == data.ref.UUID
									else
										match = (data.ref.UUID and e.UUID == data.ref.UUID) or (not data.ref.UUID and not e.UUID and e.GearName == data.ref.GearName)
									end
									if match then table.remove(offer, idx) break end
								end
							end
							trade.lastChange = data.lastChange
							local pd = trade.players[data.playerIndex]
							if pd then pd.ready = false pd.accepted = false end
							broadcastTradeState(trade)
						elseif data.action == "chat" then
							local trade = activeTrades[data.tradeId]
							if not trade then return end
							trade.chat = trade.chat or {}
							table.insert(trade.chat, { u = data.u, t = data.t })
							while #trade.chat > CHAT_MAX_MESSAGES do table.remove(trade.chat, 1) end
							broadcastTradeState(trade)
						elseif data.action == "ready" then
							local trade = activeTrades[data.tradeId]
							if not trade then return end
							if trade.players[data.playerIndex] then
								trade.players[data.playerIndex].ready = true
							end
							trade.lastChange = data.lastChange
							broadcastTradeState(trade)

						elseif data.action == "accept" then
							local trade = activeTrades[data.tradeId]
							if not trade then return end
							if trade.players[data.playerIndex] then
								trade.players[data.playerIndex].accepted = true
							end
							trade.lastChange = data.lastChange
							local allAccepted = true
							for _, pd in trade.players do
								if not pd.accepted then
									allAccepted = false
									break
								end
							end
							if allAccepted then
								trade.isProcessing = true
								broadcastTradeState(trade)
								local offer1 = trade.players[1].offer
								local offer2 = trade.players[2].offer
								task.spawn(function()
									task.wait(1)

									local _f1 = getActiveTradeFilter(Players:GetPlayerByUserId(trade.users[1]))
									local _f2 = getActiveTradeFilter(Players:GetPlayerByUserId(trade.users[2]))
									if (_f1 and not offerHasWanted(_f1, offer2.brainrots)) or (_f2 and not offerHasWanted(_f2, offer1.brainrots)) then
										for _, _uid in trade.users do
											local _p = Players:GetPlayerByUserId(_uid)
											if _p then NotificationService.Error(_p, "Trade cancelled: an offer didn't include a brainrot from a player's 'Only Receive Trades With' filter.") end
										end
										clearTradeState(trade)
										activeTrades[data.tradeId] = nil
										return
									end
									for _, userId in trade.users do
										local p = Players:GetPlayerByUserId(userId)
										if p then
											RemoteTradeNotification:FireClient(p, "completed", getOtherUsername(trade, userId))
										end
									end
									processPlayerTrade(trade.users[1], offer1, offer2, trade.players[2].realUsername or trade.players[2].username, trade.users[2])
									processPlayerTrade(trade.users[2], offer2, offer1, trade.players[1].realUsername or trade.players[1].username, trade.users[1])
									clearTradeState(trade)
									activeTrades[data.tradeId] = nil
								end)
							else
								broadcastTradeState(trade)
							end

						elseif data.action == "sign_text" then
							local trade = activeTrades[data.tradeId]
							if not trade then return end
							local pd = trade.players[data.playerIndex]
							if pd then
								pd.signText = data.signText
							end
							broadcastTradeState(trade)

						elseif data.action == "cancel" then
							local trade = activeTrades[data.tradeId]
							if trade then
								cancelTrade(data.tradeId, trade, data.cancellerName, true)
							end
						end
					end
				end)
			end)
			if ok then
				subscribeConnection = result
			else
				local delay = math.min(2 ^ attempt, 30)
				warn(("[TradeService] MessagingService subscribe failed (attempt %d): %s — retrying in %ds"):format(attempt, tostring(result), delay))
				task.wait(delay)
			end
		end
	end)

	local function broadcastPresence(player, online)
		if online then
			writePresence(player)
		else
			clearPresence(player)
		end
	end

	local function broadcastAllPresence()
		for _, p in Players:GetPlayers() do
			writePresence(p)
		end
	end

	local previousMorphTarget = {}
	local function setupPresenceListeners(player)
		local function refresh()
			local prev = previousMorphTarget[player]
			local _, currentDisplayId = getPlayerDisplayInfo(player)
			if prev and prev ~= player.UserId and prev ~= currentDisplayId then
				pcall(function()
					TradeMorphMap:RemoveAsync(tostring(prev))
				end)
			end
			previousMorphTarget[player] = (currentDisplayId ~= player.UserId) and currentDisplayId or nil
			writePresence(player)
		end
		player:GetAttributeChangedSignal("MorphedUserId"):Connect(refresh)
		player:GetAttributeChangedSignal("MorphedUsername"):Connect(refresh)
		player:GetAttributeChangedSignal("MorphedDisplayName"):Connect(refresh)
		player:GetAttributeChangedSignal("CustomName"):Connect(refresh)
	end

	for _, player in Players:GetPlayers() do
		setupPresenceListeners(player)
		local _, di = getPlayerDisplayInfo(player)
		if di ~= player.UserId then
			previousMorphTarget[player] = di
		end
	end

	Players.PlayerAdded:Connect(function(player)
		broadcastPresence(player, true)
		setupPresenceListeners(player)
		local _, di = getPlayerDisplayInfo(player)
		if di ~= player.UserId then
			previousMorphTarget[player] = di
		end
	end)

	Players.PlayerRemoving:Connect(function(player)
		broadcastPresence(player, false)
		previousMorphTarget[player] = nil

		activeInvites[player.UserId] = nil
		brainrotCooldowns[player.UserId] = nil
		brainrotRemoveCooldowns[player.UserId] = nil
		inviteSendCooldowns[player.UserId] = nil

		local inTrade, tradeId, trade = isPlayerInTrade(player)
		if inTrade and tradeId then
			cancelTrade(tradeId, trade, player.Name, false)
		end
	end)

	for _, p in Players:GetPlayers() do
		writePresence(p)
	end

	task.spawn(function()
		while true do
			task.wait(PRESENCE_REFRESH)
			broadcastAllPresence()
		end
	end)

	RemoteGetPresenceBatch.OnServerInvoke = function(player, userIds)
		if typeof(userIds) ~= "table" then return {} end
		local result = {}
		local MAX_BATCH = 200
		local pending = 0
		local doneEvent = Instance.new("BindableEvent")
		for i, userId in userIds do
			if i > MAX_BATCH then break end
			if typeof(userId) == "number" then
				pending += 1
				task.spawn(function()
					local presence = getPresence(userId)
					if presence and presence.jobId ~= game.JobId then
						result[tostring(userId)] = {
							online = true,
							displayName = presence.displayName,
							displayUserId = presence.displayUserId,
						}
					end
					pending -= 1
					if pending == 0 then doneEvent:Fire() end
				end)
			end
		end
		if pending > 0 then doneEvent.Event:Wait() end
		doneEvent:Destroy()
		return result
	end

	RemoteInvite.OnServerInvoke = function(sender, _guid, targetUserId)
		if typeof(targetUserId) ~= "number" then
			return false, "Invalid user."
		end

		if sender.UserId == targetUserId then
			return false, "You cannot trade with yourself."
		end

		if isPlayerInTrade(sender) then
			return false, "You are already in a trade."
		end

		local now = workspace:GetServerTimeNow()
		local lastSend = inviteSendCooldowns[sender.UserId]
		if lastSend and now - lastSend < INVITE_SEND_COOLDOWN then
			return false, "Please wait before sending another invite."
		end

		local senderDisplayName, senderDisplayUserId = getPlayerDisplayInfo(sender)

		local targetPlayer = Players:GetPlayerByUserId(targetUserId)

		if not targetPlayer then
			local presenceData = getPresence(targetUserId)
			if not presenceData then
				return false, "That player is not online."
			end

			inviteSendCooldowns[sender.UserId] = now

			local inviteId = HttpService:GenerateGUID(false)
			local expiresAt = workspace:GetServerTimeNow() + INVITE_DURATION

			activeInvites[inviteId] = {
				id = inviteId,
				from = sender.UserId,
				to = targetUserId,
				expires = expiresAt,
				crossServer = true,
				senderName = sender.Name,
				senderDisplayName = senderDisplayName,
				senderDisplayUserId = senderDisplayUserId,
				senderJobId = game.JobId,
			}

			local ok = pcall(function()
				publishCrossServerMessage("invite", presenceData.jobId, {
					inviteId = inviteId,
					from = sender.UserId,
					to = targetUserId,
					expires = expiresAt,
					senderName = sender.Name,
					senderDisplayName = senderDisplayName,
					senderDisplayUserId = senderDisplayUserId,
					senderJobId = game.JobId,
				})
			end)

			if not ok then
				activeInvites[inviteId] = nil
				inviteSendCooldowns[sender.UserId] = nil
				return false, "Failed to send cross-server invite."
			end

			task.delay(INVITE_DURATION, function()
				if activeInvites[inviteId] then
					activeInvites[inviteId] = nil
				end
			end)

			return true
		end

		if isPlayerInTrade(targetPlayer) then
			return false, "That player is already in a trade."
		end

		local canTrade, tradeErr = canReceiveTrade(targetPlayer, sender.UserId)
		if not canTrade then
			return false, tradeErr
		end

		inviteSendCooldowns[sender.UserId] = now

		local inviteId = HttpService:GenerateGUID(false)
		local expiresAt = workspace:GetServerTimeNow() + INVITE_DURATION

		activeInvites[inviteId] = {
			id = inviteId,
			from = sender.UserId,
			to = targetUserId,
			expires = expiresAt,
			senderName = sender.Name,
			senderDisplayName = senderDisplayName,
			senderDisplayUserId = senderDisplayUserId,
		}

		RemoteCreateInvite:FireClient(targetPlayer, inviteId, {
			from = sender.UserId,
			expires = expiresAt,
			senderName = sender.Name,
			senderDisplayName = senderDisplayName,
			senderDisplayUserId = senderDisplayUserId,
		})

		task.delay(INVITE_DURATION, function()
			if activeInvites[inviteId] then
				activeInvites[inviteId] = nil
			end
		end)

		return true
	end

	RemoteAcceptInvite.OnServerInvoke = function(accepter, _guid, inviteId)
		if typeof(inviteId) ~= "string" then
			return false, "Invalid invite."
		end

		local invite = activeInvites[inviteId]
		if not invite then
			return false, "This invite has expired or does not exist."
		end

		if invite.to ~= accepter.UserId then
			return false, "This invite was not sent to you."
		end

		if workspace:GetServerTimeNow() > invite.expires then
			activeInvites[inviteId] = nil
			return false, "This invite has expired."
		end

		local accepterDisplayName, accepterDisplayUserId = getPlayerDisplayInfo(accepter)

		if invite.crossServer then
			activeInvites[inviteId] = nil

			if isPlayerInTrade(accepter) then
				return false, "You are already in a trade."
			end

			local presenceData = getPresence(invite.from)
			local senderJobId = (presenceData and presenceData.jobId) or invite.senderJobId
			if not senderJobId then
				return false, "The player who sent the invite is no longer online."
			end

			local tradeId = HttpService:GenerateGUID(false)
			local emptySlotsAccepter, maxSlotsAccepter = getEmptySlots(accepter)
			local now = workspace:GetServerTimeNow()

			local senderDisplayName = invite.senderDisplayName
				or (presenceData and presenceData.displayName)
				or invite.senderName
			local senderDisplayUserId = invite.senderDisplayUserId
				or (presenceData and presenceData.displayUserId)
				or invite.from

			local trade = {
				tradeId = tradeId,
				users = { invite.from, accepter.UserId },
				players = {
					{
						username = senderDisplayName,
						displayUserId = senderDisplayUserId,
						realUsername = invite.senderName,
						offer = { brainrots = {}, baseSkins = {}, gears = {} },
						ready = false,
						accepted = false,
						maxSlots = 0,
						emptySlots = 0,
						signText = "",
						canChat = true,
					},
					{
						username = accepterDisplayName,
						displayUserId = accepterDisplayUserId,
						realUsername = accepter.Name,
						offer = { brainrots = {}, baseSkins = {}, gears = {} },
						ready = false,
						accepted = false,
						maxSlots = maxSlotsAccepter,
						emptySlots = emptySlotsAccepter,
						signText = "",
						canChat = true,
					},
				},
				lastChange = now,
				isProcessing = false,
				crossServer = true,
				jobIds = { senderJobId, game.JobId },
			}

			activeTrades[tradeId] = trade
			broadcastTradeState(trade)

			publishCrossServerMessage("trade", senderJobId, {
				action = "create",
				tradeId = tradeId,
				users = trade.users,
				players = trade.players,
				lastChange = now,
				jobIds = trade.jobIds,
			})

			return true
		end

		local senderPlayer = Players:GetPlayerByUserId(invite.from)

		if not senderPlayer then
			activeInvites[inviteId] = nil
			return false, "The player who sent the invite is no longer in the server."
		end

		if isPlayerInTrade(senderPlayer) then
			activeInvites[inviteId] = nil
			return false, "That player is already in a trade."
		end

		if isPlayerInTrade(accepter) then
			activeInvites[inviteId] = nil
			return false, "You are already in a trade."
		end

		activeInvites[inviteId] = nil

		local tradeId = HttpService:GenerateGUID(false)
		local emptySlotsSender, maxSlotsSender = getEmptySlots(senderPlayer)
		local emptySlotsAccepter, maxSlotsAccepter = getEmptySlots(accepter)

		local senderDisplayName, senderDisplayUserId = getPlayerDisplayInfo(senderPlayer)

		local trade = {
			tradeId = tradeId,
			users = { [1] = invite.from, [2] = accepter.UserId },
			players = {
				[1] = {
					username = senderDisplayName,
					displayUserId = senderDisplayUserId,
					realUsername = senderPlayer.Name,
					offer = { brainrots = {}, baseSkins = {}, gears = {} },
					ready = false,
					accepted = false,
					maxSlots = maxSlotsSender,
					emptySlots = emptySlotsSender,
					signText = "",
					canChat = true,
				},
				[2] = {
					username = accepterDisplayName,
					displayUserId = accepterDisplayUserId,
					realUsername = accepter.Name,
					offer = { brainrots = {}, baseSkins = {}, gears = {} },
					ready = false,
					accepted = false,
					maxSlots = maxSlotsAccepter,
					emptySlots = emptySlotsAccepter,
					signText = "",
					canChat = true,
				},
			},
			lastChange = workspace:GetServerTimeNow(),
			isProcessing = false,
		}

		activeTrades[tradeId] = trade
		broadcastTradeState(trade)
		return true
	end

	RemoteDeclineInvite.OnServerEvent:Connect(function(player, _guid, inviteId)
		if typeof(inviteId) ~= "string" then return end
		local invite = activeInvites[inviteId]
		if invite and invite.to == player.UserId then
			activeInvites[inviteId] = nil
		end
	end)

	RemoteSearchUser.OnServerInvoke = function(player, _guid, targetUserId)
		if typeof(targetUserId) ~= "number" then
			return false, "Invalid user ID."
		end

		local targetPlayer = Players:GetPlayerByUserId(targetUserId)
		local inGame = targetPlayer ~= nil
		local canInvite = false
		local crossServer = false
		local displayName, displayUserId
		local realUserId = targetUserId

		if inGame then
			local targetInTrade = isPlayerInTrade(targetPlayer)
			local selfInTrade = isPlayerInTrade(player)
			canInvite = not targetInTrade and not selfInTrade
			displayName, displayUserId = getPlayerDisplayInfo(targetPlayer)
		else
			local presenceData = getPresence(targetUserId)
			if presenceData and presenceData.jobId ~= game.JobId then
				inGame = true
				crossServer = true
				canInvite = not isPlayerInTrade(player)
				displayName = presenceData.displayName
				displayUserId = presenceData.displayUserId
			else
				for _, p in Players:GetPlayers() do
					if p ~= player and p:GetAttribute("MorphedUserId") == targetUserId then
						inGame = true
						realUserId = p.UserId
						local targetInTrade = isPlayerInTrade(p)
						local selfInTrade = isPlayerInTrade(player)
						canInvite = not targetInTrade and not selfInTrade
						displayName, displayUserId = getPlayerDisplayInfo(p)
						break
					end
				end

				if not inGame then
					local morph = getMorphIndirection(targetUserId)
					if morph and morph.jobId ~= game.JobId
						and morph.realUserId ~= player.UserId then
						local morpherPresence = getPresence(morph.realUserId)
						if morpherPresence and morpherPresence.jobId ~= game.JobId then
							inGame = true
							crossServer = true
							realUserId = morph.realUserId
							canInvite = not isPlayerInTrade(player)
							displayName = morpherPresence.displayName
							displayUserId = morpherPresence.displayUserId
						end
					end
				end
			end
		end

		return true, inGame, canInvite, crossServer, displayName, displayUserId, realUserId
	end

	RemoteAddBrainrot.OnServerInvoke = function(player, _guid, indexOnPlot, brainrotData)
		if typeof(indexOnPlot) ~= "number" or typeof(brainrotData) ~= "table" then
			return false, "Invalid data."
		end

		local now = workspace:GetServerTimeNow()
		local lastAdd = brainrotCooldowns[player.UserId]
		if lastAdd and now - lastAdd < BRAINROT_ADD_COOLDOWN then
			return false, "please_wait"
		end

		local tradeId, trade = getTradeForPlayer(player)
		if not trade then
			return false, "You are not in a trade."
		end

		if trade.isProcessing then
			return false, "Trade is being processed."
		end

		local playerIndex = nil
		for index, userId in trade.users do
			if userId == player.UserId then playerIndex = index break end
		end
		if not playerIndex then
			return false, "Player not found in trade."
		end

		local playerData = trade.players[playerIndex]

		if playerData.accepted then
			return false, "You cannot modify your offer after confirming."
		end

		local currentOffer = playerData.offer.brainrots
		if #currentOffer >= MAX_BRAINROTS_PER_OFFER then
			return false, ("You can only offer up to %s animals."):format(MAX_BRAINROTS_PER_OFFER)
		end

		for _, existing in currentOffer do
			if existing.IndexOnPlot == indexOnPlot then
				return false, "That animal is already in your offer."
			end
		end

		local podiums = getPlayerPodiums(player)
		if not podiums then
			return false, "Could not load your animals."
		end

		local animalData = podiums[indexOnPlot]
		if not animalData or animalData == "Empty" then
			return false, "No animal found at that slot."
		end

		if animalData.Machine then
			return false, "Machine animals cannot be traded."
		end

		if animalData.IsFake then
			return false, "This animal cannot be traded."
		end

		if animalData.Steal and animalData.Steal ~= false then
			return false, "That animal is currently being stolen and cannot be traded."
		end

		local otherIndex = playerIndex == 1 and 2 or 1
		local otherData = trade.players[otherIndex]

		local base = getPlayerBase(player)
		local maxSlots = base and base.MaxAnimals or 50
		local occupied = countOccupiedSlots(podiums, maxSlots)
		local afterTrade = occupied - (#currentOffer + 1) + #otherData.offer.brainrots
		if afterTrade > maxSlots then
			return false, "You don't have enough space to receive brainrots."
		end

		brainrotCooldowns[player.UserId] = now

		local entry = {
			UUID = animalData.UUID,
			Index = animalData.Index,
			Mutation = animalData.Mutation,
			Traits = animalData.Traits,
			IndexOnPlot = indexOnPlot,
		}
		table.insert(currentOffer, entry)

		playerData.ready = false
		playerData.accepted = false
		trade.lastChange = workspace:GetServerTimeNow()
		broadcastTradeState(trade)

		if trade.crossServer then
			publishCrossServerAction(trade, "add_brainrot", {
				playerIndex = playerIndex,
				entry = entry,
				lastChange = trade.lastChange,
			})
		end

		return true
	end

	RemoteRemoveBrainrot.OnServerInvoke = function(player, _guid, indexOnPlot, brainrotData)
		if typeof(indexOnPlot) ~= "number" then
			return false, "Invalid data."
		end

		local now = workspace:GetServerTimeNow()
		local lastRemove = brainrotRemoveCooldowns[player.UserId]
		if lastRemove and now - lastRemove < BRAINROT_REMOVE_COOLDOWN then
			return false, "please_wait_remove"
		end

		local tradeId, trade = getTradeForPlayer(player)
		if not trade then
			return false, "You are not in a trade."
		end

		if trade.isProcessing then
			return false, "Trade is being processed."
		end

		local playerIndex = nil
		for index, userId in trade.users do
			if userId == player.UserId then playerIndex = index break end
		end
		if not playerIndex then return false, "Player not found in trade." end

		local playerData = trade.players[playerIndex]

		if playerData.accepted then
			return false, "You cannot modify your offer after confirming."
		end

		local currentOffer = playerData.offer.brainrots
		local found = false
		for i, entry in currentOffer do
			if entry.IndexOnPlot == indexOnPlot then
				table.remove(currentOffer, i)
				found = true
				break
			end
		end

		if not found then
			return false, "That animal is not in your offer."
		end

		brainrotRemoveCooldowns[player.UserId] = now

		playerData.ready = false
		playerData.accepted = false
		trade.lastChange = workspace:GetServerTimeNow()
		broadcastTradeState(trade)

		if trade.crossServer then
			publishCrossServerAction(trade, "remove_brainrot", {
				playerIndex = playerIndex,
				indexOnPlot = indexOnPlot,
				lastChange = trade.lastChange,
			})
		end

		return true
	end

	RemoteCancelTrade.OnServerEvent:Connect(function(player, _guid)
		warn("[TDBG-S] Cancel received from", player and player.Name)
		local tradeId, trade = getTradeForPlayer(player)
		if trade then
			if trade.isProcessing then return end
			local cancellerName = getPlayerDisplayInfo(player)
			cancelTrade(tradeId, trade, cancellerName)
		end
	end)

	RemoteSetSignText.OnServerEvent:Connect(function(player, signText)
		if typeof(signText) ~= "string" then return end

		signText = string.sub(string.gsub(signText, "\n", ""), 1, SIGN_MAX_LENGTH)

		local tradeId, trade = getTradeForPlayer(player)
		if not trade then return end
		if trade.isProcessing then return end

		local playerIndex = nil
		for index, userId in trade.users do
			if userId == player.UserId then playerIndex = index break end
		end
		if not playerIndex then return end

		trade.players[playerIndex].signText = signText
		broadcastTradeState(trade)

		if trade.crossServer then
			publishCrossServerAction(trade, "sign_text", {
				playerIndex = playerIndex,
				signText = signText,
			})
		end
	end)

	RemoteSendChatMessage.OnServerEvent:Connect(function(player, _guid, text)
		if typeof(text) ~= "string" then return end
		local _, trade = getTradeForPlayer(player)
		if not trade or trade.isProcessing then return end
		local playerIndex
		for index, userId in trade.users do
			if userId == player.UserId then playerIndex = index break end
		end
		if not playerIndex then return end
		text = string.sub(string.gsub(text, "\n", " "), 1, CHAT_MAX_LENGTH)
		if #text == 0 then return end
		local presets = TradingFlags.SignPresets:Get() or {}
		local isPreset = false
		for _, preset in presets do
			if preset == text then
				isPreset = true
				break
			end
		end
		if not isPreset and not trade.players[playerIndex].canChat then
			warn(("[TradeService] Free-chat blocked for %s: canChat=false. Use a preset instead. Text=%q"):format(player.Name, text))
			return
		end
		local now = os.clock()
		local last = chatCooldowns[player.UserId]
		if last and now - last < CHAT_COOLDOWN then return end
		chatCooldowns[player.UserId] = now
		local otherUserId
		for _, uid in trade.users do
			if uid ~= player.UserId then otherUserId = uid break end
		end
		local filtered = text
		local okF, result = pcall(function()
			local tf = TextService:FilterStringAsync(text, player.UserId)
			if otherUserId then
				return tf:GetChatForUserAsync(otherUserId)
			end
			return tf:GetNonChatStringForBroadcastAsync()
		end)
		if okF and typeof(result) == "string" then
			if isPreset then
				if #result > 0 then filtered = result end
			else
				filtered = result
			end
		end
		if #filtered == 0 then
			warn(("[TradeService chat] dropping empty post-filter message from %s (raw=%q)"):format(player.Name, text))
			return
		end
		warn(("[TradeService chat] from=%s raw=%q filter_ok=%s filter_result=%q stored=%q"):format(player.Name, text, tostring(okF), tostring(result), filtered))
		trade.chat = trade.chat or {}
		table.insert(trade.chat, { u = player.UserId, t = filtered })
		while #trade.chat > CHAT_MAX_MESSAGES do table.remove(trade.chat, 1) end
		broadcastTradeState(trade)
		if trade.crossServer then
			publishCrossServerAction(trade, "chat", { u = player.UserId, t = filtered })
		end
	end)

	RemoteAddItem.OnServerInvoke = function(player, _guid, itemType, ref)
		if typeof(itemType) ~= "string" or typeof(ref) ~= "table" then return false, "Invalid data." end
		local now = workspace:GetServerTimeNow()
		local last = itemAddCooldowns[player.UserId]
		if last and now - last < ITEM_ADD_COOLDOWN then return false, "please_wait" end
		local _, trade = getTradeForPlayer(player)
		if not trade then return false, "You are not in a trade." end
		if trade.isProcessing then return false, "Trade is being processed." end
		local playerIndex
		for index, userId in trade.users do
			if userId == player.UserId then playerIndex = index break end
		end
		if not playerIndex then return false, "Player not found in trade." end
		local playerData = trade.players[playerIndex]
		if playerData.accepted then return false, "You cannot modify your offer after confirming." end
		local data = getData(player)
		if not data then return false, "Could not load your data." end
		local addedRef
		if itemType == "BaseSkin" then
			local uuid, skinName = ref.UUID, ref.SkinName
			if typeof(uuid) ~= "string" or typeof(skinName) ~= "string" then return false, "Invalid item." end
			local rec = data:Get("BaseSkinInventory." .. uuid)
			if typeof(rec) ~= "table" or rec.SkinName ~= skinName or not BaseSkins.IsTradable(skinName) then
				return false, "You do not own that base skin."
			end
			for _, otherUserId in trade.users do
				if otherUserId ~= player.UserId then
					local partner = Players:GetPlayerByUserId(otherUserId)
					if partner then
						local partnerData = getData(partner)
						if partnerData and BaseSkins.Owns(partnerData, skinName) then
							return false, "They already own that base skin."
						end
					end
				end
			end
			local offer = playerData.offer.baseSkins
			if #offer >= MAX_ITEMS_PER_OFFER then return false, "Your offer is full." end
			for _, e in offer do
				if e.UUID == uuid then return false, "That item is already in your offer." end
			end
			addedRef = { UUID = uuid, SkinName = skinName }
			table.insert(offer, addedRef)
		elseif itemType == "Gear" then
			local resolved = Gears.ResolveOwnedRef(data, ref)
			if not resolved then return false, "You do not own that gear." end
			local offer = playerData.offer.gears
			if #offer >= MAX_ITEMS_PER_OFFER then return false, "Your offer is full." end
			for _, e in offer do
				if (resolved.UUID and e.UUID == resolved.UUID) or (not resolved.UUID and not e.UUID and e.GearName == resolved.GearName) then
					return false, "That item is already in your offer."
				end
			end
			addedRef = resolved
			table.insert(offer, addedRef)
		else
			return false, "Unknown item type."
		end
		itemAddCooldowns[player.UserId] = now
		playerData.ready = false
		playerData.accepted = false
		trade.lastChange = workspace:GetServerTimeNow()
		broadcastTradeState(trade)
		if trade.crossServer then
			publishCrossServerAction(trade, "add_item", { playerIndex = playerIndex, itemType = itemType, ref = addedRef, lastChange = trade.lastChange })
		end
		return true
	end

	RemoteRemoveItem.OnServerInvoke = function(player, _guid, itemType, ref)
		if typeof(itemType) ~= "string" or typeof(ref) ~= "table" then return false, "Invalid data." end
		local now = workspace:GetServerTimeNow()
		local last = itemRemoveCooldowns[player.UserId]
		if last and now - last < ITEM_REMOVE_COOLDOWN then return false, "please_wait_remove" end
		local _, trade = getTradeForPlayer(player)
		if not trade then return false, "You are not in a trade." end
		if trade.isProcessing then return false, "Trade is being processed." end
		local playerIndex
		for index, userId in trade.users do
			if userId == player.UserId then playerIndex = index break end
		end
		if not playerIndex then return false, "Player not found in trade." end
		local playerData = trade.players[playerIndex]
		if playerData.accepted then return false, "You cannot modify your offer after confirming." end
		local offerKey = (itemType == "BaseSkin" and "baseSkins") or (itemType == "Gear" and "gears")
		if not offerKey then return false, "Unknown item type." end
		local offer = playerData.offer[offerKey]
		local found = false
		for i, e in offer do
			local match
			if itemType == "BaseSkin" then
				match = e.UUID == ref.UUID
			else
				match = (ref.UUID and e.UUID == ref.UUID) or (not ref.UUID and not e.UUID and e.GearName == ref.GearName)
			end
			if match then table.remove(offer, i) found = true break end
		end
		if not found then return false, "That item is not in your offer." end
		itemRemoveCooldowns[player.UserId] = now
		playerData.ready = false
		playerData.accepted = false
		trade.lastChange = workspace:GetServerTimeNow()
		broadcastTradeState(trade)
		if trade.crossServer then
			publishCrossServerAction(trade, "remove_item", { playerIndex = playerIndex, itemType = itemType, ref = ref, lastChange = trade.lastChange })
		end
		return true
	end

	RemoteGetTradeHistory.OnServerInvoke = function(player, _guid)
		local data = getData(player)
		if not data then return {} end
		local history = data:Get("TradeHistory")
		if typeof(history) ~= "table" then return {} end
		return history
	end
	RemoteReady.OnServerEvent:Connect(function(player, _guid)
		warn("[TDBG-S] Ready received from", player and player.Name)
		local tradeId, trade = getTradeForPlayer(player)
		if not trade then return false, "You are not in a trade." end

		if trade.isProcessing then return false end

		local now = workspace:GetServerTimeNow()
		if now < trade.lastChange + LOCK_DURATION then return false end

		local playerIndex = nil
		for index, userId in ipairs(trade.users) do
			if userId == player.UserId then 
				playerIndex = index 
				break 
			end
		end
		if not playerIndex then return false end

		local playerData = trade.players[playerIndex]
		if playerData.accepted then return false end
		if playerData.ready then return false end

		local otherIndex = playerIndex == 1 and 2 or 1
		local otherData = trade.players[otherIndex]
		local otherPlayer = Players:GetPlayerByUserId(trade.users[otherIndex])

		local podiums = getPlayerPodiums(player)
		local base = getPlayerBase(player)
		local maxSlots = base and base.MaxAnimals or 50
		local occupied = podiums and countOccupiedSlots(podiums, maxSlots) or 0
		local afterTrade = occupied - #playerData.offer.brainrots + #otherData.offer.brainrots
		if afterTrade > maxSlots then
			return false, "You don't have enough space to receive brainrots."
		end

		if otherPlayer then
			local otherPodiums = getPlayerPodiums(otherPlayer)
			local otherBase = getPlayerBase(otherPlayer)
			local otherMaxSlots = otherBase and otherBase.MaxAnimals or 50
			local otherOccupied = otherPodiums and countOccupiedSlots(otherPodiums, otherMaxSlots) or 0
			local otherAfterTrade = otherOccupied - #otherData.offer.brainrots + #playerData.offer.brainrots
			if otherAfterTrade > otherMaxSlots then
				return false, "The other player doesn't have enough space in their base."
			end
		end

		local _filterSet = getActiveTradeFilter(player)
		if _filterSet and not offerHasWanted(_filterSet, otherData.offer.brainrots) then
			NotificationService.Error(player, "You can only accept trades that include a brainrot you selected in 'Only Receive Trades With'.")
			return false
		end
		playerData.ready = true
		trade.lastChange = workspace:GetServerTimeNow()
		broadcastTradeState(trade)

		if trade.crossServer then
			publishCrossServerAction(trade, "ready", {
				playerIndex = playerIndex,
				lastChange = trade.lastChange,
			})
		end
	end)

	local acceptProcessing = {}

	RemoteAccept.OnServerEvent:Connect(function(player, _guid)
		warn("[TDBG-S] Accept received from", player and player.Name)
		local tradeId, trade = getTradeForPlayer(player)
		if not trade then return end

		if trade.isProcessing then return end
		if acceptProcessing[tradeId] then return end

		local now = workspace:GetServerTimeNow()

		local allReady = true
		for _, pData in trade.players do
			if not pData.ready then allReady = false break end
		end
		if not allReady then return end

		if now < (trade.lastChange or 0) + ACCEPT_LOCK_DURATION then return end

		local playerIndex = nil
		for index, userId in trade.users do
			if userId == player.UserId then playerIndex = index break end
		end
		if not playerIndex then return end

		local playerData = trade.players[playerIndex]
		if playerData.accepted then return end

		playerData.accepted = true
		trade.lastChange = workspace:GetServerTimeNow()

		local allAccepted = true
		for _, pData in trade.players do
			if not pData.accepted then allAccepted = false break end
		end

		if not allAccepted then
			broadcastTradeState(trade)
			if trade.crossServer then
				publishCrossServerAction(trade, "accept", {
					playerIndex = playerIndex,
					lastChange = trade.lastChange,
				})
			end
			return
		end

		acceptProcessing[tradeId] = true
		trade.isProcessing = true
		broadcastTradeState(trade)

		if trade.crossServer then
			publishCrossServerAction(trade, "accept", {
				playerIndex = playerIndex,
				lastChange = trade.lastChange,
			})
		end

		task.spawn(function()
			task.wait(3)

			local offer1 = trade.players[1].offer
			local offer2 = trade.players[2].offer

			local _f1 = getActiveTradeFilter(Players:GetPlayerByUserId(trade.users[1]))
			local _f2 = getActiveTradeFilter(Players:GetPlayerByUserId(trade.users[2]))
			if (_f1 and not offerHasWanted(_f1, offer2.brainrots)) or (_f2 and not offerHasWanted(_f2, offer1.brainrots)) then
				for _, _uid in trade.users do
					local _p = Players:GetPlayerByUserId(_uid)
					if _p then NotificationService.Error(_p, "Trade cancelled: an offer didn't include a brainrot from a player's 'Only Receive Trades With' filter.") end
				end
				acceptProcessing[tradeId] = nil
				cancelTrade(tradeId, trade, nil)
				return
			end

			for _, userId in trade.users do
				local p = Players:GetPlayerByUserId(userId)
				if p then
					RemoteTradeNotification:FireClient(p, "completed", getOtherUsername(trade, userId))
				end
			end

			processPlayerTrade(trade.users[1], offer1, offer2, trade.players[2].realUsername or trade.players[2].username, trade.users[2])
			processPlayerTrade(trade.users[2], offer2, offer1, trade.players[1].realUsername or trade.players[1].username, trade.users[1])

			acceptProcessing[tradeId] = nil
			cancelTrade(tradeId, trade, nil)
		end)
	end)

	Players.PlayerRemoving:Connect(function(player)
		brainrotCooldowns[player.UserId] = nil
		brainrotRemoveCooldowns[player.UserId] = nil
		inviteSendCooldowns[player.UserId] = nil
		for inviteId, invite in activeInvites do
			if invite.from == player.UserId or invite.to == player.UserId then
				activeInvites[inviteId] = nil
			end
		end
		local tradeId, trade = getTradeForPlayer(player)
		if trade then
			local cancellerName = getPlayerDisplayInfo(player)
			cancelTrade(tradeId, trade, cancellerName)
		end
	end)
end

function TradeService:isInTrade(userId)
	for _, trade in activeTrades do
		for _, id in trade.users do
			if id == userId then
				return true
			end
		end
	end
	return false
end

return TradeService