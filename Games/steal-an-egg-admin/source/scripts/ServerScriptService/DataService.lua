--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")

local Remotes = require(ReplicatedStorage.Shared.Remotes)
local DefaultStats = require(ReplicatedStorage.Shared.Modules.DefaultStats)

local DataService = {}

local DATASTORE_NAME = "PlayerData_v1"
local AUTOSAVE_INTERVAL = 60
local LOAD_ATTEMPTS = 5
local RETRY_DELAY = 3
local SESSION_LOCK_TIMEOUT = 120
local PROFILE_FETCH_TIMEOUT = 30
local FINAL_SAVE_ATTEMPTS = 3
local FINAL_SAVE_RETRY_DELAY = 1

local LEADERSTAT_FIELDS: { [string]: string } = {
	Money = "IntValue",
	SpeedPower = "NumberValue",
}

local sessions: { [number]: any } = {}
local loadFailed: { [number]: boolean } = {}
local loading: { [number]: boolean } = {}
local unloading: { [number]: boolean } = {}
local lastPlayTick: { [number]: number } = {}
local initialized = false

local dataStore: DataStore? = nil

local function deepCopy(source: any): any
	if type(source) ~= "table" then
		return source
	end
	local copy = {}
	for key, value in pairs(source) do
		copy[key] = deepCopy(value)
	end
	return copy
end

local function makeDefaultData(): any
	return deepCopy(DefaultStats)
end

local function keyFor(userId: number): string
	return "Player_" .. userId
end

local function lockKeyFor(userId: number): string
	return "Lock_" .. userId
end

local function isArray(value: any): boolean
	return type(value) == "table" and #value > 0
end

local function isFiniteNumber(n: any): boolean
	return type(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge
end

local function isPresent(player: Player): boolean
	return player.Parent ~= nil
end

local function deepMergeInto(target: any, source: any): any
	for key, value in pairs(source) do
		if type(value) == "table" then
			if isArray(value) then
				-- arrays are replaced wholesale, never merged by index
				target[key] = value
			elseif type(target[key]) == "table" and not isArray(target[key]) then
				deepMergeInto(target[key], value)
			else
				target[key] = value
			end
		else
			target[key] = value
		end
	end
	return target
end

local function mergeWithDefaults(saved: any): any
	local data = makeDefaultData()
	if type(saved) ~= "table" then
		return data
	end
	return deepMergeInto(data, saved)
end

-- Acquires the lock, or refreshes it if this server already owns it.
local function acquireLock(userId: number): boolean
	local store = dataStore
	if store == nil then
		return true
	end

	local ok, result = pcall(function()
		return store:UpdateAsync(lockKeyFor(userId), function(existing)
			local now = os.time()
			local heldByOther = existing ~= nil
				and type(existing.LockedAt) == "number"
				and (now - existing.LockedAt) < SESSION_LOCK_TIMEOUT
				and existing.SessionId ~= game.JobId

			if heldByOther then
				return nil
			end

			return {
				LockedAt = now,
				SessionId = game.JobId,
			}
		end)
	end)
	if not ok then
		return false
	end
	return result ~= nil and result.SessionId == game.JobId
end

-- Only releases a lock this server owns (UpdateAsync can't delete, so mark it expired).
local function releaseLock(userId: number)
	local store = dataStore
	if store == nil then
		return
	end
	pcall(function()
		store:UpdateAsync(lockKeyFor(userId), function(existing)
			if type(existing) == "table" and existing.SessionId == game.JobId then
				return {
					LockedAt = 0,
					SessionId = game.JobId,
				}
			end
			return nil
		end)
	end)
end

local function saveData(userId: number, data: any): (boolean, string?)
	local store = dataStore
	if store == nil then
		return false, "no datastore"
	end
	if loadFailed[userId] then
		return false, "load previously failed; save skipped"
	end
	if type(data) ~= "table" then
		return false, "invalid data"
	end

	local ok, err = pcall(function()
		data.LastSave = os.time()
		store:SetAsync(keyFor(userId), data)
	end)
	return ok, if ok then nil else tostring(err)
end

local function saveWithRetry(userId: number, data: any, attempts: number): (boolean, string?)
	local ok, err = saveData(userId, data)
	local attempt = 1
	-- only retry failures that could be transient
	while not ok and attempt < attempts and dataStore ~= nil and not loadFailed[userId] and type(data) == "table" do
		task.wait(FINAL_SAVE_RETRY_DELAY)
		attempt += 1
		ok, err = saveData(userId, data)
	end
	return ok, err
end

local function accruePlayTime(userId: number, data: any)
	local now = os.clock()
	local last = lastPlayTick[userId]
	lastPlayTick[userId] = now
	if last ~= nil and type(data.PlayTimeSeconds) == "number" then
		data.PlayTimeSeconds += now - last
	end
end

function DataService.Get(player: any): any
	if typeof(player) ~= "Instance" or not player:IsA("Player") then
		return nil
	end
	return sessions[player.UserId]
end

function DataService.IsLoaded(player: any): boolean
	return DataService.Get(player) ~= nil
end

function DataService.GetField(player: any, key: any, defaultValue: any): any
	local data = DataService.Get(player)
	if data == nil then
		return defaultValue
	end
	local value = data[key]
	if value == nil then
		return defaultValue
	end
	return value
end

function DataService.SyncChanges(player: any, changes: any, removed: any?)
	if typeof(player) ~= "Instance" or not player:IsA("Player") then
		return
	end
	if type(changes) ~= "table" then
		return
	end

	Remotes.ProfileMirror.ProfileDelta:FireClient(player, changes, removed or {}, player)

	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats ~= nil then
		for key, value in changes do
			local name = tostring(key)
			local className = LEADERSTAT_FIELDS[name]
			if className ~= nil and type(value) == "number" then
				local stat = leaderstats:FindFirstChild(name)
				if stat ~= nil and stat:IsA(className) then
					local valueObject: any = stat
					valueObject.Value = value
				end
			end
		end
	end
end

function DataService.SyncChange(player: any, key: any, value: any)
	if value == nil then
		DataService.SyncChanges(player, {}, { key })
	else
		DataService.SyncChanges(player, { [key] = value })
	end
end

function DataService.SetField(player: any, key: any, value: any): boolean
	local data = DataService.Get(player)
	if data == nil then
		return false
	end
	data[key] = value
	DataService.SyncChange(player, key, value)
	return true
end

local function addToNumberField(player: any, field: string, amount: any): boolean
	local data = DataService.Get(player)
	if data == nil or not isFiniteNumber(amount) then
		return false
	end
	local current = if type(data[field]) == "number" then data[field] else 0
	data[field] = current + amount
	DataService.SyncChange(player, field, data[field])
	return true
end

function DataService.AddMoney(player: any, amount: number): boolean
	return addToNumberField(player, "Money", amount)
end

function DataService.SetMoney(player: any, value: number): boolean
	if typeof(player) ~= "Instance" or not player:IsA("Player") then
		return false
	end
	local data = sessions[player.UserId]
	if data == nil or not isFiniteNumber(value) then
		return false
	end
	local amount = math.floor(math.max(0, value))
	data.Money = amount
	DataService.SyncChange(player, "Money", amount)
	return true
end

function DataService.AddSpeedPower(player: any, amount: number): boolean
	return addToNumberField(player, "SpeedPower", amount)
end

function DataService.WaitForProfile(player: any, timeout: number?): any
	if typeof(player) ~= "Instance" or not player:IsA("Player") then
		return nil
	end
	local deadline = os.clock() + (timeout or 10)
	while true do
		local data = sessions[player.UserId]
		if data ~= nil then
			return data
		end
		if os.clock() >= deadline or player.Parent == nil then
			return sessions[player.UserId]
		end
		task.wait(0.1)
	end
end

local function applyLeaderstats(player: Player)
	local data = sessions[player.UserId]
	if data == nil then
		return
	end

	local leaderstats: Folder
	local isNew = false
	local existing = player:FindFirstChild("leaderstats")
	if existing ~= nil and existing:IsA("Folder") then
		leaderstats = existing
	else
		if existing ~= nil then
			existing:Destroy()
		end
		leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		isNew = true
	end

	for field, className in LEADERSTAT_FIELDS do
		local found = leaderstats:FindFirstChild(field)
		if found ~= nil and not found:IsA(className) then
			found:Destroy()
			found = nil
		end
		local stat: any = found
		if stat == nil then
			stat = Instance.new(className)
			stat.Name = field
			stat.Parent = leaderstats
		end
		local value = data[field]
		stat.Value = if type(value) == "number" then value else 0
	end

	if isNew then
		leaderstats.Parent = player -- parent last so clients get a populated folder
	end
end

function DataService.ForceSave(player: any)
	if typeof(player) ~= "Instance" or not player:IsA("Player") then
		return
	end
	local data = sessions[player.UserId]
	if data == nil then
		return
	end
	accruePlayTime(player.UserId, data)
	local ok, err = saveData(player.UserId, data)
	if not ok then
		warn(("[DataService] Save failed for %d: %s"):format(player.UserId, tostring(err)))
	end
end

local function startAutosave(player: Player, session: any)
	local userId = player.UserId
	task.spawn(function()
		-- bound to this exact session table so a rejoin can't leave two loops running
		while sessions[userId] == session and not unloading[userId] do
			task.wait(AUTOSAVE_INTERVAL)
			if sessions[userId] ~= session or unloading[userId] then
				break
			end
			if loadFailed[userId] then
				continue -- nothing safe to save
			end

			accruePlayTime(userId, session)

			if not acquireLock(userId) then
				warn(("[DataService] Lock refresh failed for %s; skipping autosave"):format(player.Name))
				continue
			end

			local ok, err = saveData(userId, session)
			if not ok then
				warn(("[DataService] Autosave failed for %s: %s"):format(player.Name, tostring(err)))
			end
		end
	end)
end

local function loadPlayer(player: Player)
	local userId = player.UserId
	if sessions[userId] ~= nil or loading[userId] then
		return
	end
	loading[userId] = true

	-- 1) acquire session lock
	local locked = false
	for attempt = 1, LOAD_ATTEMPTS do
		if not isPresent(player) then
			loading[userId] = nil
			return
		end
		if acquireLock(userId) then
			locked = true
			break
		end
		warn(("[DataService] Could not lock data for %s (attempt %d); retrying..."):format(player.Name, attempt))
		if attempt < LOAD_ATTEMPTS then
			task.wait(RETRY_DELAY)
		end
	end

	if not isPresent(player) then
		loading[userId] = nil
		if locked then
			releaseLock(userId)
		end
		return
	end

	if not locked then
		warn(("[DataService] Could not lock data for %s; using temporary default data (will not save)"):format(player.Name))
		loadFailed[userId] = true
		sessions[userId] = makeDefaultData()
		lastPlayTick[userId] = os.clock()
		loading[userId] = nil
		applyLeaderstats(player)
		return
	end

	-- 2) load data, distinguishing "new player" from "load failed"
	local store = dataStore
	local loadOk = false
	local saved: any = nil
	if store ~= nil then
		for attempt = 1, LOAD_ATTEMPTS do
			local ok, result = pcall(function()
				return store:GetAsync(keyFor(userId))
			end)
			if ok then
				saved = result
				loadOk = true
				break
			end
			if attempt == LOAD_ATTEMPTS then
				warn(("[DataService] Load failed for %s: %s"):format(player.Name, tostring(result)))
			else
				task.wait(RETRY_DELAY)
			end
		end
	end

	if not isPresent(player) then
		loading[userId] = nil
		releaseLock(userId)
		return
	end

	local session: any
	if loadOk then
		session = mergeWithDefaults(saved) -- saved == nil -> genuine new player -> defaults
	else
		loadFailed[userId] = true -- never overwrite real data with defaults
		session = makeDefaultData()
	end

	sessions[userId] = session
	lastPlayTick[userId] = os.clock()
	loading[userId] = nil

	applyLeaderstats(player)
	startAutosave(player, session)
end

local function unloadPlayer(player: Player)
	local userId = player.UserId
	local data = sessions[userId]
	if data == nil or unloading[userId] then
		return
	end
	unloading[userId] = true

	accruePlayTime(userId, data)
	local ok, err = saveWithRetry(userId, data, FINAL_SAVE_ATTEMPTS)
	if not ok then
		warn(("[DataService] Final save failed for %s: %s"):format(player.Name, tostring(err)))
	end

	sessions[userId] = nil
	loadFailed[userId] = nil
	lastPlayTick[userId] = nil
	unloading[userId] = nil
	releaseLock(userId)
end

function DataService.Init()
	if initialized then
		return
	end
	initialized = true

	local ok, store = pcall(function()
		return DataStoreService:GetDataStore(DATASTORE_NAME)
	end)
	if ok then
		dataStore = store
	else
		warn("[DataService] DataStore unavailable: " .. tostring(store))
	end

	Remotes.ProfileMirror.FetchProfile.OnServerInvoke = function(requester, requestedPlayer)
		local target = requester
		if typeof(requestedPlayer) == "Instance" and requestedPlayer:IsA("Player") then
			target = requestedPlayer
		end

		local profile = DataService.WaitForProfile(target, PROFILE_FETCH_TIMEOUT)
		if profile == nil then
			warn(("[DataService] FetchProfile timed out for %s (%d)"):format(target.Name, target.UserId))
			return nil
		end
		return deepCopy(profile)
	end

	Players.PlayerAdded:Connect(function(player)
		task.spawn(loadPlayer, player)
	end)
	Players.PlayerRemoving:Connect(unloadPlayer)

	game:BindToClose(function()
		local pending = 0
		for _, player in Players:GetPlayers() do
			pending += 1
			task.spawn(function()
				unloadPlayer(player)
				pending -= 1
			end)
		end
		-- also wait for unloads already started by PlayerRemoving
		while pending > 0 or next(unloading) ~= nil do
			task.wait()
		end
	end)
end

function DataService.Start()
	for _, player in Players:GetPlayers() do
		task.spawn(loadPlayer, player)
	end
end

return DataService