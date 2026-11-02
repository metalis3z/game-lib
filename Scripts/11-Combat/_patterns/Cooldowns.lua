--!strict
-- Pattern: Cooldowns (ModuleScript, server or client)
-- Credit: replaces the "AddTag('DashCD') ... task.delay(4, RemoveTag)" style used in
-- jujutsu-shenanigans (Combat.server, StunHandler) and the per-ability Cooldown field in
-- bite-by-night (Fighter.lua / Ability.lua) with one small, testable object.
--
-- What it does:
--   Tracks cooldowns per owner (a Player, a character Model, anything) and per action name using
--   timestamps instead of threads, so there is nothing to clean up and no race when an action is
--   used twice quickly. Also supports charges (e.g. 3 dashes that refill one at a time).
--
-- Usage (server):
--   local Cooldowns = require(path.to.Cooldowns)
--   local cd = Cooldowns.new()
--   remote.OnServerEvent:Connect(function(player, action)
--       if action == "Dash" and cd:TryUse(player, "Dash", 2) then
--           -- do the dash
--       end
--   end)
--   cd:Remaining(player, "Dash")       --> seconds left (0 if ready)
--   cd:SetCharges(player, "Dash", 3, 4) -- 3 charges, one comes back every 4 s
--   cd:Reset(player, "Dash")            -- e.g. a "refresh cooldowns" power-up
--   Players.PlayerRemoving:Connect(function(p) cd:Clear(p) end)

export type ChargeState = { max: number, refill: number, used: { number } }

local Cooldowns = {}
Cooldowns.__index = Cooldowns

export type Cooldowns = typeof(setmetatable({} :: {
	_readyAt: { [any]: { [string]: number } },
	_charges: { [any]: { [string]: ChargeState } },
	_clock: () -> number,
}, Cooldowns))

-- clock: optional time source (default os.clock); pass workspace:GetServerTimeNow to share
-- timestamps between server and client.
function Cooldowns.new(clock: (() -> number)?): Cooldowns
	return setmetatable({
		_readyAt = {},
		_charges = {},
		_clock = clock or os.clock,
	}, Cooldowns)
end

local function bucket<T>(map: { [any]: { [string]: T } }, owner: any): { [string]: T }
	local b = map[owner]
	if not b then
		b = {}
		map[owner] = b
	end
	return b
end

-- Charges --------------------------------------------------------------------------------------

function Cooldowns.SetCharges(self: Cooldowns, owner: any, action: string, max: number, refillSeconds: number)
	bucket(self._charges, owner)[action] = { max = max, refill = refillSeconds, used = {} }
end

local function liveCharges(self: Cooldowns, state: ChargeState): number
	local now = self._clock()
	-- drop uses whose refill time has passed
	local i = 1
	while i <= #state.used do
		if now - state.used[i] >= state.refill then
			table.remove(state.used, i)
		else
			i += 1
		end
	end
	return state.max - #state.used
end

-- Basic cooldowns ------------------------------------------------------------------------------

function Cooldowns.Remaining(self: Cooldowns, owner: any, action: string): number
	local charges = self._charges[owner] and self._charges[owner][action]
	if charges then
		if liveCharges(self, charges) > 0 then
			return 0
		end
		local oldest = charges.used[1]
		return math.max(0, oldest + charges.refill - self._clock())
	end
	local readyAt = self._readyAt[owner] and self._readyAt[owner][action]
	if not readyAt then
		return 0
	end
	return math.max(0, readyAt - self._clock())
end

function Cooldowns.IsReady(self: Cooldowns, owner: any, action: string): boolean
	return self:Remaining(owner, action) <= 0
end

-- Returns true and starts the cooldown if the action was ready; returns false otherwise.
function Cooldowns.TryUse(self: Cooldowns, owner: any, action: string, seconds: number?): boolean
	local charges = self._charges[owner] and self._charges[owner][action]
	if charges then
		if liveCharges(self, charges) <= 0 then
			return false
		end
		table.insert(charges.used, self._clock())
		return true
	end
	if not self:IsReady(owner, action) then
		return false
	end
	bucket(self._readyAt, owner)[action] = self._clock() + (seconds or 0)
	return true
end

-- Adds (or with a negative number removes) time from a running cooldown.
function Cooldowns.Extend(self: Cooldowns, owner: any, action: string, seconds: number)
	local b = bucket(self._readyAt, owner)
	b[action] = math.max(b[action] or self._clock(), self._clock()) + seconds
end

function Cooldowns.Reset(self: Cooldowns, owner: any, action: string?)
	if action then
		if self._readyAt[owner] then
			self._readyAt[owner][action] = nil
		end
		local charges = self._charges[owner] and self._charges[owner][action]
		if charges then
			table.clear(charges.used)
		end
	else
		self._readyAt[owner] = nil
		for _, state in self._charges[owner] or {} do
			table.clear(state.used)
		end
	end
end

function Cooldowns.Clear(self: Cooldowns, owner: any)
	self._readyAt[owner] = nil
	self._charges[owner] = nil
end

return Cooldowns
