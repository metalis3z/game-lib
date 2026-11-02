if _G.__ReplicatorClientReference then
	error("ReplicatorClient has already been required on the client in another module.")
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CMD_INIT    = utf8.char(0)
local CMD_UPDATE  = utf8.char(1)
local CMD_DESTROY = utf8.char(2)


local NONE = {}

local ROOT_PATH = {}
local Signal = require(script.ReplicatorSignal)
local ReplicatorClient = {}
local instanceToId = {}
local registry = {}

local function deepClone(t)
	local clone = table.clone(t)
	for key, value in clone do
		if type(value) == "table" then
			clone[key] = deepClone(value)
		end
	end
	return clone
end


local function enforceColonCalls(object)
	for key, value in object do
		if type(value) == "function" then
			object[key] = function(...)
				if select(1, ...) == object then
					return value(...)
				end
				error(("called '%s' with dot syntax instead of colon syntax (use :%s() not .%s())"):format(key, key, key))
			end
		end
	end
end


local function incrementRefcount(refcounts, key)
	refcounts[key] = (refcounts[key] or 0) + 1
end

local function decrementRefcount(refcounts, key)
	local current = refcounts[key]
	if current == nil or current <= 1 then
		refcounts[key] = nil
	else
		refcounts[key] = current - 1
	end
end


local function applyDiff(currentData, diffNode, pathKey, signalDescendants, listenSignals, observeSignals, pendingFires)
	if diffNode == nil then
		if type(currentData) == "table" then
			return deepClone(currentData)
		else
			return nil
		end
	end

	if diffNode.o == 0 then
		local newValue = diffNode.v
		if type(newValue) == "table" then
			return deepClone(newValue)
		else
			return newValue
		end
	end

	for rawKey, childDiff in next, diffNode do
		local key = rawKey
		if (childDiff.o == 0 or childDiff.o == 1) and childDiff.k then
			key = tonumber(rawKey)
		end

		local childPathKey
		if pathKey then
			childPathKey = ("%s\255%s"):format(pathKey, tostring(key))
		else
			childPathKey = pathKey
		end

		local newValue
		if childDiff.o == 0 then
			local v = childDiff.v
			if type(v) == "table" then
				newValue = deepClone(v)
			else
				newValue = v
			end
		else
			local childDescendantKey
			if signalDescendants[childPathKey] then
				childDescendantKey = childPathKey
			else
				childDescendantKey = nil
			end
			newValue = applyDiff(
				currentData[key] or {},
				childDiff.v,
				childDescendantKey,
				signalDescendants,
				listenSignals,
				observeSignals,
				pendingFires
			)
		end

		if childPathKey then
			local listenEntry = listenSignals[childPathKey]
			if listenEntry then
				local fireValue = (newValue == nil) and NONE or newValue
				table.insert(pendingFires, { signal = listenEntry.signal, newValue = fireValue, oldValue = nil })
			end

			local observeEntry = observeSignals[childPathKey]
			if observeEntry then
				local oldValue = currentData[key]
				if type(oldValue) == "table" then
					oldValue = deepClone(oldValue)
				end
				local fireValue = (newValue == nil) and NONE or newValue
				table.insert(pendingFires, { signal = observeEntry.signal, newValue = fireValue, oldValue = oldValue })
			end
		end

		currentData[key] = newValue
	end

	return currentData
end


local function processPacket(packet)
	local cmd        = packet[1]
	local instanceId = packet[2]

	if cmd == CMD_INIT then
		local replicatorId = packet[3]
		local initialData  = packet[4]

		for existingInstanceId, existingRepId in instanceToId do
			if existingRepId == replicatorId and existingInstanceId ~= instanceId then
				error(('ReplicatorClient received two INITs for the same replicatorId "%s" with different instanceIds'):format(replicatorId))
			end
		end

		instanceToId[instanceId] = replicatorId

		local replicator = ReplicatorClient.get(replicatorId)

		replicator.Data = deepClone(initialData)

		for _, entry in replicator._observeSignals do
			entry.signal:Fire(replicator:TryIndex(entry.path), nil)
		end

		for _, entry in replicator._listenSignals do
			entry.signal:Fire(replicator:TryIndex(entry.path))
		end

		local rawSig = replicator._listenRawSignal
		if rawSig then
			rawSig:Fire(replicator.Data, replicator.Data)
		end

		return
	end

	if cmd == CMD_UPDATE then
		local replicatorId = instanceToId[instanceId]
		if not replicatorId then
			return
		end

		local replicator = ReplicatorClient.get(replicatorId)

		local rawSig          = replicator._listenRawSignal
		local signalDescendants = replicator._signalDescendants
		local listenSignals   = replicator._listenSignals
		local observeSignals  = replicator._observeSignals

		local diff = packet[3]
		local pendingFires = {}

		local newData = applyDiff(
			replicator.Data,
			diff,
			"\254",
			signalDescendants,
			listenSignals,
			observeSignals,
			pendingFires
		)

		if newData ~= replicator.Data then
			replicator.Data = newData
		end

		for _, fireInfo in pendingFires do
			local value = fireInfo.newValue
			if value == NONE then
				value = nil
			end
			fireInfo.signal:Fire(value, fireInfo.oldValue)
		end

		if rawSig then
			rawSig:Fire(replicator.Data, diff)
		end

		return
	end

	if cmd == CMD_DESTROY then
		local replicatorId = instanceToId[instanceId]
		if not replicatorId then
			return
		end

		local replicator = ReplicatorClient.get(replicatorId)

		if replicator._destroyed then
			error(('ReplicatorClient received duplicate DESTROY for replicatorId "%s"'):format(replicatorId))
		end

		replicator.Destroying:Fire()

		for _, entry in replicator._listenSignals do
			entry.signal:DisconnectAll()
		end
		table.clear(replicator._listenSignals)

		for _, entry in replicator._observeSignals do
			entry.signal:DisconnectAll()
		end
		table.clear(replicator._observeSignals)

		table.clear(replicator._signalDescendants)

		replicator._destroyed = true

		registry[replicatorId]     = nil
		instanceToId[instanceId]   = nil
	end
end


function ReplicatorClient.get(replicatorId)
	local existing = registry[replicatorId]
	if existing then
		return existing
	end

	local replicator = {
		Id                = replicatorId,
		Data              = nil,
		Ready             = false,
		Destroying        = Signal.new(),
		_listenSignals    = {},
		_listenRawSignal  = Signal.new(),
		_observeSignals   = {},
		_destroyed        = false,
		_signalDescendants = {},
	}

	local function registerPathListener(path, isObserve, callback)
		if #path == 0 and path ~= ROOT_PATH then
			warn("path:", path)
			error("invalid empty path passed to listener registration")
		end

		local pathKey = ("\254\255%s"):format(table.concat(path, "\255"))

		local signalTable
		if isObserve then
			signalTable = replicator._observeSignals
		else
			signalTable = replicator._listenSignals
		end

		local entry = signalTable[pathKey]
		if not entry then
			entry = {
				signal    = Signal.new(),
				path      = path,
				connected = 0,
			}
			signalTable[pathKey] = entry
		end

		local function updateRefcounts(fn)
			fn(replicator._signalDescendants, "\254")
			local prefix = "\254"
			for i = 1, #path - 1 do
				prefix = ("%s\255%s"):format(prefix, path[i])
				fn(replicator._signalDescendants, prefix)
			end
		end

		local connection = entry.signal:Connect(callback)
		entry.connected += 1
		updateRefcounts(incrementRefcount)

		return function()
			connection:Disconnect()
			entry.connected -= 1
			if entry.connected == 0 then
				signalTable[pathKey] = nil
			end
			updateRefcounts(decrementRefcount)
		end
	end

	function replicator.Listen(self, path, callback)
		if type(path[1]) == "table" then
			local disconnects = {}
			for _, singlePath in path do
				table.insert(disconnects, registerPathListener(singlePath, false, callback))
			end
			return function()
				for _, disconnect in disconnects do
					disconnect()
				end
				table.clear(disconnects)
			end
		end

		return registerPathListener(path, false, callback)
	end

	function replicator.ListenRaw(self, callback)
		return replicator._listenRawSignal:Connect(callback)
	end

	function replicator.Path(self, base)
		local basePath = type(base) == "string" and { base } or base
		return function(extension)
			local result = table.clone(basePath)
			if extension == nil then
				return result
			elseif type(extension) == "string" then
				table.insert(result, extension)
				return result
			else
				table.move(extension, 1, #extension, #result + 1, result)
				return result
			end
		end
	end

	function replicator.Observe(self, path, callback)
		task.spawn(callback, replicator:TryIndex(path), nil)
		return registerPathListener(path, true, callback)
	end

	function replicator.Index(self, path)
		local current = replicator.Data
		if type(current) ~= "table" then
			error("Replicator:Index() failed — Data is not a table")
		end
		local len = #path
		for i, key in path do
			current = current[key]
			if i < len and type(current) ~= "table" then
				error(("Replicator:Index() failed — '%s' is not a table"):format(table.concat(path, "/", 1, i)))
			end
		end
		return current
	end

	function replicator.TryIndex(self, path)
		local current = replicator.Data
		if type(current) ~= "table" then
			return nil
		end
		local len = #path
		for i, key in path do
			current = current[key]
			if i < len and type(current) ~= "table" then
				return nil
			end
		end
		return current
	end

	function replicator.WaitForLoaded(self)
		if not replicator.Data then
			replicator._listenRawSignal:Wait()
		end
	end

	registry[replicatorId] = replicator

	enforceColonCalls(replicator)

	return replicator
end


local initCalled = false

function ReplicatorClient.init()
	if initCalled then return end
	initCalled = true

	local runningCoroutine = coroutine.running()
	local waitingForHandshake = false

	local TIMEOUT_SECONDS = 30
	local remoteEvent = ReplicatedStorage
		:WaitForChild("__ReplicatorInternal", TIMEOUT_SECONDS)
	if not remoteEvent then
		error("ReplicatorClient: Timeout waiting for __ReplicatorInternal")
	end
	remoteEvent = remoteEvent:WaitForChild("RemoteEvent", TIMEOUT_SECONDS)
	if not remoteEvent then
		error("ReplicatorClient: Timeout waiting for RemoteEvent")
	end

	remoteEvent.OnClientEvent:Connect(function(batch)
		for _, packet in batch do
			processPacket(packet)
		end
		if waitingForHandshake and coroutine.status(runningCoroutine) == "suspended" then
			task.spawn(runningCoroutine)
			waitingForHandshake = false
		end
	end)

	remoteEvent:FireServer()
	waitingForHandshake = true
	coroutine.yield()
end

_G.__ReplicatorClientReference = ReplicatorClient
return ReplicatorClient