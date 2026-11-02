--[[
	SessionStore  (ModuleScript, server only)

	A small, dependency-free player data store with:
	  * a lease-based session lock kept INSIDE the save (taken and checked with one UpdateAsync,
	    so two servers can never both write the same player)
	  * template reconcile (new fields get their default, old fields are kept)
	  * numbered migrations (Options.Migrations[1], [2], ... run once, in order)
	  * dirty-only autosave that still renews the lease for idle players
	  * parallel save on BindToClose with a deadline
	  * Studio memory mode, so play-testing never touches real data

	Credit: lease-in-the-save idea from aura-ascension DataService; retry + parallel BindToClose
	from steal-a-brainrot DataService; dirty-only autosave from steal-an-egg Core_PlayerData;
	"read a plain old save and wrap it" from rivals-modded PlayerDataService (legacy store).

	Usage (server Script):
		local SessionStore = require(game.ServerScriptService.SessionStore)

		local store = SessionStore.new("PlayerData_v1", {
			Coins = 0,
			Inventory = {},
			Settings = { Music = true },
		}, {
			Migrations = {
				-- [1] runs on saves made before migration 1 existed, and so on.
				[1] = function(data) data.Coins = math.floor(data.Coins or 0) end,
				[2] = function(data) data.Gems = (data.Diamonds or 0); data.Diamonds = nil end,
			},
		})

		store:OnLoaded(function(player, data)
			print(player.Name, "has", data.Coins, "coins")
		end)
		store:Start()

		-- Always change data through Update so it is marked dirty and saved:
		store:Update(player, function(data)
			data.Coins += 10
		end)
]]

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local SessionStore = {}
SessionStore.__index = SessionStore

local DEFAULT_OPTIONS = {
	KeyPrefix = "Player_",
	AutosaveInterval = 60, -- seconds between autosave passes
	LeaseSeconds = 300, -- a crashed server's lock frees itself after this long
	LoadAttempts = 6, -- tries before the player is kicked (another server may still be saving)
	RetryDelay = 2, -- seconds, multiplied by the attempt number
	SaveAttempts = 3,
	ShutdownTimeout = 25, -- BindToClose gives us about 30 seconds in total
	UseMemoryInStudio = true, -- Studio play-tests never read or write the real DataStore
	KickMessage = "Your data could not be loaded safely. Please rejoin in a moment.",
	Migrations = {},
}

local function deepCopy(value)
	if type(value) ~= "table" then
		return value
	end
	local copy = {}
	for key, child in pairs(value) do
		copy[deepCopy(key)] = deepCopy(child)
	end
	return copy
end

-- Fills in missing keys from the template without touching what the player already has.
local function reconcile(target, template)
	for key, default in pairs(template) do
		local current = target[key]
		if current == nil then
			target[key] = deepCopy(default)
		elseif type(current) == "table" and type(default) == "table" then
			reconcile(current, default)
		end
	end
end

function SessionStore.new(storeName, template, options)
	local opts = table.clone(DEFAULT_OPTIONS)
	for key, value in pairs(options or {}) do
		opts[key] = value
	end

	local self = setmetatable({}, SessionStore)
	self._template = template
	self._opts = opts
	self._migrationCount = #opts.Migrations
	self._memoryOnly = opts.UseMemoryInStudio and RunService:IsStudio()
	self._store = if self._memoryOnly then nil else DataStoreService:GetDataStore(storeName)
	self._sessionId = if game.JobId ~= "" then game.JobId else ("studio-" .. tostring(os.time()))
	self._records = {} -- [Player] = { Data = {...}, Meta = {...} }
	self._dirty = {} -- [Player] = true when there are unsaved changes
	self._busy = {} -- [Player] = true while a save is running
	self._callbacks = {}
	self._closing = false
	return self
end

function SessionStore:_key(player)
	return self._opts.KeyPrefix .. player.UserId
end

function SessionStore:_newRecord()
	return {
		Data = deepCopy(self._template),
		Meta = { Version = self._migrationCount, Session = "", LeaseUntil = 0, LastSave = 0 },
	}
end

-- Accepts nil (new player), a record, or a plain data table written by an older system.
function SessionStore:_normalize(saved)
	if type(saved) ~= "table" then
		return nil
	end
	if type(saved.Meta) ~= "table" or type(saved.Data) ~= "table" then
		saved = { Data = saved, Meta = { Version = 0 } }
	end
	local meta = saved.Meta
	meta.Version = tonumber(meta.Version) or 0
	meta.Session = if type(meta.Session) == "string" then meta.Session else ""
	meta.LeaseUntil = tonumber(meta.LeaseUntil) or 0
	meta.LastSave = tonumber(meta.LastSave) or 0
	return saved
end

function SessionStore:_isLockedByOther(record)
	local meta = record.Meta
	return meta.Session ~= "" and meta.Session ~= self._sessionId and meta.LeaseUntil > os.time()
end

function SessionStore:_migrate(record)
	local migrations = self._opts.Migrations
	for version = record.Meta.Version + 1, self._migrationCount do
		migrations[version](record.Data)
	end
	record.Meta.Version = self._migrationCount
	reconcile(record.Data, self._template)
end

function SessionStore:_load(player)
	if self._memoryOnly then
		return self:_newRecord()
	end

	local opts = self._opts
	for attempt = 1, opts.LoadAttempts do
		local loaded = nil
		local ok, err = pcall(function()
			self._store:UpdateAsync(self:_key(player), function(saved)
				local record = self:_normalize(saved) or self:_newRecord()
				if self:_isLockedByOther(record) then
					loaded = nil
					return nil -- another live server owns this player: write nothing
				end
				record.Meta.Session = self._sessionId
				record.Meta.LeaseUntil = os.time() + opts.LeaseSeconds
				loaded = record
				return record
			end)
		end)
		if ok and loaded then
			return loaded
		end
		if not ok then
			warn(("[SessionStore] Load attempt %d failed for %s: %s"):format(attempt, player.Name, tostring(err)))
		end
		if player.Parent ~= Players then
			return nil
		end
		task.wait(opts.RetryDelay * attempt)
	end
	return nil
end

-- Returns true when the save landed (or there was nothing to save).
function SessionStore:_save(player, release)
	local record = self._records[player]
	if not record then
		return true
	end

	local waitUntil = os.clock() + 15
	while self._busy[player] and os.clock() < waitUntil do
		task.wait(0.1)
	end
	if self._records[player] ~= record then
		return true -- released by the save we were waiting on
	end
	self._busy[player] = true
	self._dirty[player] = nil -- set again by Update calls that happen while we save

	local opts = self._opts
	local now = os.time()
	local snapshot = deepCopy(record)
	snapshot.Meta.LastSave = now
	snapshot.Meta.Session = if release then "" else self._sessionId
	snapshot.Meta.LeaseUntil = if release then 0 else now + opts.LeaseSeconds

	local saved, lost = self._memoryOnly, false
	if not self._memoryOnly then
		for attempt = 1, opts.SaveAttempts do
			local ok, err = pcall(function()
				self._store:UpdateAsync(self:_key(player), function(current)
					current = self:_normalize(current)
					if current and self:_isLockedByOther(current) then
						lost = true
						return nil -- our lease ran out and another server took over: never overwrite it
					end
					lost = false
					return snapshot
				end)
			end)
			if ok then
				saved = not lost
				break
			end
			warn(("[SessionStore] Save attempt %d failed for %s: %s"):format(attempt, player.Name, tostring(err)))
			if attempt < opts.SaveAttempts then
				task.wait(opts.RetryDelay * attempt)
			end
		end
	end

	self._busy[player] = nil
	if saved then
		record.Meta.LastSave = now
		record.Meta.LeaseUntil = snapshot.Meta.LeaseUntil
	else
		self._dirty[player] = true
	end

	if lost then
		self._records[player] = nil
		self._dirty[player] = nil
		if player.Parent == Players then
			player:Kick("Your data was opened on another server. Please rejoin.")
		end
	elseif release then
		self._records[player] = nil
		self._dirty[player] = nil
	end
	return saved
end

function SessionStore:_onJoin(player)
	local record = self:_load(player)
	if player.Parent ~= Players then
		if record then
			self._records[player] = record
			self:_save(player, true) -- left while loading: hand the lock back
		end
		return
	end
	if not record then
		player:Kick(self._opts.KickMessage)
		return
	end

	self:_migrate(record)
	self._records[player] = record
	for _, callback in ipairs(self._callbacks) do
		task.spawn(callback, player, record.Data)
	end
end

------------------------------------------------------------------------
-- Public API
------------------------------------------------------------------------

-- callback(player, data) runs once per player when their data is ready.
function SessionStore:OnLoaded(callback)
	table.insert(self._callbacks, callback)
	for player, record in pairs(self._records) do
		task.spawn(callback, player, record.Data)
	end
end

-- Live data table (or nil while loading). Treat it as read-only; write with Update.
function SessionStore:Get(player)
	local record = self._records[player]
	return record and record.Data
end

function SessionStore:WaitFor(player, timeout)
	local deadline = os.clock() + (timeout or 30)
	while not self._records[player] and player.Parent == Players and os.clock() < deadline do
		task.wait(0.1)
	end
	return self:Get(player)
end

-- mutator(data) changes the data in place. Returns false if the player is not loaded.
function SessionStore:Update(player, mutator)
	local record = self._records[player]
	if not record then
		return false
	end
	mutator(record.Data)
	self._dirty[player] = true
	return true
end

-- Save right now (for example straight after a Robux purchase). Yields.
function SessionStore:SaveNow(player)
	return self:_save(player, false)
end

function SessionStore:Start()
	Players.PlayerAdded:Connect(function(player)
		self:_onJoin(player)
	end)
	for _, player in ipairs(Players:GetPlayers()) do
		task.spawn(self._onJoin, self, player)
	end

	Players.PlayerRemoving:Connect(function(player)
		self:_save(player, true)
	end)

	task.spawn(function()
		local opts = self._opts
		while not self._closing do
			task.wait(opts.AutosaveInterval)
			local now = os.time()
			for player, record in pairs(self._records) do
				-- Idle players are saved too when their lease is half used, so the lock never lapses.
				local leaseLow = record.Meta.LeaseUntil - now < opts.LeaseSeconds / 2
				if (self._dirty[player] or leaseLow) and not self._busy[player] then
					task.spawn(self._save, self, player, false)
				end
			end
		end
	end)

	game:BindToClose(function()
		self._closing = true
		local pending = 0
		for player in pairs(self._records) do
			pending += 1
			task.spawn(function()
				self:_save(player, true)
				pending -= 1
			end)
		end
		local deadline = os.clock() + self._opts.ShutdownTimeout
		while pending > 0 and os.clock() < deadline do
			task.wait(0.1)
		end
		if pending > 0 then
			warn(("[SessionStore] Shutdown finished with %d saves still running"):format(pending))
		end
	end)
end

return SessionStore
