--!strict
--[[

This module handles the cross-server communication of global data,
such as Bans, Warnings, Members, Logs, Game Settings and Roles.
It's designed to scale for over 150,000 concurrent servers to
support HD Admin within Roblox's top games.

This incorporates all three cross-server-communication tools,
DataStores, MessagingService & MemoryStores, where:
	- The first is used for persistence and source of truth
	  (handled by User via the DataStores module)
	- Second for notifying other servers of changes (so that
	  polling can be avoided)
	- and Third for the temporary hosting and sharing of these
	  changes in data due to its larger size limits (64kb
	  per key vs 1kb for MessagingService)

MemoryStore keys are partitioned to prevent hitting the global
"Per-key throughput limits" for a single key. This is necessary
for games that have 100k+ servers.

Servers only save to DataStores when they have actual pending
changes (made locally by an admin), not when receiving remote
updates. This uses minimal resources and has a negligible impact
on the budgets (DataStores, MemoryStores, etc) within your
experience.

Credit to @yHasteeD and @do_small for their feedback and help
developing and testing the original system this is based upon

]]


-- LOCAL FIRST
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local config = modules.Parent.Services.Config
local configSettings = require(config.Settings)



-- CONFIG
local TOPIC_NAME = "HDAdminSync_" .. (configSettings.SystemSettings.DataGroupName or "HD")
local PARTITIONS = configSettings.SystemSettings.Partitions or 5
local HASH_EXPIRY = 55
local SEND_COOLDOWN = 10


-- LOCAL
local RunService = game:GetService("RunService")
local isStudio = RunService:IsStudio()
local generateUID = require(modules.DataUtil.generateUID)
local Serializer = require(modules.Serializer)

local function serializeChanges(changes: {{any}}): {{any}}
	local serialized = {}
	for _, change in changes do
		local action = if change[3] == "remove" then "remove" else "set"
		table.insert(serialized, {change[1], Serializer.serialize(change[2], true), action})
	end
	return serialized
end

local function deserializeChanges(changes: {{any}}): {{any}}
	local deserialized = {}
	for _, change in changes do
		local action = change[3]
		local entry = {change[1], Serializer.deserialize(change[2], true)}
		if action == "remove" then
			entry[3] = "remove"
		end
		table.insert(deserialized, entry)
	end
	return deserialized
end

local MemoryStoreService: any = game:GetService("MemoryStoreService")
local MessagingService: any = game:GetService("MessagingService")
local DataStores = require(script.Parent)
local IsolatedServer = require(modules.IsolatedServer)

local CrossServerSync = {}
local _hashMap: MemoryStoreHashMap? = nil
local _subscribed = false
local _subscriptionConnection: any = nil
local _actionUIDsFromThisServer: {[string]: true} = {}
local _registeredCallbacks: {[string]: (changes: {{any}}) -> ()} = {}
local _pendingChanges: {[string]: {{any}}} = {}
local _processingCategories: {[string]: true} = {}


-- INTERNAL
local function getHashMap(): MemoryStoreHashMap?
	if not _hashMap then
		local success, result = pcall(function()
			return MemoryStoreService:GetHashMap(TOPIC_NAME)
		end)
		if success then
			_hashMap = result
		end
	end
	return _hashMap
end

local function retryIndefinitely(callback: () -> any): any
	local retryWaitTime = 3
	while true do
		local success, result = pcall(callback)
		-- Studio returns without retrying, so without this line a failure here
		-- vanishes completely and cross-server bugs become invisible
		if not success then
			print(`HD Admin CrossServerSync call failed: {tostring(result)}`)
		end
		if success or isStudio then
			return result
		end
		task.wait(retryWaitTime)
		retryWaitTime *= 2
	end
end

local function onMessageReceived(message: any)
	local information = typeof(message) == "table" and message.Data
	if typeof(information) ~= "table" then
		return
	end
	local category: string = information[1]
	local actionUID: string = information[2]
	if _actionUIDsFromThisServer[actionUID] then
		return
	end
	local callback = _registeredCallbacks[category]
	if not callback then
		return
	end
	local hashMap = getHashMap()
	if not hashMap then
		return
	end
	local partitionKey = DataStores.pickPartitionKey(actionUID, PARTITIONS)
	local changes = retryIndefinitely(function()
		return hashMap:GetAsync(partitionKey)
	end)
	if typeof(changes) == "table" then
		callback(deserializeChanges(changes))
	end
end

local function ensureSubscribed()
	if _subscribed or IsolatedServer.isIsolated() then
		return
	end
	_subscribed = true
	task.defer(function()
		_subscriptionConnection = retryIndefinitely(function()
			return MessagingService:SubscribeAsync(TOPIC_NAME, onMessageReceived)
		end)
	end)
end

local function processQueue(category: string)
	task.delay(0.1, function()
		if IsolatedServer.isIsolated() then
			_pendingChanges[category] = nil
			_processingCategories[category] = nil
			return
		end
		local changes = _pendingChanges[category]
		if not changes or #changes == 0 then
			_pendingChanges[category] = nil
			_processingCategories[category] = nil
			return
		end
		_pendingChanges[category] = {}

		local hashMap = getHashMap()
		if not hashMap then
			_processingCategories[category] = nil
			return
		end

		local actionUID = generateUID(10)

		-- Write changes to all partitions in MemoryStore
		local serializedChanges = serializeChanges(changes)
		retryIndefinitely(function()
			for partitionIndex = 1, PARTITIONS do
				hashMap:SetAsync(actionUID .. partitionIndex, serializedChanges, HASH_EXPIRY)
			end
		end)

		-- Notify all servers via MessagingService
		_actionUIDsFromThisServer[actionUID] = true
		retryIndefinitely(function()
			return MessagingService:PublishAsync(TOPIC_NAME, {category, actionUID})
		end)
		task.delay(HASH_EXPIRY, function()
			_actionUIDsFromThisServer[actionUID] = nil
		end)

		if _pendingChanges[category] and #_pendingChanges[category] > 0 then
			task.wait(SEND_COOLDOWN)
			processQueue(category)
		else
			_pendingChanges[category] = nil
			_processingCategories[category] = nil
		end
	end)
end


-- PUBLIC
function CrossServerSync.register(category: string, callback: (changes: {{any}}) -> ())
	if _registeredCallbacks[category] then
		error(`CrossServerSync: category '{category}' is already registered`)
	end
	_registeredCallbacks[category] = callback
	ensureSubscribed()
end

function CrossServerSync.unregister(category: string)
	_registeredCallbacks[category] = nil
end

function CrossServerSync.publish(category: string, changes: {{any}})
	-- Changes are always applied locally before they reach here, so an isolated
	-- server can just drop them
	if IsolatedServer.isIsolated() then
		return
	end
	if #changes == 0 then
		return
	end
	local pending = _pendingChanges[category]
	if not pending then
		pending = {}
		_pendingChanges[category] = pending
	end
	for _, change in changes do
		table.insert(pending, change)
	end
	if not _processingCategories[category] then
		_processingCategories[category] = true
		processQueue(category)
	end
end

function CrossServerSync.broadcast(category: string, payload: any)
	-- Wraps the payload as a single change tuple so one-off messages (like global
	-- command statements) ride the same MemoryStore and MessagingService pipeline
	-- as data syncs
	CrossServerSync.publish(category, {{category, payload}})
end

-- Swaps the real Roblox services for fakes so suites can drive the pipeline
-- without touching live MemoryStore or MessagingService. Registered categories
-- are left alone (suites register and unregister their own), so this is safe
-- to call in a session where real stores are already syncing. Pass no
-- arguments to restore the real services
function CrossServerSync._setServicesForTesting(memoryStore: any?, messaging: any?)
	MemoryStoreService = memoryStore or game:GetService("MemoryStoreService")
	MessagingService = messaging or game:GetService("MessagingService")
	_hashMap = nil
	_subscribed = false
	_subscriptionConnection = nil
	table.clear(_actionUIDsFromThisServer)
	table.clear(_pendingChanges)
	table.clear(_processingCategories)
end


-- SETUP
IsolatedServer.onIsolate(function()
	if _subscriptionConnection then
		pcall(function()
			_subscriptionConnection:Disconnect()
		end)
		_subscriptionConnection = nil
	end
	_subscribed = true
	table.clear(_pendingChanges)
	table.clear(_processingCategories)
end)


return CrossServerSync
