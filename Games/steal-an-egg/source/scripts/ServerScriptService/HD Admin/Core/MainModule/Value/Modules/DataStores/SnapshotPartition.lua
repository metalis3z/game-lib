--!strict
--[[
 
	This swaps the DataStore startup-read to a MemoryStore cache for
	any User whose Store has `partitionData = true`. Without it, every server
	restarting at the same time would make a read request to a single
	DataStore key, which is fine for most experiences, but would quickly
	exceed Roblox's per-key throughout limit (which has a read cap of 25 MB/min)
	for large scale games that have over 20k+ servers.

]]


-- LOCAL FIRST
local DataStores = require(script.Parent)


-- CONFIG
local PARTITION_PREFIX = `{DataStores.dataGroupName}/Snapshot/`
local REFRESH_LOCK_PREFIX = `{DataStores.dataGroupName}/RefreshLock/`
local PARTITION_TTL = 60 * 60 * 24 * 45 -- 45 days (the MemoryStore max)
local REFRESH_AGE_THRESHOLD = 60 * 60 * 24 * 25 -- 25 days
local REFRESH_LOCK_TTL = 60 -- seconds
local READ_RETRY_ATTEMPTS = 4 -- random partition retries before leader-electing
local LEADER_JITTER_MAX = 3 -- seconds of random delay before attempting lock
local POST_REFRESH_WAIT = 4 -- seconds losers wait before retrying partition reads


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local MemoryStoreService: any = game:GetService("MemoryStoreService")
local RunService = game:GetService("RunService")
local IsolatedServer = require(modules.IsolatedServer)
local _hashMaps: {[string]: MemoryStoreHashMap} = {}
local _forceLive = false
local SnapshotPartition = {}


-- LOCAL FUNCTIONS
local function getJobId(): string
	return if RunService:IsStudio() then "Studio" else game.JobId
end

local function useStudioPath(): boolean
	return RunService:IsStudio() and not _forceLive
end

local function getHashMap(name: string): MemoryStoreHashMap?
	if _hashMaps[name] then
		return _hashMaps[name]
	end
	local success, result = pcall(function()
		return MemoryStoreService:GetHashMap(name)
	end)
	if not success then
		return nil
	end
	_hashMaps[name] = result
	return result
end

local function partitionMapName(dataStoreName: string): string
	return PARTITION_PREFIX .. dataStoreName
end

local function lockMapName(dataStoreName: string): string
	return REFRESH_LOCK_PREFIX .. dataStoreName
end

local function tryClaimLock(dataStoreName: string, key: string): boolean
	if IsolatedServer.isIsolated() then
		return false
	end
	local lockMap = getHashMap(lockMapName(dataStoreName))
	if not lockMap then
		return false
	end
	local myJobId = getJobId()
	local claimedNow = false
	local success = pcall(function()
		lockMap:UpdateAsync(key, function(existing: any)
			local now = os.time()
			if typeof(existing) == "table" and existing.claimedAt then
				local age = now - existing.claimedAt
				if age < REFRESH_LOCK_TTL then
					return nil -- someone else holds it, leave it alone
				end
			end
			claimedNow = true
			return {jobId = myJobId, claimedAt = now}
		end, REFRESH_LOCK_TTL)
	end)
	return success and claimedNow
end

local function releaseLock(dataStoreName: string, key: string)
	local lockMap = getHashMap(lockMapName(dataStoreName))
	if not lockMap then
		return
	end
	-- UpdateAsync can't delete (returning nil just cancels the write), so read
	-- ownership first then RemoveAsync
	local myJobId = getJobId()
	local ok, existing = pcall(function()
		return lockMap:GetAsync(key)
	end)
	if ok and typeof(existing) == "table" and (existing :: any).jobId == myJobId then
		pcall(function()
			lockMap:RemoveAsync(key)
		end)
	end
end


-- PUBLIC
function SnapshotPartition.publishSnapshot(dataStoreName: string, key: string, serializedData: any, partitionCount: number): (boolean, string?)
	if useStudioPath() then
		return true, nil
	end
	-- An isolated server's data can hold local-only changes which must never reach
	-- the real snapshot cache that other servers start from
	if IsolatedServer.isIsolated() then
		return true, nil
	end
	local hashMap = getHashMap(partitionMapName(dataStoreName))
	if not hashMap then
		--warn(`[SnapshotPartition] publishSnapshot failed: MemoryStore unavailable store={dataStoreName} key={key}`)
		return false, "MemoryStore unavailable"
	end
	local wrapper = {
		data = serializedData,
		writtenAt = os.time(),
		writtenWithPartitionCount = partitionCount,
	}
	local startClock = os.clock()
	local writeFailures = 0
	for partitionIndex = 1, partitionCount do
		local partitionKey = key .. "/" .. tostring(partitionIndex)
		local ok = pcall(function()
			hashMap:SetAsync(partitionKey, wrapper, PARTITION_TTL)
		end)
		if not ok then
			writeFailures += 1
		end
	end
	local elapsed = string.format("%.2f", os.clock() - startClock)
	if writeFailures > 0 then
		--warn(`[SnapshotPartition] publishSnapshot done with errors store={dataStoreName} key={key} ok={partitionCount - writeFailures}/{partitionCount} ({elapsed}s)`)
	end
	return true, nil
end

function SnapshotPartition.getSnapshot(
	dataStoreName: string,
	key: string,
	currentPartitionCount: number,
	dataStoreFallback: () -> (boolean, any)
): (boolean, any, {writtenAt: number, writtenWithPartitionCount: number}?)
	if useStudioPath() then
		local ok, result = dataStoreFallback()
		return ok, result, nil
	end
	local hashMap = getHashMap(partitionMapName(dataStoreName))
	if not hashMap then
		--warn(`[SnapshotPartition] getSnapshot MemoryStore unavailable, falling back to DataStore store={dataStoreName} key={key}`)
		local ok, result = dataStoreFallback()
		return ok, result, nil
	end

	local function readRandomPartition(): (any?, {writtenAt: number, writtenWithPartitionCount: number}?, string?)
		local partitionKey = DataStores.pickPartitionKey(key .. "/", currentPartitionCount)
		local ok, result = pcall(function()
			return hashMap:GetAsync(partitionKey)
		end)
		if ok and typeof(result) == "table" and result.data ~= nil then
			return result.data, {
				writtenAt = result.writtenAt or 0,
				writtenWithPartitionCount = result.writtenWithPartitionCount or currentPartitionCount,
			}, partitionKey
		end
		return nil, nil, partitionKey
	end

	-- First attempt + retries (up to READ_RETRY_ATTEMPTS extra random reads)
	for attempt = 1, 1 + READ_RETRY_ATTEMPTS do
		local snapshotData, meta, partitionKey = readRandomPartition()
		if snapshotData ~= nil then
			return true, snapshotData, meta
		end
	end

	local jitter = math.random() * LEADER_JITTER_MAX
	task.wait(jitter)

	if tryClaimLock(dataStoreName, key) then
		local fallbackOk, fallbackResult = dataStoreFallback()
		if fallbackOk and fallbackResult ~= nil then
			SnapshotPartition.publishSnapshot(dataStoreName, key, fallbackResult, currentPartitionCount)
		elseif fallbackOk then
			-- No saved data yet, which is expected for a brand new game
			--print(`[SnapshotPartition] getSnapshot found no saved data store={dataStoreName} key={key}`)
		else
			--warn(`[SnapshotPartition] getSnapshot leader DataStore fallback failed store={dataStoreName} key={key}: {tostring(fallbackResult)}`)
		end
		releaseLock(dataStoreName, key)
		return fallbackOk, fallbackResult, nil
	end

	task.wait(POST_REFRESH_WAIT)
	for attempt = 1, 1 + READ_RETRY_ATTEMPTS do
		local snapshotData, meta, partitionKey = readRandomPartition()
		if snapshotData ~= nil then
			return true, snapshotData, meta
		end
	end

	-- This is a rare fallback typically if the cold-start case after a 45-day inactiveness
	--warn(`[SnapshotPartition] getSnapshot hard fallback to DataStore (rare cold-start path) store={dataStoreName} key={key}`)
	local ok, result = dataStoreFallback()
	return ok, result, nil
end

-- Two reasons a usable snapshot still may want a background refresh:
-- 1. because of different number of partitions (like when we change total partitions between versions)
-- 2. Snapshot is approaching the 45-day TTL ceiling, so the cache silentyl expires
function SnapshotPartition.needsMigration(
	meta: {writtenAt: number, writtenWithPartitionCount: number}?,
	currentPartitionCount: number
): boolean
	if not meta then
		return false
	end
	if meta.writtenWithPartitionCount ~= currentPartitionCount then
		return true
	end
	local age = os.time() - meta.writtenAt
	if age > REFRESH_AGE_THRESHOLD then
		return true
	end
	return false
end

function SnapshotPartition.scheduleBackgroundMigration(
	dataStoreName: string,
	key: string,
	currentPartitionCount: number,
	dataStoreFallback: () -> (boolean, any)
)
	-- Studio shouldn't touch the live data
	if useStudioPath() then
		return
	end
	if IsolatedServer.isIsolated() then
		return
	end
	task.spawn(function()
		task.wait(math.random() * LEADER_JITTER_MAX)
		if not tryClaimLock(dataStoreName, key) then
			return
		end
		local fallbackOk, fallbackResult = dataStoreFallback()
		if fallbackOk and fallbackResult ~= nil then
			SnapshotPartition.publishSnapshot(dataStoreName, key, fallbackResult, currentPartitionCount)
		elseif not fallbackOk then
			--warn(`[SnapshotPartition] scheduleBackgroundMigration DataStore fallback failed store={dataStoreName} key={key}: {tostring(fallbackResult)}`)
		end
		releaseLock(dataStoreName, key)
	end)
end

-- Swaps the real MemoryStore for a fake and lets suites run the live code
-- path inside Studio
function SnapshotPartition._setBackendForTesting(memoryStore: any?, forceLive: boolean?)
	MemoryStoreService = memoryStore or game:GetService("MemoryStoreService")
	_forceLive = forceLive == true
	table.clear(_hashMaps)
end


return SnapshotPartition
