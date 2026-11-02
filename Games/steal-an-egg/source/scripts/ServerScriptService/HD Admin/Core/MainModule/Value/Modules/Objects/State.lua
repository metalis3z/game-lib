--!strict

--[[

	It gives you tables with listeners, serialisation and replication built in - handy
	for tracking player data. When tables are set, they are deep copied. This means that
	all changes *must* be set with :set(), and that data returned with :get() will not
	be applied to the state if changed.

	The optional parameter to create a serialised copy of data is particularly useful -
	bad data gets caught the moment :set() is called and never reaches the datastore,
	and the incorrect code gets flagged right away.

	Replication (which is enabled via state:replicate on the server and state:sync on the
	client) means that specified state data on the server can be synced and listened for via
	a state object on the client. State is only replicated to the client *once* the client
	requests it by doing :onBind,:onChange or :fetchAsync. Data does *not* replicate back
	to the server - this must be done separately

]]


-- LOCAL
local RunService = game:GetService("RunService")
local SYNCING = "___"
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local deepCopyTable = require(modules.TableUtil.deepCopyTable)
local deepEquals = require(modules.TableUtil.deepEquals)
local Serializer = require(modules.Serializer)
local Janitor = require(modules.Objects.Janitor)
local Signal = require(modules.Objects.Signal)
local Players = game:GetService("Players")
local Remote = require(modules.Objects.Remote)
local stateReplication: Remote.Class?, stateReplicationRequest: Remote.Class? = nil, nil
local replicationHandlers = {}
local firstFetchCallbacks: {[string]: (boolean | {any})} = {}
local createConnection = require(modules.AssetUtil.createConnection)
local Fusion = require(modules.Parent.Packages.Fusion)
local State = {}
State.__index = State


-- FUNCTIONS
function State.getPathwayKey(pathway: {any}): string
	local pathwayKey: string = ""
	for index, key in pathway do
		if typeof(key) ~= "string" then
			error("All arguments except final must be strings")
		end
		local syncing = if index == 1 then "" else SYNCING
		pathwayKey = pathwayKey..syncing..key
	end
	return pathwayKey
end

function State.getPathway(pathwayKey: string): {string}
	local pathway = string.split(pathwayKey, SYNCING)
	return pathway
end

function State.verifyFirstFetch(firstPathwayKey: string, yieldableCallback: (any) -> (any))
	local callbacksInGroup = firstFetchCallbacks[firstPathwayKey] :: any
	if yieldableCallback == nil then
		error("State.verifyFirstFetch requires a callback function")
	end
	if typeof(callbacksInGroup) == "boolean" then
		-- If true, then it means the first fetch has already occurred
		task.defer(function()
			yieldableCallback()
		end)
		return
	end
	if callbacksInGroup == nil then
		-- If nil, we create for the first time
		callbacksInGroup = {}
		firstFetchCallbacks[firstPathwayKey] = callbacksInGroup
	end
	table.insert(callbacksInGroup, yieldableCallback)
end


-- CONSTRUCTOR
function State.new(dataMustBeSerializable: boolean?, initialTable: {[string]: any | number}?)
	
	-- Define properties
	local janitor = Janitor.new()
	local self = {
		_data = {} :: {[string]: any},
		_changeCallbacks = {} :: {[string]: {[number]: (...any) -> (...any)}},
		_anyChangeCallbacks = {} :: {[number]: (...any) -> (...any)},
		_verifyCallbacks = {} :: {(Player, {string}, any) -> (...any)},
		_activeReplications = {} :: {[Player]: {replicationKey: string, listeners: {[string]: true}}},
		_syncingReplicationKey = nil :: any?,
		_writeSeq = 0,
		-- Client-side replication bookkeeping, all keyed by pathwayKey
		_appliedSeq = {} :: {[string]: number}, -- highest seq applied per path
		_loaded = {} :: {[string]: boolean}, -- first value has arrived
		_subscribed = {} :: {[string]: boolean}, -- subscribe request sent
		_subscribeError = {} :: {[string]: string?}, -- last subscribe failure reason
		janitor = janitor,
		dataMustBeSerializable = (if dataMustBeSerializable == true then true else false) :: boolean,
		isActive = true :: any,
	}

	-- Cleanup
	janitor:add(function()
		self._data = nil :: any
		self._changeCallbacks = nil :: any
	end)
	
	setmetatable(self, State)

	if initialTable then
		self:setAll(initialTable)
	end

	return self
end


-- CLASS
export type Class = typeof(State.new(...))
type Disconnect = createConnection.Disconnect


-- METHODS
function State.get(self: Class, ...: string | {string}): any?
	local pathway = {...} :: {[number]: string}
	local tablePathway = pathway[1]
	if typeof(tablePathway) == "table" then
		pathway = tablePathway
	end
	if self._syncingReplicationKey then
		local pathwayKey = State.getPathwayKey(pathway :: any)
		if not self._loaded[pathwayKey] and not self._subscribed[pathwayKey] then
			task.spawn(function()
				self:fetchAsync(table.unpack(pathway :: {string}))
			end)
		end
	end
	local value = self._data
	for _, key in pathway :: any do
		value = value[key] :: any
		if value == nil then
			return nil
		end
	end
	if typeof(value) == "table" then
		value = deepCopyTable(value)
	end
	return value
end

function State.getAll(self: Class, getSerialized: boolean?): {[string]: any}
	if getSerialized then
		local serializedCopy = Serializer.serialize(self._data, true)
		return serializedCopy
	end
	local normalCopy = deepCopyTable(self._data) :: {[string]: any}
	return normalCopy
end

function State.set(self: Class, ...: string | {string} | any)
	-- If the pathway does not exist, it is built automatically
	-- If the pathway does exist, but is not built up of tables, then an error is thrown
	if self.isActive ~= true then
		return
	end
	local totalArgs = select("#", ...)
	local finalArg = select(totalArgs, ...)
	local pathwayAndValue = {...}
	local value = finalArg
	if totalArgs == #pathwayAndValue then
		table.remove(pathwayAndValue, totalArgs)
	end
	local tablePathway = pathwayAndValue[1]
	if typeof(tablePathway) == "table" then
		pathwayAndValue = tablePathway
	end
	if self.dataMustBeSerializable == true and not Serializer.isValid(value) then
		error(`State has 'dataMustBeSerializable' enabled, but the value '{tostring(value)}' (type: {typeof(value)}) is not serializable`)
	end
	local data = self._data
	local callbacksToCall = {} :: {{(any) -> (any)}}
	local function buildPathway(keyToAdd: string, dataTable: any?, nextPathway: any?, useGivenValue: boolean?)
		-- Every time the pathway develops, we check for listeners and call if present
		if typeof(keyToAdd) ~= "string" then
			error("Keys must be strings")
		end
		if string.match(keyToAdd, SYNCING) then
			error(`Keys cannot contain '{SYNCING}'`)
		end
		local dataValue = if useGivenValue then value else dataTable[keyToAdd]
		if dataValue == nil and value ~= nil then
			dataValue = {}
		end
		if not useGivenValue and value == nil and typeof(dataValue) ~= "table" then
			return nil, nil
		end
		if not useGivenValue and typeof(dataValue) ~= "table" and typeof(value) ~= "table" then
			error("Cannot set a multi-pathway-key to a non-table that already exists")
		end
		dataTable[keyToAdd] = dataValue
		if typeof(dataValue) == "table" then
			dataTable = dataValue :: any
		end
		local pathway = deepCopyTable(nextPathway)
		table.insert(pathway, keyToAdd)
		local pathwayKey = State.getPathwayKey(pathway)
		local callbacksArray = self._changeCallbacks[pathwayKey]
		if callbacksArray then
			for _, callback in callbacksArray do
				callback = callback :: (any) -> (any)
				table.insert(callbacksToCall :: any, {callback, dataValue})
			end
		end
		return dataTable, pathway
	end
	local function addValueTablesToPathwayRecursive(valueToCheck: any, dataTable: any, pathway : any)
		-- This allows us to listen to changes within value (if present) in addition
		-- to the given pathway of the key
		if typeof(valueToCheck) == "table" then
			for subKey, subValue in (valueToCheck :: {[any]: any}) do
				if typeof(subKey) == "string" then
					local nextDataTable, nextPathway = buildPathway(subKey, dataTable, pathway, nil)
					addValueTablesToPathwayRecursive(subValue, nextDataTable, nextPathway)
				end
			end
		end
	end
	local finalIndex = #pathwayAndValue
	local nextDataTable, nextPathway = data, {}
	for index, keyToAdd in pathwayAndValue do
		nextDataTable, nextPathway = buildPathway(keyToAdd, nextDataTable, nextPathway, index == finalIndex)
		if nextDataTable == nil then
			-- No-op delete (pathway never existed) - nothing changed, nobody to notify
			return
		end
	end
	addValueTablesToPathwayRecursive(value, nextDataTable, nextPathway)
	for _, callbackDetail in callbacksToCall do
		local callback = callbackDetail[1]
		local dataValue = callbackDetail[2]
		task.spawn(callback, dataValue)
	end
	local pathwayKey = State.getPathwayKey(pathwayAndValue)
	self._writeSeq += 1
	local seq = self._writeSeq
	for _, callback in self._anyChangeCallbacks do
		task.spawn(callback, pathwayKey, value, seq)
	end
end

function State.setAll(self: Class, table: {[string]: any}?)
	if table == nil then
		table = {}
	end
	table = table :: {[string]: any}
	if self.isActive ~= true then
		return
	end
	for key, value in table do
		self:set(key, value)
	end
	for key, value in self._data do
		if not table[key] then
			self:set(key, nil)
		end
	end
end

function State.clear(self: Class)
	self:setAll({})
end

function State.update(self: Class, ...: string | {string} | any)
	-- This is the same as set, but the value is a function that returns the new value
	local totalArgs = select("#", ...)
	local finalArg = select(totalArgs, ...)
	local pathwayAndCallback = {...}
	local callback = finalArg
	if totalArgs == #pathwayAndCallback then
		table.remove(pathwayAndCallback, totalArgs)
	end
	local tablePathway = pathwayAndCallback[1]
	if typeof(tablePathway) == "table" then
		pathwayAndCallback = tablePathway
	end
	if typeof(callback) ~= "function" then
		error("Final argument must be a function")
	end
	local currentValue = self:get(table.unpack(pathwayAndCallback))
	local newValue = (callback :: any)(currentValue)
	self:set(pathwayAndCallback, newValue)
end

function State.onAnyChange(self: Class, callback: (pathwayKey: string, value: any) -> (...any))
	local callbacksArray = self._anyChangeCallbacks :: any
	table.insert(callbacksArray, callback)
	return createConnection(function()
		if self.isActive ~= true then
			return
		end
		local index = table.find(callbacksArray, callback)
		if index then
			table.remove(callbacksArray, index)
		end
	end)
end

function State.onChange(self: Class, ...: string | {string} | (...any) -> (...any)): Disconnect
	local totalArgs = select("#", ...)
	local finalArg = select(totalArgs, ...)
	local pathwayAndCallback = {...}
	local callback = finalArg
	if typeof(callback) ~= "function" then
		error("Final argument must be a function")
	end
	if totalArgs == #pathwayAndCallback then
		table.remove(pathwayAndCallback, totalArgs)
	end
	local tablePathway = pathwayAndCallback[1]
	if typeof(tablePathway) == "table" then
		pathwayAndCallback = tablePathway
	end
	local pathwayKey = State.getPathwayKey(pathwayAndCallback :: any)
	local callbacksArray = self._changeCallbacks[pathwayKey]
	if not callbacksArray then
		callbacksArray = {}
		self._changeCallbacks[pathwayKey] = callbacksArray
	end
	table.insert(callbacksArray :: any, callback :: any)
	if self._syncingReplicationKey then
		task.spawn(function()
			self:fetchAsync(table.unpack(pathwayAndCallback :: {string}))
		end)
	end
	return createConnection(function()
		if self.isActive ~= true then
			return
		end
		local index = table.find(callbacksArray, callback)
		if index then
			table.remove(callbacksArray, index)
		end
	end)
end

function State.onBind(self: Class, ...: string | {string} | (...any) -> (...any)): Disconnect
	-- This is the same as :onChange, but the callback is called immediately with the current value
	local totalArgs = select("#", ...)
	local finalArg = select(totalArgs, ...)
	local pathway = {...}
	local callback = finalArg
	if typeof(callback) ~= "function" then
		error("Final argument must be a function")
	end
	if totalArgs == #pathway then
		table.remove(pathway, totalArgs)
	end
	local tablePathway = pathway[1]
	if typeof(tablePathway) == "table" then
		pathway = tablePathway
	end
	pathway = pathway :: {string}
	-- Always pass through the current value (even nil or not-yet-loaded) to stay
	-- consistent with Fusion's onBind. The onChange below triggers the subscribe
	task.spawn(callback, self:get(table.unpack(pathway)))
	return self:onChange(...)
end

local function applyVerify(self: Class, playerArg: Player, pathway: {string}, value: any): any
	if #self._verifyCallbacks == 0 then
		return value
	end
	local verified = if typeof(value) == "table" then deepCopyTable(value) else value
	for _, callback in self._verifyCallbacks do
		local shouldUpdate, newValue = callback(playerArg, pathway, verified)
		if shouldUpdate then
			verified = newValue
		end
	end
	return verified
end

function State.replicate(self: Class, player: Player, replicationName: string, pathwaysToLimitTo: {{string}}?, fetchCallback: ((Player, {string}) -> (...any))?)
	if RunService:IsServer() == false then
		error("State.replicate can only be called on the server")
	end
	if typeof(player) ~= "Instance" or player:IsA("Player") == false then
		error("First argument must be a player")
	end
	local userId = player.UserId
	local replicationKey = `{userId}_{replicationName}`
	local alreadyExists = replicationHandlers[replicationKey]
	if alreadyExists then
		error(`replicationKey '{replicationKey}' has already been used'`)
	end

	local repJanitor = self.janitor:add(Janitor.new())
	repJanitor:add(function()
		replicationHandlers[replicationKey] = nil
	end)

	-- Invoke can only be called once so we set it up initially here then build the handler below
	if not stateReplication then
		stateReplication = Remote.new("StateReplication", "Event") :: any
		stateReplicationRequest = Remote.new("StateReplicationRequest", "Function", "Low")
		stateReplicationRequest:onServerInvoke(function(player, incomingReplicationKey: string, ...: unknown): (boolean, string | {any})
			if typeof(incomingReplicationKey) ~= "string" then
				return false, "Replication name must be a string"
			end
			-- Keys are "{userId}_{name}", so the leading userId must match
			-- the caller, otherwise without this a client could read another player's perm/temp.
			-- The minus sign matters as Studio test server clients have ids like -1
			local ownerIdStr = string.match(incomingReplicationKey, "^(%-?%d+)_")
			if ownerIdStr ~= tostring(player.UserId) then
				return false, "Replication key does not belong to you"
			end
			local replicationHandler = replicationHandlers[incomingReplicationKey] :: (...any) -> (boolean, string | {any})?
			if not replicationHandler then
				return false, "Replication handler does not exist"
			end
			return replicationHandler(player, ...)
		end)
	end
	stateReplicationRequest = stateReplicationRequest :: Remote.Class
	-- Caps how many distinct listeners one client can register on this replication
	-- the byte budget below already bounds it, but a hard count stops a flood of
	-- tiny pathways inflating the per-change match loops
	local MAX_LISTENERS_PER_REPLICATION = 256
	local activeListeners = {}
	local activeListenersSize = 0
	local activeListenersCount = 0
	self._activeReplications[player] = {replicationKey = replicationKey, listeners = activeListeners}
	repJanitor:add(function()
		self._activeReplications[player] = nil
		for key, value in activeListeners do
			activeListeners[key] = nil
		end
	end)
	repJanitor:add(player.AncestryChanged:Connect(function()
		if player.Parent == nil and repJanitor.destroy then
			repJanitor:destroy()
		end
	end))

	-- Here we generate a dictionary of valid pathways that can be listened for
	local validPathways = {}
	if pathwaysToLimitTo then
		for _, pathway in pathwaysToLimitTo do
			local pathwayKey = State.getPathwayKey(pathway)
			if not validPathways[pathwayKey] then
				validPathways[pathwayKey] = true
			end
		end
	end
	
	-- Upon requesting and verifying, replication to client can now begin
	local function replicationHandler(player, ...: unknown): (boolean, string | {any})
		local pathway = {...} :: {string}
		for _, value in pathway do
			if typeof(value) ~= "string" then
				return false, "Pathways must be strings"
			end
		end
		local pathwayKey = State.getPathwayKey(pathway)
		local isWithinMaxSize = require(modules.VerifyUtil.isWithinMaxSize)
		local isValidSize, actualSize = isWithinMaxSize(pathwayKey, 200)
		local isNewListener = not activeListeners[pathwayKey]
		if pathwaysToLimitTo == nil then
			-- We perform additional checks here as a malicious client could flood
			-- the server with unlimited pathways to listen for
			if isValidSize == false then
				return false, "Incoming pathway exceeded maximum bytes"
			end
			if isNewListener and activeListenersCount >= MAX_LISTENERS_PER_REPLICATION then
				return false, "Too many active listeners"
			end
			if activeListenersSize + actualSize > 10000 then
				return false, "Total active listeners exceeded maximum size"
			end
		end
		-- Here we call fetchCallback if present which can yield
		-- This is useful for, for example, yielding until Perm data has loaded
		if fetchCallback then
			-- The client's invoke hangs silently while this yields, so flag a stall
			local finished = false
			task.delay(15, function()
				if not finished then
					warn(`HD Admin: fetch of '{pathwayKey}' is still waiting on its fetch callback after 15 seconds`)
				end
			end)
			local success, result = pcall(fetchCallback, player, pathway)
			finished = true
			if not success then
				return false, `HD Admin: Fetch callback error: {result}`
			end
		end
		-- Here we check if any other services need setting up before we can return our first value
		local firstPathwayKey = pathway[1]
		local callbacksInGroup = firstFetchCallbacks[firstPathwayKey]
		if callbacksInGroup == true then
			-- The callbacks are currently being processed by another thread,
			-- so we yield until they are done
			while firstFetchCallbacks[firstPathwayKey] == true do
				task.wait(0.05)
			end
		elseif typeof(callbacksInGroup) == "table" then
			firstFetchCallbacks[firstPathwayKey] = true
			for _, callbackToRun in callbacksInGroup do
				-- Same stall flag as the fetchCallback above
				local finished = false
				task.delay(15, function()
					if not finished then
						warn(`HD Admin: first fetch of '{firstPathwayKey}' is still running after 15 seconds, an upstream load has likely stalled`)
					end
				end)
				local success, result = pcall(callbackToRun)
				finished = true
				if not success then
					warn("HD Admin: First fetch callback error:", result)
				end
			end
			firstFetchCallbacks[firstPathwayKey] = false
		end
		if not activeListeners[pathwayKey] then
			if pathwaysToLimitTo then
				local isValid = false
				local partialPathway = {} :: {string}
				for index, key in pathway do
					table.insert(partialPathway, key)
					local parialPathwayKey = State.getPathwayKey(partialPathway)
					if validPathways[parialPathwayKey] then
						isValid = true
						break
					end
				end
				if not isValid then
					return false, `Not allowed to listen for pathway '{pathwayKey}'`
				end
			end
			activeListenersSize += actualSize
			activeListenersCount += 1
			activeListeners[pathwayKey] = true
		end
		local currentValue = applyVerify(self, player, pathway, self:get(table.unpack(pathway)))
		;(stateReplication :: any):fireClient(player, replicationKey, pathway, currentValue, self._writeSeq)
		return true
	end
	replicationHandlers[replicationKey] = replicationHandler
	
	-- Replicate all valid changes to the client
	local stateEvent = stateReplication :: any
	repJanitor:add(self:onAnyChange(function(pathwayKey: string, value: any, seq: number)
		local hasListener = activeListeners[pathwayKey]
		if not hasListener then
			-- Case 1: the change is at a deeper pathway than what the listener tracks
			-- like change at "FavoritedEmotes___79795305221612" while listener is "FavoritedEmotes"
			-- The listener should still fire because the parent table has logically changed
			for possibleParentKey, _ in activeListeners do
				if possibleParentKey == string.sub(pathwayKey, 1, #possibleParentKey) then
					hasListener = true
					break
				end
			end
		end
		if not hasListener then
			-- Case 2: the change is at a higher pathway than what the listener tracks
			-- like change at "GameSettings" (setting the whole dict) while listener is
			-- "GameSettings___SystemSettings___UseDefaultRoles". We need to notify the
			-- listener with the value retrieved from the parent table at the listener's subpath
			local changePathway = State.getPathway(pathwayKey)
			for possibleDescendantKey, _ in activeListeners do
				-- Verify descendant key starts with pathwayKey followed by the pathway separator
				-- (to avoid false-matching like "Game" as prefix of "GameSettings")
				local prefixLen = #pathwayKey
				local isDescendant = string.sub(possibleDescendantKey, 1, prefixLen) == pathwayKey
					and (#possibleDescendantKey == prefixLen
						or string.sub(possibleDescendantKey, prefixLen + 1, prefixLen + #SYNCING) == SYNCING)
				if isDescendant then
					-- Extract the value at the listener's full pathway from the parent value
					local descendantPathway = State.getPathway(possibleDescendantKey)
					local subValue: any = value
					for index = #changePathway + 1, #descendantPathway do
						if typeof(subValue) ~= "table" then
							subValue = nil
							break
						end
						subValue = subValue[descendantPathway[index]]
					end
					stateEvent:fireClient(player, replicationKey, descendantPathway, applyVerify(self, player, descendantPathway, subValue), seq)
				end
			end
			return
		end
		local pathway = State.getPathway(pathwayKey)
		stateEvent:fireClient(player, replicationKey, pathway, applyVerify(self, player, pathway, value), seq)
	end))

	return createConnection(function()
		if repJanitor.destroy then
			repJanitor:destroy()
		end
	end)
end

function State.resyncPlayer(self: Class, player: Player)
	if RunService:IsServer() == false then
		error("State.resyncPlayer can only be called on the server")
	end
	local replication = self._activeReplications[player]
	if not replication or not stateReplication then
		return
	end
	-- Bump the write counter so the client's stale-seq drop rule can't
	-- have the re-sent snapshots when nothing else has written since
	self._writeSeq += 1
	local seq = self._writeSeq
	for pathwayKey, _ in replication.listeners do
		local pathway = State.getPathway(pathwayKey)
		local currentValue = applyVerify(self, player, pathway, self:get(table.unpack(pathway)))
		local stateReplicationAny = stateReplication :: any
		stateReplicationAny:fireClient(player, replication.replicationKey, pathway, currentValue, seq)
	end
end

function State.sync(self: Class, replicationName: string)
	if RunService:IsClient() == false then
		error("State.sync can only be called on the client")
	end
	if self._syncingReplicationKey ~= nil then
		error("Client state tables can only sync to one server state at a time")
	end
	local userId = Players.LocalPlayer.UserId
	local replicationKey = `{userId}_{replicationName}`
	self._syncingReplicationKey = replicationKey :: any
	local janitor = self.janitor
	if stateReplication == nil then
		stateReplication = Remote.get("StateReplication")
	end
	stateReplication = stateReplication :: Remote.Class
	if stateReplication == nil then
		error("StateReplication remote does not exist")
	end
	local selfClass = self :: Class
	local setProfileLabel = "HD_StateSet_" .. replicationName
	janitor:add(stateReplication:onClientEvent(function(replicationKey: string, pathway, value, seq)
		if replicationKey ~= self._syncingReplicationKey then
			return
		end
		local pathwayKey = State.getPathwayKey(pathway)
		-- A lower-or-equal sequence means this snapshot or update is older than what we've already applied
		local applied = selfClass._appliedSeq[pathwayKey]
		if typeof(seq) == "number" and applied ~= nil and seq <= applied then
			selfClass._loaded[pathwayKey] = true
			return
		end
		if typeof(seq) == "number" then
			selfClass._appliedSeq[pathwayKey] = seq
		end
		-- Setting a value we already have would still fire everything downstream
		if deepEquals(selfClass:get(table.unpack(pathway)), value) then
			selfClass._loaded[pathwayKey] = true
			return
		end
		debug.profilebegin(setProfileLabel)
		selfClass:set(pathway, value)
		debug.profileend()
		selfClass._loaded[pathwayKey] = true
	end))
	return
end

function State.fetch(self: Class, ...: string | {string} | (...any) -> (...any))
	-- Same as fetchAsync, but this has a one time optional callback.
	-- This can be useful for scenarios where you want to load data from the server
	-- and to then listen for it via :onAnyChange, because all you have to then do is
	-- call :fetch("Cash"), :fetch("Exp") and so on. It's also useful for
	-- scenarios where you only need to onBind the value once
	local totalArgs = select("#", ...)
	local finalArg = select(totalArgs, ...)
	local pathway = {...}
	local callback = nil
	if typeof(finalArg) == "function" then
		callback = finalArg
		table.remove(pathway, totalArgs)
	end
	local tablePathway = pathway[1]
	if typeof(tablePathway) == "table" then
		pathway = tablePathway
	end
	task.spawn(function()
		local success, value = self:fetchAsync(table.unpack(pathway :: {string}))
		if success and callback then
			(callback :: any)(value)
		end
	end)
end

function State.fetchAsync(self: Class, ...: string | {string}): (boolean, string | {any})
	-- This is useful for when you want to fetch the data from the server and to then
	-- have its value passed in the given callback
	-- This can only be used on the client
	if RunService:IsClient() == false then
		error("State.sync can only be called on the client")
	end
	if self._syncingReplicationKey == nil then
		error("State.fetchAsync can only be called after State.sync")
	end
	local pathway = {...} :: {string}
	local tablePathway = pathway[1]
	if typeof(tablePathway) == "table" then
		pathway = tablePathway
	end
	pathway = pathway :: {string}
	local pathwayKey = State.getPathwayKey(pathway)
	if self._loaded[pathwayKey] then
		return true, self:get(table.unpack(pathway))
	end
	if not self._subscribed[pathwayKey] then
		self._subscribed[pathwayKey] = true
		self._subscribeError[pathwayKey] = nil
		if stateReplicationRequest == nil then
			stateReplicationRequest = Remote.get("StateReplicationRequest")
		end
		if stateReplicationRequest == nil then
			error("StateReplicationRequest remote does not exist")
		end
		stateReplicationRequest = stateReplicationRequest :: Remote.Class
		local ok, reason = stateReplicationRequest:invokeServerAsync(self._syncingReplicationKey, table.unpack(pathway))
		if not ok then
			self._subscribed[pathwayKey] = nil
			self._subscribeError[pathwayKey] = if typeof(reason) == "string" then reason else "subscribe failed"
			warn(`HD Admin: state subscribe for '{pathwayKey}' was rejected: {tostring(reason)}`)
		end
	end
	local startClock = os.clock()
	while not self._loaded[pathwayKey] do
		local err = self._subscribeError[pathwayKey]
		if err then
			return false, err
		end
		if os.clock() - startClock > 30 then
			self._subscribed[pathwayKey] = nil
			warn(`HD Admin: timed out waiting for '{pathwayKey}' to replicate from the server`)
			return false, "Timed out waiting for replication"
		end
		task.wait()
	end
	return true, self:get(table.unpack(pathway))
end

function State.verify(self: Class, callback: (Player, {string}, any) -> (...any))
	local callbacksArray = self._verifyCallbacks :: any
	table.insert(callbacksArray, callback)
	return createConnection(function()
		if self.isActive ~= true then
			return
		end
		local index = table.find(callbacksArray, callback)
		if index then
			table.remove(callbacksArray, index)
		end
	end)
end

function State.fuse(self: Class, scope: Fusion.Scope, ...: string | {string}): (Fusion.Value<any?>, () -> (), (...any) -> ())
	-- Bridges a connection between HD state and a Fusion Value
	local args = {...}
	local firstArg = args[1]
	local pathway: {string} = if typeof(firstArg) == "table" then firstArg :: any else args :: any

	local activeState: Class = self
	local stateObject = scope:Value(activeState:get(pathway :: any))
	local activeConnection: Disconnect? = nil

	local function connectListener()
		activeConnection = activeState:onChange(pathway :: any, function(newValue: any)
			stateObject:set(newValue)
		end)
	end
	connectListener()

	local cleanupFn: () -> ()
	cleanupFn = function()
		if activeConnection then
			activeConnection.Disconnect()
			activeConnection = nil
		end
	end
	table.insert(scope :: any, cleanupFn)

	local function disconnect()
		cleanupFn()
		local scopeArray = scope :: any
		for index = #scopeArray, 1, -1 do
			if scopeArray[index] == cleanupFn then
				table.remove(scopeArray, index)
				break
			end
		end
	end

	local function refuse(...: any)
		if activeConnection then
			activeConnection.Disconnect()
			activeConnection = nil
		end

		local refuseArgs = {...}
		if #refuseArgs == 2 then
			activeState = refuseArgs[1]
			pathway = refuseArgs[2]
		else
			pathway = refuseArgs[1]
		end

		stateObject:set(activeState:get(pathway :: any))
		connectListener()
	end

	return stateObject, refuse, disconnect
end

function State.destroy(self: Class)
	if self.isActive == false then
		return
	end
	self.isActive = false
	self.janitor:destroy()
end


return State