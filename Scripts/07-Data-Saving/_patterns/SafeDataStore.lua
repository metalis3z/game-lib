--[[
	SafeDataStore  (ModuleScript, server only)

	A thin wrapper around GlobalDataStore calls for the "small" stores every game has besides
	player data (codes, global counters, ban lists, gift inboxes, settings...).

	  * every call is pcall'd and retried with exponential backoff
	  * waits for request budget instead of spamming and getting throttled
	  * calls on the same key run one at a time (no two writes racing on one key)
	  * refuses to write nil by accident (use Remove for that)
	  * returns (success, value) so callers can tell "no data" from "DataStore is down"

	Credit: BIG Paintball "2 _ Datastore" (retry wrapper, refuse nil writes, cached stores),
	steal-a-brainrot DataService (SafeGetAsync / SafeSetAsync with 2^n backoff).

	Usage:
		local SafeDataStore = require(game.ServerScriptService.SafeDataStore)
		local codes = SafeDataStore.new("RedeemedCodes_v1")

		local ok, value = codes:Get("Player_123")
		if not ok then
			-- DataStore is down: do NOT treat this as "new player"
		end

		local ok, newValue = codes:Update("GlobalCounter", function(old)
			return (old or 0) + 1
		end)

		codes:Set("Player_123", { "WELCOME" })
		codes:Remove("Player_123")
]]

local DataStoreService = game:GetService("DataStoreService")

local SafeDataStore = {}
SafeDataStore.__index = SafeDataStore

local MAX_ATTEMPTS = 5
local BASE_DELAY = 1 -- seconds; doubles every retry (1, 2, 4, 8)
local BUDGET_WAIT = 10 -- seconds to wait for request budget before trying anyway

local BUDGET_TYPE = {
	Get = Enum.DataStoreRequestType.GetAsync,
	Set = Enum.DataStoreRequestType.SetIncrementAsync,
	Update = Enum.DataStoreRequestType.UpdateAsync,
	Remove = Enum.DataStoreRequestType.SetIncrementAsync,
}

local storeCache = {}

function SafeDataStore.new(name, scope)
	local cacheKey = name .. "\0" .. tostring(scope)
	if storeCache[cacheKey] then
		return storeCache[cacheKey]
	end
	local self = setmetatable({
		Name = name,
		_store = DataStoreService:GetDataStore(name, scope),
		_keyBusy = {},
	}, SafeDataStore)
	storeCache[cacheKey] = self
	return self
end

local function waitForBudget(kind)
	local requestType = BUDGET_TYPE[kind]
	local deadline = os.clock() + BUDGET_WAIT
	while DataStoreService:GetRequestBudgetForRequestType(requestType) < 1 and os.clock() < deadline do
		task.wait(0.5)
	end
end

-- Runs fn() with retries, one call per key at a time. Returns (success, result).
function SafeDataStore:_run(kind, key, fn)
	while self._keyBusy[key] do
		task.wait()
	end
	self._keyBusy[key] = true

	local ok, result
	for attempt = 1, MAX_ATTEMPTS do
		waitForBudget(kind)
		ok, result = pcall(fn)
		if ok then
			break
		end
		warn(("[SafeDataStore] %s %s/%s failed (attempt %d/%d): %s"):format(
			kind, self.Name, tostring(key), attempt, MAX_ATTEMPTS, tostring(result)))
		if attempt < MAX_ATTEMPTS then
			task.wait(BASE_DELAY * 2 ^ (attempt - 1))
		end
	end

	self._keyBusy[key] = nil
	if ok then
		return true, result
	end
	return false, nil
end

function SafeDataStore:Get(key)
	return self:_run("Get", key, function()
		return self._store:GetAsync(key)
	end)
end

function SafeDataStore:Set(key, value)
	assert(value ~= nil, "SafeDataStore:Set refuses nil; call Remove to delete a key")
	return self:_run("Set", key, function()
		self._store:SetAsync(key, value)
		return value
	end)
end

-- transform(old) returns the new value, or nil to cancel the write.
-- Keep transform fast and non-yielding: Roblox may call it more than once.
function SafeDataStore:Update(key, transform)
	return self:_run("Update", key, function()
		return self._store:UpdateAsync(key, transform)
	end)
end

function SafeDataStore:Remove(key)
	return self:_run("Remove", key, function()
		return self._store:RemoveAsync(key)
	end)
end

return SafeDataStore
