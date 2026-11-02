--!strict

--[[

	This is what powers the "Perm" modifiers

--]]


-- CONFIG
local MAX_ENTRIES = 100
local STRIPPED_MODIFIERS: {[string]: true} = {perm = true, join = true, global = true, wasGlobal = true}


-- LOCAL
local PermTasks = {}
local Players = game:GetService("Players")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local services = modules.Parent.Services
local User = require(modules.Objects.User)
local Task = require(modules.Objects.Task)
local generateUID = require(modules.DataUtil.generateUID)
local getArgIdentity = require(modules.CommandUtil.getArgIdentity)
local gameUser: any = nil
local knownEntries: {[string]: any} = {}
local spawnedTaskUIDs: {[string]: {[string]: true}} = {}
local processedJoinUserIds: {[number]: true} = {}


-- TYPES
export type EntryKind = "permPinned" | "joinPlayers" | "joinServer"
export type Entry = {
	kind: EntryKind,
	commandKey: string,
	args: {[string]: {string}}?,
	qualifiers: {[string]: {string}}?,
	modifiers: {[string]: {string}}?,
	callerUserId: number | string,
	callerName: string?,
	callerDisplayName: string?,
	callerTopRoleKey: string?,
	targetUserId: number?,
	targetName: string?,
	targetUserName: string?,
	createdAt: number,
	argOverrides: {[string]: any}?,
	argOverrideKeys: {[string]: string}?,
}


-- LOCAL FUNCTIONS
local function getEntries(): {[string]: any}
	if not gameUser then
		return {}
	end
	local entries = gameUser.perm:get("Tasks")
	return if typeof(entries) == "table" then entries else {}
end

local function canonicaliseQualifiers(qualifiers: any): string
	if typeof(qualifiers) ~= "table" then
		return ""
	end
	local parts: {string} = {}
	for key, values in qualifiers do
		local valueText = ""
		if typeof(values) == "table" then
			local copied: {string} = {}
			for _, value in values :: {any} do
				table.insert(copied, tostring(value))
			end
			table.sort(copied)
			valueText = table.concat(copied, ",")
		end
		table.insert(parts, `{tostring(key):lower()}({valueText})`)
	end
	table.sort(parts)
	return table.concat(parts, ";")
end

local function sameAudience(entryA: any, entryB: any): boolean
	if entryA.kind == "permPinned" then
		return entryA.targetUserId == entryB.targetUserId
	end
	return canonicaliseQualifiers(entryA.qualifiers) == canonicaliseQualifiers(entryB.qualifiers)
end

local function instantiate(entryUID: string, entry: any, targetUserId: number?, isReplay: boolean?)
	local taskUID = if entry.kind == "joinPlayers" and targetUserId then `{entryUID}_{targetUserId}` else entryUID
	local existing = Task.getTask(taskUID)
	if existing and (existing :: any).isActive then
		return
	end
	if typeof(entry.callerUserId) == "number" and typeof(entry.callerTopRoleKey) == "string" then
		require(modules.References.remoteCallerRoles).register(entry.callerUserId, entry.callerTopRoleKey)
	end
	local taskModifiers: {[string]: any} = {}
	if typeof(entry.modifiers) == "table" then
		for modifierName, value in entry.modifiers :: {[string]: any} do
			if not STRIPPED_MODIFIERS[modifierName] then
				taskModifiers[modifierName] = value
			end
		end
	end
	local newTask = Task.new({
		UID = taskUID,
		callerUserId = entry.callerUserId,
		targetUserId = targetUserId or entry.targetUserId,
		commandKey = entry.commandKey,
		args = entry.args,
		modifiers = taskModifiers :: any,
		qualifiers = entry.qualifiers,
		isRestricted = true,
	})
	if not newTask then
		return
	end
	(newTask :: any).extra.entryUID = entryUID
	if entry.kind ~= "permPinned" then
		(newTask :: any).extra.suppressAutoPrompt = true
	end
	if isReplay then
		(newTask :: any).isReplay = true
	end
	if typeof(entry.argOverrides) == "table" then
		local newTaskAny = newTask :: any
		newTaskAny.extra.argOverrides = entry.argOverrides
		newTaskAny.extra.argOverrideKeys = entry.argOverrideKeys
	end
	if typeof(entry.createdAt) == "number" then
		(newTask :: any).startedAt = entry.createdAt
	end
	PermTasks.trackTask(entryUID, newTask)
end

local function playerMatchesCommand(commandKey: string, qualifiers: any, callerUserId: number | string, player: Player): boolean
	local Commands = require(services.Commands) :: any
	local Args = require(modules.Parser.Args) :: any
	local command = Commands.getCommand(commandKey)
	if not command or typeof(command.args) ~= "table" then
		return false
	end
	local firstArg = Args.get(command.args[1])
	if not firstArg or not firstArg.playerArg then
		return false
	end
	local targets = firstArg:parse(qualifiers, callerUserId)
	if typeof(targets) ~= "table" then
		return firstArg.hidden == true and not firstArg.runForEachPlayer
	end
	for _, target in targets :: {any} do
		if target == player then
			return true
		end
	end
	return false
end

local function evaluateEntryForPlayer(entryUID: string, entry: any, player: Player)
	if typeof(entry) ~= "table" then
		return
	end
	if entry.kind == "permPinned" then
		if entry.targetUserId == player.UserId then
			instantiate(entryUID, entry, entry.targetUserId, true)
		end
		return
	end
	if entry.kind ~= "joinPlayers" then
		return
	end
	local matches = playerMatchesCommand(entry.commandKey, entry.qualifiers, entry.callerUserId, player)
	if matches then
		instantiate(entryUID, entry, player.UserId, true)
	end
end

local function applyChangedOverrides(entryUID: string, entry: any, previous: any)
	local newOverrides = if typeof(entry.argOverrides) == "table" then entry.argOverrides else nil
	if not newOverrides then
		return
	end
	local oldOverrides = if typeof(previous) == "table" and typeof(previous.argOverrides) == "table" then previous.argOverrides else {}
	local changed: {[string]: any}? = nil
	for argName, value in newOverrides do
		if oldOverrides[argName] ~= value then
			changed = changed or {}
			;(changed :: any)[argName] = value
		end
	end
	if not changed then
		return
	end
	local spawned = spawnedTaskUIDs[entryUID]
	if not spawned or next(spawned) == nil then
		return
	end
	local function getDeclaredReference(liveTask: any, argIndex: number): any
		local config = liveTask.extra.lastPromptConfig
		local configArgs = if typeof(config) == "table" then config.args else nil
		if typeof(configArgs) ~= "table" then
			return argIndex
		end
		for _, argEntry in configArgs do
			local reference = if typeof(argEntry) == "table" then argEntry.arg else argEntry
			if reference ~= nil and liveTask:getArgIndex(reference) == argIndex then
				return reference
			end
		end
		return argIndex
	end
	for argKey, value in changed do
		local argIndex = tonumber(argKey)
		for taskUID in spawned do
			local liveTask = Task.getTask(taskUID) :: any
			if not liveTask or not liveTask.isActive then
				continue
			end
			-- Older entries are keyed by arg name, which the task can still resolve back to a position
			local resolvedIndex = argIndex or liveTask:getArgIndex(argKey)
			if not resolvedIndex then
				continue
			end
			-- The position only counts while it still holds the same arg, so edited commands drop stale values
			local savedIdentities = entry.argOverrideKeys
			if typeof(savedIdentities) == "table" then
				local savedIdentity = savedIdentities[tostring(argKey)]
				if savedIdentity ~= nil and savedIdentity ~= getArgIdentity(liveTask:getArgDetail(resolvedIndex)) then
					continue
				end
			end
			-- The flag stops the task writing the change straight back, then onChange applies it live without rerunning (so music doesn't restart)
			liveTask.extra.applyingRemoteArg = true
			liveTask:setArg(resolvedIndex, value)
			liveTask.extra.applyingRemoteArg = nil
			local config = liveTask.extra.lastPromptConfig
			if typeof(config) == "table" and typeof(config.onChange) == "function" and not liveTask.deactivated then
				pcall(config.onChange, getDeclaredReference(liveTask, resolvedIndex), value)
			end
		end
	end
end

local function reconcile(isBoot: boolean?)
	local entries = getEntries()
	for entryUID in knownEntries do
		if entries[entryUID] then
			continue
		end
		knownEntries[entryUID] = nil
		local spawned = spawnedTaskUIDs[entryUID]
		spawnedTaskUIDs[entryUID] = nil
		if spawned then
			for taskUID in spawned do
				local liveTask = Task.getTask(taskUID)
				if liveTask and (liveTask :: any).isActive then
					(liveTask :: any):destroy()
				end
			end
		end
	end
	for entryUID, entry in entries do
		local previous = knownEntries[entryUID]
		knownEntries[entryUID] = entry
		if typeof(entry) ~= "table" then
			continue
		end
		if previous then
			applyChangedOverrides(entryUID, entry, previous)
			continue
		end
		if entry.kind == "joinServer" then
			if isBoot then
				instantiate(entryUID, entry, nil, true)
			end
		elseif entry.kind == "permPinned" then
			local targetUserId = entry.targetUserId
			if typeof(targetUserId) == "number" and Players:GetPlayerByUserId(targetUserId) then
				instantiate(entryUID, entry, targetUserId, isBoot == true)
			end
		elseif entry.kind == "joinPlayers" then
			task.spawn(function()
				if getEntries()[entryUID] == nil then
					return
				end
				for _, player in Players:GetPlayers() do
					evaluateEntryForPlayer(entryUID, entry, player)
				end
			end)
		end
	end
	User.everyone:set("PermTasks", entries)
end

local function handlePlayerAsync(player: Player)
	local userId = player.UserId
	if processedJoinUserIds[userId] then
		return
	end
	processedJoinUserIds[userId] = true
	while not User.getUser(player) do
		if player.Parent == nil then
			processedJoinUserIds[userId] = nil
			return
		end
		task.wait(0.5)
	end
	while not gameUser do
		task.wait(0.5)
		if player.Parent == nil then
			return
		end
	end
	if player.Parent == nil then
		return
	end
	for entryUID, entry in getEntries() do
		evaluateEntryForPlayer(entryUID, entry, player)
	end
end


-- FUNCTIONS
function PermTasks.playerMatchesCommand(commandKey: string, qualifiers: any, callerUserId: number | string, player: Player): boolean
	return playerMatchesCommand(commandKey, qualifiers, callerUserId, player)
end

function PermTasks.add(entry: Entry): (boolean, string?)
	if not gameUser then
		return false, "Perm tasks aren't ready yet, try again in a moment"
	end
	local entries = getEntries()
	-- The caller is only online where the entry is made, so the role key freezes in now
	if typeof(entry.callerUserId) == "number" and not entry.callerTopRoleKey then
		local RemoteCallerRoles = require(modules.References.remoteCallerRoles)
		entry.callerTopRoleKey = RemoteCallerRoles.resolveLocalKey(entry.callerUserId)
	end
	local Commands = require(services.Commands) :: any
	local command = Commands.getCommand(entry.commandKey)
	local isStackable = command ~= nil and (command :: any).stackable == true
	local replaceUID: string? = nil
	if not isStackable then
		for existingUID, existing in entries do
			if typeof(existing) ~= "table" then
				continue
			end
			if existing.commandKey == entry.commandKey and existing.kind == entry.kind and sameAudience(existing, entry) then
				replaceUID = existingUID
				break
			end
		end
	end
	if not replaceUID then
		local count = 0
		for _ in entries do
			count += 1
		end
		if count >= MAX_ENTRIES then
			return false, `Perm task limit reached ({MAX_ENTRIES}). Remove some from the Tasks page first`
		end
	end
	if replaceUID then
		gameUser.perm:set("Tasks", replaceUID, nil)
	end
	local entryUID = generateUID(10)
	gameUser.perm:set("Tasks", entryUID, entry)
	return true, nil, entryUID
end

function PermTasks.remove(entryUID: string, reason: string?): boolean
	if not gameUser then
		return false
	end
	if gameUser.perm:get("Tasks", entryUID) == nil then
		return false
	end
	gameUser.perm:set("Tasks", entryUID, nil)
	return true
end

function PermTasks.removeMatching(commandKey: string, targetUserIds: {number}?): number
	if not gameUser then
		return 0
	end
	local targetSet: {[number]: true}? = nil
	if targetUserIds and #targetUserIds > 0 then
		local set: {[number]: true} = {}
		for _, userId in targetUserIds do
			set[userId] = true
		end
		targetSet = set
	end
	local removed = 0
	local keyLower = tostring(commandKey):lower()
	for entryUID, entry in getEntries() do
		if typeof(entry) ~= "table" or tostring(entry.commandKey):lower() ~= keyLower then
			continue
		end
		if targetSet and entry.kind == "permPinned" and not targetSet[entry.targetUserId] then
			continue
		end
		gameUser.perm:set("Tasks", entryUID, nil)
		removed += 1
	end
	return removed
end

function PermTasks.countMatching(commandKey: string, targetUserIds: {number}?): number
	if not gameUser then
		return 0
	end
	local targetSet: {[number]: true}? = nil
	if targetUserIds and #targetUserIds > 0 then
		local set: {[number]: true} = {}
		for _, userId in targetUserIds do
			set[userId] = true
		end
		targetSet = set
	end
	local count = 0
	local keyLower = tostring(commandKey):lower()
	for _, entry in getEntries() do
		if typeof(entry) ~= "table" or tostring(entry.commandKey):lower() ~= keyLower then
			continue
		end
		if targetSet and entry.kind == "permPinned" and not targetSet[entry.targetUserId] then
			continue
		end
		count += 1
	end
	return count
end

function PermTasks.getEntry(entryUID: string): any
	if not gameUser then
		return nil
	end
	return gameUser.perm:get("Tasks", entryUID)
end

function PermTasks.trackTask(entryUID: string, trackedTask: any)
	local taskUID = trackedTask.UID
	local spawned = spawnedTaskUIDs[entryUID]
	if not spawned then
		spawned = {}
		spawnedTaskUIDs[entryUID] = spawned
	end
	spawned[taskUID] = true
	trackedTask:onEnded(function()
		local stillSpawned = spawnedTaskUIDs[entryUID]
		if stillSpawned then
			stillSpawned[taskUID] = nil
		end
	end)
end

function PermTasks.updateEntryArg(entryUID: string, argIndex: number, value: any)
	if not gameUser then
		return
	end
	local entry = gameUser.perm:get("Tasks", entryUID)
	if entry == nil then
		return
	end
	local identity = ""
	local Commands = require(services.Commands) :: any
	local command = Commands.getCommand(entry.commandKey)
	if command and typeof(command.args) == "table" then
		identity = getArgIdentity(command.args[argIndex])
	end
	local ok = pcall(function()
		gameUser.perm:set("Tasks", entryUID, "argOverrides", tostring(argIndex), value)
		gameUser.perm:set("Tasks", entryUID, "argOverrideKeys", tostring(argIndex), identity)
	end)
	if not ok then
		warn(`HD Admin: could not save control override #{tostring(argIndex)} for perm task {entryUID}`)
	end
end


-- SETUP
-- Only clients who can view the Tasks page receive the saved entries
local getStateVerifier = require(modules.VerifyUtil.getStateVerifier)
User.everyone:verify(getStateVerifier("PermTasks", "Exclude", {}, nil, "Tasks"))
User.everyone:set("PermTasks", {})

Players.PlayerAdded:Connect(function(player: Player)
	task.spawn(handlePlayerAsync, player)
end)
Players.PlayerRemoving:Connect(function(player: Player)
	processedJoinUserIds[player.UserId] = nil
end)
for _, player in Players:GetPlayers() do
	task.spawn(handlePlayerAsync, player)
end

task.defer(function()
	local success, loadedUser = User.getUserAsync("Game")
	if not success then
		return
	end
	gameUser = loadedUser
	reconcile(true)
	local pendingReconcile = false
	gameUser.perm:onChange("Tasks", function()
		if pendingReconcile then
			return
		end
		pendingReconcile = true
		task.defer(function()
			pendingReconcile = false
			reconcile(false)
		end)
	end)
end)


return PermTasks
