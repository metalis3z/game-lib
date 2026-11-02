--!strict
-- CONFIG
local CLIENT_PROPERTIES_TO_EXCLUDE = {
	
}

local CLIENT_PROPERTIES_TO_PREVIEW = {
	"key",
	"name",
	"hide",
	"color",
	"internal",
}


-- LOCAL
local Roles = {}
local RunService = game:GetService("RunService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local State = require(modules.Objects.State)
local sharedTypes = require(modules.References.sharedTypes)
local defaultRole: any = require(modules.References.defaultRole)
local isInternalRole = require(modules.RoleUtil.isInternalRole)
local autoUnlockPerms = require(modules.RoleUtil.autoUnlockPerms)
local RoleLockRules = require(modules.Parent.Controllers.UI.Config.RoleLockRules)
local Hydration = require(script.Hydration)
local Grants = require(script.Grants)
local Preview = require(script.Preview)
local Remotes = require(script.Remotes)


-- PRESETUP
-- These run their own setups, so they must be required at startup
require(script.Purchases)
require(script.GroupJoin)
require(script.BoosterOffer)
require(script.Notices)


-- TYPES
export type Role = typeof(defaultRole)

export type ActionOptions = {
	callerUser: User.Class?,
	callerUserId: number?,
	scope: sharedTypes.ActionScope?,
	duration: number?,
	reason: string?,
}


-- PUBLIC
Roles.defaultRole = defaultRole


-- LOCAL FUNCTIONS
-- Missing keys are silently dropped which is useful when a previewed role gets deleted
local function hydrateKeys(roleKeys: {string}): {Role}
	local roleInfo = User.everyone:get("RoleInfo")
	local result: {Role} = {}
	if typeof(roleInfo) ~= "table" then return result end
	for _, key in roleKeys do
		local role = (roleInfo :: any)[key]
		if typeof(role) == "table" then
			table.insert(result, role :: Role)
		end
	end
	table.sort(result, function(roleA: Role, roleB: Role): boolean
		local rankA = (roleA :: any).rank or 0
		local rankB = (roleB :: any).rank or 0
		if rankA ~= rankB then return rankA > rankB end
		return (roleA :: any).key < (roleB :: any).key
	end)
	return result
end

local function getPreviewKeys(user: any?): {string}?
	if not user then return nil end
	local preview = user.temp:get("PreviewingRoles")
	if typeof(preview) == "table" and #(preview :: {any}) > 0 then
		return preview :: {string}
	end
	return nil
end

local function resolveOptions(options: ActionOptions?): {
	callerUser: User.Class?,
	callerUserId: number?,
	scope: string,
	expiresAt: number?,
	reason: string?,
}
	options = options or ({} :: any)
	local opts: any = options
	local callerUser: any = opts.callerUser
	local callerUserId: any = opts.callerUserId
	if not callerUser and callerUserId then
		callerUser = User.getUser(callerUserId, true)
	end
	if not callerUserId and callerUser then
		callerUserId = (callerUser :: any).userId
	end
	local expiresAt: number? = nil
	if typeof(opts.duration) == "number" and opts.duration > 0 then
		expiresAt = os.time() + opts.duration
	end
	return {
		callerUser = callerUser,
		callerUserId = callerUserId,
		scope = opts.scope or "perm",
		expiresAt = expiresAt,
		reason = opts.reason,
	}
end

local function getCallerRankAsync(opts: any): (number?, string?)
	if opts.callerUser then
		return Roles.getRealTopRank(opts.callerUser), nil
	end
	if opts.callerUserId then
		local rank, reliable = Roles.getEffectiveTopRankByUserIdAsync(opts.callerUserId)
		if not reliable then
			return nil, "Couldn't verify your rank right now (a group/gamepass lookup failed) - please try again"
		end
		return rank, nil
	end
	return nil, nil
end

local function setOnLoadedUser(targetUserId: number, roleKey: string, entry: any?): (boolean, string?)
	local targetUser: any = User.getUserByUserId(targetUserId)
	if not targetUser then
		return false, `Target {targetUserId} is not loaded on this server`
	end
	targetUser.perm:set({"PermanentRoles", roleKey}, entry)
	return true, nil
end


-- STANDARD ROLE FUNCTIONS
-- Yields on the very first call per server (while the GameStore user finishes loading)
function Roles.updateRoles(forceUpdate: boolean?): boolean
	return Hydration.update(forceUpdate, function()
		for _, user in User.getUsers() do
			Roles.revalidatePreview(user)
		end
		if RunService:IsServer() then
			Roles.permitRoleProducts()
		end
	end)
end

-- This is what lets the unlock button on the Commands page actually fire a purchase prompt
function Roles.permitRoleProducts()
	if not RunService:IsServer() then return end
	local Assets = require(modules.Parent.Services.Assets) :: any
	local Presets = require(modules.Parent.Controllers.UI.Config.Presets) :: any
	local roleInfo = User.everyone:get("RoleInfo")
	if typeof(roleInfo) ~= "table" then return end
	for _, role in roleInfo :: any do
		local products = (role :: any).giveToProducts
		if typeof(products) ~= "table" then continue end
		for _, entry in products :: any do
			if typeof(entry) ~= "table" then continue end
			local et = (entry :: any).type
			if et == "GamePass" or et == "Asset" or et == "Bundle" then
				local id = (entry :: any).id
				if typeof(id) == "number" then
					Assets.permitAsset(id)
				end
			elseif et == "Preset" then
				local presetKey = (entry :: any).preset
				if typeof(presetKey) == "string" then
					local preset = Presets.products[presetKey]
					if preset and typeof(preset.id) == "number" then
						Assets.permitAsset(preset.id)
					end
				end
			end
		end
	end
end

function Roles.getRole(name: string): Role?
	Roles.updateRoles()
	local exact = User.everyone:get("RoleInfo", name) :: Role?
	if exact then return exact end
	local lowerName = name:lower()
	if lowerName ~= name then
		local lower = User.everyone:get("RoleInfo", lowerName) :: Role?
		if lower then return lower end
	end
	local roleInfo = User.everyone:get("RoleInfo")
	if typeof(roleInfo) == "table" then
		for key, role in roleInfo :: {[string]: any} do
			if typeof(key) == "string" and key:lower() == lowerName then
				return role :: Role?
			end
		end
	end
	return nil
end

function Roles.getRoles()
	Roles.updateRoles()
	return Hydration.getOrdered()
end

function Roles.getOwnedRoles(user: User.Class?): ({string}, {[string]: boolean})
	if not user then
		return {}, {}
	end
	local ownedRolesDict = {}
	local tempRoles = user.temp:get("Roles") or {}
	local permRoles = user.perm:get("PermanentRoles") or {}
	for _, roleKey in tempRoles do
		ownedRolesDict[roleKey] = true
	end
	for roleKey, _ in permRoles do
		ownedRolesDict[roleKey] = true
	end
	local ownedRolesArray = {}
	for roleName, _ in ownedRolesDict do
		table.insert(ownedRolesArray, roleName)
	end
	return ownedRolesArray, ownedRolesDict
end


-- USER-ROLE-UTILITY FUNCTIONS
local function internalRoleKeys(): {string}
	local out: {string} = {}
	local roleInfo = User.everyone:get("RoleInfo")
	if typeof(roleInfo) == "table" then
		for key, role in roleInfo :: {[string]: any} do
			if isInternalRole(role) then
				table.insert(out, key)
			end
		end
	end
	return out
end

function Roles.qualifiesForAutoUnlock(user: User.Class?): boolean
	if not user then return false end
	if RunService:IsStudio() then return true end
	-- Read the real owned roles so previewing a lesser role can't drop the grant
	local owned, _ = Roles.getOwnedRoles(user)
	for _, key in owned do
		local role = User.everyone:get("RoleInfo", key)
		if typeof(role) == "table" then
			for _, permKey in autoUnlockPerms do
				if RoleLockRules.isEffectivelyEnabledOnRole(role, permKey) then
					return true
				end
			end
		end
	end
	return false
end

local function withAutoBooster(keys: {string}): {string}
	local present: {[string]: true} = {}
	for _, key in keys do present[key] = true end
	local out: {string}? = nil
	for _, key in internalRoleKeys() do
		if not present[key] then
			out = out or table.clone(keys)
			table.insert(out :: {string}, key)
			present[key] = true
		end
	end
	return out or keys
end

function Roles.getRolesForUser(user: User.Class?): {Role}
	Roles.updateRoles()
	if not user then return {} end
	local preview = getPreviewKeys(user)
	local keys = if preview then preview else (Roles.getOwnedRoles(user))
	if Roles.qualifiesForAutoUnlock(user) then
		keys = withAutoBooster(keys)
	end
	return hydrateKeys(keys)
end

function Roles.getRealRolesForUser(user: User.Class?): {Role}
	Roles.updateRoles()
	if not user then return {} end
	local owned, _ = Roles.getOwnedRoles(user)
	return hydrateKeys(owned)
end

function Roles.getTopRole(user: User.Class?): Role?
	return Roles.getRolesForUser(user)[1]
end

function Roles.getRealTopRole(user: User.Class?): Role?
	return Roles.getRealRolesForUser(user)[1]
end

function Roles.getTopRank(user: User.Class?): number
	local top = Roles.getTopRole(user)
	if not top then return 0 end
	return (top :: any).rank or 0
end

function Roles.getRealTopRank(user: User.Class?): number
	local top = Roles.getRealTopRole(user)
	if not top then return 0 end
	return (top :: any).rank or 0
end

function Roles.hasRole(user: User.Class?, roleKey: string): boolean
	if not user or typeof(roleKey) ~= "string" then return false end
	local preview = getPreviewKeys(user)
	if preview then
		for _, previewKey in preview do
			if previewKey == roleKey then return true end
		end
		return false
	end
	local _, ownedDict = Roles.getOwnedRoles(user)
	return ownedDict[roleKey] == true
end

function Roles.hasRealRole(user: User.Class?, roleKey: string): boolean
	if not user or typeof(roleKey) ~= "string" then return false end
	local _, ownedDict = Roles.getOwnedRoles(user)
	return ownedDict[roleKey] == true
end


-- USER-ROLE PERMISSION FUNCTIONS
function Roles.hasPermission(user: User.Class?, permissionKey: string): boolean
	if typeof(permissionKey) ~= "string" then return false end
	if user and (user :: any).isServerUser then return true end
	local roles = Roles.getRolesForUser(user)
	for _, role in roles do
		if RoleLockRules.isEffectivelyEnabledOnRole(role, permissionKey) then
			return true
		end
	end
	return false
end

function Roles.hasAnyPermission(user: User.Class?, permissionKeys: {string}): boolean
	if typeof(permissionKeys) ~= "table" or #permissionKeys == 0 then return false end
	local roles = Roles.getRolesForUser(user)
	for _, role in roles do
		for _, key in permissionKeys do
			if RoleLockRules.isEffectivelyEnabledOnRole(role, key) then
				return true
			end
		end
	end
	return false
end

function Roles.hasAllPermissions(user: User.Class?, permissionKeys: {string}): boolean
	if typeof(permissionKeys) ~= "table" then return false end
	if #permissionKeys == 0 then return true end
	local roles = Roles.getRolesForUser(user)
	for _, key in permissionKeys do
		local satisfied = false
		for _, role in roles do
			if RoleLockRules.isEffectivelyEnabledOnRole(role, key) then
				satisfied = true
				break
			end
		end
		if not satisfied then return false end
	end
	return true
end


-- ROLE-SPECIFIC PERMISSIONS
function Roles.isForcedOn(role: Role, permissionKey: string): boolean
	return RoleLockRules.isForcedOnRole(role, permissionKey)
end


-- PAGE-VIEW PERMISSIONS
function Roles.canViewPage(user: User.Class?, pageKey: string): boolean
	if not user or typeof(pageKey) ~= "string" then return false end
	if Roles.hasPermission(user, "mayViewAll") then return true end
	local roles = Roles.getRolesForUser(user)
	for _, role in roles do
		local pages = (role :: any).mayViewPages
		if typeof(pages) ~= "table" then continue end
		for _, page in pages :: {string} do
			if page == "All" or page == pageKey then return true end
		end
	end
	return false
end


-- COMMAND-ROLE PERMISSIONS
function Roles.isCommandVetted(command: any, user: User.Class?): (boolean, string?)
	local isVettable = require(modules.CommandUtil.isVettable)
	if not isVettable(command) then
		return true
	end
	local Vetting = require(modules.Parent.Services.Vetting) :: any
	local identity = (command :: any).identity or (command :: any).key
	local status = if typeof(identity) == "string" then Vetting.getStatus(identity) else nil
	if status == "disabled" then
		return false, "This command was disabled by this game via Vet Commands."
	end
	-- Pending only ever applies to internally loaded commands
	if status == "pending" and (command :: any).fromInternal == true then
		if user and (Roles.hasPermission(user, "mayVetCommands") or Roles.hasPermission(user, "permitAll")) then
			return true
		end
		return false, "This command is awaiting vetting"
	end
	return true
end

function Roles.canUseCommand(user: User.Class?, commandOrKey: any): (boolean, string?)
	if not user then return false, "No user" end
	if (user :: any).isServerUser then return true, nil end
	local command: any
	if typeof(commandOrKey) == "string" then
		local Commands = require(modules.Parent.Services.Commands) :: any
		command = Commands.getCommand(commandOrKey)
		if not command then return false, "Unknown command" end
	elseif typeof(commandOrKey) == "table" then
		command = commandOrKey
	else
		return false, "Invalid command argument"
	end
	local vetted, vetReason = Roles.isCommandVetted(command, user)
	if not vetted then
		return false, vetReason or "This command is awaiting vetting"
	end
	if Roles.hasPermission(user, "permitAll") then
		return true, nil
	end
	local cmdRoles = (command :: any).roles
	if typeof(cmdRoles) ~= "table" then
		return false, "Command has no role mapping"
	end
	local userRoleKeys: {[string]: boolean} = {}
	local roles = Roles.getRolesForUser(user)
	for _, role in roles do
		userRoleKeys[(role :: any).key] = true
	end
	for _, cmdRoleKey in cmdRoles do
		if typeof(cmdRoleKey) == "string" and userRoleKeys[cmdRoleKey] then
			return true, nil
		end
	end
	return false, "Your role doesn't have access to this command"
end

function Roles.getUsableCommands(user: User.Class?): {any}
	local Commands = require(modules.Parent.Services.Commands) :: any
	local all = Commands.getCommandsArray()
	local out: {any} = {}
	if typeof(all) ~= "table" then return out end
	for _, cmd in all do
		local ok = Roles.canUseCommand(user, cmd)
		if ok then
			table.insert(out, cmd)
		end
	end
	return out
end

function Roles.canViewCommand(user: User.Class?, command: any): boolean
	local ok = Roles.canUseCommand(user, command)
	if ok then return true end
	return Roles.hasPermission(user, "mayViewUnavailableCommands")
end


-- RANK-RELATIVE PERMISSIONS
function Roles.canEditRole(user: User.Class?, targetRoleKey: string): boolean
	if not user or typeof(targetRoleKey) ~= "string" then return false end
	if not Roles.hasPermission(user, "mayEditRoles") then return false end
	local targetRole = Roles.getRole(targetRoleKey)
	if not targetRole then return false end
	if isInternalRole(targetRole) then return false end
	local targetRank = (targetRole :: any).rank or 0
	return Roles.getRealTopRank(user) > targetRank
end

function Roles.canGrantPermission(user: User.Class?, permKey: string): boolean
	if not user or typeof(permKey) ~= "string" then return false end
	if Roles.hasPermission(user, "mayEditAll") then return true end
	return Roles.hasPermission(user, permKey)
end

-- This stops two players of the same top role from moderating each other
function Roles.canModerateUser(user: User.Class?, targetUser: User.Class?): boolean
	if not user or not targetUser then return false end
	return Roles.getRealTopRank(user) > Roles.getRealTopRank(targetUser)
end

function Roles.canGiveRole(user: User.Class?, roleKey: string): boolean
	if not user or typeof(roleKey) ~= "string" then return false end
	local role = Roles.getRole(roleKey)
	if not role then return false end
	local roleRank: number = if typeof((role :: any).rank) == "number" then (role :: any).rank else 0
	return Roles.getRealTopRank(user) > roleRank
end

function Roles.canTakeRole(user: User.Class?, roleKey: string): boolean
	if not user or typeof(roleKey) ~= "string" then return false end
	local role = Roles.getRole(roleKey)
	if not role then return false end
	local roleRank: number = if typeof((role :: any).rank) == "number" then (role :: any).rank else 0
	return Roles.getRealTopRank(user) > roleRank
end

function Roles.canTarget(user: User.Class?, targetUser: User.Class?): boolean
	if not user or not targetUser then return false end
	if user == targetUser then return true end
	if Roles.hasPermission(user, "permitAll") then return true end
	if not Roles.hasPermission(user, "permitTargetingOthers") then return false end
	return Roles.getRealTopRank(user) > Roles.getRealTopRank(targetUser)
end

function Roles.getEffectiveTopRankByUserIdAsync(userId: number): (number, boolean)
	if typeof(userId) ~= "number" or userId <= 0 then return 0, true end
	-- A senior previewing a junior role must NOT become moderatable or strippable by
	-- someone their real rank outranks
	local loaded = User.getUserByUserId(userId, true)
	if loaded and (loaded :: any).isLoaded then
		return Roles.getRealTopRank(loaded), true
	end
	Roles.updateRoles()
	local allRoles = Hydration.getOrdered()
	local roleInfo = User.everyone:get("RoleInfo")
	if typeof(roleInfo) ~= "table" then return 0, true end
	local maxRank = 0
	-- (1) First we gather the giver roles (the ones players qualify for through a group,
	-- gamepass, friendship, being the creator, etc). qualifiesForRole works these out even
	-- when no Player is loaded
	local errorSink = { failed = false }
	local giverGranted = Grants.resolveRolesForUserId(userId, allRoles, { errorSink = errorSink })
	for _, roleKey in giverGranted do
		local roleEntry: any = (roleInfo :: any)[roleKey]
		if typeof(roleEntry) == "table" then
			local rank: number = if typeof((roleEntry :: any).rank) == "number" then (roleEntry :: any).rank else 0
			if rank > maxRank then maxRank = rank end
		end
	end
	-- (2) We read saved perm roles from MemberStore and NOT the target's own PlayerStore,
	-- as loading that would session-lock them
	local Members = require(modules.Parent.Services.Members) :: any
	if typeof(Members.updatePermanent) == "function" then
		Members.updatePermanent()
	end
	if not User.getUser("Members", true) then
		User.new("Members", "MemberStore")
	end
	local ok, memberUser = User.getUserAsync("Members")
	if ok and memberUser then
		local entry: any = (memberUser :: any).perm:get(tostring(userId))
		if typeof(entry) == "table" and typeof((entry :: any).PermanentRoles) == "table" then
			for permRoleKey in (entry :: any).PermanentRoles do
				if typeof(permRoleKey) ~= "string" then continue end
				local roleEntry: any = (roleInfo :: any)[permRoleKey]
				if typeof(roleEntry) == "table" then
					local rank: number = if typeof((roleEntry :: any).rank) == "number" then (roleEntry :: any).rank else 0
					if rank > maxRank then maxRank = rank end
				end
			end
		end
	end
	return maxRank, not errorSink.failed
end


-- USER-ROLE NUMERIC PERMISSIONS FUNCTIONS
function Roles.getHighestValue(user: User.Class?, numericFieldKey: string): number
	if typeof(numericFieldKey) ~= "string" then return 0 end
	local isLimitField = numericFieldKey:sub(1, 5) == "limit"
	if isLimitField and Roles.hasPermission(user, "permitBypassLimits") then
		return math.huge
	end
	local fallback = defaultRole[numericFieldKey]
	if typeof(fallback) ~= "number" then fallback = 0 end
	local roles = Roles.getRolesForUser(user)
	if #roles == 0 then return fallback end
	local best: number? = nil
	for _, role in roles do
		if isLimitField and isInternalRole(role) then
			continue
		end
		local value = (role :: any)[numericFieldKey]
		if typeof(value) == "number" then
			if best == nil or value > best then
				best = value
			end
		end
	end
	return if best ~= nil then best else fallback
end


-- ROLE-GIVER FUNCTIONS
function Roles.resolveRolesForPlayer(player: Player, opts: Grants.Opts?): {string}
	Roles.updateRoles()
	return Grants.resolveRolesForPlayer(player, Hydration.getOrdered(), opts)
end
Roles.qualifiesForRole = Grants.qualifiesForRole

function Roles.giveRoleAsync(
	targetUserId: number,
	roleKey: string,
	options: ActionOptions?
): (boolean, string?)
	if typeof(targetUserId) ~= "number" then
		return false, "targetUserId must be a number"
	end
	if typeof(roleKey) ~= "string" or roleKey == "" then
		return false, "roleKey must be a non-empty string"
	end
	local role = Roles.getRole(roleKey)
	if not role then
		return false, `Unknown role '{roleKey}'`
	end
	local opts = resolveOptions(options)
	local callerRank, callerRankError = getCallerRankAsync(opts)
	if callerRankError then
		return false, callerRankError
	end
	if callerRank then
		local roleRank: number = if typeof((role :: any).rank) == "number" then (role :: any).rank else 0
		if callerRank <= roleRank then
			return false, `Cannot grant role '{roleKey}' - its rank ({roleRank}) is at or above your own ({callerRank})`
		end
		-- We skip this rank check when you're targeting yourself, otherwise it would
		-- stop you managing your own roles at your current rank
		if opts.callerUserId ~= targetUserId then
			local targetRank, rankReliable = Roles.getEffectiveTopRankByUserIdAsync(targetUserId)
			if not rankReliable then
				return false, "Couldn't verify the target's rank right now (a group/gamepass lookup failed) - please try again"
			end
			if callerRank <= targetRank then
				return false, `Cannot grant to user {targetUserId} - their rank ({targetRank}) is at or above your own ({callerRank})`
			end
		end
	end
	local grantEntry = {
		type      = opts.scope,
		grantedBy = opts.callerUserId or "system",
		grantedAt = os.time(),
		expiresAt = opts.expiresAt,
		reason    = opts.reason,
	}
	if opts.scope == "server" then
		grantEntry.grantedOnJobId = if game.JobId == "" then "Studio" else game.JobId
	end
	if opts.scope == "perm" then
		local getUserInfoAsync = require(modules.PlayerUtil.getUserInfoAsync)
		local slim = {
			userId = targetUserId :: any,
			userName = tostring(targetUserId),
			userDisplayName = tostring(targetUserId),
		}
		local userInfoOk, userInfo = getUserInfoAsync(targetUserId)
		if userInfoOk and typeof(userInfo) == "table" then
			slim = {
				userId = (userInfo :: any).userId,
				userName = (userInfo :: any).userName,
				userDisplayName = (userInfo :: any).userDisplayName,
			}
		end
		local extras: { { path: {string}, value: any } } = {
			{ path = {tostring(targetUserId), "UserInfo"}, value = slim },
		}
		local Permanent = require(modules.DataStores.Permanent)
		return Permanent.applyAsync({
			targetUserId    = targetUserId,
			playerStorePath = {"PermanentRoles", roleKey},
			globalStoreName = "MemberStore",
			globalUserKey   = "Members",
			globalStorePath = {tostring(targetUserId), "PermanentRoles", roleKey},
			globalExtraWrites = extras,
			payload         = grantEntry,
		})
	end
	if opts.scope == "server" then
		return setOnLoadedUser(targetUserId, roleKey, grantEntry)
	end
	return false, `Unknown scope '{tostring(opts.scope)}'`
end

function Roles.takeRoleAsync(
	targetUserId: number,
	roleKey: string,
	options: ActionOptions?
): (boolean, string?)
	if typeof(targetUserId) ~= "number" then
		return false, "targetUserId must be a number"
	end
	if typeof(roleKey) ~= "string" or roleKey == "" then
		return false, "roleKey must be a non-empty string"
	end
	local role = Roles.getRole(roleKey)
	if not role then
		return false, `Unknown role '{roleKey}'`
	end
	local opts = resolveOptions(options)
	local callerRank, callerRankError = getCallerRankAsync(opts)
	if callerRankError then
		return false, callerRankError
	end
	if callerRank then
		local roleRank: number = if typeof((role :: any).rank) == "number" then (role :: any).rank else 0
		if callerRank <= roleRank then
			return false, `Cannot revoke role '{roleKey}' - its rank ({roleRank}) is at or above your own ({callerRank})`
		end
		if opts.callerUserId ~= targetUserId then
			local targetRank, rankReliable = Roles.getEffectiveTopRankByUserIdAsync(targetUserId)
			if not rankReliable then
				return false, "Couldn't verify the target's rank right now (a group/gamepass lookup failed) - please try again"
			end
			if callerRank <= targetRank then
				return false, `Cannot revoke from user {targetUserId} - their rank ({targetRank}) is at or above your own ({callerRank})`
			end
		end
	end

	if opts.scope == "server" then
		local targetUser: any = User.getUserByUserId(targetUserId)
		if not targetUser then
			return true, nil
		end
		local existing = targetUser.perm:get({"PermanentRoles", roleKey})
		if typeof(existing) == "table" and (existing :: any).type == "server" then
			targetUser.perm:set({"PermanentRoles", roleKey}, nil)
		end
		return true, nil
	end

	-- 1. First we clear the perm record from PlayerStore and MemberStore
	local Permanent = require(modules.DataStores.Permanent)
	local permOk, permErr = Permanent.removeAsync({
		targetUserId    = targetUserId,
		playerStorePath = {"PermanentRoles", roleKey},
		globalStoreName = "MemberStore",
		globalUserKey   = "Members",
		globalStorePath = {tostring(targetUserId), "PermanentRoles", roleKey},
		-- After the role record is removed from MemberStore, we drop the
		-- target's UserInfo too if no perm grants remain, which keeps the
		-- permanent table clean of ghost entries
		globalAfterWrite = function(memberUser)
			local userIdStr = tostring(targetUserId)
			local entry = (memberUser :: any).perm:get(userIdStr)
			if typeof(entry) ~= "table" then return end
			local remaining = (entry :: any).PermanentRoles
			if typeof(remaining) ~= "table" or next(remaining) == nil then
				(memberUser :: any).perm:set({userIdStr, "UserInfo"}, nil)
			end
		end,
	})

	local serverOk, serverErr = setOnLoadedUser(targetUserId, roleKey, nil)
	if not permOk and not serverOk then
		return false, permErr or serverErr or "Failed to take role"
	end
	return true, nil
end


-- PREVIEW ROLE FUNCTIONS
Roles.canPreview = Preview.canPreview
Roles.setPreviewingRoles = Preview.setPreviewingRoles
Roles.clearPreviewingRoles = Preview.clearPreviewingRoles
Roles.isPreviewing = Preview.isPreviewing
Roles.getPreviewingRoles = Preview.getPreviewingRoles
Roles.revalidatePreview = Preview.revalidatePreview
Roles.attachPreviewAutoClear = Preview.attachPreviewAutoClear


-- SETUP
local getStateVerifier = require(modules.VerifyUtil.getStateVerifier)
User.everyone:verify(getStateVerifier(
	"Roles",
	"OnlyInclude",
	CLIENT_PROPERTIES_TO_PREVIEW
))
User.everyone:verify(getStateVerifier(
	"RoleInfo",
	"Exclude",
	CLIENT_PROPERTIES_TO_EXCLUDE,
	nil,
	nil,
	{"giveToUsers"},
	"Roles"
))
User.everyone:verify(getStateVerifier(
	"SavedRoles",
	"OnlyInclude",
	CLIENT_PROPERTIES_TO_PREVIEW
))
User.everyone:verify(getStateVerifier(
	"SavedRoleInfo",
	"Exclude",
	CLIENT_PROPERTIES_TO_EXCLUDE,
	nil,
	nil,
	{"giveToUsers"},
	"Roles"
))
User.everyone:verify(getStateVerifier(
	"DefaultRoleInfo",
	"Exclude",
	CLIENT_PROPERTIES_TO_EXCLUDE,
	nil,
	nil,
	{"giveToUsers"},
	"Roles"
))

-- Make sure data fetched via User.everyone is built before the client first reads it
State.verifyFirstFetch("Roles", Roles.updateRoles)
State.verifyFirstFetch("RoleInfo", Roles.updateRoles)
State.verifyFirstFetch("SavedRoles", Roles.updateRoles)
State.verifyFirstFetch("SavedRoleInfo", Roles.updateRoles)

-- This is essential to register all remote handlers
Remotes.setup(Roles, Hydration)


return Roles