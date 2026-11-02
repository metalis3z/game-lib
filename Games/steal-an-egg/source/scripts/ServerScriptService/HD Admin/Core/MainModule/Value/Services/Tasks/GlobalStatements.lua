--!strict
-- CONFIG
local CATEGORY = "GlobalCommands"
local DEDUPE_TTL = 60 * 5


-- LOCAL
local GlobalStatements = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local services = modules.Parent.Services
local CrossServerSync = require(modules.DataStores.CrossServerSync)
local generateUID = require(modules.DataUtil.generateUID)
local receivedTaskUIDs: {[string]: number} = {}


-- LOCAL FUNCTIONS
local function pruneReceived()
	local now = os.time()
	for taskUID, receivedAt in receivedTaskUIDs do
		if now - receivedAt > DEDUPE_TTL then
			receivedTaskUIDs[taskUID] = nil
		end
	end
end


-- FUNCTIONS
function GlobalStatements.broadcast(callerUserId: number | string, statement: any)
	local taskUID = generateUID(10)
	local callerTopRoleKey: string? = nil
	if typeof(callerUserId) == "number" then
		local RemoteCallerRoles = require(modules.References.remoteCallerRoles)
		callerTopRoleKey = RemoteCallerRoles.resolveLocalKey(callerUserId)
	end
	CrossServerSync.broadcast(CATEGORY, {
		taskUID = taskUID,
		callerUserId = callerUserId,
		callerTopRoleKey = callerTopRoleKey,
		statement = statement,
	})
end


-- SETUP
CrossServerSync.register(CATEGORY, function(changes: {{any}})
	for _, change in changes do
		local payload = change[2]
		if typeof(payload) ~= "table" then
			continue
		end
		local taskUID = (payload :: any).taskUID
		local statement = (payload :: any).statement
		local callerUserId = (payload :: any).callerUserId
		if typeof(taskUID) ~= "string" or typeof(statement) ~= "table" or callerUserId == nil then
			continue
		end
		if typeof(statement.commands) ~= "table" or typeof(statement.modifiers) ~= "table" or typeof(statement.qualifiers) ~= "table" then
			continue
		end
		pruneReceived()
		if receivedTaskUIDs[taskUID] then
			continue
		end
		receivedTaskUIDs[taskUID] = os.time()
		local callerTopRoleKey = (payload :: any).callerTopRoleKey
		if typeof(callerUserId) == "number" and typeof(callerTopRoleKey) == "string" then
			require(modules.References.remoteCallerRoles).register(callerUserId, callerTopRoleKey)
		end
		statement.modifiers.perm = nil
		statement.modifiers.join = nil
		statement.modifiers.permjoin = nil
		statement.modifiers.permspawn = nil
		statement.modifiers.permschedule = nil
		statement.modifiers.permloop = nil
		statement.modifiers.permdelay = nil
		statement.modifiers.globalOrigin = nil
		statement.modifiers.preview = nil
		statement.receivedFromBroadcast = true
		local Commands = require(services.Commands) :: any
		task.spawn(function()
			Commands.executeStatement(callerUserId, statement)
		end)
	end
end)


return GlobalStatements
