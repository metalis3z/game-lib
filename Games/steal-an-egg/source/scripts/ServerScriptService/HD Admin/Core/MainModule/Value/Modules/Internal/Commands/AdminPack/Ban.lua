--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local getNameFromUserIdAsync = CommandAPI.getNameFromUserIdAsync


-- LOCAL FUNCTIONS
local function nameFor(userId: number): string
	local ok, name = getNameFromUserIdAsync(userId)
	if ok and typeof(name) == "string" then return name end
	return tostring(userId)
end

local function resolveTargetUserId(targetArg: any): number?
	if typeof(targetArg) == "number" and targetArg > 0 then
		return targetArg
	end
	if typeof(targetArg) == "Instance" and targetArg:IsA("Player") then
		return targetArg.UserId
	end
	return nil
end

local function resolveBanOption(banOption: any): ("perm" | "server" | "expire"?, string?)
	if banOption == "Server" then return "server", "serverBan" end
	if banOption == "Time"   then return "expire", "timeBan" end
	if banOption == "Perm"   then return "perm",   "permBan" end
	return nil, nil
end

local function commandKeyForScope(scope: "perm" | "server" | "expire"): string
	if scope == "perm" then return "permBan" end
	if scope == "server" then return "serverBan" end
	return "timeBan"
end

local function runScopedBan(
	task: CommandAPI.Task,
	scope: "perm" | "server" | "expire",
	subCommandKey: string,
	targetUserId: number,
	reason: string,
	duration: number?,
	banAlts: boolean?
)
	local caller = task.caller :: Player

	if reason == "" then
		CommandAPI.prompt("error", caller, "Reason is required")
		return
	end
	if scope == "expire" and (typeof(duration) ~= "number" or duration <= 0) then
		CommandAPI.prompt("error", caller, "Time bans require a duration")
		return
	end

	local ServerAPI = require(script:FindFirstAncestor("HD Admin").Core.ServerAPI)
	local canUse, denyReason = ServerAPI.canUseCommandAsync(caller, subCommandKey)
	if not canUse then
		CommandAPI.prompt("error", caller, denyReason or `You don't have permission to use ;{subCommandKey}`)
		return
	end

	local ok, result = ServerAPI.banAsync(targetUserId, {
		callerUserId = caller.UserId,
		scope = scope,
		reason = reason,
		duration = duration,
		banAlts = if banAlts == nil then true else banAlts,
	})
	if ok then
		CommandAPI.prompt("success", caller, `Banned {nameFor(targetUserId)}`)
	else
		CommandAPI.prompt("error", caller, tostring(result or "Failed to ban"))
	end
end


-- COMMANDS
local commands: CommandAPI.Commands = {

	--------------------
	{
		name = "Ban",
		args = {"AnyUser", "BanOptions", "OptionalBanImpact", "OptionalBanDuration", "Reason"},
		autoPreview = true,
		disableModifiers = true,
		run = function(task: CommandAPI.Task)
			local targetUserId = resolveTargetUserId(task:getArg("AnyUser"))
			if not targetUserId then
				CommandAPI.prompt("error", task.caller :: Player, "Invalid user")
				return
			end
			local scope, subCommandKey = resolveBanOption(task:getArg("BanOptions"))
			if not scope or not subCommandKey then
				CommandAPI.prompt("error", task.caller :: Player, "Pick a ban type (Server / Time / Perm)")
				return
			end
			local banAlts = if scope == "perm" or scope == "expire"
				then (task:getArg("OptionalBanImpact") == nil or task:getArg("OptionalBanImpact") == "Alts")
				else nil
			local duration = if scope == "expire" and typeof(task:getArg("OptionalBanDuration")) == "number" then task:getArg("OptionalBanDuration") else nil
			local reason = if typeof(task:getArg("Reason")) == "string" then task:getArg("Reason") else ""

			if scope == "expire" and (typeof(duration) ~= "number" or duration <= 0) then
				CommandAPI.prompt("error", task.caller :: Player, "Time bans require a duration")
				return
			end

			runScopedBan(task, scope, subCommandKey, targetUserId, reason, duration, banAlts)
		end,
	},

	--------------------
	{
		name = "PermBan",
		aliases = {"PermanentBan"},
		args = {"AnyUser", "BanImpact", "Reason"},
		autoPreview = true,
		disableModifiers = true,
		run = function(task: CommandAPI.Task)
			local targetUserId = resolveTargetUserId(task:getArg("AnyUser"))
			if not targetUserId then
				CommandAPI.prompt("error", task.caller :: Player, "Invalid user")
				return
			end
			local banAlts: boolean = task:getArg("BanImpact") == nil or task:getArg("BanImpact") == "Alts"
			local reason = if typeof(task:getArg("Reason")) == "string" then task:getArg("Reason") else ""
			runScopedBan(task, "perm", commandKeyForScope("perm"), targetUserId, reason, nil, banAlts)
		end,
	},

	--------------------
	{
		name = "TimeBan",
		aliases = {"TBan"},
		args = {"AnyUser", "Duration", "BanImpact", "Reason"},
		autoPreview = true,
		disableModifiers = true,
		run = function(task: CommandAPI.Task)
			local targetUserId = resolveTargetUserId(task:getArg("AnyUser"))
			if not targetUserId then
				CommandAPI.prompt("error", task.caller :: Player, "Invalid user")
				return
			end
			local duration = if typeof(task:getArg("Duration")) == "number" then task:getArg("Duration") else nil
			local banAlts: boolean = task:getArg("BanImpact") == nil or task:getArg("BanImpact") == "Alts"
			local reason = if typeof(task:getArg("Reason")) == "string" then task:getArg("Reason") else ""
			runScopedBan(task, "expire", commandKeyForScope("expire"), targetUserId, reason, duration, banAlts)
		end,
	},

	--------------------
	{
		name = "Unban",
		args = {"AnyUser"},
		autoPreview = true,
		disableModifiers = true,
		run = function(task: CommandAPI.Task)
			local caller = task.caller :: Player
			local targetUserId = resolveTargetUserId(task:getArg("AnyUser"))
			if not targetUserId then
				CommandAPI.prompt("error", caller, "Invalid user")
				return
			end
			local ServerAPI = require(script:FindFirstAncestor("HD Admin").Core.ServerAPI)
			local ok, err, removedCount = ServerAPI.unbanAsync(targetUserId, nil, {
				callerUserId = caller.UserId,
			})
			if not ok then
				CommandAPI.prompt("error", caller, tostring(err or "Failed to unban"))
			elseif (removedCount or 0) > 0 then
				CommandAPI.prompt("success", caller, `Unbanned {nameFor(targetUserId)}`)
			else
				CommandAPI.prompt("warn", caller, `{nameFor(targetUserId)} has no active bans to remove`)
			end
		end,
	},

	--------------------
}


return commands
