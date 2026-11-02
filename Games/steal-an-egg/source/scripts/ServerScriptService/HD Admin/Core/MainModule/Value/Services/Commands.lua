--!strict
-- CONFIG
local MAXIMUM_REQUEST_PER_SECOND = 20

local CLIENT_PROPERTIES_TO_EXCLUDE = {
	"run",
	"creationOrder",
	"order",
	"loadedFired",
	"sourceModule",
}

local BYPASS_PREVIEW_SOURCES: {[string]: boolean} = {
	ClientPreviewRun = true,
	ClientCommand = true,
	API = true,
}

local CLIENT_PROPERTIES_TO_PREVIEW = {
	"name",
	"key",
	"identity",
	"prefix",
	"hide",
	"tags",
	"args",
	"primaryRole",
	"roles",
	"directRoles",
	"fromInternal",
}


-- LOCAL
local Commands = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local parser = modules.Parser
local Signal = require(modules.Objects.Signal)
local User = require(modules.Objects.User)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local ParserTypes = require(parser.ParserTypes)
local Config = require(modules.Parent.Services.Config)
local Task = require(modules.Objects.Task)
local commandsArray: Task.Commands = {}
local keyToCommand: {[string]: Command} = {}
local identityToCommand: {[string]: Command} = {}
local lowerCaseNameAndAliasCommandsDictionary: {[string]: Command} = {}
local sortedNameAndAliasWithOverrideLengthArray: {string} = {}
local commandsRequireUpdating = true
local commandPrefixes: {[string]: boolean} = {}
local serverUser: User.Class? = nil
local sharedTypes = require(modules.References.sharedTypes)
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local GroupService = game:GetService("GroupService")
local HD_ADMIN_GROUP_ID = 4676369
Commands.executed = Signal.new()


-- TYPES
export type MessageSource = sharedTypes.MessageSource
export type RequestInfo = {
	messageSource: MessageSource?,
	preferredUnlockRole: string?,
}
type User = User.Class
type Batch = ParserTypes.ParsedBatch
type Statement = ParserTypes.ParsedStatement
type ArgGroup = {[string]: {string}}
type Task = Task.Class
type Command = Task.Command
type ClientCommand = Task.ClientCommand
type TriStateSetting = Task.TriStateSetting
type Properties = Task.Properties


-- LOCAL FUNCTIONS
local function assignCommandRoles()
	local roleInfo = User.everyone:get("RoleInfo")
	if typeof(roleInfo) ~= "table" then
		return
	end
	local rolesByRank: {{key: string, role: any}} = {}
	for roleKey, role in roleInfo :: any do
		if typeof(role) == "table" then
			table.insert(rolesByRank, { key = roleKey, role = role })
		end
	end
	table.sort(rolesByRank, function(entryA: any, entryB: any)
		local rankA = (entryA.role :: any).rank or 0
		local rankB = (entryB.role :: any).rank or 0
		if rankA ~= rankB then return rankA < rankB end
		return entryA.key < entryB.key
	end)
	local tagSetByRole: {[string]: {[string]: true}} = {}
	for _, entry in rolesByRank do
		local set: {[string]: true} = {}
		local tags = (entry.role :: any).inheritCommandsWithTags
		if typeof(tags) == "table" then
			for _, tag in tags :: {any} do
				if typeof(tag) == "string" then set[tag] = true end
			end
		end
		tagSetByRole[entry.key] = set
	end
	local nameGrantsByRole: {[string]: {[string]: true}} = {}
	for _, entry in rolesByRank do
		local grantSet: {[string]: true} = {}
		local names = (entry.role :: any).inheritCommandsWithNames
		if typeof(names) == "table" then
			for _, nameEntry in names :: {any} do
				if typeof(nameEntry) == "string" then grantSet[string.lower(nameEntry)] = true end
			end
		end
		nameGrantsByRole[entry.key] = grantSet
	end
	for _, command in commandsArray do
		local cmdTags = (command :: any).tags
		local primaryRole: string? = nil
		local rolesForCommand: {string} = {}
		local directMatchKeys: {[string]: true} = {}
		if typeof(cmdTags) == "table" then
			-- First pass does the direct tag matches, rank-ascending so primaryRole is lowest
			for _, entry in rolesByRank do
				local set = tagSetByRole[entry.key]
				local matched = false
				for _, tag in cmdTags :: {any} do
					if typeof(tag) == "string" and set[tag] then
						matched = true
						break
					end
				end
				if matched then
					directMatchKeys[entry.key] = true
					if primaryRole == nil then
						primaryRole = entry.key
					end
				end
			end
			for _, entry in rolesByRank do
				local role = entry.role :: any
				local directlyMatches = directMatchKeys[entry.key] == true
				local inheritsViaJuniors = false
				if role.inheritCommandsFromJuniorRoles == true then
					local myRank = role.rank or 0
					for _, other in rolesByRank do
						if isInternalRole(other.role) then continue end
						if directMatchKeys[other.key] and ((other.role :: any).rank or 0) < myRank then
							inheritsViaJuniors = true
							break
						end
					end
				end
				if directlyMatches or inheritsViaJuniors then
					table.insert(rolesForCommand, entry.key)
				end
			end
		end
		local commandIdentity = (command :: any).identity or command.key
		local nameGrantSet: {[string]: true} = {}
		for _, entry in rolesByRank do
			local grants = nameGrantsByRole[entry.key]
			if grants and (grants[commandIdentity] or grants[command.key]) then
				nameGrantSet[entry.key] = true
				if not table.find(rolesForCommand, entry.key) then
					table.insert(rolesForCommand, entry.key)
				end
				if primaryRole == nil then
					primaryRole = entry.key
				end
			end
		end
		local directRoles: {string} = {}
		for _, entry in rolesByRank do
			if directMatchKeys[entry.key] or nameGrantSet[entry.key] then
				table.insert(directRoles, entry.key)
			end
		end
		;(command :: any).primaryRole = primaryRole
		;(command :: any).roles = rolesForCommand
		;(command :: any).directRoles = directRoles
	end
end

local function publishUnresolvedGrants(ledger: any)
	local roleInfoForGrants = User.everyone:get("RoleInfo")
	local unresolved: {{key: string, state: string, roleKey: string}} = {}
	if typeof(roleInfoForGrants) == "table" then
		for roleKey, role in roleInfoForGrants :: any do
			local names = (role :: any).inheritCommandsWithNames
			if typeof(names) ~= "table" then continue end
			for _, nameEntry in names :: {any} do
				if typeof(nameEntry) ~= "string" then continue end
				local nameLower = string.lower(nameEntry)
				if identityToCommand[nameLower] or lowerCaseNameAndAliasCommandsDictionary[nameLower] then continue end
				local state = if ledger[nameLower] then "excluded" else "unknown"
				table.insert(unresolved, {key = nameEntry, state = state, roleKey = roleKey})
			end
		end
	end
	User.everyone:set("UnresolvedCommandGrants", unresolved)
end


-- FUNCTIONS
function Commands.updateCommands(forceUpdate: boolean?)
	if not commandsRequireUpdating and not forceUpdate then
		return false
	end
	commandsRequireUpdating = false
	-- We fill in the full role set before working out each command's primaryRole/roles. If we
	-- don't, RoleInfo is empty and no command gets a role
	local Roles = require(modules.Parent.Services.Roles)
	Roles.updateRoles()
	commandsArray = {}
	keyToCommand = {}
	identityToCommand = {}
	lowerCaseNameAndAliasCommandsDictionary = {}
	sortedNameAndAliasWithOverrideLengthArray = {}
	commandPrefixes = {}
	local forEveryCommand = require(modules.CommandUtil.forEveryCommand)
	local InternalModule = require(modules.Internal) :: any
	local creationOrder = 0
	local seenCommandTables: {[any]: boolean} = {}
	local function getChildren(parentContainer: Instance)
		local children = parentContainer:GetChildren()
		table.sort(children, function(childA: Instance, childB: Instance)
			return childA.Name < childB.Name
		end)
		for _, commandModule in children do
			if commandModule:IsA("Folder") then
				getChildren(commandModule)
				continue
			end
			if not commandModule:IsA("ModuleScript") then
				continue
			end
			-- One bad module (like a broken Custom command) must never
			-- take down the whole catalog
			local requireOk, commandsInside = pcall(require, commandModule)
			if not requireOk then
				warn(`HD Admin: command module '{commandModule:GetFullName()}' failed to load: {commandsInside}`)
				continue
			end
			forEveryCommand(commandsInside, function(command: any)
				local prefixes = command.prefixes
				local commandName = command.name
				if typeof(commandName) ~= "string" then
					return
				end
				-- Packs can reference the same module to layer tags and
				-- modify, so the shared table only registers once
				if seenCommandTables[command] then
					return
				end
				seenCommandTables[command] = true

				if typeof((command :: any).fullName) ~= "string" then
					(command :: any).fullName = commandName
				end
				commandName = (command :: any).fullName

				-- If command contains a custom prefix
				local commandNameLower = commandName:lower()
				if typeof(prefixes) == "table" then
					for _, prefix in prefixes do
						if typeof(prefix) == "string" then
							commandPrefixes[prefix] = true
						end
					end
				end
				creationOrder += 1
				command.creationOrder = creationOrder
				command.name = commandName
				command.key = commandNameLower
				table.insert(commandsArray, command :: Command)
				keyToCommand[commandNameLower] = command
				local identity = InternalModule.getIdentity(command)
				if identityToCommand[identity] and identityToCommand[identity] ~= command then
					warn(`HD Admin: duplicate command identity '{identity}' ({command.name})`)
				end
				identityToCommand[identity] = command
				command.identity = identity
				local function registerNameOrAlias(nameOrAlias: string?, isOverride: boolean?)
					if typeof(nameOrAlias) ~= "string" then
						return false
					end
					local writeTo = lowerCaseNameAndAliasCommandsDictionary
					local nameOrAliasLower = nameOrAlias:lower()
					local firstTime = writeTo[nameOrAliasLower] == nil
					if not isOverride then
						writeTo[nameOrAliasLower] = command
					end
					if firstTime then
						table.insert(sortedNameAndAliasWithOverrideLengthArray, nameOrAliasLower)
					end
					return true
				end
				registerNameOrAlias(commandName)
				local function registerAliases(array, isOverride)
					if typeof(array) == "table" then
						for _, alias in array do
							if isOverride then
								local overrideAlias = string.sub(alias, 2)
								alias = overrideAlias
							end
							registerNameOrAlias(alias, isOverride)
						end
					end
				end
				registerAliases(command.aliases)
				registerAliases(command.undoAliases)
				-- If the command is an override (its name contains a validPrefix, like /helicopter)
				local firstChar = string.sub(commandName, 1, 1)
				local isValidPrefix = require(modules.CommandUtil.isValidPrefix)
				if isValidPrefix(firstChar) then
					local overrideName = string.sub(commandName, 2)
					commandPrefixes[firstChar] = true
					command.prefix = firstChar
					command.name = overrideName
					registerNameOrAlias(overrideName, true) -- Also register override so that it can be detected in parser
					registerAliases(command.aliases, true) -- Same as line above, register for parser
				end
			end)
		end
	end
	getChildren(script)
	table.sort(sortedNameAndAliasWithOverrideLengthArray, function(nameA: string, nameB: string): boolean
		if #nameA == #nameB then
			return nameA < nameB
		end
		return #nameA > #nameB
	end)
	table.sort(commandsArray, function(commandA: any, commandB: any)
		local orderA = commandA.order or 0
		local orderB = commandB.order or 0
		if orderA == orderB then
			local internalOrderA = commandA.creationOrder or 0
			local internalOrderB = commandB.creationOrder or 0
			return internalOrderA < internalOrderB
		end
		return orderA < orderB
	end)
	for index, command in commandsArray do
		command.index = index
	end
	assignCommandRoles()
	publishUnresolvedGrants(InternalModule.getExcludedLedger())
	User.everyone:set("Commands", commandsArray)
	User.everyone:set("CommandInfo", keyToCommand)
	User.everyone:set("BoosterDisplay", require(modules.CommandUtil.boosterDisplay).getAll())
	local tagCounts: {[string]: number} = {}
	for _, command in commandsArray do
		local tags = command.tags
		if typeof(tags) == "table" then
			for _, tag in tags :: {any} do
				if typeof(tag) == "string" then
					tagCounts[tag] = (tagCounts[tag] or 0) + 1
				end
			end
		end
	end
	local commandTags: {{Tag: string, TotalCommands: number}} = {}
	for tag, count in tagCounts do
		table.insert(commandTags, { Tag = tag, TotalCommands = count })
	end
	local tagPriority: {[string]: number} = InternalModule.getTagOrders()
	table.sort(commandTags, function(entryA: any, entryB: any)
		local priorityA, priorityB = tagPriority[entryA.Tag], tagPriority[entryB.Tag]
		if priorityA and priorityB then return priorityA < priorityB end
		if priorityA ~= nil or priorityB ~= nil then return priorityA ~= nil end
		return entryA.Tag < entryB.Tag
	end)
	User.everyone:set("CommandTags", commandTags)
	return true
end

function Commands.getCommandByIdentity(identity: string): Command?
	Commands.updateCommands()
	return identityToCommand[string.lower(identity)]
end

function Commands.getCommand(keyOrNameOrAlias: string, overridePrefix: string?): (Command?, boolean?)
	Commands.updateCommands()
	local lowerNameOrAlias = keyOrNameOrAlias:lower()
	local command = lowerCaseNameAndAliasCommandsDictionary[lowerNameOrAlias] :: Command?
	if not command and typeof(overridePrefix) == "string" and #overridePrefix == 1 then
		local newAlias = overridePrefix..lowerNameOrAlias
		command = lowerCaseNameAndAliasCommandsDictionary[newAlias] :: Command?
		return command, true
	end
	return command, false
end

function Commands.getCommandsArray()
	Commands.updateCommands()
	return commandsArray
end

function Commands.getSortedNameAndAliasLengthArray()
	Commands.updateCommands()
	return sortedNameAndAliasWithOverrideLengthArray
end

function Commands.getCommandPrefixes()
	Commands.updateCommands()
	return commandPrefixes
end

function Commands.request(user: User.Class, message: string, info: RequestInfo?): (boolean, {any}, {Task})
	-- It's essential that in addition to checking the maximum commands a player can use, that
	-- we also check the maximum requests they are making too, so to avoid malicious spamming
	-- of messages which could overwhelm the parser (like 100,000 characters every milisecond)
	-- If detected, we simply ignore the message from that user
	local requestInfo: RequestInfo = info or {}
	if not requestInfo.messageSource then
		requestInfo.messageSource = "Unknown" :: MessageSource
	end
	local getDataSize = require(modules.VerifyUtil.getDataSize)
	local Roles = require(modules.Parent.Services.Roles) :: any
	local bypassLimits = Roles.hasPermission(user, "permitBypassLimits")
	local maxRequestSize = Config.getSetting("RequestSizeLimit")
	local requestsPerSecondLimit = Roles.getHighestValue(user, "limitRequestsPerSecond")
	local maxRequestsPerSecond = if bypassLimits then MAXIMUM_REQUEST_PER_SECOND else math.min(requestsPerSecondLimit, MAXIMUM_REQUEST_PER_SECOND)
	local messageSize = getDataSize(message)
	if not bypassLimits and messageSize > maxRequestSize then
		return false, {{false, `Request exceeded max size of {maxRequestSize} characters!`}}, {}
	end
	local requestsThisSecond = user.temp:get("RequestsThisSecond")
	local requestsThisSecondStartClock = user.temp:get("RequestsThisSecondStartClock")
	local clockNow = os.clock()
	if clockNow - requestsThisSecondStartClock >= 1 then
		requestsThisSecond = 0
		requestsThisSecondStartClock = clockNow
		user.temp:set("RequestsThisSecond", requestsThisSecond)
		user.temp:set("RequestsThisSecondStartClock", requestsThisSecondStartClock)
	end
	local newRequestsThisSecond = requestsThisSecond + 1
	if not bypassLimits and newRequestsThisSecond > maxRequestsPerSecond then
		return false, {{false, `Request rate exceeded max of {maxRequestsPerSecond} requests per second!`}}, {}
	end
	user.temp:set("RequestsThisSecond", newRequestsThisSecond)
	--
	local Parser = require(modules.Parser) :: any -- 'Any' to remove cyclic warning
	local batch = Parser.parse(message, user)
	local approved, notices, tasks = Commands.processBatchAsync(user, batch, requestInfo)
	if not tasks then
		tasks = {}
	end
	--
	return approved, notices, tasks :: {Task}
end

function Commands.getServerUser(): User.Class?
	if not serverUser then
		-- The server user acts on behalf of the game itself, so role and
		-- permission checks don't apply to it
		serverUser = User.new("HDAdminServerUser", "PlayerStore", { blockLoadingAndSaving = true });
		(serverUser :: any).isServerUser = true
	end
	return serverUser
end

function Commands.processNotices(caller: Player, notices: {any})
	for _, noticeTable in notices do
		local isWarning = noticeTable[1] == false
		local string = noticeTable[2]
		local noticeOptions = noticeTable[3]
		local Prompt = require(modules.Prompt)
		if isWarning then
			-- Roles opt in to these through the promptWarnings role setting
			local Roles = require(modules.Parent.Services.Roles) :: any
			if Roles.hasPermission(User.getUser(caller), "promptWarnings") then
				Prompt.warn(caller, string, noticeOptions)
			end
		else
			Prompt.info(caller, string, noticeOptions)
		end
	end
end

function Commands.processStatementAsync(callerUser: User, statement: Statement, info: RequestInfo?): (boolean, string | {Task}, boolean?, any?)
	local approved, warning, warningIsInfo, noticeOptions = Commands.verifyStatementAsync(callerUser, statement, info)
	if not approved then
		return false, (warning or "Statement denied"), warningIsInfo, noticeOptions
	end
	local callerUserId = callerUser.userId
	local tasks = Commands.executeStatement(callerUserId, statement, if info then info.messageSource else nil)
	Commands.executed:Fire(callerUser, statement)
	return true, tasks
end

function Commands.processBatchAsync(callerUser: User, batch: Batch, info: RequestInfo?): (boolean, {any}, {Task}?)
	if type(batch) ~= "table" then
		return false, {{false, "The batch must be a table!"}}, nil
	end
	local collectiveTasks: {any} = {}
	local collectiveNotices = {}
	local atLeastOneSuccess = false
	for _, statement in batch do
		local success, tasksOrWarning, warningIsInfo, noticeOptions = Commands.processStatementAsync(callerUser, statement, info)
		if success and typeof(tasksOrWarning) == "table" then
			for _, task in tasksOrWarning do
				atLeastOneSuccess = true
				table.insert(collectiveTasks, task)
			end
		end
		if not success and typeof(tasksOrWarning) == "string" then
			if tasksOrWarning ~= "" then
				table.insert(collectiveNotices, {if warningIsInfo == true then true else false, tasksOrWarning, noticeOptions})
			end
			break -- After any failures, stop processing further statements to avoid spam
		end
	end
	return atLeastOneSuccess, collectiveNotices, collectiveTasks :: {Task}
end

-- COMMAND GATE HELPERS
local function resolveProductName(id: number, infoType: Enum.InfoType?): string
	local ok, info = pcall(function()
		return MarketplaceService:GetProductInfo(id, infoType or Enum.InfoType.GamePass)
	end)
	if ok and typeof(info) == "table" and typeof((info :: any).Name) == "string" then
		return (info :: any).Name
	end
	return "#" .. tostring(id)
end

local function resolveGroupName(groupId: number): string
	local ok, info = pcall(function()
		return GroupService:GetGroupInfoAsync(groupId)
	end)
	if ok and typeof(info) == "table" and typeof((info :: any).Name) == "string" then
		return (info :: any).Name
	end
	return tostring(groupId)
end

local function offerUnlock(callerPlayer: Player, command: any, preferredRoleKey: string?): (string?, any?)
	local cmdRoles = (command :: any).roles
	if typeof(cmdRoles) ~= "table" then return nil end
	local Roles = require(modules.Parent.Services.Roles) :: any
	local pickRoleGiver = require(modules.CommandUtil.pickRoleGiver)
	local bestGiver: any = nil
	local bestRole: any = nil
	-- The Commands page sends the section's role so the invite matches what
	-- was clicked
	if typeof(preferredRoleKey) == "string" and table.find(cmdRoles, preferredRoleKey) then
		local role = Roles.getRole(preferredRoleKey)
		if typeof(role) == "table" then
			local giver = pickRoleGiver((role :: any).giveToProducts, (role :: any).giveToGroups)
			if giver then
				bestGiver = giver
				bestRole = role
			end
		end
	end
	if bestGiver == nil then
		local bestRank: number? = nil
		for _, roleKey in cmdRoles do
			local role = Roles.getRole(roleKey)
			if typeof(role) ~= "table" then continue end
			local giver = pickRoleGiver((role :: any).giveToProducts, (role :: any).giveToGroups)
			if giver == nil then continue end
			local rank = if typeof((role :: any).rank) == "number" then (role :: any).rank else 0
			if bestRank == nil or rank < bestRank then
				bestRank = rank
				bestGiver = giver
				bestRole = role
			end
		end
	end
	if bestGiver == nil then return nil end
	-- We escape the dynamic names so a stray '<' can't break the rich text
	local function escapeRich(text: string): string
		return (text:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
	end
	local roleName = if typeof((bestRole :: any).name) == "string" then (bestRole :: any).name else (bestRole :: any).key
	local roleColorHex = if typeof((bestRole :: any).color) == "Color3" then (bestRole :: any).color:ToHex() else "ffffff"
	local roleRich = `<b><font color="#{roleColorHex}">{escapeRich(roleName)}</font></b>`
	-- The Unlock button re-prompts the role's best giver if the first prompt
	-- was dismissed
	local noticeOptions = {
		linkButtons = {
			{label = "Unlock", unlockRole = (bestRole :: any).key},
		},
	}
	if bestGiver.kind == "Group" then
		local GroupJoin = require(modules.Parent.Services.Roles.GroupJoin)
		local groupId = bestGiver.groupId :: number
		GroupJoin.promptJoin(callerPlayer, groupId)
		return `Join <b>{escapeRich(resolveGroupName(groupId))}</b> to unlock role {roleRich} and use this command!`, noticeOptions
	end
	local promptPurchaseAsync = require(modules.AssetUtil.promptPurchaseAsync)
	local id = bestGiver.id :: number
	local infoType = bestGiver.infoType
	task.spawn(promptPurchaseAsync, id, callerPlayer, infoType)
	return `Purchase <b>{escapeRich(resolveProductName(id, infoType))}</b> to unlock role {roleRich} and use this command!`, noticeOptions
end

local function isInternalOnlyCommand(command: any): boolean
	local cmdRoles = (command :: any).roles
	if typeof(cmdRoles) ~= "table" or #cmdRoles == 0 then
		return false
	end
	local Roles = require(modules.Parent.Services.Roles) :: any
	local isInternalRole = require(modules.RoleUtil.isInternalRole)
	for _, roleKey in cmdRoles do
		if not isInternalRole(Roles.getRole(roleKey)) then
			return false
		end
	end
	return true
end

local function commandIsBoosterBundle(command: any): boolean
	local groups = (command :: any).groups
	if typeof(groups) ~= "table" then return false end
	for _, groupName in groups do
		if groupName == "BoosterBundle" then return true end
	end
	return false
end

-- The reason we hand back is so we don't fire our own message too
local function gateCommand(user: User, command: any, preferredUnlockRole: string?): (boolean, string?, boolean?, any?)
	if commandIsBoosterBundle(command) then
		local Config = require(modules.Parent.Services.Config) :: any
		if Config.getSetting("DisableBoosterBundles") == true then
			return false, "Booster bundles are disabled by the game owner"
		end
	end
	local Roles = require(modules.Parent.Services.Roles) :: any
	local canUse, denyReason = Roles.canUseCommand(user, command)
	local callerPlayer = Players:GetPlayerByUserId(user.userId)
	if not canUse then
		-- A disabled or pending command must never read as 'unlock the role'
		-- since the caller may hold the role already
		local vetted, vetReason = Roles.isCommandVetted(command, user)
		if not vetted then
			return false, vetReason or denyReason
		end
		if callerPlayer then
			if isInternalOnlyCommand(command) then
				local BoosterOffer = require(modules.Parent.Services.Roles.BoosterOffer) :: any
				BoosterOffer.prompt(callerPlayer, true)
				return false, "", true
			end
			local msg, noticeOptions = offerUnlock(callerPlayer, command, preferredUnlockRole)
			if msg then return false, msg, true, noticeOptions end
		end
		return false, denyReason
	end
	if (command :: any).groupExclusive == true and callerPlayer then
		local GroupGate = require(modules.Parent.Services.Roles.GroupGate)
		if not GroupGate.isInGroup(user.userId, HD_ADMIN_GROUP_ID) then
			local GroupJoin = require(modules.Parent.Services.Roles.GroupJoin)
			GroupJoin.promptJoin(callerPlayer, HD_ADMIN_GROUP_ID)
			return false, "Group exclusive command. Join HD Admin to unlock!"
		end
	end
	return true, nil
end

local function getModifierPermissionError(user: User, statementModifiers: any): string?
	local Roles = require(modules.Parent.Services.Roles) :: any
	local Modifiers = require(parser.Modifiers) :: any
	local permitAbusive = Roles.hasPermission(user, "permitModifiersAbusive")
	local permitGlobal = Roles.hasPermission(user, "permitModifiersGlobal")
	for modifierName in statementModifiers do
		if typeof(modifierName) ~= "string" then continue end
		local modifierItem = Modifiers.get(modifierName)
		if not modifierItem then continue end
		if modifierItem.isAbusive and not permitAbusive then
			return `Your role can't use the '{modifierName}' modifier`
		end
		if modifierItem.isGlobal and not permitGlobal then
			return `Your role can't use the '{modifierName}' modifier`
		end
	end
	return nil
end

local function getModifierComboError(statementCommands: any, statementModifiers: any): string?
	local hasGlobal = statementModifiers.global ~= nil
	local hasPerm = statementModifiers.perm ~= nil
	local hasJoin = statementModifiers.join ~= nil
	local hasSpawn = statementModifiers.spawn ~= nil
	local hasUnperm = statementModifiers.unperm ~= nil
	if hasGlobal and hasPerm then
		return "The 'perm' modifier can't be combined with 'global' (perm already runs on every server)"
	end
	if hasGlobal and hasJoin then
		return "The 'global' modifier can't be combined with 'join'. Use 'permJoin' to cover every server"
	end
	if hasUnperm and (hasGlobal or hasPerm or hasJoin) then
		return "The 'unperm' modifier can't be combined with 'global', 'perm' or 'join'"
	end
	if hasGlobal or hasPerm or hasJoin then
		local Args = require(parser.Args) :: any
		for commandName in statementCommands do
			local command = Commands.getCommand(commandName) :: any
			if not command then
				continue
			end
			if command.disableGlobalModifiers == true then
				return `Command '{commandName}' can't be used with the 'global', 'perm' or 'join' modifiers`
			end
			if command.disableModifiers == true then
				continue
			end
			local firstArg = Args.get(command.args[1])
			local hasPlayerArg = firstArg and firstArg.playerArg == true
			if hasJoin and not hasPlayerArg then
				return `'join' only works with player commands. Use ;perm{command.name} to run it on every server now and every startup`
			end
			local runsForEachPlayer = hasPlayerArg and firstArg.runForEachPlayer == true
			if hasPerm and not hasSpawn and not hasJoin and runsForEachPlayer then
				return `'perm' only replays when a server starts, so it can't follow a player. Use ;permSpawn{command.name} to stay with the players you pick, or ;permJoin{command.name} to cover everyone who joins`
			end
		end
	end
	return nil
end

function Commands.verifyStatementAsync(user: User, statement: Statement, info: RequestInfo?)--: (approved: boolean, reason: string?, reasonIsInfo: boolean?, noticeOptions: any?)
	local preferredUnlockRole = if info then info.preferredUnlockRole else nil
	
	-- Was the statement rejected during parsing?
	if statement.isValid ~= true then
		return false, statement.errorMessage
	end

	local ParserUtility = require(parser.ParserUtility)
	ParserUtility.convertStatementToRealNames(statement)

	-- Is user still active?
	local callerUserId = user.userId
	if not user.isActive then
		return false, "User hasn't loaded yet!"
	end

	-- Developers can switch a player's command access off through the loader API
	if user.temp:get("CommandsDisabled") == true then
		return false, "Your commands have been disabled by this game!"
	end

	local statementCommands = statement.commands
	local statementModifiers = statement.modifiers
	local statementQualifiers = statement.qualifiers
	local totalCommands = 0
	if not statementCommands then
		return false, "Failed to execute command as it does not exist!"
	end
	for commandName, arguments in statementCommands do
		local command = Commands.getCommand(commandName) :: Command?
		if not command or typeof(command.args) ~= "table" then
			continue
		end
		totalCommands += 1
	end

	for commandName, _ in statementCommands do
		local command = Commands.getCommand(commandName) :: Command?
		if not command then continue end
		local allowed, denyReason, denyIsInfo, noticeOptions = gateCommand(user, command, preferredUnlockRole)
		if not allowed then
			return false, denyReason or `You do not have permission to use command '{commandName}'!`, denyIsInfo, noticeOptions
		end
	end

	-- Without this anyone who can run a command could ;loop it up to 10M times
	local modifierPermissionError = getModifierPermissionError(user, statementModifiers)
	if modifierPermissionError then
		return false, modifierPermissionError
	end

	local modifierComboError = getModifierComboError(statementCommands, statementModifiers)
	if modifierComboError then
		return false, modifierComboError
	end

	-- Block the command from running if a cooldown is already active
	local warningNotice
	local forEveryPotentialTask = require(modules.CommandUtil.forEveryPotentialTask) :: any
	forEveryPotentialTask(callerUserId, statement, function(command: Command, arguments, optionalTargetUserId: number?)
		local commandKey = command.key:lower()
		local commandName = command.name
		local hasACooldown = typeof(command.cooldown) == "number" and command.cooldown > 0
		if not hasACooldown or statementModifiers.undo then
			return true
		end
		local groups = command.groups
		local clockNow = os.clock()
		local blockingTask
		local blockingEndTime = 0
		for _, otherTask in Task.getTasks(nil, optionalTargetUserId) do
			local endTime = otherTask.cooldownEndTime
			if not endTime or endTime <= clockNow then
				continue
			end
			local sharesCooldown = otherTask.commandKey == commandKey
			if not sharesCooldown and typeof(groups) == "table" then
				for _, groupName in groups do
					if otherTask.dictOfGroupsLower[string.lower(groupName)] then
						sharesCooldown = true
						break
					end
				end
			end
			if sharesCooldown then
				blockingTask = otherTask
				blockingEndTime = endTime
				break
			end
		end
		if blockingTask then
			local additionalUserMessage = ""
			local associatedPlayer = blockingTask.target
			if associatedPlayer then
				additionalUserMessage = ` on {associatedPlayer.DisplayName} (@{associatedPlayer.Name})`
			end
			local remainingTime = (math.ceil((blockingEndTime-os.clock())*100))/100
			warningNotice = `Wait {remainingTime} seconds until using '{commandName}' again{additionalUserMessage}!`
			return false
		end
		return true
	end)
	if warningNotice then
		return false, warningNotice
	end

	-- Commands-per-second limit
	local Roles = require(modules.Parent.Services.Roles) :: any
	local bypassLimits = Roles.hasPermission(user, "permitBypassLimits")
	local commandsPerMinuteLimit = Roles.getHighestValue(user, "limitCommandsPerMinute")
	local maxCommandsPer1Second = math.max(1, math.floor(commandsPerMinuteLimit / 6))
	local commandsThisSecond = user.temp:get("CommandsThisSecond")
	local commandsThisSecondStartClock = user.temp:get("CommandsThisSecondStartClock")
	local clockNow = os.clock()
	if clockNow - commandsThisSecondStartClock >= 1 then
		commandsThisSecond = 0
		commandsThisSecondStartClock = clockNow
		user.temp:set("CommandsThisSecond", commandsThisSecond)
		user.temp:set("CommandsThisSecondStartClock", commandsThisSecondStartClock)
	end
	local newComandsThisSecond = commandsThisSecond + totalCommands
	if not bypassLimits and newComandsThisSecond > maxCommandsPer1Second then
		return false, `Exceeded {maxCommandsPer1Second} commands per second. Send less and try again.`
	end

	-- Commands-per-60s and -per-20s limits
	local maxCommandsPer20Seconds = math.max(1, math.floor(commandsPerMinuteLimit / 2))
	local commandsThisMinute = user.perm:get("CommandsThisMinute")
	local commandsThisMinuteStartStamp = user.perm:get("CommandsThisMinuteStartStamp")
	local timeNow = os.time()
	if timeNow - commandsThisMinuteStartStamp >= 60 then
		commandsThisMinute = 0
		commandsThisMinuteStartStamp = timeNow
		user.perm:set("CommandsThisMinute", commandsThisMinute)
		user.perm:set("CommandsThisMinuteStartStamp", commandsThisMinuteStartStamp)
	end
	local timeSoFar = timeNow - commandsThisMinuteStartStamp
	local cooldownAmount = commandsThisMinuteStartStamp + 60 - timeNow
	local newComandsThisMinute = commandsThisMinute + totalCommands
	if not bypassLimits then
		if newComandsThisMinute > commandsPerMinuteLimit then
			return false, `Exceeded {commandsPerMinuteLimit} commands per minute. Wait {cooldownAmount}s to send again.`
		end
		if timeSoFar <= 20 and newComandsThisMinute > maxCommandsPer20Seconds then
			cooldownAmount -= 40
			return false, `Exceeded {maxCommandsPer20Seconds} commands per 20s. Wait {cooldownAmount}s to send again.`
		end
	end

	-- Per-command arg checks
	local Args = require(parser.Args) :: any -- 'any' cast to dodge the cyclic-dep warning
	local permitMultipleTargets = Roles.hasPermission(user, "permitMultipleTargets")
	local permitTargetingOthers = Roles.hasPermission(user, "permitTargetingOthers")
	-- Undo/preview don't actually run effects, so the per-arg checks are skipped for them
	local skipDeepChecks = statementModifiers and (statementModifiers.undo or statementModifiers.preview)
	for commandName, arguments in statementCommands do
		-- Parser sometimes leaves `arguments` nil for arg-less commands
		if typeof(arguments) ~= "table" then
			arguments = {}
			statementCommands[commandName] = arguments
		end
		local command = Commands.getCommand(commandName) :: any
		if not command then continue end

		if not skipDeepChecks and (not permitMultipleTargets or not permitTargetingOthers) then
			local playerArg: any = Args.get("player")
			if playerArg then
				local targetPlayers = playerArg:parse(statementQualifiers, callerUserId)
				if typeof(targetPlayers) == "table" then
					if not permitMultipleTargets and #targetPlayers > 1 then
						return false, "You're only permitted to target 1 player per statement!"
					end
					if not permitTargetingOthers then
						for _, targetPlayer in targetPlayers do
							if targetPlayer.UserId ~= callerUserId then
								return false, "You can only use commands on yourself!"
							end
						end
					end
				end
			end
		end

		local argStringIndex = 0
		if typeof(command.args) == "table" then
			for _, argNameOrAliasOrDetail in command.args do
				local argItem: any = Args.get(argNameOrAliasOrDetail)
				if not argItem then continue end
				if argStringIndex == 0 and argItem.playerArg then
					continue
				end
				argStringIndex += 1
				if skipDeepChecks then continue end
				local argString = arguments[argStringIndex]
				if argItem.verifyCanUse then
					local canUseArg, deniedReason = argItem:verifyCanUse(user, argString, {argNameOrAlias = argNameOrAliasOrDetail})
					if not canUseArg then
						return false, tostring(deniedReason or "Argument denied")
					end
				end
			end
		end
	end

	-- Now actually set when success
	user.temp:set("CommandsThisSecond", newComandsThisSecond)
	user.perm:set("CommandsThisMinute", newComandsThisMinute)

	return true, nil
end

function Commands.executeStatement(callerUserId: number | string, statement: Statement, messageSource: MessageSource?): {Task}

	-- Convert statement to real names
	local ParserUtility = require(parser.ParserUtility)
	ParserUtility.convertStatementToRealNames(statement)

	-- Lets restrictions be bypassed if customised
	-- Useful for fake server users for example
	if statement.isRestricted == nil then
		local callerUser = User.getUserByUserId(callerUserId)
		statement.isRestricted = true :: any
		if callerUser then
			--statement.isRestricted = not main.services.RoleService.verifySettings(callerUser, "ignore.roleRestrictions").areSome(true)
		end
	end
	
	-- If 'player' instance detected within qualifiers, convert to player.Name
	local ParserTypes = require(parser.ParserTypes)
	local ConfigSettings = require(modules.Parent.Services.Config.Settings)
	for qualifierKey, qualifierTable in statement.qualifiers do
		if typeof(qualifierKey) == "Instance" and qualifierKey:IsA("Player") then
			local callerUser = User.getUserByUserId(callerUserId)
			local playerDefinedSearch: ConfigSettings.PlayerSearch = Config.getSetting("PlayerDefinedSearch", callerUser)
			local playerName = qualifierKey.Name
			if playerDefinedSearch == "UserName" or playerDefinedSearch == "UserNameAndDisplayName" then
				local playerIdentifier = Config.getSetting("PlayerIdentifier", callerUser)
				playerName = tostring(playerIdentifier)..playerName
			end
			statement.qualifiers[qualifierKey] = nil
			statement.qualifiers[playerName] = qualifierTable
		end
	end

	local arrivedFromAnotherServer = statement.modifiers.wasGlobal ~= nil
		or (statement :: any).receivedFromBroadcast == true
	local bypassPreview = arrivedFromAnotherServer
		or (typeof(messageSource) == "string" and BYPASS_PREVIEW_SOURCES[messageSource] == true)
	if bypassPreview then
		statement.modifiers.preview = nil
	else
		for commandName, _ in statement.commands do
			local command = Commands.getCommand(commandName)
			local previewModifier = statement.modifiers.preview :: any
			if command and command.autoPreview == true and previewModifier ~= false then
				statement.modifiers.preview = true :: any
				break
			end
		end
	end
	
	local Modifiers = require(parser.Modifiers) :: any
	local ignorePreTaskChecks = false
	local modifierNamesSnapshot = {}
	for modifierName, _ in statement.modifiers do
		table.insert(modifierNamesSnapshot, modifierName)
	end
	for _, modifierName in modifierNamesSnapshot do
		local modifierItem = Modifiers.get(modifierName)
		local preCreation = if modifierItem then modifierItem.preCreation else nil
		if preCreation then
			(preCreation :: any)(callerUserId, statement)
		end
		if modifierItem and modifierItem.ignorePreTaskChecks then
			ignorePreTaskChecks = true
		end
	end

	-- Define the properties that we'll create the task from arguments
	local Args = require(parser.Args)
	local tasks: {any} = {}
	local qualifiers = (statement.qualifiers or {}) :: ArgGroup
	local modifiers = (statement.modifiers or {}) :: ArgGroup
	local generateUID = require(modules.DataUtil.generateUID)
	local statementHasUndo = modifiers.undo ~= nil
	local statementHasUnperm = modifiers.unperm ~= nil
	local statementHasPerm = modifiers.perm ~= nil
	local usedStatementTaskUID = false
	local entriesAdded = 0
	local entriesRemoved = 0
	local entryWarning: string? = nil

	if statementHasUndo or statementHasUnperm then
		local PermTasks = require(modules.Parent.Services.Tasks.PermTasks) :: any
		local callerPlayer = if typeof(callerUserId) == "number" then Players:GetPlayerByUserId(callerUserId) else nil
		for commandName in statement.commands do
			local command = Commands.getCommand(commandName) :: any
			if not command or not command.key then
				continue
			end
			local targetUserIds: {number}? = nil
			local firstArg: any = Args.get(command.args[1])
			if firstArg and firstArg.playerArg == true and firstArg.runForEachPlayer then
				local targets = firstArg:parse(statement.qualifiers, callerUserId)
				if typeof(targets) == "table" and #targets > 0 then
					local userIds: {number} = {}
					for _, targetPlayer in targets :: {Player} do
						table.insert(userIds, targetPlayer.UserId)
					end
					targetUserIds = userIds
				end
			end
			if statementHasUnperm then
				entriesRemoved += PermTasks.removeMatching(command.key, targetUserIds)
			else
				local kept = PermTasks.countMatching(command.key, targetUserIds)
				if kept > 0 and callerPlayer then
					local Prompt = require(modules.Prompt)
					local plural = if kept == 1 then "task" else "tasks"
					Prompt.info(callerPlayer, `{kept} perm {plural} kept running. Use ;unperm{command.name} to end them`)
				end
			end
		end
	end

	if statementHasUnperm then
		local callerPlayer = if typeof(callerUserId) == "number" then Players:GetPlayerByUserId(callerUserId) else nil
		if callerPlayer then
			local Prompt = require(modules.Prompt)
			if entriesRemoved > 0 then
				local plural = if entriesRemoved == 1 then "task" else "tasks"
				Prompt.success(callerPlayer, `Removed {entriesRemoved} perm {plural}! Click here to view.`, {openPage = "Tasks"})
			else
				Prompt.warn(callerPlayer, "No saved perm tasks matched")
			end
		end
		return tasks :: {Task}
	end

	local prefilteredByCommand: {[string]: {overrides: {[string]: any}?, failure: string?}} = {}
	local function getPrefilteredText(command: any, commandKey: string, args: any)
		local memo = prefilteredByCommand[commandKey]
		if not memo then
			local prefilterTextArgs = require(modules.CommandUtil.prefilterTextArgs)
			local overrides, failure = prefilterTextArgs(command, args, callerUserId)
			memo = {overrides = overrides, failure = failure}
			prefilteredByCommand[commandKey] = memo
		end
		return memo
	end

	-- Tasks are split into separate players (such as those with the 'Player' arg),
	-- while some do not (such as those with the 'Players' arg, or without any type
	-- of player arg at all)
	local forEveryPotentialTask = require(modules.CommandUtil.forEveryPotentialTask)
	forEveryPotentialTask(callerUserId, statement, function(command: Command, arguments, optionalTargetUserId: number?, entryKind: string?)

		-- Setup task properties
		local commandKey = command.key :: string
		local args = (arguments or {}) :: ArgGroup
		local entryUIDForTask: string? = (statement :: any).entryUID
		local suppressAutoPrompt = entryUIDForTask ~= nil
		local statementOverrides = (statement :: any).argOverrides
		local argOverridesForTask: {[string]: any}? = if typeof(statementOverrides) == "table" and typeof(statementOverrides[commandKey]) == "table"
			then statementOverrides[commandKey]
			else nil
		local taskUID: string
		if statement.taskUID and not usedStatementTaskUID then
			usedStatementTaskUID = true
			taskUID = statement.taskUID
		else
			taskUID = generateUID(10)
		end
		local getEffectiveModifiers = require(modules.CommandUtil.getEffectiveModifiers)
		local effectiveModifiers = getEffectiveModifiers(command, modifiers) :: ArgGroup

		if entryKind and not statementHasUndo then
			local prefiltered = getPrefilteredText(command, commandKey, args)
			if prefiltered.failure then
				if not entryWarning then
					entryWarning = prefiltered.failure
				end
				return true
			end
			local PermTasks = require(modules.Parent.Services.Tasks.PermTasks) :: any
			local callerPlayer = if typeof(callerUserId) == "number" then Players:GetPlayerByUserId(callerUserId) else nil
			local targetPlayer = if optionalTargetUserId then Players:GetPlayerByUserId(optionalTargetUserId) else nil
			local added, warning, newEntryUID = PermTasks.add({
				kind = entryKind,
				commandKey = commandKey,
				args = args,
				qualifiers = qualifiers,
				modifiers = effectiveModifiers,
				callerUserId = callerUserId,
				callerName = if callerPlayer then callerPlayer.Name else nil,
				callerDisplayName = if callerPlayer then callerPlayer.DisplayName else nil,
				targetUserId = optionalTargetUserId,
				targetName = if targetPlayer then targetPlayer.DisplayName else nil,
				targetUserName = if targetPlayer then targetPlayer.Name else nil,
				createdAt = os.time(),
				argOverrides = prefiltered.overrides,
			})
			if added then
				entriesAdded += 1
			elseif not entryWarning then
				entryWarning = warning
			end
			if entryKind ~= "joinServer" or not added then
				return true
			end
			entryUIDForTask = newEntryUID
			local immediateModifiers = {} :: ArgGroup
			for modifierName, value in effectiveModifiers do
				if modifierName ~= "join" and modifierName ~= "perm" and modifierName ~= "global" and modifierName ~= "wasGlobal" then
					immediateModifiers[modifierName] = value
				end
			end
			local broadcastModifiers = table.clone(immediateModifiers)
			broadcastModifiers.wasGlobal = {}
			local GlobalStatements = require(modules.Parent.Services.Tasks.GlobalStatements) :: any
			GlobalStatements.broadcast(callerUserId, {
				isValid = true,
				isConverted = true,
				commands = {[commandKey] = args},
				modifiers = broadcastModifiers,
				qualifiers = qualifiers,
				isRestricted = statement.isRestricted,
				entryUID = newEntryUID,
				argOverrides = if prefiltered.overrides then {[commandKey] = prefiltered.overrides} else nil,
			})
			argOverridesForTask = prefiltered.overrides
			effectiveModifiers = immediateModifiers
		end

		if not statementHasUndo and effectiveModifiers.join and not effectiveModifiers.perm then
			local prefiltered = getPrefilteredText(command, commandKey, args)
			if prefiltered.failure then
				if not entryWarning then
					entryWarning = prefiltered.failure
				end
				return true
			end
			for _, existingTask in Task.getTasks(commandKey) do
				local existingAny = existingTask :: any
				if not existingAny.targetUserId and typeof(existingAny.modifiers) == "table" and existingAny.modifiers.join then
					existingAny:destroy()
				end
			end
			local childModifiers = {} :: ArgGroup
			for modifierName, value in effectiveModifiers do
				if modifierName ~= "join" and modifierName ~= "global" and modifierName ~= "wasGlobal" then
					childModifiers[modifierName] = value
				end
			end
			local watcherTask = Task.new({
				callerUserId = callerUserId,
				commandKey = commandKey,
				args = args,
				modifiers = { join = effectiveModifiers.join } :: ArgGroup,
				qualifiers = qualifiers,
				isRestricted = statement.isRestricted,
				UID = taskUID,
			})
			if watcherTask then
				(watcherTask :: any).extra.childModifiers = childModifiers
				;(watcherTask :: any).extra.childArgOverrides = prefiltered.overrides
				if typeof(callerUserId) == "number" then
					local RemoteCallerRoles = require(modules.References.remoteCallerRoles)
					local roleKey = RemoteCallerRoles.resolveLocalKey(callerUserId)
					if roleKey then
						RemoteCallerRoles.register(callerUserId, roleKey)
					end
				end
				table.insert(tasks, watcherTask)
			end
			return true
		end

		local properties: Properties = {
			callerUserId = callerUserId,
			targetUserId = optionalTargetUserId,
			commandKey = commandKey,
			args = args,
			modifiers = effectiveModifiers,
			qualifiers = qualifiers,
			isRestricted = statement.isRestricted,
			UID = taskUID,
		}
		
		-- Undo tasks if already applied to player (or server level)
		local runningTasks = Task.getTasks(commandKey, optionalTargetUserId)
		local hasACooldown = typeof(command.cooldown) == "number" and command.cooldown > 0
		if not ignorePreTaskChecks and not hasACooldown and not command.stackable == true then
			for _, task in runningTasks do
				task:destroy()
			end
		end
		
		-- Undo tasks if they contain the same group as any groups from this command
		local ourGroups = command.groups
		if not ignorePreTaskChecks and optionalTargetUserId and typeof(ourGroups) == "table" then
			local allPlayerTasks = Task.getTasks(nil, optionalTargetUserId)
			for _, task in allPlayerTasks do
				local dictOfGroupsLower = task.dictOfGroupsLower
				for _, groupName in ourGroups do
					local nameLower = string.lower(groupName)
					if dictOfGroupsLower[nameLower] then
						task:destroy()
						break
					end
				end
			end
		end

		-- Finally all good, now create task
		local task = Task.new(properties)
		if task then
			if argOverridesForTask then
				(task :: any).extra.argOverrides = argOverridesForTask
			end
			if entryUIDForTask then
				(task :: any).extra.entryUID = entryUIDForTask
				if suppressAutoPrompt then
					(task :: any).extra.suppressAutoPrompt = true
				end
				local PermTasks = require(modules.Parent.Services.Tasks.PermTasks) :: any
				PermTasks.trackTask(entryUIDForTask, task)
			end
			table.insert(tasks, task)
		end

		return true
	end)

	if not statementHasUndo and typeof(modifiers.schedule) == "table" and typeof(callerUserId) == "number" then
		local epoch = tonumber((modifiers.schedule :: any)[1])
		local callerPlayer = Players:GetPlayerByUserId(callerUserId)
		if epoch and callerPlayer then
			local Prompt = require(modules.Prompt)
			for commandName in statement.commands do
				local command = Commands.getCommand(commandName) :: any
				if command then
					Prompt.info(callerPlayer, `{command.name} scheduled for %TIME%`, {localEpoch = epoch})
				end
			end
		end
	end

	if typeof(callerUserId) == "number" and not statementHasUndo then
		local permExpectsEntries = false
		if statementHasPerm then
			for commandName in statement.commands do
				local command = Commands.getCommand(commandName) :: any
				if command and command.disableModifiers ~= true then
					permExpectsEntries = true
					break
				end
			end
		end
		local callerPlayer = Players:GetPlayerByUserId(callerUserId)
		if callerPlayer and (entriesAdded > 0 or entryWarning or permExpectsEntries) then
			local Prompt = require(modules.Prompt)
			if entryWarning then
				Prompt.warn(callerPlayer, entryWarning)
			elseif entriesAdded > 0 then
				local plural = if entriesAdded == 1 then "task" else "tasks"
				Prompt.success(callerPlayer, `Saved {entriesAdded} perm {plural}! Click here to view.`, {openPage = "Tasks"})
			elseif permExpectsEntries then
				Prompt.warn(callerPlayer, "No players matched, so nothing was saved")
			end
		end
	end

	if #tasks > 0 and (messageSource == "Chat" or messageSource == "ChatCommand") and typeof(callerUserId) == "number" then
		local callerUser = User.getUserByUserId(callerUserId)
		local callerPlayer = Players:GetPlayerByUserId(callerUserId)
		if callerUser and callerPlayer and not callerUser.temp:get("ShownBoosterGrid") then
			for _, activeTask in tasks do
				local commandKey = (activeTask :: any).commandKey
				if commandKey == "/commands" then
					continue
				end
				local command = Commands.getCommand(commandKey) :: any
				local tags = command and command.tags
				if typeof(tags) ~= "table" or not table.find(tags, "_Booster") then
					continue
				end
				callerUser.temp:set("ShownBoosterGrid", true)
				require(modules.CommandUtil.openCommands)(callerPlayer)
				break
			end
		end
	end

	return tasks :: {Task}
end


-- SETUP
-- These set restrictions on what the client can see, and which clients
local getStateVerifier = require(modules.VerifyUtil.getStateVerifier)
User.everyone:verify(getStateVerifier(
	"Commands",
	"OnlyInclude",
	CLIENT_PROPERTIES_TO_PREVIEW
))
User.everyone:verify(getStateVerifier(
	"CommandInfo",
	"Exclude",
	CLIENT_PROPERTIES_TO_EXCLUDE
))


-- We make sure data fetched via User.everyone is accurate
local State = require(modules.Objects.State)
State.verifyFirstFetch("Commands", Commands.updateCommands)
State.verifyFirstFetch("CommandInfo", Commands.updateCommands)
State.verifyFirstFetch("CommandTags", Commands.updateCommands)


task.defer(function()
	Commands.updateCommands()
	for _, command in commandsArray do
		local loaded = (command :: any).loaded
		if typeof(loaded) == "function" and (command :: any).loadedFired ~= true then
			(command :: any).loadedFired = true
			task.spawn(function()
				local success, problem = pcall(loaded, command)
				if not success then
					warn(`HD Admin: '{command.name}' loaded errored: {problem}`)
				end
			end)
		end
	end
end)


return Commands