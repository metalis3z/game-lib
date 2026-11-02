--!strict

--[[

This is a User object for managing user data and state
It includes behaviour for loading user data, getting policy information, and managing
the automatic saving and replication of user data.
This is especially useful for Commands which accept User objects (instead of the Player instance)
so you can create 'fake users' with, say, elevated permissions,
without having to build any additional logic around to account for these.

Overview:
	- There are three main State objects: user.perm, user.temp, and User.everyone
	- Data within user.perm is persistent and saved to the datastore
	- Data is saved on a need-to-save basis, and when the player leaves, with
	  cooldowns and delays to handle limits appropriately. Data is serialized and (if specified) compressed.
	- Data within user.temp is temporary and not saved to the datastore
	- *Everyone* within User.everyone is retrievable by *everyone* (all clients)
	- 'Public' data within user.perm and user.temp is retrievable by the client of the user
	- 'Private' data within user.perm and user.temp is not retrievable
	- Public and Private data can be customised within the modules under DataStores
	- Values are set with :set, for example, perm:set("Cash", 100)
	- Values are viewed with :get, for example, local cash = perm:get("Cash")
	- Values can also be listened with :onBind and :onChange - see State for more details
	- User objects are automatically destroyed if its given key is a player and when
	  that player leaves the game
	- To stop rapid leave/join abuse, the user will block the loading of user data if their
	  total saves within the last minute exceed 5. This will rarely if never be exceeded
	  (maybe unless teleporting a lot and rapidly between servers), and is essential in
	  stopping malicious users from destroying the game's global limits

--]]


-- CONFIG
local SAVE_IN_STUDIO = false
local AUTO_SAVE_COOLDOWN = 60
local SESSION_LOCK_RELEASE_RETRIES = 4
local MAX_SAVES_PER_MINUTE = 5


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local users: {[string]: Class} = {}
local Janitor = require(modules.Objects.Janitor)
local State = require(modules.Objects.State)
local Signal = require(modules.Objects.Signal)
local IsolatedServer = require(modules.IsolatedServer)
local User = {}
User.__index = User


-- PUBLIC
User.userAdded = Signal.new()
User.userLoaded = Signal.new()
User.userRemoved = Signal.new()
User.everyone = State.new(false)


-- LOCAL FUNCTIONS
-- datastore noise (session locks, save/load retries) is only useful while debugging in Studio
local function studioWarn(message: string)
	if RunService:IsStudio() then
		warn(message)
	end
end

-- Once per key per server so a stuck load doesn't spam from every getUserAsync call site
local slowLoadWarned: {[string]: boolean} = {}


-- FUNCTIONS
function User.getRealKey(playerOrKey: UserKey): (string, boolean)
	-- If is a player object, then their actual key becomes tostring(player.UserId)
	local isPlayer = if typeof(playerOrKey) == "Instance" and playerOrKey:IsA("Player") then true else false
	if isPlayer then
		playerOrKey = playerOrKey :: Player
		return tostring(playerOrKey.UserId), isPlayer
	elseif typeof(playerOrKey) == "string" then
		return playerOrKey, isPlayer
	elseif typeof(playerOrKey) == "number" then
		return tostring(playerOrKey), isPlayer
	end
	error(`playerOrKey '{playerOrKey}' must be a Player or string`)
end

function User.getUser(playerOrKey: UserKey, canBeUnloaded: boolean?): Class?
	local realKey = User.getRealKey(playerOrKey)
	local user = users[realKey]
	if not user then
		return nil
	end
	local isLoaded = if user then user.isLoaded :: boolean else nil
	if not canBeUnloaded and isLoaded == false then
		return nil -- User must be loaded!
	end
	return user
end

function User.getUserByUserId(userId: number | string, canBeUnloaded: boolean?): Class?
	if typeof(userId) == "string" then
		local users = User.getUsers()
		for _, user in users do
			if user.userId == userId then
				return user
			end
		end
		return nil
	end
	local player = Players:GetPlayerByUserId(userId)
	if not player then
		return nil
	end
	return User.getUser(player, canBeUnloaded)
end

function User.getUserAsync(playerOrKey: UserKey): (boolean, Class)
	-- GameStores (Game, Members, etc) are often created some frames after User.getUserAsync is called
	-- from other locations, therefore instead of returning 'no store' after waiting a single frame
	-- for GameStores, we instead wait indefinitely as there's almost the guarantee that they will be
	-- created (unlike player keys where the player could easily leave, etc)
	local realKey, isPlayer = User.getRealKey(playerOrKey)
	local isGameStore = not isPlayer and typeof(realKey) == "string" and tonumber(realKey) == nil
	local checks = 0
	local hasWarned = false
	local startClock = os.clock()
	while true do
		if isPlayer and typeof(playerOrKey) == "Instance" and playerOrKey.Parent == nil then
			return false, `Player '{playerOrKey.Name}' ({playerOrKey.UserId}) left the server` :: any
		end
		local user = users[realKey]
		if not user and checks > 0 and not isGameStore then
			return false, `User '{realKey}' does not exist`  :: any
		end
		local isLoaded = if user then user.isLoaded :: boolean else nil
		if user and isLoaded == true then
			return true, user
		end
		if isGameStore and not user and not hasWarned and os.clock() - startClock > 10 then
			hasWarned = true
			warn(`HD Admin: still waiting for user '{realKey}' to be created. Does anything create it?`)
		end
		if user and isLoaded ~= true and not slowLoadWarned[realKey] and os.clock() - startClock > 30 then
			slowLoadWarned[realKey] = true
			warn(`HD Admin: user '{realKey}' still hasn't finished loading after 30 seconds`)
		end
		checks += 1
		task.wait()
	end
end

function User.getUsers(canBeUnloaded: boolean?): {Class}
	local usersArray = {}
	for _, user in users do
		user = user :: Class
		if not canBeUnloaded and user.isLoaded == false then
			continue
		end
		table.insert(usersArray, user)
	end
	return usersArray :: {Class}
end

function User._getSavesThisMinute(dataTable, andIncrement)
	local nextRefreshTime = dataTable._nextRefreshTime :: number?
	local timeNow = os.time()
	if nextRefreshTime == nil or timeNow >= nextRefreshTime then
		nextRefreshTime = timeNow + 60
		dataTable._nextRefreshTime = nextRefreshTime
		dataTable._savesThisMinute = nil :: any
	end
	local savesThisMinute: number = dataTable._savesThisMinute or 0
	if andIncrement then
		savesThisMinute += 1
		dataTable._savesThisMinute = savesThisMinute
	end
	return savesThisMinute
end

function User.incrementSavesThisMinute(dataTable)
	return User._getSavesThisMinute(dataTable, true)
end


-- CONSTRUCTOR
function User.new(playerOrKey: UserKey, dataStoreName: string?, options: Options?)

	local realKey, isPlayer = User.getRealKey(playerOrKey)
	local janitor = Janitor.new()
	local player = if isPlayer then playerOrKey :: Player else nil
	local userId = if isPlayer and player then player.UserId else realKey
	local self = {
		janitor = janitor,
		perm = State.new(true), -- We don't destroy perm until after a successful save and release
		temp = janitor:add(State.new(false)),
		beforeLoading = janitor:add(Signal.new()),
		beforeSaving = janitor:add(Signal.new()),
		realKey = realKey :: string,
		player = player,
		userId = userId :: number | string,
		policyInfo = {},
		policyInfoLoaded = false :: boolean,
		isPlayer = isPlayer :: boolean,
		isLoading = false :: boolean,
		isLoaded = false :: any,
		isActive = true :: boolean,
		sessionLocking = true :: boolean,
		blockLoadingAndSaving = false :: boolean,
		crossServerCommunication = false :: boolean,
		compressData = false :: boolean,
		partitionData = false :: boolean,
		_userOptions = options,
	}
	setmetatable(self, User)

	-- A player can rejoin before their old user is removed - destroy the old
	-- one and replace it
	local oldUser = users[realKey] :: any?
	if oldUser then
		oldUser:destroy()
	end
	users[realKey] = self
	User.userAdded:Fire(self)
	janitor:add(function()
		if users[realKey] == self then
			users[realKey] = nil
		end
		User.userRemoved:Fire(self)
	end)

	-- If a player is present, destroy this user when the player leaves
	-- We load policyInfo early so server and client can read it as soon as possible
	-- (assuming Public temp contains 'PolicyInfo')
	if player then
		task.spawn(function()
			while self.isActive and not self.policyInfo do
				self:getPolicyInfoAsync()
				task.wait()
			end
		end)
		janitor:add(player.AncestryChanged:Connect(function()
			if player.Parent == nil then
				self:destroy()
			end
		end))
	end

	if dataStoreName then
		self:_loadAndAutoSaveData(dataStoreName)
	else
		self:_resolveOptions()
	end

	return self
end


-- CLASS
export type Class = typeof(User.new(...))
export type UserKey = (Player | string | number)?
export type Options = {
	sessionLocking: boolean?,
	blockLoadingAndSaving: boolean?,
	crossServerCommunication: boolean?,
	compressData: boolean?,
	partitionData: boolean?,
}


-- METHODS
local OPTIONS_DEFAULTS: {[string]: boolean} = {
	sessionLocking = true,
	blockLoadingAndSaving = false,
	crossServerCommunication = false,
	compressData = false,
	partitionData = false,
}

function User._resolveOptions(self: Class, storeOptions: Options?)
	local base = storeOptions or {} :: Options
	local userOptions = self._userOptions :: Options?
	for key, default in OPTIONS_DEFAULTS do
		local storeValue = (base :: any)[key]
		local userValue = if userOptions then (userOptions :: any)[key] else nil
		-- User options override store defaults, which override global defaults
		local resolved = if userValue ~= nil then userValue elseif storeValue ~= nil then storeValue else default
		;(self :: any)[key] = resolved
	end
	if self.sessionLocking and self.crossServerCommunication then
		error("sessionLocking and crossServerCommunication cannot both be enabled")
	end
	if self.partitionData and not self.crossServerCommunication then
		error("partitionData requires crossServerCommunication to be enabled")
	end
end

function User._loadAndAutoSaveData(self: Class, dataStoreName: string)
	if typeof(dataStoreName) ~= "string" then
		error("dataStoreName must be a string")
	end
	local dataStores = modules.DataStores
	local store = dataStores:FindFirstChild(dataStoreName)
	if not store then
		error(`DataStore '{dataStoreName}' does not exist`)
	end
	if self.isLoading or self.isLoaded or self.isActive == false then
		return
	end
	
	local DataStores = require(dataStores) :: any
	local Store = require(store) :: any
	self:_resolveOptions(Store.options)
	local template = Store.generateTemplate(self)
	local janitor = self.janitor
	local player = self.player
	local perm: State.Class = self.perm
	local temp: State.Class = self.temp
	local permitSaveAndLoad = not self.blockLoadingAndSaving
	local startData = {
		perm = {},
		temp = {},
	}

	local function getPathwaysToLimitTo(dataType)
		local limiters: {any} = {}
		for _, detail in template do
			detail = detail :: {any}
			local items = detail[3]
			local startTable = startData[dataType]
			local visibility = detail[2] :: string
			if detail[1] == dataType then
				if visibility == "public" then
					for key, _ in items do
						local pathway = {key}
						table.insert(limiters, pathway)
					end
				end
				for key, value in items do
					startTable[key] = value
				end
			end
		end
		return limiters :: {{string}}
	end

	-- Always fill in startData from the template (for both player and non-player users)
	local permLimiters = getPathwaysToLimitTo("perm")
	local tempLimiters = getPathwaysToLimitTo("temp")
	if player and typeof(player) == "Instance" and player:IsA("Player") then
		local function yieldUntilLoaded()
			User.getUserAsync(self.realKey)
		end
		janitor:add(perm:replicate(player, `UserPerm`, permLimiters, yieldUntilLoaded))
		janitor:add(temp:replicate(player, `UserTemp`, tempLimiters))
		janitor:add(User.everyone:replicate(player, `UserEveryone`))
	end
	
	-- We set temp data so it can be accessed via .getUser(key, true) even if perm data hasn't loaded
	temp:setAll(startData.temp)
	
	-- We attempt to load data indefinitely until success or until the player leaves
	local loadedData: any = nil
	local realKey = self.realKey
	local Serializer = require(modules.Serializer)
	local waitTimeRetry = 2
	local retries = 0
	local isCSC = self.crossServerCommunication :: boolean
	local sessionLockJobId: string? = nil
	local lockTakenForReal = false

	if isCSC then
		-- We read via the MemoryStore snapshot caches so 100k+ servers
		--  can be supported if for example they all reset and request data loads
		local usePartitions = self.partitionData :: boolean
		local SnapshotPartition: any = nil
		local partitionCount = 0
		if usePartitions then
			SnapshotPartition = require(modules.DataStores.SnapshotPartition)
			local configSettings = require(modules.Parent.Services.Config.Settings)
			partitionCount = configSettings.SystemSettings.Partitions or 5
		end
		while permitSaveAndLoad do
			if self.isActive == false then
				return
			end
			local function readFromDataStore(): (boolean, any)
				return DataStores.getAsync(dataStoreName, realKey)
			end
			local success: boolean, result: any
			local snapshotMeta: any = nil
			if usePartitions then
				success, result, snapshotMeta = SnapshotPartition.getSnapshot(
					dataStoreName, realKey, partitionCount, readFromDataStore
				)
			else
				success, result = readFromDataStore()
			end
			if success then
				local incomingData = result
				if typeof(incomingData) == "string" then
					incomingData = Serializer.decompress(incomingData)
				end
				if typeof(incomingData) ~= "table" then
					incomingData = {}
				end
				loadedData = incomingData
				-- The data is valid but may be stale (partition count changed
				-- between deploys, or snapshot is approaching its 45-day TTL)
				if usePartitions and SnapshotPartition.needsMigration(snapshotMeta, partitionCount) then
					SnapshotPartition.scheduleBackgroundMigration(
						dataStoreName, realKey, partitionCount, readFromDataStore
					)
				end
				break
			end
			-- Studio with API access disabled
			if DataStores.isStudioApiBlocked() then
				loadedData = {}
				break
			end
			-- A load failure stalls everything downstream so this must stay visible in live servers
			warn(`HD Admin failed to load data for '{realKey}' from '{dataStoreName}': {result}`)
			waitTimeRetry *= 2
			retries += 1
			task.wait(waitTimeRetry)
		end
	else
		-- Standard loading uses UpdateAsync with session locking
		local firstSessionLockRejectTime: number? = nil
		while permitSaveAndLoad do
			if self.isActive == false then
				return
			end
			local dataHasLoaded = true
			local dataFailedReason = nil
			local customWaitTime: number? = nil
			local success, warning = DataStores.updateAsync(dataStoreName, realKey, function(incomingData: any)
				if typeof(incomingData) == "string" then
					incomingData = Serializer.decompress(incomingData)
				end
				if typeof(incomingData) ~= "table" then
					incomingData = {}
				end
				local timeNow = os.time()
				local permitSessionLocking = self.sessionLocking :: boolean
				local lockActive, incomingSessionLock = DataStores.isSessionLockActive(incomingData)
				if permitSessionLocking and lockActive then
					if firstSessionLockRejectTime == nil then
						firstSessionLockRejectTime = timeNow
					end
					local timeSinceFirstReject = timeNow - firstSessionLockRejectTime :: number
					local keepRetrying = retries < SESSION_LOCK_RELEASE_RETRIES
					if keepRetrying or incomingSessionLock == "Studio" or RunService:IsStudio() then
						dataFailedReason = "Unable to load data as it is currently session locked"
						dataHasLoaded = false
						return nil
					end
					warn(`HD admin ignored session lock for user '{realKey}' as it was locked for over {timeSinceFirstReject} seconds - this may result in a loss of progress. This should only happen in rare occassions where Roblox's datastores fail for an extended period. If this regularly occurs, contact ForeverHD.`)
				end
				loadedData = incomingData
				if SAVE_IN_STUDIO == false and RunService:IsStudio() then
					return nil
				end
				local savesThisMinute = User._getSavesThisMinute(loadedData)
				if savesThisMinute > MAX_SAVES_PER_MINUTE then
					local nextRefreshTime = loadedData._nextRefreshTime + 1 or timeNow + 3
					dataFailedReason = "Unable to load data as user has exceeded the maximum saves per minute"
					dataHasLoaded = false
					customWaitTime = nextRefreshTime - timeNow
					return nil
				end
				local jobId = if RunService:IsStudio() then "Studio" else game.JobId
				if permitSessionLocking then
					loadedData._sessionLock = jobId
					loadedData._lastSavedTime = os.time() -- isSessionLockActive bases locks off this, so without it the lock never expires
					sessionLockJobId = jobId
					lockTakenForReal = not IsolatedServer.isIsolated()
				end
				User.incrementSavesThisMinute(loadedData)
				return loadedData
			end)
			if dataFailedReason then
				warning = dataFailedReason
			end
			if success and dataHasLoaded then
				break
			end
			-- Studio with API access disabled: stop retrying and fall through with
			-- an empty table so the template defaults take over
			if DataStores.isStudioApiBlocked() then
				loadedData = {}
				break
			end
			if customWaitTime then
				task.wait(customWaitTime)
			else
				-- Same as the CSC loop above, load failures must stay visible in live servers
				warn(`HD Admin failed to load data for '{realKey}' from '{dataStoreName}': {warning}`)
				waitTimeRetry *= 2
				retries += 1
				task.wait(waitTimeRetry)
			end
		end
	end

	-- Cancel if user destroyed
	if self.isActive == false then
		return
	end

	-- The real store still holds the session lock this load wrote, and once isolated
	-- our saves can never refresh or clear, so we release it there directly rather
	-- than leaving other servers blocked until it expires
	if lockTakenForReal and sessionLockJobId then
		janitor:add(IsolatedServer.onIsolate(function()
			DataStores._updateRealAsync(dataStoreName, realKey, function(incomingData: any)
				local wasCompressed = typeof(incomingData) == "string"
				if wasCompressed then
					incomingData = Serializer.decompress(incomingData)
				end
				if typeof(incomingData) ~= "table" or incomingData._sessionLock ~= sessionLockJobId then
					return nil
				end
				incomingData._sessionLock = nil
				if wasCompressed then
					incomingData = Serializer.compress(incomingData)
				end
				return incomingData
			end)
		end))
	end

	-- Provide another warning of success if initially failed
	if retries > 0 then
		warn(`HD Admin finally loaded data for '{realKey}' from '{dataStoreName} after {retries} retries`)
	end

	-- Deserialize data if was originally serialized
	if typeof(loadedData) == "table" and loadedData._isSerialized == true then
		loadedData = loadedData :: any
		loadedData._isSerialized = nil
		loadedData = Serializer.deserialize(loadedData)
	end

	local gdprUserIds = {}
	if player then
		table.insert(gdprUserIds, player.UserId)
	end

	local deepCopyTable = require(modules.TableUtil.deepCopyTable)
	local templateDefaults = deepCopyTable(startData.perm)

	-- _savedChanges holds only values that differ from templateDefaults
	-- This is what gets persisted to DataStore instead of the full perm data
	local _savedChanges: {[string]: any} = {}

	-- Fill in _savedChanges from the loaded DataStore data, then merge saved values
	-- onto the template to produce the full perm state
	local permStartData = startData.perm
	if typeof(loadedData) == "table" then
		loadedData._lastSavedTime = nil
		loadedData._isSerialized = nil
		loadedData._sessionLock = nil
		loadedData._nextRefreshTime = nil
		loadedData._savesThisMinute = nil
		loadedData._prev = nil -- legacy: was used by the now-removed cascade system

		-- The remaining loadedData keys are the sparse saved changes
		-- Fill in _savedChanges and merge onto the template
		local function mergeAndTrack(saved: any, template: any, target: any, changes: any)
			for key, value in saved do
				if typeof(value) == "table" and #value == 0 then
					local templateChild = if typeof(template) == "table" then template[key] else nil
					local targetChild = target[key]
					if typeof(targetChild) ~= "table" then
						targetChild = {}
						target[key] = targetChild
					end
					local changesChild = changes[key]
					if typeof(changesChild) ~= "table" then
						changesChild = {}
						changes[key] = changesChild
					end
					mergeAndTrack(value, templateChild, targetChild, changesChild)
				else
					target[key] = value
					changes[key] = value
				end
			end
		end
		mergeAndTrack(loadedData :: any, templateDefaults, permStartData, _savedChanges)
	end
	perm:setAll(permStartData :: any)

	-- Expose on self so Store modules (like beforeLoading hooks) can access them
	;(self :: any)._savedChanges = _savedChanges
	;(self :: any)._templateDefaults = templateDefaults
	-- We initialise the _lastCSCSnapshot to the current saved state so the next CSC publish
	-- only sends what has actually changed since this session loaded instead of every
	-- pre-existing entry
	;(self :: any)._lastCSCSnapshot = deepCopyTable(_savedChanges)

	-- Shared helpers: walk templateDefaults to find the default at a path, and
	-- sparse-update a tracker table (used by both the local perm:onAnyChange
	-- tracker and the CSC callback below)
	local function templateValueAt(pathway: {string}): any
		local current: any = templateDefaults
		for _, key in pathway do
			if typeof(current) == "table" then
				current = current[key]
			else
				return nil
			end
		end
		return current
	end
	local function setNested(tbl: any, path: {string}, val: any, removeIfNil: boolean)
		local chain = {tbl}
		for index = 1, #path - 1 do
			local key = path[index]
			if typeof(tbl[key]) ~= "table" then
				if removeIfNil then return end
				tbl[key] = {}
			end
			tbl = tbl[key]
			table.insert(chain, tbl)
		end
		local finalKey = path[#path]
		if removeIfNil then
			tbl[finalKey] = nil
			-- Walk up and remove any now-empty parent tables so the tracker only holds the changed fields
			for chainIndex = #chain, 2, -1 do
				if next(chain[chainIndex]) == nil then
					chain[chainIndex - 1][path[chainIndex - 1]] = nil
				else
					break
				end
			end
		else
			tbl[finalKey] = val
		end
	end

	local isReleasingProfile = false
	local hasReleasedProfile = false
	local serverIsShuttingDown = false
	local trackingChanges = false

	local function buildDataToSave(): any
		local dataToSave = deepCopyTable(_savedChanges)
		dataToSave._isSerialized = true
		dataToSave._lastSavedTime = os.time()
		return dataToSave
	end

	local function saveAsync()
		if not permitSaveAndLoad then
			return false, "Saving and loading blocked for this user"
		end
		if isReleasingProfile then
			return false, "Already releasing profile"
		end
		if SAVE_IN_STUDIO == false and RunService:IsStudio() then
			hasReleasedProfile = true
			return false, "In studio"
		end
		local isActive = self.isActive :: boolean
		local isFinalSave = isActive == false or serverIsShuttingDown
		-- Only save when there are actual changes (applies to both modes)
		if next(_savedChanges) == nil then
			-- The load wrote our session lock into the DataStore, so a no-change leave must
			-- still clear it, otherwise players who change nothing lock themselves out of
			-- their next join until the lock ages out
			if isFinalSave and self.sessionLocking and sessionLockJobId then
				DataStores.updateAsync(dataStoreName, realKey, function(incomingData: any)
					local wasCompressed = typeof(incomingData) == "string"
					if wasCompressed then
						incomingData = Serializer.decompress(incomingData)
					end
					if typeof(incomingData) ~= "table" or incomingData._sessionLock ~= sessionLockJobId then
						return nil
					end
					incomingData._sessionLock = nil
					if wasCompressed then
						incomingData = Serializer.compress(incomingData)
					end
					return incomingData
				end)
			end
			hasReleasedProfile = true
			return false, "No pending changes"
		end
		if isFinalSave then
			isReleasingProfile = true
		end
		local beforeSaving = self.beforeSaving :: Signal.Signal<any>
		trackingChanges = false
		beforeSaving:Fire(isReleasingProfile)
		trackingChanges = true

		if isCSC then
			local snapshot = deepCopyTable(_savedChanges)
			-- We diff against the last-published snapshot to find only the keys that
			-- changed since last publish otherwise we'd re-publish stale values
			-- that clobber concurrent changes from other servers
			local lastSnapshot: any = (self :: any)._lastCSCSnapshot or {}
			local changes: {{any}} = {}
			local areValuesEqual = require(modules.DataUtil.areValuesEqual)
			local function diffAdditions(src: any, prev: any, pathway: {string})
				for key, value in src do
					local childPathway = table.clone(pathway)
					table.insert(childPathway, key)
					local prevValue = if typeof(prev) == "table" then prev[key] else nil
					-- An empty table must be treated as a value, not recursed into,
					-- otherwise it never reaches the changes list and silently vanishes
					-- from the save (like a perm entry's modifiers = {spawn = {}})
					if typeof(value) == "table" and #value == 0 and next(value) ~= nil then
						diffAdditions(value, if typeof(prevValue) == "table" then prevValue else nil, childPathway)
					else
						if not areValuesEqual(value, prevValue) then
							table.insert(changes, {childPathway, value})
						end
					end
				end
			end
			local function collectRemovals(prev: any, current: any, pathway: {string})
				if typeof(prev) ~= "table" then return end
				for key, prevValue in prev do
					local childPathway = table.clone(pathway)
					table.insert(childPathway, key)
					local currentValue = if typeof(current) == "table" then current[key] else nil
					if typeof(prevValue) == "table" then
						if typeof(currentValue) == "table" then
							collectRemovals(prevValue, currentValue, childPathway)
						else
							table.insert(changes, {childPathway, nil, "remove"})
						end
					else
						if currentValue == nil then
							-- Lua can't store nil reliably as the 2nd element
							table.insert(changes, {childPathway, nil, "remove"})
						end
					end
				end
			end
			diffAdditions(snapshot, lastSnapshot, {})
			collectRemovals(lastSnapshot, snapshot, {})
			-- Captured inside the transform below so we can fan it out to
			-- MemoryStore snapshot partitions after the DataStore write
			-- succeeds (when partitionData = true)
			local finalData: any = nil
			local success, warning = DataStores.updateAsync(dataStoreName, realKey, function(existingData: any)
				if typeof(existingData) == "string" then
					existingData = Serializer.decompress(existingData)
				end
				if typeof(existingData) ~= "table" then
					existingData = {}
				end
				-- Decode the stored data before merging, otherwise the re-serialize
				-- below double-wraps untouched values (a stored "c_ff0000" Color3
				-- becomes "s_c_ff0000" and loads back as a plain string)
				if existingData._isSerialized == true then
					existingData._isSerialized = nil
					existingData = Serializer.deserialize(existingData)
				end
				local function applyChange(path: {string}, value: any, isRemoval: boolean)
					local target = existingData
					for index = 1, #path - 1 do
						local key = path[index]
						if typeof(target[key]) ~= "table" then
							if isRemoval then return end
							target[key] = {}
						end
						target = target[key]
					end
					if isRemoval then
						target[path[#path]] = nil
					else
						target[path[#path]] = value
					end
				end
				for _, change in changes do
					applyChange(change[1], change[2], change[3] == "remove")
				end
				-- We deliberately keep empty tables in the blob. Pruning them here used
				-- to tidy parents emptied by removals, but it also destroyed real empty
				-- table values (a perm entry's modifiers = {spawn = {}}), and a lingering
				-- empty parent merges harmlessly over the template anyway
				existingData._lastSavedTime = os.time()
				existingData._isSerialized = true
				existingData = Serializer.serialize(existingData, true)
				if self.compressData then
					existingData = Serializer.compress(existingData)
				end
				finalData = existingData
				return existingData
			end)
			if success then
				-- The snapshot only advances on a successful write, otherwise a failed
				-- save would silently orphan its changes forever (they'd vanish from
				-- every future diff, so neither the DataStore nor other servers would
				-- ever receive them)
				(self :: any)._lastCSCSnapshot = deepCopyTable(snapshot)
				local CrossServerSync = require(modules.DataStores.CrossServerSync) :: any
				CrossServerSync.publish(dataStoreName, changes)
				-- Refresh the MemoryStore snapshot cache so new servers booting up
				-- find the latest data without hitting DataStore
				if self.partitionData and finalData ~= nil then
					local SnapshotPartition = require(modules.DataStores.SnapshotPartition) :: any
					local configSettings = require(modules.Parent.Services.Config.Settings)
					local partitionCount = configSettings.SystemSettings.Partitions or 5
					SnapshotPartition.publishSnapshot(dataStoreName, realKey, finalData, partitionCount)
				end
			else
				studioWarn(`HD Admin failed to save CSC data for '{realKey}' to '{dataStoreName}': {warning}`)
			end
			if isReleasingProfile then
				hasReleasedProfile = true
			end
			return success, warning
		else
			local dataToSave = buildDataToSave()
			User.incrementSavesThisMinute(dataToSave)
			if isReleasingProfile and self.sessionLocking then
				dataToSave._sessionLock = nil
			elseif self.sessionLocking then
				dataToSave._sessionLock = sessionLockJobId
			end
			dataToSave = Serializer.serialize(dataToSave, true)
			if self.compressData then
				dataToSave = Serializer.compress(dataToSave)
			end
			local success, warning = false, ""
			while success ~= true do
				success, warning = DataStores.setAsync(dataStoreName, realKey, dataToSave, gdprUserIds)
				if not success then
					studioWarn(`HD Admin failed to save data for '{realKey}' to DataStore '{dataStoreName}': {warning}`)
				end
				if not isReleasingProfile then
					break
				end
			end
			if isReleasingProfile and success then
				hasReleasedProfile = true
				perm:destroy()
			end
			return success, warning
		end
	end

	-- Exposed so cross server actions (Permanent.ActionMessenger) can persist an
	-- applied change immediately instead of waiting out the auto save cooldown,
	-- since the originator polls the DataStore for proof the change landed
	;(self :: any).saveAsync = saveAsync

	-- Let listeners tweak data before loading
	local beforeLoading = self.beforeLoading :: Signal.Signal<any>
	beforeLoading:Fire()

	-- Save data and release session when player/user leaves
	self.janitor:add(function()
		task.defer(saveAsync)
	end)

	-- Save data and release when server is shutting down
	if permitSaveAndLoad then
		game:BindToClose(function()
			serverIsShuttingDown = true
			task.defer(saveAsync)
			while hasReleasedProfile == false do
				task.wait(1)
			end
		end)
	end

	-- areValuesEqual is shared by both the local perm:onAnyChange tracker (below) and
	-- the CSC.register callback (further down)
	local areValuesEqual = require(modules.DataUtil.areValuesEqual)

	-- Auto save: only save when data has actually changed
	if permitSaveAndLoad then
		local lastSavedTime = 0
		local pendingSave = false
		perm:onAnyChange(function(pathwayKey: string, value: any)
			-- Skip changes that come from remote CSC updates or beforeLoading
			if not trackingChanges then
				return
			end

			local pathway = State.getPathway(pathwayKey)
			local templateValue = templateValueAt(pathway)
			local matchesDefault = areValuesEqual(value, templateValue)
			setNested(_savedChanges, pathway, value, matchesDefault)

			-- We schedule a save if one isn't already pending
			if pendingSave then
				return
			end
			pendingSave = true
			task.delay(1, function()
				if not isCSC then
					local cooldownRemaining = (lastSavedTime + AUTO_SAVE_COOLDOWN) - os.clock()
					if cooldownRemaining > 0 then
						task.wait(cooldownRemaining)
					end
				end
				pendingSave = false
				lastSavedTime = os.clock()
				saveAsync()
			end)
		end)
	end

	-- Enable change tracking now that load and beforeLoading are complete
	-- For CSC, we also register to receive remote changes from other servers
	if isCSC then
		local CrossServerSync = require(modules.DataStores.CrossServerSync) :: any
		CrossServerSync.register(dataStoreName, function(changes: {{any}})
			--[[
			we suppress the tracker so the perm:set calls below don't re-trigger
			publish (loops), and mirror each change into _savedChanges and
			_lastCSCSnapshot so local reverts still diff and the next saveAsync
			doesn't echo CSC-received state back out
			trackingChanges must ALWAYS be restored to true once we're done, even
			if the apply loop errors - if it stays false the tracker silently drops
			every later local change to this user's perm, so CSC never publishes
			and DataStore never persists them. pcall + always-true reset stops that
			--]]
			trackingChanges = false
			local applyOk, applyErr = pcall(function()
				for _, change in changes do
					local pathway: {string} = change[1]
					local value: any = change[2]
					local isRemoval = change[3] == "remove"
					if isRemoval then
						local templateValue = templateValueAt(pathway)
						-- Copied because set stores tables by reference. Handing the
						-- template itself to live state let later received additions
						-- write INTO the template, so the next whole key removal
						-- restored those entries instead of clearing them
						if typeof(templateValue) == "table" then
							templateValue = deepCopyTable(templateValue)
						end
						perm:set(pathway, templateValue)
						setNested(_savedChanges, pathway, nil, true)
						setNested((self :: any)._lastCSCSnapshot, pathway, nil, true)
					else
						perm:set(pathway, value)
						local templateValue = templateValueAt(pathway)
						local matchesDefault = areValuesEqual(value, templateValue)
						setNested(_savedChanges, pathway, value, matchesDefault)
						setNested((self :: any)._lastCSCSnapshot, pathway, value, matchesDefault)
					end
				end
			end)
			trackingChanges = true
			if not applyOk then
				studioWarn(`HD Admin CSC.register apply error for '{dataStoreName}': {tostring(applyErr)}`)
			end
		end)
		janitor:add(function()
			CrossServerSync.unregister(dataStoreName)
		end)
	end
	trackingChanges = true

	-- Now fire that we have loaded!
	self.isLoaded = true :: any
	if self.isActive then
		User.userLoaded:Fire(self)
	end

end

function User.getPolicyInfoAsync(self: Class): (boolean, string | any)
	-- Syncs the policy into temp.PolicyInfo so the client can read it
	local policyInfo = self.policyInfo
	if not self.isPlayer then
		return false, "User is not a player"
	end
	local player = self.player :: Player
	if self.policyInfoLoaded then
		return true, policyInfo
	end
	local PolicyService = game:GetService("PolicyService")
	local success, warningOrPolicy = false, ""
	for _ = 1, 4 do
		success, warningOrPolicy = pcall(function()
			return PolicyService:GetPolicyInfoForPlayerAsync(player)
		end)
		if success then
			local temp = self.temp :: State.Class
			temp:set("PolicyInfo", warningOrPolicy)
			return true, warningOrPolicy
		end
		task.wait(3)
	end
	return false, warningOrPolicy
end

function User.destroy(self: Class)
	if self.isActive == false then
		return
	end
	self.isActive = false :: any
	self.janitor:destroy()
end


return User