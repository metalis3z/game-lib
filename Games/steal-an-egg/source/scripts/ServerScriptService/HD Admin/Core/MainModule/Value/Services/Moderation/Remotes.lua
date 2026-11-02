--!strict
-- LOCAL
local Remotes = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local Remote = require(modules.Objects.Remote)


-- LOCAL FUNCTIONS
local function commandKeyForScope(scope: string): string
	if scope == "perm" then return "permBan" end
	if scope == "expire" then return "timeBan" end
	if scope == "server" then return "serverBan" end
	return "permBan"
end


-- FUNCTIONS
function Remotes.setup(Moderation: any)
	Remote.new("BanUser", "Function", "Low"):onServerInvoke(function(
		player: Player,
		targetUserId: unknown,
		scope: unknown,
		reason: unknown,
		duration: unknown,
		banAlts: unknown
	): (boolean, string?)
		local callerUser = User.getUser(player)
		if not callerUser then return false, "Caller not loaded" end
		if typeof(targetUserId) ~= "number" or (targetUserId :: number) <= 0 then
			return false, "targetUserId must be a positive integer"
		end
		local resolvedScope: "perm" | "server" | "expire"
		if scope == "perm" or scope == "server" or scope == "expire" then
			resolvedScope = scope :: any
		else
			return false, "scope must be 'perm', 'server', or 'expire'"
		end
		if typeof(reason) ~= "string" then
			return false, "reason must be a string"
		end
		if resolvedScope == "expire" then
			if typeof(duration) ~= "number" or (duration :: number) <= 0 then
				return false, "expire scope requires a positive duration in seconds"
			end
		end

		local Roles = require(modules.Parent.Services.Roles) :: any
		local commandKey = commandKeyForScope(resolvedScope)
		local canUse, denyReason = Roles.canUseCommand(callerUser, commandKey)
		if not canUse then
			if denyReason == "Unknown command" then
				return false, `Bans are disabled because the game dev disabled the "Ban" command from loading. Re-load it within the "Admin" pack to restore.`
			end
			return false, denyReason or `Missing '{commandKey}' command permission`
		end

		local targetUser = User.getUserByUserId(targetUserId :: number, true)
		if targetUser and not Roles.canTarget(callerUser, targetUser) then
			return false, "You can't ban someone of equal or higher rank"
		end

		return Moderation.banAsync(targetUserId :: number, {
			callerUser = callerUser,
			scope = resolvedScope,
			reason = reason :: string,
			duration = if typeof(duration) == "number" then duration :: number else nil,
			banAlts = if banAlts == nil then true else banAlts == true,
		})
	end)

	Remote.new("UnbanUser", "Function", "Low"):onServerInvoke(function(
		player: Player,
		targetUserId: unknown,
		banId: unknown
	): (boolean, string?)
		local callerUser = User.getUser(player)
		if not callerUser then return false, "Caller not loaded" end
		if typeof(targetUserId) ~= "number" or (targetUserId :: number) <= 0 then
			return false, "targetUserId must be a positive integer"
		end
		local resolvedBanId: string? = nil
		if banId ~= nil then
			if typeof(banId) ~= "string" then
				return false, "banId must be a string when provided"
			end
			resolvedBanId = banId :: string
		end

		local Roles = require(modules.Parent.Services.Roles) :: any
		local canUse, denyReason = Roles.canUseCommand(callerUser, "unban")
		if not canUse then
			if denyReason == "Unknown command" then
				return false, `Unbans are disabled because the game dev disabled the "Ban" command from loading. Re-load it within the "Admin" pack to restore.`
			end
			return false, denyReason or "Missing 'unban' command permission"
		end

		local targetUser = User.getUserByUserId(targetUserId :: number, true)
		if targetUser and not Roles.canTarget(callerUser, targetUser) then
			return false, "You can't unban someone of equal or higher rank"
		end

		local ok, err = Moderation.unbanAsync(targetUserId :: number, resolvedBanId, {
			callerUser = callerUser,
		})
		return ok, err
	end)
end


return Remotes
