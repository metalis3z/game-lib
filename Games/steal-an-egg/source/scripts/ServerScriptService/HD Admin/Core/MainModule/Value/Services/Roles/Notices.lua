--!strict

--[[

	Notices on join

--]]


-- CONFIG
local READY_FALLBACK = 10
local INTRO_DURATION = 20
local GRANT_FLUSH_DELAY = 0.5
local QUALIFYING_PERMISSIONS = {"mayEditAll", "mayEditRoles", "mayEditSettingsGame"}


-- LOCAL
local Notices = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local services = modules.Parent.Services
local frontend = modules.Parent.Controllers.UI
local User = require(modules.Objects.User)
local Framework = require(modules.Framework)
local Prompt = require(modules.Prompt)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local colourRoleName = require(modules.RoleUtil.colourRoleName)
local promptClientReadyRemote = require(modules.References.promptClientReadyRemote)
local versionIsOutdated = false
local outdatedText = ""
local shownOutdatedTo: {[string]: boolean} = {}
local clientReadyUserIds: {[string]: boolean} = {}
local pendingJoinUsers: {[string]: User.Class} = {}
local watchedUsers: {[any]: boolean} = {}


-- LOCAL FUNCTIONS
local function joinNames(names: {string}): string
	if #names <= 1 then
		return names[1] or ""
	end
	if #names == 2 then
		return `{names[1]} and {names[2]}`
	end
	return `{table.concat(names, ", ", 1, #names - 1)} and {names[#names]}`
end

local function getNoticeableRoles(roles: {any}): {any}
	local noticeable = {}
	for _, role in roles do
		if isInternalRole(role) or role.hide == true then
			continue
		end
		table.insert(noticeable, role)
	end
	return noticeable
end

local function showIntro(user: User.Class)
	local player = user.player
	if not player then
		return
	end
	local Roles = require(services.Roles) :: any
	if not Roles.hasPermission(user, "promptWelcome") then
		return
	end
	local roles = getNoticeableRoles(Roles.getRealRolesForUser(user))
	if #roles == 0 then
		return
	end
	local roleBadges = {}
	for _, role in roles do
		table.insert(roleBadges, {name = role.name, color = role.color})
	end
	Prompt.info(player, `Welcome <font weight="900">@{player.Name}</font>! Your roles are:`, {
		duration = INTRO_DURATION,
		roleBadges = roleBadges,
		linkButtons = {
			{label = "Commands", page = "Commands"},
			{label = "Learn More", page = "About", style = "Neutral"},
		},
	})
end

local function maybeShowOutdated(user: User.Class)
	local player = user.player
	local userIdKey = tostring(user.userId)
	if not player or not versionIsOutdated or shownOutdatedTo[userIdKey] then
		return
	end
	if user.temp:get("RolesReady") ~= true then
		return
	end
	local Roles = require(services.Roles) :: any
	if not Roles.hasAnyPermission(user, QUALIFYING_PERMISSIONS) then
		return
	end
	if not Roles.hasPermission(user, "promptWarnings") then
		return
	end
	shownOutdatedTo[userIdKey] = true
	Prompt.warn(player, outdatedText, {openPage = "About", duration = 0})
end

local function maybeShowVetNotice(user: User.Class)
	local player = user.player
	if not player then
		return
	end
	local Vetting = require(services.Vetting) :: any
	local pending, unacked = Vetting.getCounts()
	local Roles = require(services.Roles) :: any
	local Config = require(services.Config) :: any
	local autoApprove = Config.getSetting("AutoApproveNewCommands") ~= false
	if Roles.hasPermission(user, "mayVetCommands") or Roles.hasPermission(user, "permitAll") then
		-- The pending reminder repeats every join so a waiting queue can't be forgotten
		if not autoApprove and pending > 0 then
			Prompt.info(player, `You have {pending} new command{if pending == 1 then "" else "s"} from HD Admin that need{if pending == 1 then "s" else ""} vetting. Click to view.`, {openVetting = true, duration = 0})
		elseif unacked > 0 then
			Prompt.info(player, `{unacked} new command{if unacked == 1 then "" else "s"}! Click to view.`, {openVetting = true, duration = 0})
		end
		return
	end
	if autoApprove or pending == 0 then
		return
	end
	if not Roles.hasPermission(user, "mayEditSettingsGame") then
		return
	end
	local roleInfo = User.everyone:get("RoleInfo")
	if typeof(roleInfo) == "table" then
		for _, role in roleInfo :: {[string]: any} do
			if typeof(role) == "table" and ((role :: any).mayVetCommands == true or (role :: any).mayEditAll == true) then
				return
			end
		end
	end
	Prompt.warn(player, `{pending} {if pending == 1 then "command is" else "commands are"} awaiting vetting but no role has the Vet Commands permission`, {openPage = "Roles", duration = 0})
end

local function watchGrants(user: User.Class)
	local knownKeys: {[string]: boolean} = {}
	local storedRoles = user.perm:get("PermanentRoles")
	if typeof(storedRoles) == "table" then
		for roleKey in storedRoles :: {[string]: any} do
			knownKeys[roleKey] = true
		end
	end
	local pendingKeys: {string} = {}
	local flushQueued = false
	local function flush()
		flushQueued = false
		local addedKeys = pendingKeys
		pendingKeys = {}
		local player = user.player
		if not user.isActive or not player then
			return
		end
		local Roles = require(services.Roles) :: any
		local latest = user.perm:get("PermanentRoles")
		local names = {}
		local giverUserId: number? = nil
		for _, roleKey in addedKeys do
			local role = Roles.getRole(roleKey)
			if not role or isInternalRole(role) or role.hide == true then
				continue
			end
			table.insert(names, colourRoleName(role))
			local entry = if typeof(latest) == "table" then (latest :: any)[roleKey] else nil
			if giverUserId == nil and typeof(entry) == "table" and typeof(entry.grantedBy) == "number" then
				giverUserId = entry.grantedBy
			end
		end
		if #names == 0 then
			return
		end
		local noun = if #names > 1 then "roles" else "role"
		local options: any = {openProfile = true}
		if giverUserId then
			options.fromUserId = giverUserId
		end
		Prompt.info(player, `You've received the {joinNames(names)} {noun}! Click to view your roles.`, options)
	end
	user.janitor:add(user.perm:onChange("PermanentRoles", function()
		local latest = user.perm:get("PermanentRoles")
		if typeof(latest) ~= "table" then
			return
		end
		local latestKeys: {[string]: boolean} = {}
		for roleKey in latest :: {[string]: any} do
			latestKeys[roleKey] = true
			if not knownKeys[roleKey] then
				table.insert(pendingKeys, roleKey)
			end
		end
		knownKeys = latestKeys
		if #pendingKeys > 0 and not flushQueued then
			flushQueued = true
			task.delay(GRANT_FLUSH_DELAY, flush)
		end
	end))
end

local function runJoinSequence(user: User.Class)
	if not user.isActive then
		return
	end
	maybeShowOutdated(user)
	maybeShowVetNotice(user)
	task.wait(0.5)
	if not user.isActive then
		return
	end
	showIntro(user)
end

local function watchUser(user: User.Class)
	if not user.player or watchedUsers[user] then
		return
	end
	watchedUsers[user] = true
	user.janitor:add(function()
		watchedUsers[user] = nil
	end)
	local introFired = false
	user.janitor:add(user.temp:onBind("RolesReady", function(value)
		if value ~= true or introFired then
			return
		end
		introFired = true
		watchGrants(user)
		local userIdKey = tostring(user.userId)
		if clientReadyUserIds[userIdKey] then
			task.spawn(runJoinSequence, user)
			return
		end
		pendingJoinUsers[userIdKey] = user
		task.delay(READY_FALLBACK, function()
			if pendingJoinUsers[userIdKey] == user then
				pendingJoinUsers[userIdKey] = nil
				runJoinSequence(user)
			end
		end)
	end))
end


-- SETUP
task.defer(function()
	local VERSION = require(frontend.Config.VERSION) :: any
	VERSION.getLatestVersion()
	versionIsOutdated = VERSION.isUpToDate() == false
	if not versionIsOutdated then
		return
	end
	outdatedText = VERSION.getOutdatedText(Framework.handshake)
	for _, user in User.getUsers() do
		maybeShowOutdated(user)
	end
end)

promptClientReadyRemote:onServerEvent(function(player: Player)
	local userIdKey = tostring(player.UserId)
	if clientReadyUserIds[userIdKey] then
		return
	end
	clientReadyUserIds[userIdKey] = true
	local pendingUser = pendingJoinUsers[userIdKey]
	if pendingUser then
		pendingJoinUsers[userIdKey] = nil
		task.spawn(runJoinSequence, pendingUser)
	end
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
	local userIdKey = tostring(player.UserId)
	clientReadyUserIds[userIdKey] = nil
	pendingJoinUsers[userIdKey] = nil
end)

User.userLoaded:Connect(watchUser)
for _, user in User.getUsers() do
	watchUser(user)
end


return Notices
