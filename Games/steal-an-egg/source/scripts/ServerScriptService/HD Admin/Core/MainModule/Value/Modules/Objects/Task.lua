--!strict

--[[ 

	"Tasks" are the objects created every time a command is run, and destroyed when the
	command finishes running, or when the command is ended (by the user, by a timeout, etc).

	They come with their own 'defer', 'delay, 'wait', etc methods that must be used instead of
	the standard task methods, so the task is tracked and cleaned up properly.
	They also make it possible to 'pause' and 'resume' command tasks

]]


-- CONFIG
local ERROR_START = "HD Admin Command Error: "


-- LOCAL
local Players = game:GetService("Players")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Janitor = require(modules.Objects.Janitor)
local Args = require(modules.Parser.Args)
local Signal = require(modules.Objects.Signal)
local RunService = game:GetService("RunService")
local deepCopyTable = require(modules.TableUtil.deepCopyTable)
local generateUID = require(modules.DataUtil.generateUID)
local getHumanoid = require(modules.PlayerUtil.getHumanoid)
local getTargets = require(modules.CommandUtil.getTargets)
local getArgIdentity = require(modules.CommandUtil.getArgIdentity)
local registerSound = require(modules.AssetUtil.registerSound)
local isServer = RunService:IsServer()
local isClient = not isServer
local Remote = require(modules.Objects.Remote)
-- Created at load rather than on first use, so the instance replicates and the
-- client connects long before the first command ever fires it
local endClientTask: Remote.Class? = if isServer then Remote.new("EndClientTask", "Event") else nil
local allBuffs = {} :: {Buff}
local ignoreBuffTags = {} :: {[string]: true}
local tasks = {}
local TaskClient = require(script.TaskClient)
local TaskServer = require(script.TaskServer)
local Task = {}
Task.__index = Task


-- PUBLIC
Task.updated = Signal.new() :: Signal.Signal<string, any> -- fired with ("added" | "changed" | "removed", task) on the server


-- FUNCTIONS
function Task.getTask(UID: string?): Class?
	return tasks[tostring(UID)]
end

function Task.getSelfRunTasks(callerUserId: number): {Class}
	-- These are tasks which were called by callerUserId, and either
	-- have no targetUserId (like ;music), or have a targetUserId that matches
	-- callerUserId (like ;kill me)
	local tasksToReturn = {} :: {any}
	local stringCallerUserId = tostring(callerUserId)
	for _, task in tasks do
		-- Destroyed tasks with a cooldown stay registered until it completes, and
		-- those must never read as running (they'd lock run buttons in the stop state)
		if not task.isActive then
			continue
		end
		local ourCallerUserId = tostring(task.callerUserId)
		local ourTargetUserId = tostring(task.targetUserId)
		if ourCallerUserId == stringCallerUserId and (not task.targetUserId or ourTargetUserId == stringCallerUserId) then
			table.insert(tasksToReturn, task)
		end
	end
	tasksToReturn = tasksToReturn :: {Class}
	return tasksToReturn
end

function Task.getTasksByCallerId(callerUserId: number): {Class}
	local tasksToReturn = {} :: {any}
	local stringCallerUserId = tostring(callerUserId)
	for _, task in tasks do
		local ourCallerUserId = tostring(task.callerUserId)
		if ourCallerUserId == stringCallerUserId then
			table.insert(tasksToReturn, task)
		end
	end
	tasksToReturn = tasksToReturn :: {Class}
	return tasksToReturn
end

function Task.getTasks(commandKey: string?, targetUserId: number?): {Class}
	local tasksToReturn = {} :: {any}
	local commandKeyLower = if commandKey then commandKey:lower() else nil
	local stringTargetUserId = tostring(targetUserId)
	for _, task in tasks do
		local ourNameLower = task.commandKey
		local ourUserId = tostring(task.targetUserId)
		if (not commandKeyLower or ourNameLower == commandKeyLower) and (not targetUserId or ourUserId == stringTargetUserId) then
			table.insert(tasksToReturn, task)
		end
	end
	tasksToReturn = tasksToReturn :: {Class}
	return tasksToReturn
end


-- CONSTRUCTOR
function Task.new(properties: Properties)
	return Task.construct(properties) :: Class
end

function Task.construct(properties: Properties)

	-- Define properties
	local janitor = Janitor.new()
	local lifecycleJanitor = Janitor.new() -- the lifecycle janitor holds things that must survive an effect-only Cleanup (a deactivate) and only cleanup on a real destroy
	local commandKey = properties.commandKey
	local callerUserId = properties.callerUserId
	local targetUserId = properties.targetUserId
	local UID = properties.UID or generateUID(10)
	local services = modules.Parent.Services
	local dictOfGroupsLower = {}
	local cooldown = 0
	local config = {}
	local commandArgNames = {} :: {any}
	if isServer then
		local Commands = require(services.Commands) :: any
		local command = Commands.getCommand(commandKey) :: Command?
		local groups = command and command.groups
		if typeof(groups) == "table" then
			for _, groupName in groups do
				local nameLower = tostring(groupName):lower()
				dictOfGroupsLower[nameLower] = true
			end
		end
		local thisCooldown = command and command.cooldown
		if thisCooldown and typeof(thisCooldown) == "number" and thisCooldown > 0 then
			cooldown = thisCooldown
		end
		if command and typeof(command.config) == "table" then
			config = command.config
		end
		if command and typeof(command.args) == "table" then
			commandArgNames = command.args
		end
	end
	local self = {
		
		-- Public
		janitor = janitor,
		lifecycleJanitor = lifecycleJanitor,
		UID = UID,
		isActive = true :: any,
		bypassLimits = (function()
			if not isServer or typeof(callerUserId) ~= "number" then return false end
			local User = require(modules.Objects.User) :: any
			local callerUser = User.getUserByUserId(callerUserId)
			if not callerUser then return false end
			local Roles = require(modules.Parent.Services.Roles) :: any
			return Roles.hasPermission(callerUser, "permitBypassLimits")
		end)() :: any,
		caller = if typeof(callerUserId) == "number" then Players:GetPlayerByUserId(callerUserId) else nil,
		callerUserId = callerUserId,
		target = if targetUserId then Players:GetPlayerByUserId(targetUserId) else nil,
		client = TaskClient.new(UID),
		server = TaskServer.new(UID),
		extra = {},
		config = config,
		commandKey = commandKey:lower(),
		startedAt = os.time(),
		-- True when this run is a later re-execution (boot replay, rejoin
		-- reapplication, join rerun) rather than the original call, so commands can
		-- skip one off side effects like the Now playing hint
		isReplay = false,

		-- Private
		isPaused = false,
		pauseTime = 0,
		holdsToResume = {} :: {any},
		targetUserId = targetUserId,
		args = properties.args,
		modifiers = properties.modifiers,
		qualifiers = properties.qualifiers or {},
		isRestricted = properties.isRestricted,
		isRunning = false,
		originalArgReturnValues = {} :: {[number]: any},
		defaultedArgIndexes = {} :: {[number]: boolean},
		commandArgNames = commandArgNames,
		activeHolds = 0,
		forceKeepHolds = 0,
		keptPersistences = {} :: {[string]: boolean},
		deactivated = false,
		actionPromptId = nil :: string?,
		rerunCommand = nil :: (() -> ())?,
		resumed = nil :: Signal.Signal<any>?,
		clientArgs = properties.clientArgs,
		activeClientTasks = {} :: {[string]: true},
		cooldownEndTime = nil :: number?,
		hasCompletedCooldown = false :: boolean,
		cooldown = cooldown,
		dictOfGroupsLower = dictOfGroupsLower,
		activeTweens = {} :: {[Tween]: true},
		willBeUndone = false,
		hasStartedInitialRun = false,
		isSubjob = properties.isSubjob == true,
	}
	setmetatable(self, Task)
	tasks[UID] = self :: any
	if isServer then
		Task.updated:Fire("added", self)
	end
	
	local function forEachModifier(action: (modifier: any, values: any) -> ())
		local Modifiers = require(modules.Parser.Modifiers) :: any -- 'Any' to remove cyclic warning
		local modifiers = properties.modifiers or {}
		for modifierName, values in modifiers do
			local modifier = Modifiers.get(modifierName)
			if modifier then
				action(modifier, values)
			end
		end
	end
	local totalModifiers = 0
	local keepInitialRun = false
	forEachModifier(function(modifier, values)
		local preAction = modifier.preAction
		if preAction then
			(preAction :: any)(self, values)
		end
		totalModifiers += 1
		if modifier.keepInitialRun then
			keepInitialRun = true
		end
	end)
	task.defer(function()
		-- The initial run happens here
		-- it's important we flag it so an EndClientTask that lands
		-- before this fires waits for the run instead of cancelling it
		self.hasStartedInitialRun = true
		forEachModifier(function(modifier, values)
			local action = modifier.action
			if action then
				(action :: any)(self, values)
			end
		end)
		if totalModifiers == 0 or keepInitialRun then
			self:run()
		end
		self:checkToDestroy()
	end)

	-- TASK LIBRARY WRAPPERS
	function self.spawn(callback: () -> ())
		self:registerHold()
		task.spawn(function()
			self:unregisterHold(callback)
		end)
	end

	function self.defer(callback: () -> ())
		self:registerHold()
		task.defer(function()
			self:unregisterHold(callback)
		end)
	end

	function self.delay(delayTime:number, callback: () -> ()?)
		self:registerHold()
		if callback == nil then
			callback = function() end
		end
		task.delay(delayTime, function()
			self:unregisterHold(callback)
		end)
	end

	function self.wait(yieldTime:number?)
		self:registerHold()
		task.wait(yieldTime)
		self:unregisterHold()
	end

	function self.iterate(iterations: number, callback: (index: number) -> ())
		for iteration = 1, iterations do
			if not self.isActive then
				return
			end
			self:registerHold()
			self:unregisterHold(callback :: any, nil, iteration)
		end
	end

	function self.loop(callback: (stop: () -> (), index: number) -> ())
		local iterations = 0
		local isLoopActive = true
		local function stop()
			isLoopActive = false
		end
		while self.isActive and isLoopActive do
			iterations += 1
			self:registerHold()
			self:unregisterHold(callback :: any, nil, stop, iterations)
		end
	end

	return self
end


-- PRIVATE METHODS
function Task.run(self: Task)
	
	-- Only run if command is present
	local run: any? = nil
	local command: Command? = nil
	local commandKey = self.commandKey
	local args = self.args
	if isServer then
		local services = modules.Parent.Services
		local Commands = require(services.Commands) :: any
		command = Commands.getCommand(commandKey) :: Command?
		run = if command then command.run else nil
		if command and #self.commandArgNames == 0 and typeof((command :: any).args) == "table" then
			self.commandArgNames = (command :: any).args
		end
	elseif isClient then
		local controllers = modules.Parent.Controllers
		local ClientCommands = require(controllers.ClientCommands) :: any
		command = ClientCommands.getCommand(commandKey) :: Command?
		run = if command then command.run else nil
	end
	if not run then
		return false
	end
	if self.isRunning or not self.isActive then
		return false
	end
	self.isRunning = true

	local firstCommandArg = nil
	local firstArgItem = nil
	local commandArgs = nil
	local qualifiers = self.qualifiers
	local callerUserId = self.callerUserId
	local targetUserId = self.targetUserId
	if args then
		commandArgs = if command then command.args else {}
		firstCommandArg = commandArgs[1]
		firstArgItem = Args.get(firstCommandArg :: any)
	end
	if firstArgItem then
		if firstArgItem.playerArg == true and firstArgItem.hidden == true then
			if args and commandArgs and #args >= #commandArgs then
				table.remove(args :: any, 1)
			end
		end
	end
	
	-- For when a command finishes running
	local function runningDone()
		self.isRunning = false
		self:checkToDestroy()
	end

	-- This is essential for checking if an arg was originally nil
	local function registerOriginalArg(argIndex, value)
		self.originalArgReturnValues[argIndex] = value
	end

	local function runCommand(parseArgs, ...)
		local additional = {...}
		
		-- Convert arg strings into arg values
		-- Only execute the command once all args have been converted
		-- Some arg parsers, such as text, may be aschronous due to filter requests
		if isServer and parseArgs and args and commandArgs then
			local currentArgs = additional[1]
			local parsedArgs = if type(currentArgs) == "table" then currentArgs else nil
			if not parsedArgs then
				parsedArgs = {}
				additional[1] = parsedArgs
			end
			local firstAlreadyParsedArg = parsedArgs[1]
			local nextArgIndex = #parsedArgs + 1
			for _, _ in commandArgs do
				local iNow = nextArgIndex
				local argName = commandArgs[iNow]
				local argItem = Args.get(argName :: any)
				nextArgIndex += 1
				if not argItem then
					break
				end
				local argStringIndex = (firstAlreadyParsedArg and iNow - 1) or iNow
				local argString = args[argStringIndex :: any] or ""
				if argItem.playerArg then
					argString = {
						[argString] = {}
					}
				end
				-- We settle this BEFORE parsing because parsing text refilters 
				-- it with the caller offline which throws an error
				local override = nil
				local overrides = (self.extra :: any).argOverrides
				if typeof(overrides) == "table" then
					override = overrides[tostring(iNow)]
					if override == nil then
						local legacyKey = argItem.key and tostring(argItem.key):lower()
						override = if legacyKey then overrides[legacyKey] else nil
					end
					local savedIdentities = (self.extra :: any).argOverrideKeys
					if override ~= nil and typeof(savedIdentities) == "table" then
						local savedIdentity = savedIdentities[tostring(iNow)]
						if savedIdentity ~= nil and savedIdentity ~= getArgIdentity(argName) then
							override = nil
						end
					end
				end
				local returnValue = override
				if returnValue == nil then
					returnValue = argItem:parse(argString, callerUserId, targetUserId)
					if argItem.runForEachPlayer and typeof(returnValue) == "table" then
						-- If an additional arg is a player arg and has runForEachPlayer, it's
						-- important that we convert it to a single player instance
						returnValue = returnValue[1]
					end
				end
				if returnValue == nil then
					local default = argItem.default
					if typeof(default) == "table" then
						default = deepCopyTable(argItem.default)
					end
					returnValue = default
					self.defaultedArgIndexes[iNow] = true
				end
				-- A products-gated arg only takes a non-default value from a caller who
				-- owns one of its products. Anyone else falls back to the default and gets
				-- the unlock notice, while replays with no caller present pass through
				if self.defaultedArgIndexes[iNow] ~= true then
					local ArgProducts = require(modules.CommandUtil.ArgProducts)
					local gateProducts = ArgProducts.getProducts(argItem)
					if gateProducts and not ArgProducts.matchesDefault(argItem, returnValue) then
						local callerPlayer = if callerUserId then Players:GetPlayerByUserId(callerUserId) else nil
						if callerPlayer and not ArgProducts.ownsAnyAsync(callerPlayer, gateProducts) then
							ArgProducts.sendUnlockNoticeAsync(callerPlayer, gateProducts, argItem, if command then (command :: any).name else commandKey)
							local fallback = argItem.default
							if typeof(fallback) == "table" then
								fallback = deepCopyTable(fallback)
							end
							returnValue = fallback
							self.defaultedArgIndexes[iNow] = true
						end
					end
				end
				-- Registered after the default is filled in, so a command reading getArg
				-- sees exactly what landed in its args table
				registerOriginalArg(iNow, returnValue)
				parsedArgs[iNow] = returnValue
			end
		end
		
		-- We wrap with xpcall as it enables the job to be cleaned up even if the
		-- command throws an error
		-- We save the exact effects so an action prompt can re-apply it
		-- on the same task without re-parsing or re-running modifiers
		-- Server commands read their args off the task, so only a client command's
		-- replicated values still ride the call itself
		local function invokeRun()
			local function onError(errorMessage)
				local traceback = debug.traceback("", 2)
				warn(ERROR_START..tostring(errorMessage), traceback)
			end
			if parseArgs then
				xpcall(run, onError, self)
			else
				xpcall(run, onError, self, unpack(additional))
			end
		end
		self.rerunCommand = invokeRun
		invokeRun()
		runningDone()

		return true
	end

	-- If client job, execute with job.clientArgs
	if isClient then
		return runCommand(false, unpack(self.clientArgs))
	end

	-- If the job is player-specific (such as in ;kill foreverhd, ;kill all) find the associated player and execute the command on them
	local propsTarget = self.target
	if propsTarget then
		-- Commands with a collective player arg (like Players) expect an array, so a
		-- pinned run (a perm or join rerun targeting one joiner) wraps them
		if firstArgItem and firstArgItem.playerArg and not firstArgItem.runForEachPlayer then
			local targetGroup = {propsTarget}
			registerOriginalArg(1, targetGroup)
			return runCommand(true, {targetGroup})
		end
		-- The parse loop below starts after the target, so it's registered here instead
		if firstArgItem then
			registerOriginalArg(1, propsTarget)
		end
		return runCommand(true, {propsTarget})
	end
	
	-- If the job has no associated player or qualifiers (such as in ;music <musicId>) then simply execute right away
	if firstArgItem and not firstArgItem.playerArg then
		return runCommand(true, {})
	end

	-- If the job has no associated player *but* does contain qualifiers...
	-- ...that require executing for each player (such as in ;globalKill all)
	local targetPlayers = nil
	if firstArgItem then
		local firstArgResult = firstArgItem:parse(qualifiers, callerUserId)
		local argName = firstArgItem.key
		if not firstArgResult then
			firstArgResult = firstArgItem.default
			self.defaultedArgIndexes[1] = true
		end
		registerOriginalArg(1, firstArgResult)
		targetPlayers = firstArgResult
	end
	if firstArgItem and firstArgItem.runForEachPlayer then -- If the firstArg has runForEachPlayer, convert the job into subjobs for each player returned by the qualifiers
		local selfExtra = self.extra :: any
		for index, plr in targetPlayers do
			local subProperties: Properties = {
				targetUserId = plr.UserId,
				callerUserId = self.callerUserId,
				commandKey = self.commandKey,
				args = self.args,
				-- The parent runs the action modifiers itself, so a subjob inheriting
				-- them would loop or delay all over again per player
				modifiers = {},
				qualifiers = self.qualifiers,
				isRestricted = self.isRestricted,
				isSubjob = true,
			}
			local subTask = Task.new(subProperties)
			if subTask and isServer then
				-- Subjobs speak with the parent's voice. Replays stay quiet, filtered
				-- text rides along, and entry removal reaches their effects too (the
				-- initial run is deferred, so stamping here lands before it)
				local subTaskAny = subTask :: any
				subTaskAny.isReplay = self.isReplay
				subTaskAny.extra.suppressAutoPrompt = selfExtra.suppressAutoPrompt
				subTaskAny.extra.argOverrides = selfExtra.argOverrides
				-- A separate key from entryUID so setArg never writes a subjob's
				-- control change back to the shared entry
				subTaskAny.extra.parentEntryUID = selfExtra.entryUID
				if selfExtra.entryUID then
					local PermTasks = require(modules.Parent.Services.Tasks.PermTasks) :: any
					PermTasks.trackTask(selfExtra.entryUID, subTask)
				end
			end
		end
		runningDone()
		return true
	end
	
	-- ...that require executing collectively (such as in ;bring all)
	return runCommand(true, {targetPlayers})
end

function Task.registerHold(self: Task)
	self.activeHolds += 1
end

function Task.unregisterHold(self: Task, callback: () -> ()?, remainingTime: number?, firstArg: any?, secondArg: any?)
	-- We hold the callback before calling it if the task is paused
	if self.isPaused and self.isActive then
		-- We save the callback for most task methods with a callback (spawn, defer, delay, etc)
		local durationRemaining = os.clock() - self.pauseTime
		if callback then
			table.insert(self.holdsToResume :: {any}, {callback, durationRemaining})
			return
		end
		-- For wait(), we instead have to pause the thread until the task is resumed
		local resumed = self.resumed
		if not resumed then
			resumed = self.janitor:add(Signal.new())
			self.resumed = resumed
		end
		self.resumed:Wait()
		remainingTime = durationRemaining :: number
	end
	if remainingTime and remainingTime > 0 and self.isActive then
		task.delay(remainingTime, function()
			self:unregisterHold(callback)
		end)
		return
	end
	if typeof(callback) == "function" and self.isActive then
		xpcall(callback :: any, function(errorMessage)
			local traceback = debug.traceback("", 2)
			warn(ERROR_START..tostring(errorMessage), traceback)
		end, firstArg, secondArg)
	end
	self.activeHolds -= 1
	if self.activeHolds <= 0 then
		-- If no more active holds, defer by a frame, and if still zero, consider ending
		-- the task. We don't outright destroy it as command persistence may keep it running
		task.defer(function()
			if self.activeHolds <= 0 then
				self:checkToDestroy()
			end
		end)
	end
end

function Task.pause(self: Task)
	self.pauseTime = os.clock()
	self.isPaused = true
	for tween, _ in self.activeTweens do
		tween:Pause()
	end
	if isServer then
		Task.updated:Fire("changed", self)
	end
end

function Task.resume(self: Task)
	self.isPaused = false
	for _, holdInfo in self.holdsToResume do
		local callback = holdInfo[1]
		local remainingTime = holdInfo[2]
		task.defer(function()
			self:unregisterHold(callback, remainingTime)
		end)
	end
	for tween, _ in self.activeTweens do
		tween:Play()
	end
	if self.resumed then
		self.resumed:Fire()
	end
	if isServer then
		Task.updated:Fire("changed", self)
	end
end

function Task.checkToDestroy(self: Task)
	if self.isRunning then
		return
	end
	if self.activeHolds > 0 then
		return
	end
	self:destroy()
end

function Task.updateBuffs(self: Task, player: BuffPlayer?, group: BuffGroup?, ignoreOtherRequests: boolean?)
	if ignoreOtherRequests then
		local name = if typeof(player) == "Instance" then player.Name else player
		local buffTag = `{name}-{group}`
		if ignoreBuffTags[buffTag] then
			return
		end
		ignoreBuffTags[buffTag] = true
		task.defer(function()
			task.wait()
			ignoreBuffTags[buffTag] = nil
		end)
	end
	local sortedBuffs = {} :: {Buff}
	for _, buff in allBuffs do
		if player ~= nil and buff.player ~= player then
			continue
		end
		if group ~= nil and buff.group ~= group then --and buff.group ~= "All" then
			continue
		end
		table.insert(sortedBuffs, buff)
	end
	table.sort(sortedBuffs, function(buffA: Buff, buffB: Buff)
		local priorityBuffA = buffA.priority
		local priorityBuffB = buffB.priority
		if priorityBuffA ~= priorityBuffB then
			-- Sort buffs with higher priority first
			return priorityBuffA > priorityBuffB
		end
		-- Sort buffs added later first
		return buffA.timeAdded > buffB.timeAdded
	end)
	-- We call top buffs last so that they override lower priority buffs
	local totalToCall = #sortedBuffs
	local originalValue = nil
	for index = totalToCall, 1, -1 do
		local buff = sortedBuffs[index]
		local thisOriginalValue = buff.originalValue
		if thisOriginalValue then
			originalValue = thisOriginalValue
			break
		end
	end
	for index = totalToCall, 1, -1 do
		local buff = sortedBuffs[index]
		local hasEnded = false
		local isTop = index == 1
		local newOriginalValue = self:callBuff(buff, hasEnded, originalValue, isTop)
		if originalValue == nil and newOriginalValue ~= nil then
			originalValue = newOriginalValue
		end
	end
end

function Task.callBuff(self: Task, buff: Buff, hasEnded: boolean, forcedOriginalValue: any?, isTop: boolean)
	if forcedOriginalValue ~= nil then
		buff.originalValue = forcedOriginalValue
	end
	local originalValue = buff.originalValue
	local success, incomingOriginalValue = xpcall(buff.callback, function(errorMessage)
		local traceback = debug.traceback("", 2)
		warn(ERROR_START..tostring(errorMessage), traceback)
	end, hasEnded, originalValue, isTop)
	if success and originalValue == nil then
		originalValue = incomingOriginalValue
		buff.originalValue = originalValue
	end
	return originalValue
end

-- Turns a name, an inline declaration or a position into the position that arg occupies in
-- the command's arg list. Values are stored against the position, so two args built on the
-- same base (like music's volume and speed, both Numbers) never share a slot
function Task.getArgIndex(self: Task, argNameOrIndex: any): number?
	local index = tonumber(argNameOrIndex)
	if index then
		return if self.commandArgNames[index] ~= nil then index else nil
	end
	local isDeclaration = typeof(argNameOrIndex) == "table"
	local wantedKey = if isDeclaration then nil else tostring(argNameOrIndex):lower()
	for entryIndex, entry in self.commandArgNames do
		if isDeclaration then
			if entry == argNameOrIndex then
				return entryIndex
			end
			continue
		end
		local argItem = Args.get(entry)
		local entryKey = argItem and argItem.key
		if entryKey and tostring(entryKey):lower() == wantedKey then
			return entryIndex
		end
	end
	return nil
end

-- Finds the arg this command declared at that position or under that name. A command can
-- override an arg for itself, so the detail here can differ from the registered one, and
-- looking it up on the command is the only way to see the override
function Task.getArgDetail(self: Task, argNameOrIndex: any): any
	local index = self:getArgIndex(argNameOrIndex)
	if index then
		return Args.get(self.commandArgNames[index])
	end
	-- Controls can bind to a registered arg the command never declared, so we still
	-- fall back to the global registry
	return Args.get(argNameOrIndex)
end


-- PUBLIC METHODS
function Task.buff(self: Task, player: BuffPlayer, group: BuffGroup, priorityOrCallback: number | BuffCallback, callback: BuffCallback?)
	-- A buff is simply a collection of callbacks that are re-run in-order every time another buff
	-- of its group is applied or removed. This is useful for things like WalkSpeed, Health, etc
	-- where you want these effects to 'stack', instead of being reset the first time a command ends
	-- This applies the buff accross all tasks of buffGroup
	-- Buffs are re-applied when:
	-- 1. A new buff of the same player+group is added
	-- 2. An existing buff of the same player+group is destroyed
	-- 3. When the player respawns (if player is a Player instance)

	-- The priority does not have to be specified in which case it defaults to 1
	-- This also enables shorthand instead of passing nil as the third argument
	local priority = priorityOrCallback
	if typeof(priorityOrCallback) == "function" then
		callback = priorityOrCallback
		priority = 1
	end

	-- Construct the buff
	-- It's important we provide a destroy method so that it can be manually removed
	-- If not manually, it will be removed when the task is destroyed
	local function destroyBuffCallback(buff: Buff)
		if buff.isActive == false then
			return
		end
		for index, buffToCheck in allBuffs do
			if buffToCheck == buff then
				table.remove(allBuffs, index)
				break
			end
		end
		local hasEnded = true
		local originalValue = nil
		local isTop = false
		buff.isActive = false
		self:callBuff(buff, hasEnded, originalValue, isTop)
		task.defer(function()
			-- We defer to give time for other identical buffs to remove themselves
			-- (such as when all tasks are cleaned up at the same time) so that only
			-- remaining buffs are processed and applied
			self:updateBuffs(player, group, true)
		end)
	end
	local buff: Buff = {
		player = player,
		group = group,
		priority = priority :: number,
		callback = callback :: BuffCallback,
		timeAdded = os.clock(),
		taskUID = self.UID,
		originalValue = nil,
		isActive = true,
		destroy = destroyBuffCallback,
		Destroy = destroyBuffCallback,
	}

	-- Player can be any player, or 'false' for server-wide buffs
	-- Typically the player argument will be the 'player' or 'caller'
	-- Its important we check that player ~= nil, as it can sometimes
	-- be nil (for example, the caller will be nil for global commands)
	-- If nil, then don't activate buff
	if player ~= "Server" and not (typeof(player) == "Instance" and player:IsA("Player")) then
		return buff
	end

	-- Re-apply the buff when the player respawns
	if typeof(player) == "Instance" and player:IsA("Player") then
		self.janitor:add(player.CharacterAdded:Connect(function(char)
			local humanoid = char:WaitForChild("Humanoid", 5)
			local hrp = char:WaitForChild("HumanoidRootPart", 5)
			task.defer(function()
				if not hrp or not hrp.Parent or not humanoid or not humanoid.Parent then
					return
				end
				if not self.isActive then
					return
				end
				self:updateBuffs(player, group, true)
			end)
		end))
	end

	-- Now register and update all relevant buffs
	self.janitor:add(buff)
	table.insert(allBuffs, buff)
	self:updateBuffs(player, group)

	return buff
end

function Task.redo(self: Task, player: Player?, callback: () -> ())
	-- "callback" is called 1. right away, and 2. every time the player respawns
	-- (assuming the task is still active). This is useful for behaviours that you
	-- want to re-apply past death. For example when controlling another player,
	-- it's desirable to re-apply control when the target respawns
	--self:onEnded(function()
		--callback(true)
	--end)
	if typeof(player) == "Instance" and player:IsA("Player") then
		self.janitor:add(player.CharacterAdded:Connect(function(char)
			-- Yes it looks odd, but is actually necessary to
			-- overcome some weird quirks where humanoid's don't
			-- set properties correctly until after a few frames of
			-- being loaded. For example, this behvaviour can be seen
			-- in the 'spawn' modifier for tasks like ;spawnKill me
			char:WaitForChild("Humanoid", 5)
			char:WaitForChild("HumanoidRootPart", 5)
			for index = 1, 5 do
				task.wait()
			end
			local humanoid = char:FindFirstChild("Humanoid")
			local hrp = char:FindFirstChild("HumanoidRootPart")
			if not hrp or not hrp.Parent or not humanoid or not humanoid.Parent then
				return
			end
			if not self.isActive then
				return
			end
			callback()
		end))
	end
	self.spawn(function()
		callback()
	end)
end

function Task.keep(self: Task, persistence: Persistence?, forceKeep: boolean?)
	-- Typically when a command finishes running the task is destroyed
	-- This method allows you to keep the task alive based on certain conditions
	-- For example, you may want a task which modifies walkspeed to only stay until
	-- the player respawns - this is achieved with persistence "UntilTargetRespawns"
	-- Persistence's can 'combine' - for example, if you call keep("UntilTargetLeaves")
	-- followed by keep("UntilCallerLeaves"), the task will be destroyed when either
	-- the player or caller leaves

	local persistenceKey = if typeof(persistence) == "string" then persistence else "Indefinitely"
	if self.keptPersistences[persistenceKey] then
		return
	end
	self.keptPersistences[persistenceKey] = true

	-- If 'forceKeep' is true, then the task is kept regardless of other persistence's ending
	if forceKeep then
		self.forceKeepHolds += 1
	end

	-- If persistence is not specified or "Indefinitely", we simply keep the task alive
	-- until it is manually ended
	self:registerHold()
	if typeof(persistence) ~= "string" or persistence == "Indefinitely" then
		return
	end

	-- End a hold
	local function endPersistence()
		if forceKeep then
			self.forceKeepHolds -= 1
		end
		local willDestroy = self.forceKeepHolds <= 0
		if willDestroy then
			self:destroy()
		end
	end

	-- This works out the player to track
	local trackingPlayer: Player? = nil
	local isCaller = persistence:match("Caller")
	if persistence:match("Target") then
		trackingPlayer = self.target
	elseif isCaller then
		trackingPlayer = self.caller
	end
	if not trackingPlayer then
		return
	end

	-- This determines the action to track
	local action = persistence:match("([A-Z][a-z]+)$")
	if not action then
		return
	end

	-- If the original source task contains a Caller persistence (like end after caller leaving),
	-- then it's important we also fire to all other servers to make sure the task ends there too
	local originalCaller = self.caller
	if isCaller and originalCaller then
		self:onEnded(function()
			if not originalCaller:GetAttribute("HDCallerHasInformedOthers") then
				originalCaller:SetAttribute("HDCallerHasInformedOthers", true)
				--main.services.JobService.callerLeftSender:fireOtherServers(userId)
			end
		end)
	end

	-- We end the task here when the action occurs
	-- We stack the actions in this case, because for example a player leaving will also 
	-- count as as them 'dying' or 'respawning', and a player respawning, will also count
	-- as them 'dying'
	local isDies = action == "Dies"
	local isRespawns = action == "Respawns"
	local humanoid = getHumanoid(trackingPlayer)
	if isDies or isRespawns then
		if humanoid then
			if isDies and humanoid.Health <= 0 then
				endPersistence()
			elseif self.lifecycleJanitor.add then
				self.lifecycleJanitor:add(humanoid.Died:Connect(function()
					if isRespawns then
						-- This is more desirable than characterAdded, because it ends
						-- the task before the character is added again, meaning the
						-- 'hasEnded' behaviour doesn't impact the new character
						local respawnTime = Players.RespawnTime-0.01
						task.wait(respawnTime)
					end
					endPersistence()
				end))
			end
		end
	end
	if isRespawns or isDies then
		local loadCharacterStarted = require(modules.PlayerUtil.loadCharacterStarted)
		self.lifecycleJanitor:add(loadCharacterStarted:Connect(function(incomingPlayer)
			if incomingPlayer == trackingPlayer then
				endPersistence()
			end
		end))
		self.lifecycleJanitor:add(trackingPlayer.CharacterAdded:Connect(function(char)
			endPersistence()
		end))
	end
	local isLeaves = action == "Leaves"
	if isLeaves or isRespawns or isDies then
		self.lifecycleJanitor:add(trackingPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
			if not trackingPlayer or not trackingPlayer.Parent then
				endPersistence()
			end
		end))
	end
end

-- Reads a command arg's current value. It starts as the parsed value (or the default the
-- command declared for it) and updates when a prompt slider changes it via setArg. A
-- command only needs this for an arg it re-reads later, otherwise args holds the same value.
-- Pass true as the second argument to get nil back when the caller never typed the arg
-- and the value only came from the arg's registered default
function Task.getArg(self: Task, argNameOrIndex: any, ignoreDefault: boolean?)
	local index = self:getArgIndex(argNameOrIndex)
	if not index then
		return nil
	end
	if ignoreDefault and self.defaultedArgIndexes[index] then
		return nil
	end
	return self.originalArgReturnValues[index]
end

-- Force-sets a command arg's value and returns it. The prompt calls this when a slider
-- changes, so a re-run reads the adjusted value through getArg instead of the original
function Task.setArg(self: Task, argNameOrIndex: any, value: any): any
	local argIndex = self:getArgIndex(argNameOrIndex)
	if not argIndex then
		return value
	end
	self.originalArgReturnValues[argIndex] = value
	self.defaultedArgIndexes[argIndex] = nil
	-- Entry backed tasks persist the change so every server and future replays pick
	-- it up. Remote applications carry the flag so they can't write straight back
	local extraAny = self.extra :: any
	if isServer and extraAny.entryUID then
		if not extraAny.applyingRemoteArg then
			local PermTasks = require(modules.Parent.Services.Tasks.PermTasks) :: any
			PermTasks.updateEntryArg(extraAny.entryUID, argIndex, value)
		end
	end
	return value
end

function Task.bindPrompt(self: Task, config: any)
	local Action = require(modules.Prompt.Action)
	-- We keep the config so the caller can retrieve the card later from the Tasks
	-- page, even on a server where it never bound because they weren't present
	self.extra.lastPromptConfig = config
	-- Already bound, so we update the existing card in place so
	-- dynamic data (like a re-randomised /dance emote) stays in sync,
	-- rather than keeping the stale original card
	if self.actionPromptId then
		Action.update(self, config)
		return
	end
	-- Replayed, broadcast and join rerun tasks keep the card quiet so a rejoining
	-- caller isn't spammed on every server. Edit Command pulls it up on demand
	if self.extra.suppressAutoPrompt then
		return
	end
	local handle = Action.bind(self, config)
	-- We tear the card down only when the task is truly destroyed
	self.lifecycleJanitor:add(handle)
	return handle
end

-- We fire EndClientTask to every player running a client-side piece of this task,
-- so their client effect (fly loop, etc) stops
function Task.endClientTasks(self: Task, isDeactivate: boolean?)
	if not isServer then
		return
	end
	if not endClientTask then
		endClientTask = Remote.new("EndClientTask", "Event")
	end
	for plrName, _ in self.activeClientTasks do
		local player = Players:FindFirstChild(plrName :: string)
		if player and endClientTask and player:IsA("Player") then
			endClientTask:fireClient(player, self.UID, isDeactivate == true)
		end
		self.activeClientTasks[plrName] = nil
	end
end

function Task.deactivate(self: Task)
	if self.deactivated or not self.isActive then
		return
	end
	self.deactivated = true
	self:endClientTasks(true)
	self.janitor:cleanup()
end

function Task.reactivate(self: Task)
	if not self.deactivated or not self.isActive then
		return
	end
	self.deactivated = false
	if self.rerunCommand then
		self.rerunCommand()
	end
end

function Task.createSound(self: Task, soundType: registerSound.SoundType?)
	-- It's essential that all command sound's are created via task:createSound so
	-- that they can be properly registered, so that client's can modify their
	-- properties (volume, etc) within settings
	if not soundType then
		soundType = "Command"
	end
	local registerSound = require(modules.AssetUtil.registerSound)
	local sound = Instance.new("Sound")
	registerSound(sound, soundType)
	return sound
end

function Task.tween(self: Task, instance: Instance, tweenInfo: TweenInfo, propertyTable: {[any]: any})
	local TweenService = game:GetService("TweenService")
	local tween = TweenService:Create(instance, tweenInfo, propertyTable) :: Tween
	if not self.isActive then
		tween:Destroy()
		return tween
	end
	self.activeTweens[tween] = true
	if self.isPaused then
		tween:Pause()
	end
	local hasCleaned = false
	local function cleanup()
		if not hasCleaned then
			hasCleaned = true
			tween:Cancel()
			tween:Destroy()
			self.activeTweens[tween] = nil
		end
	end
	self.janitor:add(tween.Completed:Once(cleanup))
	self.janitor:add(cleanup)
	tween:Play()
	return tween
end

function Task.onEnded(self: Task, callback: () -> ())
	if self.isActive then
		self.janitor:add(callback)
	end
end

function Task.onEndedForGood(self: Task, callback: () -> ())
	-- This is when the task dies AND if no other identical is applied right after,
	-- so there's a chance that the callback won't run at all
	-- This is useful for commands like ;serverLock and ;chatTag which want to display
	-- a notice when the command finishes EXCEPT when the command is immediately re-applied
	-- after, which stops an "Ended" then "Started" spam
	local target = self.target
	local targetUserId = target and target.UserId
	local commandKey = self.commandKey
	self:onEnded(function()
		task.delay(0.1, function()
			if commandKey then
				-- Only a genuinely active replacement holds the callback back. Our own
				-- destroyed task can still sit in the registry while its cooldown runs
				for _, matchingTask in Task.getTasks(commandKey, targetUserId) do
					if matchingTask.isActive then
						return
					end
				end
			end
			callback()
		end)
	end)
end

function Task.destroy(self: Task)
	if self.isActive == false then
		return
	end
	if isServer then
		Task.updated:Fire("removed", self)
		self:endClientTasks()
	end
	local function unregisterTask()
		tasks[self.UID] = nil
	end
	if self.cooldown > 0 and not self.hasCompletedCooldown then
		self.cooldownEndTime = os.clock() + self.cooldown
		task.delay(self.cooldown, function()
			self.hasCompletedCooldown = true
			unregisterTask()
		end)
	else
		unregisterTask()
	end
	self.holdsToResume = {}
	self.isActive = false
	self.janitor:destroy()
	self.lifecycleJanitor:destroy()
end


-- TYPES
export type TargetType = getTargets.TargetType

export type TriStateSetting = "Default" | "True" | "False"

export type Persistence =
	--"UntilTargetDies" | -- Waits until the player dies or leaves before ending the task
	"UntilTargetRespawns" | -- Waits until the player respawns or leaves before ending the task
	"UntilTargetLeaves" | -- Waits until the player leaves before ending the task
	--"UntilCallerDies" | -- Waits until the caller dies or leaves before ending the task
	"UntilCallerRespawns" | -- Waits until the caller respawns or leaves before ending the task
	"UntilCallerLeaves" | -- Waits until the caller (the person who ran the command) leaves before ending the task
	"Indefinitely" -- The task is only ended when :destroy is manually called (via ;unCommandName), or when its associated player leaves

export type BuffPlayer = Player? | "Server"

export type BuffGroup = string -- "All" | "Player" | "Camera" | "Character" | "Humanoid" | "Outfit" | "Server" | "Map" | "Other"

export type BuffCallback = (hasEnded: boolean, originalValue: any?, isTop: boolean) -> (...any)

export type Buff = {
	player: BuffPlayer,
	group: BuffGroup,
	priority: number,
	callback: BuffCallback,
	timeAdded: number,
	taskUID: string,
	originalValue: any?,
	isActive: boolean,
	destroy: (buff: Buff) -> (),
}

export type Properties = {
	UID: string?,
	callerUserId: number | string, -- Can be a string for non-player callers such as the "Server User"
	targetUserId: number?,
	commandKey: string,
	args: {[string]: {string}}?,
	modifiers: {[string]: {string}}?,
	qualifiers: {[string]: {string}}?,
	isRestricted: boolean?,
	isSubjob: boolean?, -- per player split of a targetless run, hidden from the Tasks feed
	clientArgs: {any}?,
}

export type Command = {
	name: string,
	key: string?, -- this is the key used to identify the command (typically name:lower()). THIS should be used to retrieve commands, not the name, because the key can sometimes be completely different to the name for overrrides
	tags: {string}?,
	order: number?, -- lower numbers appear first in the command list
	aliases: {string}?,
	undoAliases: {string}?, -- aliases that undo the command - "ice" might have "thaw"
	description: string?,
	config: {string: any}?,
	groups: {string}?, -- all commands in the same group are *undone* when another is run
	cooldown: number?, -- if > 0, the command cannot be run again until finished and its cooldown expired
	stackable: boolean?, -- if true, multiple instances of the command can be run at once by the same caller/target
	autoPreview: boolean?, -- if true, the command is viewed first in UI (useful for ban command)
	credit: {string}?,
	args: {Args.Argument | Args.ArgumentDetail},
	run: ((Class) -> () | any)?,
	prefix: string?, -- custom display prefix, useful for overrides
	index: number?, -- this is the actual layoutOrder value (lower value should appear higher)
	hide: boolean?, -- if true, the command is hidden from the Commands page
	disableModifiers: boolean?, -- if true, any modifiers in the parsed call are silently stripped and the Modifiers picker is hidden from the Run page UI
	disableGlobalModifiers: boolean?, -- if true, the global, perm and join modifiers are rejected for this command
	groupExclusive: boolean?, -- on top of normal permission, the caller must be in the HD Admin group
}

export type Commands = {Command}

export type ClientCommand = {
	--[string]: any,
	name: string,
	run: ((Class, ...any) -> () | any)?,
	replication: ((...any) -> () | any)?,
}

export type ClientCommands = {ClientCommand}

type TaskFunctions = {
    new: (Properties) -> Class,
    getTask: (string?) -> Task?,
    getTasks: (string?, number?) -> {Task},
	getTasksByCallerId: (number) -> {Task},
	getSelfRunTasks: (number) -> {Task},
	updated: Signal.Signal<string, Task>,
}

type TaskMethods = {
    spawn: (callback: () -> ()) -> any,
    defer: (callback: () -> ()) -> any,
    delay: (delayTime: number, callback: () -> ()) -> any,
    wait: (yieldTime: number?) -> any,
    iterate: (iterations: number, callback: (i: number) -> ()) -> any,
    loop: (callback: (stop: () -> (), i: number) -> ()) -> any,
    pause: (self: Class) -> any,
    resume: (self: Class) -> any,
	buff: (self: Class, player: BuffPlayer, buffGroup: BuffGroup, priorityOrCallback: number | BuffCallback, callback: BuffCallback?) -> any,
	updateBuffs: (self: Class, player: BuffPlayer?, group: BuffGroup?, ignoreOtherRequests: boolean?) -> any,
    keep: (self: Class, persistence: Persistence) -> any,
	redo: (self: Class, player: Player?, callback: () -> ()) -> any,
	tween: (self: Class, instance: Instance, tweenInfo: TweenInfo, propertyTable: {[any]: any}) -> Tween,
    getArg: (self: Class, argNameOrIndex: string | number) -> any,
	getArgDetail: (self: Class, argNameOrIndex: string | number) -> any,
	getArgIndex: (self: Class, argNameOrIndex: string | number) -> number?,
	setArg: (self: Class, argNameOrIndex: string | number, value: any) -> any,
	bindPrompt: (self: Class, config: any) -> any,
	deactivate: (self: Class) -> any,
	reactivate: (self: Class) -> any,
	endClientTasks: (self: Class, isDeactivate: boolean?) -> any,
    onEnded: (self: Class, callback: () -> ()) -> any,
	onEndedForGood: (self: Class, callback: () -> ()) -> any,
    destroy: (self: Class) -> any,
	createSound: (self: Class, soundType: registerSound.SoundType?) -> Sound,
}

type TaskProperties = {
	janitor: typeof(Janitor.new()),
	lifecycleJanitor: typeof(Janitor.new()),
	keptPersistences: {[string]: boolean},
	deactivated: boolean,
	actionPromptId: string?,
	rerunCommand: (() -> ())?,
	UID: string,
	isActive: boolean,
	caller: Player?,
	callerUserId: number | string,
	target: Player,
	qualifiers: {[string]: {string}},
	client: TaskClient.Class,
	server: TaskServer.Class,
	extra: {[string]: any},
	config: {[string]: any},
	commandKey: string,
	startedAt: number,
	isReplay: boolean,
	isSubjob: boolean,
	hasStartedInitialRun: boolean,
}

export type Class = TaskMethods & TaskProperties

export type Task = typeof(Task.construct(...))


return Task :: TaskFunctions
