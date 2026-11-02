--!strict
--[[

	In v2, we have features like the ability to 'give permanent roles' or to
	'permanently ban' people. to achieve this and to make this model scalable,
	we have two separate sources of truth:

		1. 	The user's PlayerStore profile. This is the primary source of truth
			(for example, it's checked against to determine if a player has a 
			 certain role when they join a server, or to see if they were banned,
			 and if so, then kicks them from the server).
			 
		2. 	A separate 'shared' cross-server store ("BanStore", "MemberStore", etc).
			This then makes it possible to actually view a global collection of
			this data (like perm roles, perm bans, etc) so that admins can 'view these'
			and 'act upon these' (such as undoing) later on.

	The issue however with the 'shared' stores, is that they *must never* be loaded
	by *all servers* (for example, on startup), otherwise we would have to partition
	them like we're doing for GameStore... except its fine for GameStore because it
	will rarely hold much data (only system configs, role info, etc), whereas Bans,
	Members, etc could end up holding THOUSANDS of records which would be
	too large to sanely spread accross partitions.

	Therefore, this is why we have this 'Permanent' orchestrator module. To overcome
	this challenge. However their are some technicals which have had to be considered:

	The target player can be in one of four states when an action is issued:

	  	A. 	Loaded on THIS server (easy, just call :set)
	 
	  	B. 	Loaded on ANOTHER server in the universe (we must publish to that server,
	      poll DataStore for the receiver's save to land)                                
	  
		C. 	Offline with an existing profile (UpdateAsync the DataStore directly,
			(lock-aware)

	  	D. 	Offline with no profile at all (UpdateAsync builds fresh profile from
			(template)
	                                                 
	Approach:
	 - Use UpdateAsync as a probe: if the transform sees an active session
	   lock, we know the target is in another server. Capture the jobId,
	   bail without writing, and switch to the cross-server path (B).
	 - For B: publish via MessagingService, then POLL GetAsync until the
	   change appears in DataStore. The receiver doesn't have to ack -
	   the data itself is the ack.
	 - Returns to the caller only AFTER the PlayerStore write is durable
	   (A/B/C/D resolved). The global store update fires in the background
	   so admins don't wait on its CSC propagation; a failure there notifies
	   the admin (Q4 in discussion) but the action is already enforced

]]


-- CONFIG
local POLL_INTERVAL = 1
local POLL_DEADLINE = 15 -- seconds before giving up on a cross-server publish
local MAX_RETRIES = 3
local PLAYER_STORE_NAME = "PlayerStore"


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local DataStores = require(modules.DataStores)
local User = require(modules.Objects.User)
local Serializer = require(modules.Serializer)
local generateUID = require(modules.DataUtil.generateUID)
local areValuesEqual = require(modules.DataUtil.areValuesEqual)
local ActionMessenger = require(script.ActionMessenger)
local Permanent = {}


-- TYPES
export type StatusPhase =
	"checking"
	| "in-server"
	| "datastore"
	| "cross-server"
	| "polling"
	| "retry"
	| "global"
	| "global-done"
	| "global-failed"
	| "done"
	| "failed"

export type ApplySpec = {
	targetUserId: number | string,
	playerStorePath: {string},
	globalStoreName: string?,
	globalUserKey: string?,
	globalStorePath: {string}?,
	globalExtraWrites: { { path: {string}, value: any } }?,
	globalAfterWrite: ((globalUser: any) -> ())?,
	payload: any, -- (nil to remove)
	onStatus: ((StatusPhase) -> ())?,
}


-- LOCAL FUNCTIONS
local function setAtPath(tbl: any, path: {string}, value: any)
	local target: any = tbl
	for index = 1, #path - 1 do
		local key = path[index]
		if typeof(target[key]) ~= "table" then
			if value == nil then return end -- nothing to remove
			target[key] = {}
		end
		target = target[key]
	end
	target[path[#path]] = value
end

local function getAtPath(tbl: any, path: {string}): any
	local target: any = tbl
	for _, key in path do
		if typeof(target) ~= "table" then return nil end
		target = target[key]
	end
	return target
end

local function decodeProfileBlob(raw: any): any?
	if typeof(raw) == "string" then
		raw = Serializer.decompress(raw)
	end
	if typeof(raw) ~= "table" then return nil end
	if raw._isSerialized == true then
		raw._isSerialized = nil
		raw = Serializer.deserialize(raw)
	end
	return raw
end

local function writeProfileAsync(
	targetUserKey: string,
	playerStorePath: {string},
	value: any
): (boolean, boolean, string?)
	local wroteApplied = false
	local lockedJobId: string? = nil

	local success, _ = DataStores.updateAsync(PLAYER_STORE_NAME, targetUserKey, function(incomingData: any)
		local wasCompressed = typeof(incomingData) == "string"
		if wasCompressed then
			incomingData = Serializer.decompress(incomingData)
		end
		if typeof(incomingData) ~= "table" then
			incomingData = {}
		end

		local locked, jobId = DataStores.isSessionLockActive(incomingData)
		if locked then
			lockedJobId = jobId
			return nil
		end

		-- This is a small amount of overhead but
		-- keeps the saved value consistent with what a normal save produces
		local wasSerialized = incomingData._isSerialized == true
		if wasSerialized then
			incomingData._isSerialized = nil
			incomingData = Serializer.deserialize(incomingData)
		end

		setAtPath(incomingData, playerStorePath, value)
		incomingData._lastSavedTime = os.time()
		-- It's important to not touch _sessionLock

		incomingData._isSerialized = true
		incomingData = Serializer.serialize(incomingData, true)
		if wasCompressed then
			incomingData = Serializer.compress(incomingData)
		end
		wroteApplied = true
		return incomingData
	end)

	return success, wroteApplied, lockedJobId
end

local function pollForChange(
	targetUserKey: string,
	playerStorePath: {string},
	expectedValue: any
): boolean
	local deadline = os.clock() + POLL_DEADLINE
	while os.clock() < deadline do
		task.wait(POLL_INTERVAL)
		local ok, raw = DataStores.getAsync(PLAYER_STORE_NAME, targetUserKey)
		if ok then
			local decoded = decodeProfileBlob(raw)
			if decoded ~= nil then
				local current = getAtPath(decoded, playerStorePath)
				if areValuesEqual(current, expectedValue) then
					return true
				end
			end
		end
	end
	return false
end

local function applyToInServerUser(userId: number | string, playerStorePath: {string}, value: any): boolean
	local localUser: any = User.getUserByUserId(userId, true)
	if not localUser or not localUser.isLoaded then return false end
	localUser.perm:set(playerStorePath, value)
	return true
end

local function updateGlobalStore(
	globalStoreName: string,
	globalUserKey: string,
	globalStorePath: {string},
	value: any,
	extras: { { path: {string}, value: any } }?,
	afterWrite: ((globalUser: any) -> ())?
): (boolean, string?)
	local existing = User.getUser(globalUserKey, true)
	if not existing then
		User.new(globalUserKey, globalStoreName)
	end
	local ok, globalUser = User.getUserAsync(globalUserKey)
	if not ok or not globalUser then
		return false, "Failed to load global store user"
	end
	(globalUser :: any).perm:set(globalStorePath, value)
	if extras then
		for _, extraWrite in extras do
			if typeof(extraWrite) == "table" and typeof(extraWrite.path) == "table" then
				(globalUser :: any).perm:set(extraWrite.path, extraWrite.value)
			end
		end
	end
	if afterWrite then
		local hookOk, hookErr = pcall(afterWrite, globalUser)
		if not hookOk then
			warn(`[Permanent] globalAfterWrite hook errored: {tostring(hookErr)}`)
		end
	end
	return true, nil
end


-- PUBLIC
function Permanent.applyAsync(spec: ApplySpec): (boolean, string?)
	local targetUserId = spec.targetUserId
	local playerStorePath = spec.playerStorePath
	local payload = spec.payload
	local onStatus = spec.onStatus

	if typeof(targetUserId) ~= "number" and typeof(targetUserId) ~= "string" then
		return false, "targetUserId must be a number or string"
	end
	if typeof(playerStorePath) ~= "table" or #playerStorePath == 0 then
		return false, "playerStorePath must be a non-empty array"
	end

	local userKey = tostring(targetUserId)
	local actionId = generateUID(16)
	local function status(phase: StatusPhase)
		if onStatus then
			pcall(onStatus, phase)
		end
	end

	-- PlayerStore phase
	status("checking")
	local applied = false

	-- Case A: target loaded on this server
	if applyToInServerUser(targetUserId, playerStorePath, payload) then
		status("in-server")
		applied = true
	end

	-- Cases B/C/D
	local retries = 0
	while not applied and retries < MAX_RETRIES do
		status("datastore")
		local probeOk, wroteApplied, lockJobId = writeProfileAsync(userKey, playerStorePath, payload)

		if probeOk and wroteApplied then
			-- Case C or D handled by the transform directly. A stale lock can hide a
			-- live server (saves only run when data changes, so an idle player's lock
			-- reads expired), so we also broadcast for any server that has the target
			-- loaded to apply it in-memory. Others ignore it
			ActionMessenger.publish("*", actionId, targetUserId, playerStorePath, payload)
			applied = true
			break
		end

		if lockJobId then
			-- In case B, another server has the session lock. We tell that server via
			-- MessagingService, then poll DataStore for the receiver's save to land
			status("cross-server")
			ActionMessenger.publish(lockJobId, actionId, targetUserId, playerStorePath, payload)
			status("polling")
			if pollForChange(userKey, playerStorePath, payload) then
				applied = true
				break
			end
			-- Poll timed out, meaning the target may have left their server, or the
			-- server may have crashed mid-apply
			if applyToInServerUser(targetUserId, playerStorePath, payload) then
				status("in-server")
				applied = true
				break
			end
			retries += 1
			status("retry")
		else
			-- UpdateAsync failed for a non-lock reason (Roblox throttling,
			-- network blip, etc)
			retries += 1
			status("retry")
			task.wait(2)
		end
	end

	if not applied then
		status("failed")
		return false, "Permanent action could not be applied after retries"
	end

	status("global")
	if spec.globalStoreName and spec.globalUserKey and spec.globalStorePath then
		local globalStoreName = spec.globalStoreName :: string
		local globalUserKey = spec.globalUserKey :: string
		local globalStorePath = spec.globalStorePath :: {string}
		local extras = spec.globalExtraWrites
		local afterWrite = spec.globalAfterWrite
		task.spawn(function()
			local ok, err = updateGlobalStore(globalStoreName, globalUserKey, globalStorePath, payload, extras, afterWrite)
			if ok then
				status("global-done")
			else
				warn(`[Permanent] global store update failed actionId={actionId}: {tostring(err)}`)
				status("global-failed")
			end
		end)
	end

	status("done")
	return true, nil
end

function Permanent.removeAsync(spec: ApplySpec): (boolean, string?)
	spec.payload = nil
	return Permanent.applyAsync(spec)
end


-- SETUP
-- Subscribe immediately so every server that requires this module becomes a
-- valid target for cross-server action messages
ActionMessenger.subscribe()


return Permanent
