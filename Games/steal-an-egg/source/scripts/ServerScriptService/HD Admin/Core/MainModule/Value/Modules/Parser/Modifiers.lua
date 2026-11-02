--!strict

--[[

	Modifiers are items that can be applied to statements to enhance a commands default behaviour
	For example, to execute a command in *every* server, you could add the 'global' modifier to a command:
	``;globalNotice all Greetings!``
	They are split into two groups:
		1. PreAction Modifiers - these execute before a task is created and can block the task being created entirely
		2. Action Modifiers - these execute while a task is running and can extend the longevity of the task
--]]


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local services = modules.Parent.Services
local Modifiers = {}
local Players = game:GetService("Players")
local Task = require(modules.Objects.Task)
local ParserTypes = require(modules.Parser.ParserTypes)
local requiresUpdating = true
local sortedNameAndAliasLengthArray = {}
local lowerCaseDictionary = {}


-- LOCAL FUNCTIONS
local function register(item: ModifierDetail): ModifierDetail
	return item :: ModifierDetail -- We do this to support type checking within the table
end

local function actOnTasksToUndo(task: Task.Task, callback: (task: Task.Task) -> ())
	local Commands = require(services.Commands)
	local Args = require(script.Parent.Args)
	local commandKey = task.commandKey
	local command = Commands.getCommand(commandKey)
	if not command then
		return
	end
	local firstCommandArg = command.args[1]
	local firstArgItem = Args.get(firstCommandArg :: any)
	local function actOn(taskToUndo: any)
		-- Perm backed tasks (and their subjobs) are unperm's to end, never undo's
		local extra = taskToUndo.extra
		if typeof(extra) == "table" and (extra.entryUID or extra.parentEntryUID) then
			return
		end
		callback(taskToUndo)
	end
	local function processTasks(playerUserId: number?)
		local runningTasks = Task.getTasks(commandKey, playerUserId)
		for _, task in runningTasks do
			actOn(task)
		end
	end
	if firstArgItem and firstArgItem.playerArg and firstArgItem.runForEachPlayer then
		local playerArg = Args.get("Player")
		local targets = (playerArg and playerArg:parse(task.qualifiers, task.callerUserId)) or {}
		for _, plr in targets do
			processTasks(plr.UserId)
		end
		-- Join watchers for these commands sit as one targetless task, so the per
		-- target pass above never reaches them
		for _, watcherTask in Task.getTasks(commandKey) do
			if not (watcherTask :: any).targetUserId then
				actOn(watcherTask)
			end
		end
	else
		processTasks()
	end
end


-- FUNCTIONS
function Modifiers.update()
	if not requiresUpdating then
		return false
	end
	requiresUpdating = false
	local allItems = Modifiers.getAll()
	sortedNameAndAliasLengthArray = {}
	lowerCaseDictionary = {}
	for itemNameOrAlias, item in allItems :: any do
		local lowerCaseName = tostring(itemNameOrAlias):lower()
		lowerCaseDictionary[lowerCaseName] = item
		table.insert(sortedNameAndAliasLengthArray, tostring(itemNameOrAlias))
	end
	table.sort(sortedNameAndAliasLengthArray, function(nameA: string, nameB: string): boolean
		return #nameA > #nameB
	end)
	return true
end

function Modifiers.getSortedNameAndAliasLengthArray()
	Modifiers.update()
	return sortedNameAndAliasLengthArray
end

function Modifiers.getLowercaseDictionary()
	Modifiers.update()
	return lowerCaseDictionary
end

-- Sends the statement to every other server and marks this one as the origin.
-- The Global modifier runs this, and so does globalVote's own run because it
-- broadcasts itself rather than carrying the modifier
function Modifiers.broadcastGlobalStatement(callerUserId: number, statement: Statement)
	local modifiers = statement.modifiers
	-- Receivers get wasGlobal instead of global so they can never rebroadcast.
	-- Join is also stripped from the copy because the origin server owns the
	-- saved entry, so other servers only run the immediate leg
	local oldGlobal = modifiers.global or {}
	modifiers.global = nil
	modifiers.wasGlobal = oldGlobal
	-- Commands that gather replies from every server (like globalVote) need one
	-- shared id, so it's stamped before the copy and globalOrigin after, meaning
	-- only this server's task sees itself as the collector
	local generateUID = require(modules.DataUtil.generateUID)
	modifiers.globalUID = generateUID(10) :: any
	local deepCopyTable = require(modules.TableUtil.deepCopyTable)
	local statementCopy = deepCopyTable(statement)
	modifiers.globalOrigin = true :: any
	statementCopy.modifiers.join = nil
	local prefilterTextArgs = require(modules.CommandUtil.prefilterTextArgs)
	local Commands = require(services.Commands) :: any
	-- A caller that already holds its filtered values (like a vote broadcasting from
	-- its own run) hands them over, because filtering the same text a second time
	-- gets rate limited and comes back hashed
	local suppliedOverrides = (statement :: any).argOverrides
	local overridesByCommand: {[string]: any} = if typeof(suppliedOverrides) == "table"
		then table.clone(suppliedOverrides)
		else {}
	local droppedCommandName: string? = nil
	for commandName in statementCopy.commands do
		local command = Commands.getCommand(commandName)
		if not command then
			continue
		end
		if overridesByCommand[command.key] ~= nil then
			continue
		end
		local overrides, failure = prefilterTextArgs(command, statementCopy.commands[commandName], callerUserId)
		if failure then
			statementCopy.commands[commandName] = nil
			droppedCommandName = command.name
		elseif overrides then
			overridesByCommand[command.key] = overrides
		end
	end
	if droppedCommandName then
		local callerPlayer = if typeof(callerUserId) == "number" then Players:GetPlayerByUserId(callerUserId) else nil
		if callerPlayer then
			local Prompt = require(modules.Prompt)
			Prompt.warn(callerPlayer, `'{droppedCommandName}' text was rejected by the filter, so it wasn't broadcast`)
		end
	end
	if next(statementCopy.commands) == nil then
		return
	end
	if next(overridesByCommand) then
		(statementCopy :: any).argOverrides = overridesByCommand
	end
	local GlobalStatements = require(services.Tasks.GlobalStatements) :: any
	GlobalStatements.broadcast(callerUserId, statementCopy)
end

function Modifiers.get(modifierKey: Modifier): ModifierDetail?
	local modifierKeyLower = tostring(modifierKey):lower()
	local ourDictionary = Modifiers.getLowercaseDictionary()
	local item = ourDictionary[modifierKeyLower] :: ModifierDetail?
	if not item then
		return nil
	end
	local modifierKeyCorrected = item.key
	if item.mustCreateAliasOf then
		local toCreateName = item.mustCreateAliasOf
		local qualifierToCreate = Modifiers.items[toCreateName]
		if not qualifierToCreate then
			error(`Modifiers: {modifierKeyCorrected} can not create alias because {toCreateName} is not a valid qualifier`)
		end
		qualifierToCreate = qualifierToCreate :: any
		for key, value in qualifierToCreate do
			item = item :: any
			if not item[key] then
				item[key] = value
			end
		end
		item.mustCreateAliasOf = nil :: any
		item.aliasOf = toCreateName
	end
	return item :: ModifierDetail
end

function Modifiers.getAll()
	-- We call .get to make sure all aliases are registered and setup correctly
	local items = Modifiers.items :: any
	for modifierKey, item in items do
		if not item.key then
			item.key = modifierKey
		end
		Modifiers.get(modifierKey :: Modifier)
	end
	return items :: {[string]: ModifierDetail} --:: {[Modifier]: ModifierDetail}
end

function Modifiers.createAliasOf(modifierKey: Modifier, initialTable: any?)
	-- We don't actually create a mirror table here as the data of items will have
	-- not yet gone into memory. Instead, we record the table as an alias, then
	-- set it's data once .get is called or 
	task.defer(function()
		-- This servers as a warning as opposed to an actual error
		if not Modifiers.items[modifierKey] then
			error(`Modifiers: {modifierKey} is not a valid qualifier`)
		end
	end)
	if typeof(initialTable) ~= "table" then
		initialTable = {}
	end
	initialTable.mustCreateAliasOf = modifierKey
	return initialTable
end


-- PUBLIC
Modifiers.items = {
	
	["Undo"] = register({
		isGlobal = false,
		isAbusive = false,
		description = "Ends all tasks of this command and/or player",
		ignorePreTaskChecks = true,
		displayOrder = 1,
		affectsArgs = "firstPlayerArg",
		preAction = function(task: Task.Task, values: any)
			actOnTasksToUndo(task, function(taskToUndo: Task.Task)
				taskToUndo.willBeUndone = true
			end)
		end,
		action = function(task: Task.Task, values: any)
			actOnTasksToUndo(task, function(taskToUndo: Task.Task)
				taskToUndo:destroy()
			end)
		end,
	}),

	["Un"] = Modifiers.createAliasOf("Undo"),

	-- Clears the matching saved perm entries without touching plain unsaved tasks.
	-- Their entry backed tasks still end everywhere because removal reconciles on
	-- every server. Commands.executeStatement short circuits it, so no task runs
	["Unperm"] = register({
		isGlobal = true,
		isAbusive = false,
		description = "Ends all permanent tasks of this command and/or player",
		ignorePreTaskChecks = true,
		displayOrder = 15,
		affectsArgs = "firstPlayerArg",
	}),

	["Loop"] = register({
		isGlobal = false,
		isAbusive = true,
		description = "Repeatedly re-runs",
		isCustomizable = true,
		requiresCapsule = true,
		ignorePreTaskChecks = false,
		displayOrder = 2,
		configurable = "iterations,interval",
		action = function(task: Task.Task, values)
			local iterations, interval = unpack(values)
			local ITERATION_LIMIT = 10000000
			local MINIMUM_INTERVAL = 0.1
			local newInterations = tonumber(iterations) or ITERATION_LIMIT
			if newInterations > ITERATION_LIMIT then
				newInterations = ITERATION_LIMIT
			end
			local newInterval = tonumber(interval) or MINIMUM_INTERVAL
			if newInterval < MINIMUM_INTERVAL then
				newInterval = MINIMUM_INTERVAL
			end
			local targetPlayer = task.target
			if targetPlayer then
				task:keep("UntilTargetLeaves", true)
			end
			task.iterate(newInterations, function(iteration)
				task:run()
				if iteration == newInterations then
					return
				end
				task.wait(newInterval)
			end)
		end,
	}),

	["Spawn"] = register({
		isGlobal = false,
		isAbusive = true,
		description = "Runs now and every time the player respawns",
		displayOrder = 3,
		ignorePreTaskChecks = false,
		action = function(task: Task.Task, values: any)
			local targetPlayer = task.target
			if not targetPlayer or not targetPlayer:IsA("Player") then
				return
			end
			if not task.isActive then
				return
			end
			task:keep("UntilTargetLeaves", true)
			task:redo(targetPlayer, function()
				task:run()
			end)
		end,
	}),

	["Global"] = register({
		isGlobal = true,
		isAbusive = true,
		description = "Runs once on all servers",
		ignorePreTaskChecks = false,
		displayOrder = 8,
		preCreation = function(callerUserId: number, statement: Statement)
			if not statement.modifiers.global then
				return
			end
			-- A previewed statement only opens the caller's run menu, so broadcasting
			-- now would run it everywhere before they confirm
			if statement.modifiers.preview then
				return
			end
			Modifiers.broadcastGlobalStatement(callerUserId, statement)
		end,
	}),

	["Perm"] = register({
		isGlobal = true,
		isAbusive = true,
		description = "Runs on every server and future servers",
		ignorePreTaskChecks = false,
		displayOrder = 9,
	}),

	-- Sugar for perm plus loop
	["PermLoop"] = register({
		isGlobal = true,
		isAbusive = true,
		description = "Repeatedly reruns on every server and future servers",
		isCustomizable = true,
		requiresCapsule = true,
		ignorePreTaskChecks = false,
		displayOrder = 10,
		configurable = "iterations,interval",
	}),

	-- Sugar for perm plus delay
	["PermDelay"] = register({
		isGlobal = true,
		isAbusive = true,
		description = "Waits this many seconds on all servers and future servers before running",
		isCustomizable = true,
		requiresCapsule = true,
		ignorePreTaskChecks = false,
		displayOrder = 13,
		configurable = "seconds",
	}),

	-- Sugar for perm plus join. The parser captures it as one modifier (longest
	-- name wins over perm) and convertStatementToRealNames expands it, so nothing
	-- downstream ever sees it
	["PermJoin"] = register({
		isGlobal = true,
		isAbusive = true,
		description = "Runs now and whenever a matching player joins any server. It keeps applying in future servers too",
		ignorePreTaskChecks = false,
		displayOrder = 12,
	}),

	["Join"] = register({
		isGlobal = true,
		isAbusive = true,
		description = "Runs on a player when they join this server",
		ignorePreTaskChecks = false,
		displayOrder = 4,
		action = function(task: Task.Task, _values: any)
			-- This watcher stays alive and reruns the command for each matching joiner.
			-- Combined modifiers (like loop) live in extra.childModifiers so they apply
			-- to the reruns, never to the watcher itself
			local Players = game:GetService("Players")
			local taskAny = task :: any
			if typeof(taskAny.modifiers) == "table" and taskAny.modifiers.undo then
				-- An undo statement carries join too, and its task must not start
				-- watching joins itself
				return
			end
			task:keep("Indefinitely")
			taskAny.janitor:add(Players.PlayerAdded:Connect(function(player: Player)
				task.spawn(function()
					-- We wait for their loaded User (not just the object, which the
					-- Users service may not even have created yet) so qualifiers
					-- resolve against real roles and the command sees ready data
					local User = require(modules.Objects.User)
					while not User.getUser(player) do
						if player.Parent == nil or not task.isActive then
							return
						end
						task.wait(0.5)
					end
					if not task.isActive or player.Parent == nil then
						return
					end
					local PermTasks = require(services.Tasks.PermTasks) :: any
					if not PermTasks.playerMatchesCommand(task.commandKey, taskAny.qualifiers, task.callerUserId, player) then
						return
					end
					local childTask = Task.new({
						callerUserId = task.callerUserId,
						targetUserId = player.UserId,
						commandKey = task.commandKey,
						args = taskAny.args,
						modifiers = taskAny.extra.childModifiers or {},
						qualifiers = taskAny.qualifiers,
						isRestricted = taskAny.isRestricted,
					})
					if childTask then
						(childTask :: any).extra.suppressAutoPrompt = true
						;(childTask :: any).isReplay = true
						local childOverrides = taskAny.extra.childArgOverrides
						if typeof(childOverrides) == "table" then
							(childTask :: any).extra.argOverrides = childOverrides
						end
					end
				end)
			end))
		end,
	}),

	["Delay"] = register({
		isGlobal = false,
		isAbusive = true,
		description = "Waits this many seconds before running",
		isCustomizable = true,
		requiresCapsule = true,
		displayOrder = 5,
		configurable = "seconds",
		keepInitialRun = true,
		action = function(task: Task.Task, values: any)
			local seconds = tonumber(values[1]) or 0
			task.wait(seconds)
		end,
	}),

	-- Sugar for perm plus spawn, so effects that vanish on death (paint, size)
	-- permanently survive both respawns and rejoins
	["PermSpawn"] = register({
		isGlobal = true,
		isAbusive = true,
		description = "Runs now and on every respawn, in this and future servers. It follows the players you picked wherever they go",
		ignorePreTaskChecks = false,
		displayOrder = 11,
	}),

	["Schedule"] = register({
		isGlobal = false,
		isAbusive = true,
		description = "Runs at the given epoch time",
		isCustomizable = true,
		requiresCapsule = true,
		displayOrder = 6,
		configurable = "epochTime",
		keepInitialRun = true,
		action = function(task: Task.Task, values: any)
			local executionTime = tonumber(values and values[1])
			if not executionTime then
				return
			end
			local taskAny = task :: any
			local seconds = executionTime - os.time()
			if seconds > 0 then
				-- The run fires once the moment arrives. If it fired naturally (not
				-- cancelled mid wait) any backing perm entry has served its purpose,
				-- so it removes itself instead of scheduling again on future boots
				local entryUID = taskAny.extra.entryUID
				if entryUID then
					task:onEnded(function()
						if taskAny.extra.scheduleFired then
							local PermTasks = require(services.Tasks.PermTasks) :: any
							PermTasks.remove(entryUID, "schedule fired")
						end
					end)
				end
				task.wait(seconds)
				taskAny.extra.scheduleFired = true
			elseif task.isReplay then
				-- The moment already passed, so a replay must never fire it late
				local entryUID = taskAny.extra.entryUID
				if entryUID then
					local PermTasks = require(services.Tasks.PermTasks) :: any
					PermTasks.remove(entryUID, "schedule moment passed")
				end
				task:destroy()
			end
		end,
	}),

	-- Sugar for perm plus schedule
	["PermSchedule"] = register({
		isGlobal = true,
		isAbusive = true,
		description = "Waits until the given epoch time on all servers and future servers before running",
		isCustomizable = true,
		requiresCapsule = true,
		displayOrder = 14,
		configurable = "epochTime",
	}),

	["Expire"] = register({
		isGlobal = false,
		isAbusive = true,
		description = "Ends after this many seconds",
		isCustomizable = true,
		requiresCapsule = true,
		displayOrder = 7,
		configurable = "seconds",
		keepInitialRun = true,
		action = function(task: Task.Task, values: any)
			local seconds = tonumber(values and values[1])
			if not seconds or seconds <= 0 then
				return
			end
			task.delay(seconds, function()
				task:destroy()
			end)
		end,
	}),

	["Until"] = Modifiers.createAliasOf("Expire"),

	["Preview"] = register({
		isGlobal = false,
		isAbusive = false,
		ignorePreTaskChecks = true,
		description = "Loads up the command run menu of that command instead of running",
		keepInitialRun = false,
		action = function(task: Task.Task, _values: any)
			local caller = (task :: any).caller
			if typeof(caller) ~= "Instance" or not caller:IsA("Player") then return end
			local remote = require(modules.References.openPreviewRemote) :: any
			if not remote then return end
			local taskAny = task :: any
			local modifierTokens: {string} = {}
			if typeof(taskAny.modifiers) == "table" then
				for modName, _ in taskAny.modifiers :: any do
					if typeof(modName) == "string" and modName:lower() ~= "preview" then
						table.insert(modifierTokens, modName)
					end
				end
			end
			remote:fireClient(caller, {
				commandKey = task.commandKey,
				argTokens = taskAny.args,
				modifierTokens = modifierTokens,
			})
		end,
	}),

	["Random"] = register({
		isGlobal = false,
		isAbusive = false,
		description = "Picks one command at random from the statement",
		preCreation = function(_, statement)
			local commands: any = statement.commands :: any
			if #commands > 1 then
				local randomIndex = math.random(1, #commands)
				local selectedItem = commands[randomIndex]
				commands = { selectedItem }
				statement.commands = commands
			end
		end,
	}),

}


-- TYPES
type Statement = ParserTypes.ParsedStatement
export type Modifier = keyof<typeof(Modifiers.items)>
export type ModifierDetail = {
	description: string,
	aliases: {[Modifier]: boolean}?,
	key: string?,
	mustCreateAliasOf: any?,
	aliasOf: string?,
	requiresCapsule: boolean?,
	isGlobal: boolean?,
	isAbusive: boolean?,
	ignorePreTaskChecks: boolean?,
	keepInitialRun: boolean?,
	affectsArgs: string?, -- command-bar hint: narrows which args the bar previews (see ModifierUtil.effectiveArgs)
	preCreation: ((callerUserId: number, statement: Statement) -> ())?,
	preAction: ((task: Task.Task, values: any) -> ())?,
	action: ((task: Task.Task, values: any) -> ())?,
	--blockInPrivateServers: boolean?, -- to do later: stops the command being used in private servers
}


return Modifiers