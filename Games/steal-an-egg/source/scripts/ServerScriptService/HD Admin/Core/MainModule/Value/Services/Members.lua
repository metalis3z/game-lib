--!strict

--[[

	This handles Members profile data and the netowrking involved in that

]]


-- LOCAL
local Members = {}
local Players = game:GetService("Players")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local State = require(modules.Objects.State)
local getUserInfoAsync = require(modules.PlayerUtil.getUserInfoAsync)
local fingerprintValue = require(modules.TableUtil.fingerprintValue)
local lastResyncFingerprint: {[Player]: string} = {}
local lastServerMemberFingerprint: {[Player]: string} = {}


-- TYPES
export type Member = {
	userId: number,
	userName: string,
	userDisplayName: string,
	userImage: string,
	roleKeys: {string},
	permanentRoleKeys: {[string]: true},
	giverRoleKeys: {[string]: true},
}


-- LOCAL FUNCTIONS
local function computeRealRoleKeys(targetUser: any): {string}
	local Roles = require(modules.Parent.Services.Roles) :: any
	local realRoles = Roles.getRealRolesForUser(targetUser)
	local keys: {string} = {}
	for _, role in realRoles do
		table.insert(keys, (role :: any).key)
	end
	return keys
end

local function computeEffectiveRoleKeys(targetUser: any): {string}
	local Roles = require(modules.Parent.Services.Roles) :: any
	local effectiveRoles = Roles.getRolesForUser(targetUser)
	local keys: {string} = {}
	for _, role in effectiveRoles do
		table.insert(keys, (role :: any).key)
	end
	return keys
end

local function computeGiverRoleKeys(targetUser: any): {[string]: true}
	local out: {[string]: true} = {}
	local tempRoles = (targetUser :: any).temp:get("Roles")
	if typeof(tempRoles) ~= "table" then return out end
	for _, roleKey in tempRoles do
		if typeof(roleKey) == "string" then
			out[roleKey] = true
		end
	end
	return out
end

local function computePermanentRoleKeys(targetUser: any): {[string]: true}
	local out: {[string]: true} = {}
	local permRoles = (targetUser :: any).perm:get("PermanentRoles")
	if typeof(permRoles) ~= "table" then return out end
	for roleKey, entry in permRoles do
		if typeof(roleKey) ~= "string" then continue end
		if entry == nil then continue end
		if typeof(entry) == "table" then
			local entryType = (entry :: any).type
			if entryType == "perm" or entryType == nil then
				out[roleKey] = true
			end
		else
			out[roleKey] = true
		end
	end
	return out
end

local function buildMember(player: Player, targetUser: any, preview: boolean): Member?
	local ok, info = getUserInfoAsync(player.UserId)
	if not ok or typeof(info) ~= "table" then return nil end
	local roleKeys = if preview
		then computeEffectiveRoleKeys(targetUser)
		else computeRealRoleKeys(targetUser)
	return {
		userId = (info :: any).userId,
		userName = (info :: any).userName,
		userDisplayName = (info :: any).userDisplayName,
		userImage = (info :: any).userImage,
		roleKeys = roleKeys,
		permanentRoleKeys = computePermanentRoleKeys(targetUser),
		giverRoleKeys = computeGiverRoleKeys(targetUser),
	}
end

local function roleKeysFingerprint(roleKeys: {string}): string
	local sorted = table.clone(roleKeys)
	table.sort(sorted)
	return table.concat(sorted, ",")
end

local function refreshMember(player: Player)
	local targetUser = User.getUser(player)
	if not targetUser then return end
	local selfMember = buildMember(player, targetUser, true)
	if selfMember then
		(targetUser :: any).temp:set("YouMember", selfMember)
		local fingerprint = roleKeysFingerprint((selfMember :: any).roleKeys)
		if lastResyncFingerprint[player] ~= fingerprint then
			lastResyncFingerprint[player] = fingerprint
			task.defer(function()
				if player.Parent then
					User.everyone:resyncPlayer(player)
				end
			end)
		end
	end
	local publicMember = buildMember(player, targetUser, false)
	if publicMember then
		-- Skip the re-write when nothing visible changed, otherwise preview
		-- toggles and temp-role replicate identical entries to every client
		local fingerprint = fingerprintValue(publicMember)
		if lastServerMemberFingerprint[player] ~= fingerprint then
			lastServerMemberFingerprint[player] = fingerprint
			User.everyone:set("ServerMembers", tostring(player.UserId), publicMember)
		end
	end
end

local function removeMember(userId: number)
	User.everyone:set("ServerMembers", tostring(userId), nil)
end

local function attachRefreshListeners(player: Player, targetUser: any)
	local janitor = (targetUser :: any).janitor
	janitor:add((targetUser :: any).perm:onChange("PermanentRoles", function()
		refreshMember(player)
	end))
	janitor:add((targetUser :: any).temp:onChange("Roles", function()
		refreshMember(player)
	end))
	janitor:add((targetUser :: any).temp:onChange("PreviewingRoles", function()
		refreshMember(player)
	end))
end

local function onPlayerAdded(player: Player)
	local success, targetUser = User.getUserAsync(player)
	if not success or not targetUser then return end
	local janitor = (targetUser :: any).janitor
	local fired = false
	local connection = (targetUser :: any).temp:onBind("RolesReady", function(value)
		if value ~= true or fired then return end
		fired = true
		refreshMember(player)
		attachRefreshListeners(player, targetUser)
	end)
	janitor:add(function()
		if connection then connection.Disconnect() end
	end)
end


-- MEMBER FUNCTIONS
function Members.update()
	for _, player in Players:GetPlayers() do
		if User.getUser(player) then
			refreshMember(player)
		end
	end
end


-- GLOBAL MEMBERS
local function buildPermanentMember(userIdStr: string, entry: any): Member?
	if typeof(entry) ~= "table" then return nil end
	local userInfo = (entry :: any).UserInfo
	local permRoles = (entry :: any).PermanentRoles
	if typeof(permRoles) ~= "table" or next(permRoles) == nil then return nil end
	if typeof(userInfo) ~= "table" then
		userInfo = {userId = tonumber(userIdStr) or userIdStr}
	end
	local roleInfo = User.everyone:get("RoleInfo")
	local ordered: {{key: string, rank: number}} = {}
	local permSet: {[string]: true} = {}
	for roleKey, _ in permRoles :: {[string]: any} do
		if typeof(roleKey) ~= "string" then continue end
		permSet[roleKey] = true
		local roleData: any = if typeof(roleInfo) == "table" then (roleInfo :: any)[roleKey] else nil
		local rank: number = if typeof(roleData) == "table" and typeof((roleData :: any).rank) == "number"
			then (roleData :: any).rank else 0
		table.insert(ordered, {key = roleKey, rank = rank})
	end
	table.sort(ordered, function(entryA, entryB) return entryA.rank > entryB.rank end)
	local roleKeys: {string} = {}
	for _, entry in ordered do
		table.insert(roleKeys, entry.key)
	end
	local userId = (userInfo :: any).userId
	return {
		userId = userId,
		userName = (userInfo :: any).userName or tostring(userId),
		userDisplayName = (userInfo :: any).userDisplayName or tostring(userId),
		userImage = `rbxthumb://type=AvatarBust&id={userId}&w=150&h=150`,
		roleKeys = roleKeys,
		permanentRoleKeys = permSet,
		giverRoleKeys = {},
	}
end

local permanentMembersLoaded = false
function Members.updatePermanent()
	if permanentMembersLoaded then return end
	permanentMembersLoaded = true
	task.spawn(function()
		-- Create the MemberStore user if it doesn't exist yet
		if not User.getUser("Members", true) then
			User.new("Members", "MemberStore")
		end
		local ok, memberUser = User.getUserAsync("Members")
		if not ok or not memberUser then
			permanentMembersLoaded = false
			return
		end
		local lastPublished: {[string]: string} = {}
		local function rebuild()
			local roster: {[string]: Member} = {}
			local all = (memberUser :: any).perm:getAll()
			if typeof(all) == "table" then
				for userIdStr, entry in all do
					if typeof(userIdStr) ~= "string" then continue end
					local member = buildPermanentMember(userIdStr, entry)
					if member then
						roster[userIdStr] = member
					end
				end
			end
			local nextPublished: {[string]: string} = {}
			for userIdStr, member in roster do
				local fingerprint = fingerprintValue(member)
				nextPublished[userIdStr] = fingerprint
				if lastPublished[userIdStr] ~= fingerprint then
					User.everyone:set("PermanentMembers", userIdStr, member)
				end
			end
			for userIdStr in lastPublished do
				if nextPublished[userIdStr] == nil then
					User.everyone:set("PermanentMembers", userIdStr, nil)
				end
			end
			lastPublished = nextPublished
		end

		local rebuildQueued = false
		local function queueRebuild()
			if rebuildQueued then return end
			rebuildQueued = true
			task.defer(function()
				rebuildQueued = false
				rebuild()
			end)
		end

		rebuild()
		local janitor = (memberUser :: any).janitor
		janitor:add((memberUser :: any).perm:onAnyChange(queueRebuild))
		-- Also rebuild if RoleInfo changes, like a role getting renamed or
		-- deleted, so role ordering and membership stay accurate
		janitor:add(User.everyone:onChange("RoleInfo", queueRebuild))
	end)
end


-- SETUP
-- This restricts who can see what
local getStateVerifier = require(modules.VerifyUtil.getStateVerifier)
User.everyone:verify(getStateVerifier("ServerMembers", "Exclude", {}, nil, "MembersServer"))
User.everyone:verify(getStateVerifier("PermanentMembers", "Exclude", {}, nil, "MembersPermanent"))

-- Set empty tables so the verifier has something to filter on the very first client read
User.everyone:set("ServerMembers", {})
User.everyone:set("PermanentMembers", {})

-- Make sure data fetched via User.everyone is built before the client first reads it
State.verifyFirstFetch("ServerMembers", Members.update)
State.verifyFirstFetch("PermanentMembers", Members.updatePermanent)

-- This listens for new players
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(function(player)
	lastResyncFingerprint[player] = nil
	lastServerMemberFingerprint[player] = nil
	removeMember(player.UserId)
end)
for _, player in Players:GetPlayers() do
	task.spawn(onPlayerAdded, player)
end


return Members
