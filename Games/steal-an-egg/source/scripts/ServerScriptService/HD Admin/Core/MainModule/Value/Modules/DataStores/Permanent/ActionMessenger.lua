--!strict
--[[

	This is a cross-server message channel for Permanent actions (perm bans, perm roles,
	perm warns, etc)

]]


-- CONFIG
local TOPIC_NAME = "HDPermanentAction"
local DEDUPE_TTL = 60 * 5
local SAVE_COALESCE_WINDOW = 2


-- LOCAL
local MessagingService = game:GetService("MessagingService")
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local Serializer = require(modules.Serializer)
local IsolatedServer = require(modules.IsolatedServer)
local _dedupe: {[string]: number} = {}
local _saveStates: {[string]: {running: boolean, rerunQueued: boolean, lastFinished: number}} = {}
local _subscribed = false
local ActionMessenger = {}


-- LOCAL FUNCTIONS
local function persistUserAsync(user: any, actionId: string)
	local saveAsync = (user :: any).saveAsync
	if typeof(saveAsync) ~= "function" then
		return
	end
	local stateKey = tostring((user :: any).userId)
	local saveState = _saveStates[stateKey]
	if not saveState then
		saveState = {running = false, rerunQueued = false, lastFinished = 0}
		_saveStates[stateKey] = saveState
	end
	if saveState.running then
		saveState.rerunQueued = true
		return
	end
	saveState.running = true
	task.spawn(function()
		while true do
			local sinceLast = os.clock() - saveState.lastFinished
			if sinceLast < SAVE_COALESCE_WINDOW then
				task.wait(SAVE_COALESCE_WINDOW - sinceLast)
			end
			saveState.rerunQueued = false
			saveAsync()
			saveState.lastFinished = os.clock()
			if not saveState.rerunQueued then
				break
			end
		end
		saveState.running = false
	end)
end

local function getJobId(): string
	return if RunService:IsStudio() then "Studio" else game.JobId
end

local function pruneDedupe()
	local now = os.time()
	for actionId, timestamp in _dedupe do
		if now - timestamp > DEDUPE_TTL then
			_dedupe[actionId] = nil
		end
	end
end

local function applyIncoming(payload: any)
	if typeof(payload) ~= "table" then return end
	local actionId = payload.actionId
	local targetJobId = payload.targetJobId
	local targetUserId = payload.targetUserId
	local playerStorePath = payload.playerStorePath
	local serializedValue = payload.serializedValue
	local action = payload.action
	if typeof(actionId) ~= "string" or actionId == "" then return end
	if typeof(playerStorePath) ~= "table" then return end
	if targetJobId ~= getJobId() and targetJobId ~= "*" then return end
	if _dedupe[actionId] then return end
	_dedupe[actionId] = os.time()

	local user = User.getUserByUserId(targetUserId)
	if not user then
		-- Target left this server
		return
	end

	if action == "remove" then
		(user.perm :: any):set(playerStorePath, nil)
	else
		local value = Serializer.deserialize(serializedValue, true)
		;(user.perm :: any):set(playerStorePath, value)
	end

	persistUserAsync(user, actionId)
end


-- FUNCTIONS
function ActionMessenger.subscribe()
	if _subscribed then return end
	_subscribed = true
	if RunService:IsStudio() or IsolatedServer.isIsolated() then return end
	task.spawn(function()
		local backoff = 3
		while true do
			local connection: any = nil
			local ok = pcall(function()
				connection = MessagingService:SubscribeAsync(TOPIC_NAME, function(msg: any)
					pruneDedupe()
					applyIncoming(if typeof(msg) == "table" then msg.Data else nil)
				end)
			end)
			if ok then
				IsolatedServer.onIsolate(function()
					pcall(function()
						connection:Disconnect()
					end)
				end)
				return
			end
			task.wait(backoff)
			backoff = math.min(backoff * 2, 60)
		end
	end)
end

function ActionMessenger.publish(
	targetJobId: string,
	actionId: string,
	targetUserId: number | string,
	playerStorePath: {string},
	value: any
): boolean
	local action = if value == nil then "remove" else "set"
	local payload = {
		actionId = actionId,
		targetJobId = targetJobId,
		targetUserId = targetUserId,
		playerStorePath = playerStorePath,
		serializedValue = if value == nil then nil else Serializer.serialize(value, true),
		action = action,
	}
	if RunService:IsStudio() then
		-- No cross-server in Studio (single server)
		return false
	end
	if IsolatedServer.isIsolated() then
		-- Same as Studio, an isolated server has no other servers to tell
		return false
	end
	local ok, err = pcall(function()
		MessagingService:PublishAsync(TOPIC_NAME, payload)
	end)
	if not ok then
		warn(`[Permanent] publish failed actionId={actionId}: {tostring(err)}`)
	end
	return ok
end


return ActionMessenger
