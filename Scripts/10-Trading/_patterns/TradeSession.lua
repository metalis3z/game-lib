-- TradeSession (clean pattern, server ModuleScript)
-- Credit: flow combined from smash-egg-for-animals (TradeServer: READY -> wait -> CONFIRM, edit cooldown,
-- action rate limit), brainrot-lab (TradeServer: request timeout, cleanup on leave), rcu-roller (TradeService:
-- ready + confirm stages) and steal-a-brainrot (TradeService: READY delay, re-check before swap).
--
-- What it does:
--   Server-authoritative, same-server player-to-player trading. The client only ASKS; the server owns
--   all state. Flow:
--     Request (expires) -> Accept -> both add/remove items -> both READY -> wait confirmDelay seconds
--     -> both CONFIRM -> your executeSwap() runs (must be atomic, see AtomicSwap.lua).
--   Any change to either offer clears READY and CONFIRM on both sides (stops last-second bait-and-switch).
--   Offers are re-validated against getTradable() right before the swap.
--
-- Usage (server Script):
--   local TradeSession = require(ServerScriptService.TradeSession)
--   local AtomicSwap = require(ServerScriptService.AtomicSwap)
--   local trades = TradeSession.new({
--       getTradable = function(player) -- { [itemId] = displayInfo } of items the player may offer RIGHT NOW
--           local inv = {}
--           for id, pet in DataService.get(player).Pets do
--               if not pet.Equipped then inv[id] = { Name = pet.Name, Rarity = pet.Rarity } end
--           end
--           return inv
--       end,
--       executeSwap = function(a, idsA, b, idsB) -- return true, or false + reason
--           local ok, err = AtomicSwap.swap(DataService.get(a).Pets, idsA, DataService.get(b).Pets, idsB)
--           if ok then DataService.save(a); DataService.save(b) end
--           return ok, err
--       end,
--       onState = function(player, payload) TradeUpdate:FireClient(player, payload) end,
--       onNotify = function(player, text) Notify:FireClient(player, text) end,
--   })
--   trades:BindRemote(ReplicatedStorage.Remotes.TradeAction) -- client fires (action: string, arg: any)
--   -- client actions: "Request" userId, "Accept" userId, "Decline" userId,
--   --                 "Add" itemId, "Remove" itemId, "Ready" bool, "Confirm", "Cancel"
--
--   payload.kind sent to clients: "request" (incoming invite), "state" (full trade view), "closed" (reason), "done"

local Players = game:GetService("Players")

export type Config = {
	getTradable: (player: Player) -> { [any]: any },
	executeSwap: (a: Player, idsA: { any }, b: Player, idsB: { any }) -> (boolean, string?),
	onState: (player: Player, payload: { [string]: any }) -> (),
	onNotify: ((player: Player, text: string) -> ())?,
	canTrade: ((a: Player, b: Player) -> (boolean, string?))?, -- e.g. data loaded, settings, distance
	maxOffer: number?,
	requestLifetime: number?,
	requestCooldown: number?,
	editCooldown: number?,
	confirmDelay: number?,
	maxActionsPerSecond: number?,
}

local TradeSession = {}
TradeSession.__index = TradeSession

function TradeSession.new(config: Config)
	local self = setmetatable({}, TradeSession)
	self.config = config
	self.maxOffer = config.maxOffer or 9
	self.requestLifetime = config.requestLifetime or 30
	self.requestCooldown = config.requestCooldown or 3
	self.editCooldown = config.editCooldown or 0.5
	self.confirmDelay = config.confirmDelay or 3
	self.maxActions = config.maxActionsPerSecond or 12

	self.trades = {} :: { [Player]: any } -- [player] = shared trade table
	self.requests = {} :: { [Player]: { [Player]: number } } -- [target][from] = expiresAt (os.clock)
	self.lastRequest = {} :: { [Player]: number }
	self.rate = {} :: { [Player]: { start: number, count: number } }

	Players.PlayerRemoving:Connect(function(player)
		self:_onLeave(player)
	end)
	return self
end

-- ── helpers ────────────────────────────────────────────────────────────────
local function other(trade, player)
	return if trade.A == player then trade.B else trade.A
end

function TradeSession:_notify(player: Player, text: string)
	if self.config.onNotify and player.Parent then
		self.config.onNotify(player, text)
	end
end

function TradeSession:_resetReady(trade)
	trade.ready = {}
	trade.confirm = {}
	trade.readyAt = nil
end

-- Drop offered ids that are no longer tradable (sold, equipped, deleted...). Returns true if anything changed.
function TradeSession:_prune(trade): boolean
	local changed = false
	for _, p in { trade.A, trade.B } do
		local mine = self.config.getTradable(p)
		local offer = trade.offer[p]
		for i = #offer, 1, -1 do
			if mine[offer[i]] == nil then
				table.remove(offer, i)
				changed = true
			end
		end
	end
	if changed then
		self:_resetReady(trade)
	end
	return changed
end

function TradeSession:_push(trade)
	self:_prune(trade)
	for _, p in { trade.A, trade.B } do
		if p.Parent then
			local q = other(trade, p)
			local mine, theirs = self.config.getTradable(p), self.config.getTradable(q)
			local myOffer, theirOffer = {}, {}
			for _, id in trade.offer[p] do
				table.insert(myOffer, { id = id, info = mine[id] })
			end
			for _, id in trade.offer[q] do
				table.insert(theirOffer, { id = id, info = theirs[id] })
			end
			self.config.onState(p, {
				kind = "state",
				partner = { userId = q.UserId, name = q.Name, displayName = q.DisplayName },
				myOffer = myOffer,
				theirOffer = theirOffer,
				myReady = trade.ready[p] == true,
				theirReady = trade.ready[q] == true,
				myConfirm = trade.confirm[p] == true,
				theirConfirm = trade.confirm[q] == true,
				-- client shows a countdown; the server re-checks the time on Confirm
				confirmAt = if trade.readyAt then workspace:GetServerTimeNow() + (trade.readyAt + self.confirmDelay - os.clock()) else nil,
				maxOffer = self.maxOffer,
			})
		end
	end
end

function TradeSession:_end(trade, reason: string)
	if trade.over then
		return
	end
	trade.over = true
	if self.trades[trade.A] == trade then self.trades[trade.A] = nil end
	if self.trades[trade.B] == trade then self.trades[trade.B] = nil end
	for _, p in { trade.A, trade.B } do
		if p.Parent then
			self.config.onState(p, { kind = "closed", reason = reason })
		end
	end
end

-- ── actions ────────────────────────────────────────────────────────────────
function TradeSession:Request(from: Player, target: Player)
	if self.trades[from] or target == from or not target.Parent then return end
	local now = os.clock()
	if now - (self.lastRequest[from] or -math.huge) < self.requestCooldown then
		self:_notify(from, "Wait a moment before sending another request.")
		return
	end
	self.lastRequest[from] = now
	if self.trades[target] then
		self:_notify(from, target.DisplayName .. " is already trading.")
		return
	end
	if self.config.canTrade then
		local ok, why = self.config.canTrade(from, target)
		if not ok then
			self:_notify(from, why or "You can't trade with this player right now.")
			return
		end
	end
	self.requests[target] = self.requests[target] or {}
	self.requests[target][from] = now + self.requestLifetime
	self.config.onState(target, {
		kind = "request",
		from = { userId = from.UserId, name = from.Name, displayName = from.DisplayName },
		lifetime = self.requestLifetime,
	})
	self:_notify(from, "Trade request sent to " .. target.DisplayName .. ".")
end

function TradeSession:Respond(target: Player, from: Player, accept: boolean)
	local list = self.requests[target]
	local expires = list and list[from]
	if list then list[from] = nil end
	if not expires or expires < os.clock() then
		self:_notify(target, "This trade request has expired.")
		return
	end
	if not accept then
		self:_notify(from, target.DisplayName .. " declined your trade request.")
		return
	end
	if not from.Parent or self.trades[from] or self.trades[target] then
		self:_notify(target, "That trade is no longer possible.")
		return
	end
	local trade = {
		A = from, B = target,
		offer = { [from] = {}, [target] = {} },
		ready = {}, confirm = {}, readyAt = nil,
		lastEdit = {}, executing = false, over = false,
	}
	self.trades[from], self.trades[target] = trade, trade
	self:_push(trade)
end

function TradeSession:Edit(player: Player, itemId: any, adding: boolean)
	local trade = self.trades[player]
	if not trade or trade.executing then return end
	local now = os.clock()
	if now - (trade.lastEdit[player] or -math.huge) < self.editCooldown then
		self:_push(trade)
		return
	end
	local offer = trade.offer[player]
	local index = table.find(offer, itemId)
	if adding then
		if index or #offer >= self.maxOffer then self:_push(trade) return end
		if self.config.getTradable(player)[itemId] == nil then self:_push(trade) return end -- not theirs / locked
		table.insert(offer, itemId)
	else
		if not index then self:_push(trade) return end
		table.remove(offer, index)
	end
	trade.lastEdit[player] = now
	self:_resetReady(trade) -- any change: both sides must ready again
	self:_push(trade)
end

function TradeSession:SetReady(player: Player, value: boolean)
	local trade = self.trades[player]
	if not trade or trade.executing then return end
	trade.ready[player] = value == true
	trade.confirm = {}
	trade.readyAt = if trade.ready[trade.A] and trade.ready[trade.B] then os.clock() else nil
	self:_push(trade)
end

function TradeSession:Confirm(player: Player)
	local trade = self.trades[player]
	if not trade or trade.executing or not trade.readyAt then return end
	if os.clock() < trade.readyAt + self.confirmDelay - 0.05 then
		self:_push(trade) -- too early: the countdown is enforced here, not on the client
		return
	end
	trade.confirm[player] = true
	if not (trade.confirm[trade.A] and trade.confirm[trade.B]) then
		self:_push(trade)
		return
	end

	-- execute
	trade.executing = true
	if self:_prune(trade) then -- something vanished since READY: make them look again
		trade.executing = false
		self:_notify(trade.A, "An item changed, please check the trade again.")
		self:_notify(trade.B, "An item changed, please check the trade again.")
		self:_push(trade)
		return
	end
	local idsA, idsB = table.clone(trade.offer[trade.A]), table.clone(trade.offer[trade.B])
	if #idsA + #idsB == 0 then
		trade.executing = false
		self:_resetReady(trade)
		self:_push(trade)
		return
	end
	local okCall, ok, err = pcall(self.config.executeSwap, trade.A, idsA, trade.B, idsB)
	if not okCall or not ok then
		trade.executing = false
		self:_resetReady(trade)
		local reason = if okCall then (err or "Trade failed.") else "Server error."
		self:_notify(trade.A, reason)
		self:_notify(trade.B, reason)
		self:_push(trade)
		return
	end
	trade.over = true
	self.trades[trade.A], self.trades[trade.B] = nil, nil
	for _, p in { trade.A, trade.B } do
		if p.Parent then
			self.config.onState(p, { kind = "done", gave = #(if p == trade.A then idsA else idsB), got = #(if p == trade.A then idsB else idsA) })
		end
	end
end

function TradeSession:Cancel(player: Player)
	local trade = self.trades[player]
	if not trade or trade.executing then return end
	self:_notify(other(trade, player), player.DisplayName .. " cancelled the trade.")
	self:_end(trade, "cancelled")
end

function TradeSession:_onLeave(player: Player)
	local trade = self.trades[player]
	if trade then
		self:_notify(other(trade, player), player.DisplayName .. " left: trade cancelled.")
		self:_end(trade, "left")
	end
	self.requests[player] = nil
	for _, list in self.requests do
		list[player] = nil
	end
	self.lastRequest[player] = nil
	self.rate[player] = nil
end

-- ── remote wiring with type checks + rate limit ────────────────────────────
function TradeSession:BindRemote(remote: RemoteEvent)
	remote.OnServerEvent:Connect(function(player: Player, action: any, arg: any)
		if type(action) ~= "string" then return end
		local now = os.clock()
		local r = self.rate[player]
		if not r or now - r.start > 1 then
			r = { start = now, count = 0 }
			self.rate[player] = r
		end
		r.count += 1
		if r.count > self.maxActions then return end

		local target = if type(arg) == "number" then Players:GetPlayerByUserId(arg) else nil
		local ok, e = pcall(function()
			if action == "Request" and target then
				self:Request(player, target)
			elseif action == "Accept" and target then
				self:Respond(player, target, true)
			elseif action == "Decline" and target then
				self:Respond(player, target, false)
			elseif action == "Add" and (type(arg) == "string" or type(arg) == "number") then
				self:Edit(player, arg, true)
			elseif action == "Remove" and (type(arg) == "string" or type(arg) == "number") then
				self:Edit(player, arg, false)
			elseif action == "Ready" then
				self:SetReady(player, arg == true)
			elseif action == "Confirm" then
				self:Confirm(player)
			elseif action == "Cancel" then
				self:Cancel(player)
			end
		end)
		if not ok then
			warn("[TradeSession] " .. action .. ": " .. tostring(e))
		end
	end)
end

return TradeSession
