--!strict

--[[

	We keep the internal API behaviours in here so that we can safely make changes to the
	internals of HD Admin without worrying about impacting developers

--]]


-- LOCAL
local ServerAPI = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local sharedTypes = require(modules.References.sharedTypes)
local Signal = require(modules.Objects.Signal)
local User = require(modules.Objects.User)
local TaskObject = require(modules.Objects.Task)
local Prompt = require(modules.Prompt)
local filterTextAsync = require(modules.VerifyUtil.filterTextAsync)
local Commands = require(modules.Parent.Services.Commands)
local Roles = require(modules.Parent.Services.Roles)
local Moderation = require(modules.Parent.Services.Moderation)
local Emotes = require(modules.Parent.Services.Emotes)
local Config = require(modules.Parent.Services.Config)
local VERSION = require(modules.Parent.Controllers.UI.Config.VERSION)
local IsolatedServer = require(modules.IsolatedServer)


-- TYPES
export type Target = sharedTypes.Target
export type ActionScope = sharedTypes.ActionScope
export type ActionOptions = Roles.ActionOptions
export type Role = Roles.Role
export type BanOptions = Moderation.BanOptions
export type UnbanOptions = Moderation.UnbanOptions
export type BanRecord = Moderation.BanRecord
export type Emote = Emotes.Emote
export type IncompleteEmote = Emotes.IncompleteEmote
export type Task = TaskObject.Class
export type PromptType = Prompt.PromptType
export type PromptOptions = Prompt.PromptOptions
export type PromptHandle = Prompt.Disconnect


-- LOCAL FUNCTIONS
local function resolveUserId(target: any): number?
	if typeof(target) == "Instance" and target:IsA("Player") then
		return target.UserId
	end
	if typeof(target) == "number" then
		return target
	end
	return nil
end

local function getTargetUserAsync(target: any): (boolean, any)
	if typeof(target) == "Instance" and target:IsA("Player") then
		return User.getUserAsync(target)
	end
	local userId = resolveUserId(target)
	if not userId then
		return false, "Target must be a Player or a userId number"
	end
	return User.getUserAsync(userId)
end

local function getRoleByName(roleName: any): any
	if typeof(roleName) ~= "string" or roleName == "" then
		return nil
	end
	return Roles.getRole(roleName)
end

local function setCommandsDisabled(player: any, disabled: boolean)
	if not (typeof(player) == "Instance" and player:IsA("Player")) then
		error("HD Admin: disableCommands and enableCommands take a Player")
	end
	-- Apply once their user loads so calls made straight from PlayerAdded still work
	task.spawn(function()
		local success, user = User.getUserAsync(player)
		if success and user then
			(user :: any).temp:set("CommandsDisabled", if disabled then true else nil)
		end
	end)
end

local function collectTasks(commandName: string?, target: any): {any}
	local commandKey: string? = nil
	if commandName ~= nil then
		local command = Commands.getCommand(commandName)
		if not command then
			return {}
		end
		commandKey = (command :: any).key
	end
	return (TaskObject :: any).getTasks(commandKey, resolveUserId(target))
end


-- COMMAND FUNCTIONS
function ServerAPI.requestCommand(message: string, optionalFromPlayer: Player?): (boolean, {any}, {any})
	local user: any
	if typeof(optionalFromPlayer) == "Instance" and optionalFromPlayer:IsA("Player") then
		local success, playerUser = User.getUserAsync(optionalFromPlayer)
		if not success then
			return false, {{false, `{optionalFromPlayer}`}}, {}
		end
		user = playerUser
	else
		user = Commands.getServerUser()
	end
	local approved, notices, tasks = Commands.request(user, message, {messageSource = "API"})
	if optionalFromPlayer then
		Commands.processNotices(optionalFromPlayer, notices)
	end
	return approved, notices, tasks
end

function ServerAPI.getTasks(commandName: string?, target: Target?): {Task}
	return collectTasks(commandName, target)
end

function ServerAPI.endTasks(commandName: string?, target: Target?): number
	local ended = 0
	for _, commandTask in collectTasks(commandName, target) do
		commandTask:destroy()
		ended += 1
	end
	return ended
end

function ServerAPI.disableCommands(player: Player)
	setCommandsDisabled(player, true)
end

function ServerAPI.enableCommands(player: Player)
	setCommandsDisabled(player, false)
end

function ServerAPI.onCommandRun(callback: (player: Player?, commandNames: {string}) -> ()): Signal.Connection
	-- Runs after a requested statement executes, whether from chat, the
	-- command bar, the Run page or requestCommand. The player is nil when
	-- the server itself was the caller
	return Commands.executed:Connect(function(user: any, statement: any)
		local commandNames = {}
		for commandName in statement.commands do
			table.insert(commandNames, commandName)
		end
		callback(user.player, commandNames)
	end)
end


-- ROLE FUNCTIONS
function ServerAPI.giveRoleAsync(target: Target, roleName: string, options: ActionOptions?): (boolean, string?)
	local userId = resolveUserId(target)
	if not userId then
		return false, "Target must be a Player or a userId number"
	end
	local role = getRoleByName(roleName)
	if not role then
		return false, `Unknown role '{tostring(roleName)}'`
	end
	return Roles.giveRoleAsync(userId, role.key, options)
end

function ServerAPI.takeRoleAsync(target: Target, roleName: string, options: ActionOptions?): (boolean, string?)
	local userId = resolveUserId(target)
	if not userId then
		return false, "Target must be a Player or a userId number"
	end
	local role = getRoleByName(roleName)
	if not role then
		return false, `Unknown role '{tostring(roleName)}'`
	end
	return Roles.takeRoleAsync(userId, role.key, options)
end

function ServerAPI.getRolesAsync(target: Target): (boolean, {Role} | string)
	local success, userOrReason = getTargetUserAsync(target)
	if not success then
		return false, tostring(userOrReason)
	end
	return true, Roles.getRolesForUser(userOrReason)
end

function ServerAPI.getTopRoleAsync(target: Target): (boolean, (Role | string)?)
	local success, userOrReason = getTargetUserAsync(target)
	if not success then
		return false, tostring(userOrReason)
	end
	return true, Roles.getTopRole(userOrReason)
end

function ServerAPI.hasRoleAsync(target: Target, roleName: string): boolean
	local success, user = getTargetUserAsync(target)
	if not success then
		return false
	end
	local role = getRoleByName(roleName)
	if not role then
		return false
	end
	return Roles.hasRole(user, role.key)
end

function ServerAPI.canUseCommandAsync(target: Target, commandName: string): (boolean, string?)
	-- Whether the target's roles allow them to run the given command
	local success, userOrReason = getTargetUserAsync(target)
	if not success then
		return false, tostring(userOrReason)
	end
	return Roles.canUseCommand(userOrReason, commandName)
end

function ServerAPI.getRole(roleName: string): Role?
	return getRoleByName(roleName)
end

function ServerAPI.getAllRoles(): {Role}
	return Roles.getRoles()
end


-- MODERATION FUNCTIONS
function ServerAPI.banAsync(target: Target, options: BanOptions): (boolean, string?)
	local userId = resolveUserId(target)
	if not userId then
		return false, "Target must be a Player or a userId number"
	end
	return Moderation.banAsync(userId, options)
end

function ServerAPI.unbanAsync(target: Target, banId: string?, options: UnbanOptions?): (boolean, string?, number?)
	local userId = resolveUserId(target)
	if not userId then
		return false, "Target must be a Player or a userId number"
	end
	return Moderation.unbanAsync(userId, banId, options)
end

function ServerAPI.getBanAsync(target: Target): (BanRecord?, string?)
	local userId = resolveUserId(target)
	if not userId then
		return nil, nil
	end
	local entry, banId = Moderation.getActiveBanAsync(userId)
	return entry, banId
end


-- EMOTE FUNCTIONS
ServerAPI.getEmoteById = Emotes.getEmoteById
ServerAPI.getEmoteByName = Emotes.getEmoteByName
ServerAPI.getRandomEmote = Emotes.getRandomEmote
ServerAPI.addEmoteAsync = Emotes.addEmoteAsync


-- OTHER FUNCTIONS
function ServerAPI.prompt(promptType: PromptType, player: Player, text: string, options: PromptOptions?): PromptHandle
	local promptFunction: any = (Prompt :: any)[promptType]
	if typeof(promptFunction) ~= "function" then
		error(`HD Admin: '{tostring(promptType)}' is not a valid prompt type`)
	end
	return promptFunction(player, text, options)
end

function ServerAPI.getSetting(settingName: string, optionalPlayer: Player?): any
	local optionalUser = if optionalPlayer then User.getUser(optionalPlayer) else nil
	return Config.getSetting(settingName, optionalUser)
end

function ServerAPI.getVersion(): string
	return VERSION.appVersion
end

function ServerAPI.filterTextAsync(text: string, author: Target, viewer: Target?): (boolean, string)
	if typeof(text) ~= "string" then
		return false, "Text must be a string"
	end
	local authorUserId = resolveUserId(author)
	if not authorUserId then
		return false, "Author must be a Player or a userId number"
	end
	local viewerUserId = if viewer ~= nil then resolveUserId(viewer) else nil
	if viewer ~= nil and not viewerUserId then
		return false, "Viewer must be a Player or a userId number"
	end
	return filterTextAsync(text, authorUserId, viewerUserId)
end

-- Once isolated, everything behaves as normal within this server (perm bans, role
-- edits, global commands, settings) but nothing saves or broadcasts beyond it
function ServerAPI.isolateServer()
	IsolatedServer.isolate()
end

function ServerAPI.isServerIsolated(): boolean
	return IsolatedServer.isIsolated()
end


return ServerAPI
