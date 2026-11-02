--!strict
-- CONFIG
local MAX_MESSAGE_LENGTH = 1000
local MAX_FILTER_TEXT_LENGTH = 500
local MAX_RECENT_COMMANDS = 12
local MAX_UPDATE_DISMISS_AHEAD = 4 * 7 * 24 * 60 * 60


-- LOCAL
local Users = {}
local Players = game:GetService("Players")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local services = modules.Parent.Services
local Config = require(modules.Parent.Services.Config)
local User = require(modules.Objects.User)
local sharedTypes = require(modules.References.sharedTypes)
local Remote = require(modules.Objects.Remote)
local isStringSafe = require(modules.VerifyUtil.isStringSafe)
local updateActiveCommands = Remote.new("UpdateActiveCommands", "Event")


-- TYPES
type MessageSource = sharedTypes.MessageSource


-- LOCAL FUNCTIONS
local function getActiveCommands(player: Player): {[string]: true}
	local Task = require(modules.Objects.Task)
	local activeCommands: {[string]: true} = {}
	local selfRunTasks = Task.getSelfRunTasks(player.UserId)
	for _, task in selfRunTasks do
		activeCommands[task.commandKey] = true
	end
	return activeCommands
end

local function recordRecentCommand(user: any, message: string)
	local perm = user.perm
	if not perm then
		return
	end
	if not isStringSafe(message) then
		return
	end
	local stored = perm:get("RecentCommands")
	local recents: {string} = {}
	if typeof(stored) == "table" then
		for _, entry in stored do
			if typeof(entry) == "string" and entry ~= message then
				table.insert(recents, entry)
			end
		end
	end
	table.insert(recents, 1, message)
	while #recents > MAX_RECENT_COMMANDS do
		table.remove(recents)
	end
	perm:set("RecentCommands", recents)
end


-- SETUP
 -- We must require on startup so we don't miss perm-ban/role/warn messages from other servers
require(modules.DataStores.Permanent)

-- Listen for Chatted (this replaces the old player.Chatted events which were slower)
local validSources = {ClientCommand = true, ClientCommandBar = true, ClientPreviewRun = true, ClientRun = true}
Remote.new("SendMessage", "Function"):onServerInvoke(function(player: Player, message: unknown, incomingSource: unknown, context: unknown): (boolean, string | {any})
	local returnDetails = {warning = "NA"}
	if typeof(message) ~= "string" then
		returnDetails.warning = "Invalid message string"
		return false, returnDetails
	end
	if #(message :: string) > MAX_MESSAGE_LENGTH then
		returnDetails.warning = `Message too long (max {MAX_MESSAGE_LENGTH} chars)`
		return false, returnDetails
	end
	local Commands = require(services.Commands)
	local user = User.getUser(player)
	if not user then
		returnDetails.warning = "User not loaded"
		return false, returnDetails
	end
	local messageSource: MessageSource = "Chat"
	if typeof(incomingSource) == "string" and validSources[incomingSource] then
		messageSource = incomingSource :: MessageSource
	end
	if messageSource == "ClientCommandBar" and not require(services.Roles).canViewPage(user, "CommandBar") then
		returnDetails.warning = "You don't have permission to use the command bar"
		return false, returnDetails
	end
	-- The Commands page sends its section's role so unlock invites match the
	-- section that was clicked
	local preferredUnlockRole: string? = nil
	if typeof(context) == "table" and typeof((context :: any).unlockRole) == "string" and #((context :: any).unlockRole :: string) <= 50 then
		preferredUnlockRole = (context :: any).unlockRole :: string
	end
	local approved, notices, tasks = Commands.request(user, message, {
		messageSource = messageSource,
		preferredUnlockRole = preferredUnlockRole,
	})
	Commands.processNotices(player, notices)
	if approved and messageSource == "ClientCommandBar" then
		recordRecentCommand(user, message :: string)
	end
	local promptBubble = false
	if messageSource == "ClientRun" or messageSource == "ClientPreviewRun" then
		local firstTask: any = tasks[1]
		local modifiers = firstTask and firstTask.modifiers
		if firstTask and (not modifiers or not modifiers.undo) then
			promptBubble = true
		end
		if firstTask and firstTask.isActive then
			firstTask:onEndedForGood(function()
				updateActiveCommands:fireClient(player, getActiveCommands(player))
			end)
		end
		task.wait() -- defer incase the command ends instantly (like ;jump)
		returnDetails.activeCommands = getActiveCommands(player)
	end
	local character = player.Character
	if promptBubble and character then
		local forceBubbleChat = require(modules.ChatUtil.forceBubbleChat)
		forceBubbleChat(player, character, message)
	end
	return true, returnDetails
end)

Remote.new("GetActiveCommands", "Function", "Low"):onServerInvoke(function(player: Player): {[string]: true}
	local activeCommands = getActiveCommands(player)
	return activeCommands
end)

Remote.new("FilterText", "Function", "Medium"):onServerInvoke(function(player: Player, textToFilter: unknown, targetUserId: unknown): (boolean, string)
	if typeof(textToFilter) ~= "string" then
		return false, "Invalid textToFilter"
	end
	if #(textToFilter :: string) > MAX_FILTER_TEXT_LENGTH then
		return false, `Text too long (max {MAX_FILTER_TEXT_LENGTH} chars)`
	end
	if targetUserId ~= nil and typeof(targetUserId) ~= "number" then
		return false, "Invalid targetUserId"
	end
	local filterTextAsync = require(modules.VerifyUtil.filterTextAsync)
	return filterTextAsync(textToFilter, player.UserId, targetUserId)
end)

Remote.new("GetUserProfile", "Function", "Medium"):onServerInvoke(function(player: Player, targetUserId: unknown): (boolean, any)
	if typeof(targetUserId) ~= "number" or targetUserId <= 0 or targetUserId ~= math.floor(targetUserId) then
		return false, "Invalid targetUserId"
	end
	local callerUser = User.getUser(player)
	if not callerUser then
		return false, "Caller user not loaded"
	end
	local isSelf = (targetUserId == player.UserId)
	local targetPlayer = Players:GetPlayerByUserId(targetUserId)
	local isOnline = targetPlayer ~= nil
	if not isSelf then
		local Roles = require(services.Roles) :: any
		local requiredPageKey = if isOnline then "MembersServer" else "MembersPermanent"
		if not Roles.canViewPage(callerUser, requiredPageKey) then
			return false, `Missing '{requiredPageKey}' view permission`
		end
	end
	local getUserInfoAsync = require(modules.PlayerUtil.getUserInfoAsync)
	local ok, info = getUserInfoAsync(targetUserId)
	if not ok or typeof(info) ~= "table" then
		return false, tostring(info)
	end
	local roleKeys: {string} = {}
	if isOnline then
		local targetUser = User.getUser(targetPlayer :: Player)
		if targetUser then
			local Roles = require(services.Roles) :: any
			local realRoles = Roles.getRealRolesForUser(targetUser)
			for _, role in realRoles do
				table.insert(roleKeys, (role :: any).key)
			end
		end
	end
	return true, {
		userId = (info :: any).userId,
		userName = (info :: any).userName,
		userDisplayName = (info :: any).userDisplayName,
		userImage = (info :: any).userImage,
		isOnline = isOnline,
		roleKeys = roleKeys,
	}
end)

Remote.new("DismissUpdate", "Function", "Low"):onServerInvoke(function(player: Player, updateTime: unknown): boolean
	if typeof(updateTime) ~= "number" or updateTime ~= updateTime then
		return false
	end
	local user = User.getUser(player)
	if not user then
		return false
	end
	local stamp = math.clamp(math.floor(updateTime :: number), 0, os.time() + MAX_UPDATE_DISMISS_AHEAD)
	local stored = user.perm:get("SeenUpdateTime")
	if typeof(stored) == "number" and stored >= stamp then
		return true
	end
	user.perm:set("SeenUpdateTime", stamp)
	return true
end)

Remote.new("GetToolsInfo", "Function", "High"):onServerInvoke(function(player: Player)
	local getToolsInfoAsync = require(modules.CommandUtil.getToolsInfoAsync)
	local success, toolsInfo = getToolsInfoAsync()
	if not success then
		return false, toolsInfo
	end
	local toolsInfoForClient = {}
	for _, tool in toolsInfo do
		table.insert(toolsInfoForClient, {name = tool.name, textureId = tool.textureId})
	end
	return true, toolsInfoForClient
end)

-- Setup player user objects (and their data saving and replication)
local function playerAdded(player: Player)

    local shouldKick = Config.getSetting("EnableMinimumAccountAge") == true
    local minimumAccountAge = tonumber(Config.getSetting("MinimumAccountAge")) or 0
    if shouldKick and minimumAccountAge > 0 and player.AccountAge < minimumAccountAge then
        player:Kick("🚫 Your account is too new to join! 🚫")
        return
    end
	
	-- Create user
	User.new(player, "PlayerStore")

	-- Wait for user to load (or player to leave)
	local success, user = User.getUserAsync(player)
	if not success or not user then
		return
	end

	local Roles = require(services.Roles) :: any
	local grantedRoles = Roles.resolveRolesForPlayer(player)
	user.temp:set("Roles", grantedRoles)

	user.temp:set("RolesReady", true)

	Roles.attachPreviewAutoClear(user)

	-- Listen for silent /e chat commands
	local Commands = require(services.Commands)
	local Players = game:GetService("Players")
	local TextChatService = game:GetService("TextChatService")
	local userJanitor = user.janitor
	for _, instance in TextChatService:GetDescendants() do
		if not (instance:IsA("TextChatCommand") and instance.SecondaryAlias == "/e") then
			continue
		end
		userJanitor:add(instance.Triggered:Connect(function(chatSource, message)
			local speaker = Players:FindFirstChild(chatSource.Name) :: Player?
			if not speaker or speaker ~= player then
				return
			end
			local finalMessage = string.sub(message,4)
			local approved, notices, tasks = Commands.request(user, finalMessage, {messageSource = "ChatCommand"})
			Commands.processNotices(speaker, notices)
		end))
	end

end
Players.PlayerAdded:Connect(playerAdded)
for _, player in Players:GetPlayers() do
	playerAdded(player)
end


return Users
