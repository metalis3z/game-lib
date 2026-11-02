--!strict

--[[

	This handles the prompting of a player to join a group, then granting
	their group roles without them having to rejoin

]]


-- CONFIG
local POLL_INTERVAL = 6
local POLL_TIMEOUT = 90
local HD_ADMIN_GROUP_ID = 4676369
local MAX_INFLIGHT_PER_USER = 4


-- LOCAL
local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Remote = require(modules.Objects.Remote)
local Prompt = require(modules.Prompt)
local User = require(modules.Objects.User)
local areValuesEqual = require(modules.DataUtil.areValuesEqual)
local isNumberSafe = require(modules.VerifyUtil.isNumberSafe)
local GroupGate = require(script.Parent.GroupGate)
local GroupJoin = {}
local inFlight: { [string]: boolean } = {}
local groupNameCache: { [number]: string } = {}
local promptJoinGroup: Remote.Class? = nil


-- LOCAL FUNCTIONS
local function getRoles(): any
	return require(script.Parent) :: any
end

-- Only verify groups the game actually uses, otherwise a client could burn the group API budget with spam groupIds
local function isPermittedGroup(groupId: number): boolean
	if groupId == HD_ADMIN_GROUP_ID then return true end
	local roleInfo = User.everyone:get("RoleInfo")
	if typeof(roleInfo) ~= "table" then return false end
	for _, role in roleInfo :: any do
		local giveToGroups = (role :: any).giveToGroups
		if typeof(giveToGroups) ~= "table" then continue end
		for _, entry in giveToGroups :: any do
			if typeof(entry) == "table" and tonumber((entry :: any).groupId) == groupId then
				return true
			end
		end
	end
	return false
end

local function inFlightCountFor(userId: number): number
	local count = 0
	local prefix = `{userId}:`
	for key in inFlight do
		if string.sub(key, 1, #prefix) == prefix then
			count += 1
		end
	end
	return count
end

local function groupNameFor(groupId: number): string
	local cached = groupNameCache[groupId]
	if cached then return cached end
	local name = tostring(groupId)
	local ok, info = pcall(function()
		return GroupService:GetGroupInfoAsync(groupId)
	end)
	if ok and typeof(info) == "table" and typeof((info :: any).Name) == "string" then
		name = (info :: any).Name
	end
	groupNameCache[groupId] = name
	return name
end

local function reresolveRoles(player: Player)
	local user: any = User.getUser(player)
	if not user then return end
	local Roles = getRoles()
	local granted = Roles.resolveRolesForPlayer(player, { fresh = true })
	local current = user.temp:get("Roles")
	if areValuesEqual(current, granted) then return end
	user.temp:set("Roles", granted)
end

local function verifyJoin(player: Player, groupId: number)
	local userId = player.UserId
	local key = `{userId}:{groupId}`
	if inFlight[key] then return end
	inFlight[key] = true

	local function finishSuccess()
		inFlight[key] = nil
		GroupGate.markConfirmed(userId, groupId)
		Prompt.success(player, `Successfully joined group {groupNameFor(groupId)}!`)
		reresolveRoles(player)
	end
	local function finishFail()
		inFlight[key] = nil
		Prompt.warn(player, `Group check failed for {groupNameFor(groupId)}. Please retry or rejoin the game.`)
	end

	if GroupGate.isInGroup(userId, groupId) then
		finishSuccess()
		return
	end
	if GroupGate.isInGroup(userId, groupId, { fresh = true }) then
		finishSuccess()
		return
	end
	Prompt.info(player, "Verifying group join. This can take up to 60 seconds...")
	task.spawn(function()
		local elapsed = 0
		while elapsed < POLL_TIMEOUT do
			task.wait(POLL_INTERVAL)
			elapsed += POLL_INTERVAL
			if not player.Parent then
				inFlight[key] = nil
				return
			end
			if GroupGate.isInGroup(userId, groupId) then
				finishSuccess()
				return
			end
		end
		finishFail()
	end)
end


-- FUNCTIONS
function GroupJoin.promptJoin(player: Player, groupId: number)
	if typeof(player) ~= "Instance" or not player:IsA("Player") then return end
	if typeof(groupId) ~= "number" then return end
	if promptJoinGroup then
		promptJoinGroup:fireClient(player, groupId)
	end
end


-- SETUP
local groupJoinSignal = Remote.new("GroupJoinSignal", "Event", "High")
promptJoinGroup = Remote.new("PromptJoinGroup", "Event")
groupJoinSignal:onServerEvent(function(player: Player, groupId: unknown)
	if typeof(groupId) ~= "number" then return end
	local gid = groupId :: number
	if not isNumberSafe(gid) or gid <= 0 or gid ~= math.floor(gid) then return end
	if not isPermittedGroup(gid) then return end
	if inFlightCountFor(player.UserId) >= MAX_INFLIGHT_PER_USER then return end
	verifyJoin(player, gid)
end)

Players.PlayerRemoving:Connect(function(player: Player)
	local prefix = `{player.UserId}:`
	for key in inFlight do
		if string.sub(key, 1, #prefix) == prefix then
			inFlight[key] = nil
		end
	end
end)


return GroupJoin
