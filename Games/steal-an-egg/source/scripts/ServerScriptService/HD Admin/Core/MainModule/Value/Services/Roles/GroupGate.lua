--!strict
-- LOCAL
local Players = game:GetService("Players")
local GroupService = game:GetService("GroupService")
local GroupGate = {}


-- TYPES
type GroupRoleInfo = { rank: number, name: string }
export type Opts = { fresh: boolean?, errorSink: { failed: boolean }? } -- a group-API failure sets failed = true so rank checks can fail closed


-- CONFIRMED OVERRIDE
-- Roblox's ~60s group cache means a fresh join can still read as not-a-member, so isInGroup trusts this instead
local confirmed: { [number]: { [number]: boolean } } = {}
Players.PlayerRemoving:Connect(function(player: Player)
	confirmed[player.UserId] = nil
end)


-- LOCAL FUNCTIONS
local function getGroupRoleInfo(userId: number, groupId: number, opts: Opts?): GroupRoleInfo
	local fresh = opts ~= nil and opts.fresh == true
	local function markError()
		if opts and opts.errorSink then opts.errorSink.failed = true end
	end
	local player = Players:GetPlayerByUserId(userId)
	if player and not fresh then
		local rank = 0
		local name = ""
		local okR, rv = pcall(player.GetRankInGroup, player, groupId)
		if okR and typeof(rv) == "number" then rank = rv elseif not okR then markError() end
		local okN, nv = pcall(player.GetRoleInGroup, player, groupId)
		if okN and typeof(nv) == "string" then name = nv elseif not okN then markError() end
		return { rank = rank, name = name }
	end
	local rank = 0
	local name = ""
	local ok, groupsList = pcall(GroupService.GetGroupsAsync, GroupService, userId)
	if ok and typeof(groupsList) == "table" then
		for _, group in groupsList :: { any } do
			if (group :: any).Id == groupId then
				rank = (group :: any).Rank or 0
				if typeof((group :: any).Role) == "string" then name = (group :: any).Role end
				break
			end
		end
	elseif not ok then
		markError()
	end
	return { rank = rank, name = name }
end


-- FUNCTIONS
function GroupGate.markConfirmed(userId: number, groupId: number)
	if typeof(userId) ~= "number" or typeof(groupId) ~= "number" then return end
	local set = confirmed[userId]
	if not set then
		set = {}
		confirmed[userId] = set
	end
	set[groupId] = true
end

function GroupGate.isInGroup(userId: number, groupId: number, opts: Opts?): boolean
	if typeof(userId) ~= "number" or typeof(groupId) ~= "number" then return false end
	local set = confirmed[userId]
	if set and set[groupId] then return true end
	return getGroupRoleInfo(userId, groupId, opts).rank > 0
end

function GroupGate.qualifies(userId: number, giveToGroups: any, opts: Opts?): boolean
	if typeof(userId) ~= "number" or typeof(giveToGroups) ~= "table" then return false end
	local cache: { [number]: GroupRoleInfo } = {}
	local function infoFor(groupId: number): GroupRoleInfo
		local cached = cache[groupId]
		if cached then return cached end
		local resolved = getGroupRoleInfo(userId, groupId, opts)
		cache[groupId] = resolved
		return resolved
	end
	for _, entry in giveToGroups :: { any } do
		if typeof(entry) ~= "table" then continue end
		local et = entry.type
		local gid = entry.groupId
		if typeof(gid) ~= "number" then continue end
		local info = infoFor(gid)
		if et == "AnyMember" and info.rank > 0 then return true end
		if et == "SpecificRoles" then
			if typeof(entry.roles) == "table" then
				for _, cfg in entry.roles :: { any } do
					if typeof(cfg) ~= "table" then continue end
					local cfgRank = (cfg :: any).rank
					local cfgName = (cfg :: any).name
					if typeof(cfgRank) ~= "number" then continue end
					local sameRank = cfgRank == info.rank
					local sameName = typeof(cfgName) == "string" and #cfgName > 0 and cfgName == info.name
					if sameRank and (sameName or typeof(cfgName) ~= "string" or #cfgName == 0) then
						return true
					end
					if sameName then return true end
				end
			end
			if typeof(entry.roleIds) == "table" then
				for _, rid in entry.roleIds :: { any } do
					if rid == info.rank then return true end
				end
			end
		end
	end
	return false
end


return GroupGate
