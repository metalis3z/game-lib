-- PendingDeliveryInbox (clean pattern, server ModuleScript)
-- Credit: idea from smash-egg-for-animals (removed cross-server TradeServer: DataStore "TradePending_v1" inbox,
-- claimPending / deliverTo) and its GiftServer (gifts delivered now, on another server, or at next join).
--
-- What it does:
--   A per-player "mailbox" in a DataStore. Use it whenever an item must reach a player who may be
--   OFFLINE or on ANOTHER SERVER: cross-server trades, gifts, admin grants, refunds.
--     Deliver(userId, records)  -> appends records with UpdateAsync (safe against concurrent writers), retries.
--     Claim(player, apply)       -> atomically empties the box and gives you the records to apply.
--   Optional: Deliver also publishes a MessagingService ping so the receiver's server claims at once.
--
-- IMPORTANT: Claim removes the records BEFORE you apply them. Apply + save immediately; if apply
-- returns false the records are written back with Deliver so nothing is lost.
--
-- Usage (server):
--   local Inbox = require(ServerScriptService.PendingDeliveryInbox).new("TradeInbox_v1", "TradeInboxPing_v1")
--   -- sending side, after it has REMOVED the items from the sender and saved:
--   Inbox:Deliver(targetUserId, { { Pet = "Dragon", Kg = 3.2 }, { Pet = "Cat", Kg = 1 } })
--   -- receiving side (call on join once data is loaded; pings call it too):
--   Inbox:Listen(function(player, records)
--       for _, rec in records do DataService.givePet(player, rec) end   -- validate each record here!
--       DataService.save(player)
--       return true
--   end)

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local MessagingService = game:GetService("MessagingService")

local Inbox = {}
Inbox.__index = Inbox

function Inbox.new(storeName: string, pingTopic: string?)
	local self = setmetatable({}, Inbox)
	local ok, store = pcall(function()
		return DataStoreService:GetDataStore(storeName)
	end)
	self.store = if ok then store else nil
	self.topic = pingTopic
	self.claiming = {} :: { [Player]: boolean }
	self.apply = nil :: ((Player, { any }) -> boolean)?
	return self
end

-- Append records to a user's inbox. Returns true when written.
function Inbox:Deliver(userId: number, records: { any }): boolean
	if #records == 0 then
		return true
	end
	if not self.store then
		return false
	end
	for attempt = 1, 3 do
		local ok, err = pcall(function()
			self.store:UpdateAsync(tostring(userId), function(old)
				local list = if type(old) == "table" then old else {}
				for _, rec in records do
					table.insert(list, rec)
				end
				return list
			end)
		end)
		if ok then
			if self.topic then
				pcall(function()
					MessagingService:PublishAsync(self.topic, { userId = userId })
				end)
			end
			return true
		end
		warn("[Inbox] deliver failed (attempt " .. attempt .. "): " .. tostring(err))
		task.wait(attempt)
	end
	return false
end

-- Empty the inbox and hand the records to apply(player, records).
function Inbox:Claim(player: Player, apply: (Player, { any }) -> boolean)
	if not self.store or self.claiming[player] then
		return
	end
	self.claiming[player] = true
	local got = nil
	local ok, err = pcall(function()
		self.store:UpdateAsync(tostring(player.UserId), function(old)
			if type(old) ~= "table" or #old == 0 then
				got = nil
				return nil -- nothing to change (returning nil cancels the write)
			end
			got = old
			return {}
		end)
	end)
	if not ok then
		warn("[Inbox] claim failed: " .. tostring(err))
	elseif got and #got > 0 then
		local applied = player.Parent ~= nil and apply(player, got)
		if not applied then
			self:Deliver(player.UserId, got) -- put them back, try again next join
		end
	end
	self.claiming[player] = nil
end

-- Claim on join (and when another server pings). Call once at startup.
-- applyFn must only run after the player's data is loaded: wait for it inside, or call Claim yourself later.
function Inbox:Listen(applyFn: (Player, { any }) -> boolean)
	self.apply = applyFn
	local function onPlayer(player: Player)
		task.spawn(function()
			self:Claim(player, applyFn)
		end)
	end
	Players.PlayerAdded:Connect(onPlayer)
	for _, p in Players:GetPlayers() do
		onPlayer(p)
	end
	Players.PlayerRemoving:Connect(function(p)
		self.claiming[p] = nil
	end)
	if self.topic then
		pcall(function()
			MessagingService:SubscribeAsync(self.topic, function(message)
				local data = message.Data
				local player = type(data) == "table" and Players:GetPlayerByUserId(data.userId)
				if player then
					onPlayer(player)
				end
			end)
		end)
	end
end

return Inbox
