--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local getNameFromUserIdAsync = CommandAPI.getNameFromUserIdAsync
local colourRoleName = CommandAPI.colourRoleName
local runPromptCommand = CommandAPI.runPromptCommand
local openProfile = CommandAPI.openProfile
local Players = game:GetService("Players")


-- LOCAL FUNCTIONS
local function nameFor(userId: number): string
	local ok, name = getNameFromUserIdAsync(userId)
	if ok and typeof(name) == "string" then return name end
	return tostring(userId)
end

local function reportResults(caller: Player, verb: string, targetName: string, successes: {string}, failures: {string})
	if #successes > 0 then
		CommandAPI.prompt("success", caller, `{verb} {table.concat(successes, ", ")} {if verb == "Gave" then "to" else "from"} {targetName}`)
	end
	if #failures > 0 then
		CommandAPI.prompt("error", caller, `Failed: {table.concat(failures, ", ")}`)
	end
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

local function runGiveRole(task: CommandAPI.Task)
	local targetUserId = resolveTargetUserId(task:getArg("AnyUser"))
	local rolesToGive = task:getArg("Roles")
	local caller = task.caller :: Player
	if not targetUserId then
		CommandAPI.prompt("error", caller, "Invalid user")
		return
	end
	if typeof(rolesToGive) ~= "table" or #rolesToGive == 0 then
		CommandAPI.prompt("error", caller, "No roles specified")
		return
	end
	local ServerAPI = require(script:FindFirstAncestor("HD Admin").Core.ServerAPI)
	local successes, failures = {}, {}
	for _, role in rolesToGive do
		local ok, err = ServerAPI.giveRoleAsync(targetUserId, role.name, {
			callerUserId = caller.UserId,
			scope = "server",
		})
		if ok then
			table.insert(successes, colourRoleName(role))
		else
			table.insert(failures, `{role.name} ({err})`)
		end
	end
	-- Self grants skip the success prompt because the receive notice already covers it
	if targetUserId == caller.UserId then
		successes = {}
	end
	reportResults(caller, "Gave", nameFor(targetUserId), successes, failures)
end

local function runTakeRole(task: CommandAPI.Task)
	local targetUserId = resolveTargetUserId(task:getArg("AnyUser"))
	local rolesToTake = task:getArg("Roles")
	local caller = task.caller :: Player
	if not targetUserId then
		CommandAPI.prompt("error", caller, "Invalid user")
		return
	end
	if typeof(rolesToTake) ~= "table" or #rolesToTake == 0 then
		CommandAPI.prompt("error", caller, "No roles specified")
		return
	end
	local ServerAPI = require(script:FindFirstAncestor("HD Admin").Core.ServerAPI)
	local successes, failures = {}, {}
	for _, role in rolesToTake do
		local ok, err = ServerAPI.takeRoleAsync(targetUserId, role.name, {
			callerUserId = caller.UserId,
			scope = "server",
		})
		if ok then
			table.insert(successes, colourRoleName(role))
		else
			table.insert(failures, `{role.name} ({err})`)
		end
	end
	reportResults(caller, "Removed", nameFor(targetUserId), successes, failures)
end


-- COMMANDS
local commands: CommandAPI.Commands = {

	--------------------
	{
		name = "Hint",
		aliases = {"H"},
		stackable = true,
		args = {"OptionalPlayers", "OptionalColor", "OptionalDuration", "Text"},
		run = function(task: CommandAPI.Task)
			local targets = task:getArg("OptionalPlayers", true) or Players:GetPlayers()
			local color = task:getArg("OptionalColor", true)
			local text = task:getArg("Text")
			runPromptCommand("hint", task, targets, text, {
				fromUserId = task.callerUserId,
				color = color,
				duration = task:getArg("OptionalDuration", true),
			})
		end
	},

    --------------------
	{
		name = "Notice",
		aliases = {"Not"}, -- Can't be called "N" anymore as this conflicts with the "Un" modifier due to a current limitation with the parser
		stackable = true,
		args = {"OptionalPlayers", "OptionalDuration", "Text"},
		run = function(task: CommandAPI.Task)
			local targets = task:getArg("OptionalPlayers", true) or Players:GetPlayers()
			local text = task:getArg("Text")
			runPromptCommand("info", task, targets, text, {
				fromUserId = task.callerUserId,
				duration = task:getArg("OptionalDuration", true),
			})
		end
	},

	--------------------
	{
		name = "Message",
		aliases = {"M", "Announce", "Broadcast", "Announcement"},
		stackable = true,
		args = {"OptionalPlayers", "OptionalColor", "OptionalDuration", "Text"},
		run = function(task: CommandAPI.Task)
			local targets = task:getArg("OptionalPlayers", true) or Players:GetPlayers()
			local color = task:getArg("OptionalColor", true)
			local text = task:getArg("Text")
			runPromptCommand("message", task, targets, text, {
				fromUserId = task.callerUserId,
				color = color,
				duration = task:getArg("OptionalDuration", true),
			})
		end
	},

    --------------------
	{
		name = "Profile",
		args = {"AnyUser"},
		run = function(task: CommandAPI.Task)
			local caller = task.caller
			if not caller then
				return
			end
			local userId = tonumber(task:getArg("AnyUser"))
			if not userId or userId <= 0 then
				userId = caller.UserId
			end
			openProfile(caller, userId :: number)
		end
	},

	--------------------
	{
		name = "GiveServerRole",
		aliases = {"GiveServerRoles"},
		args = {"Player", "Roles"},
		disableModifiers = true,
		run = function(task: CommandAPI.Task)
			runGiveRole(task)
		end,
	},

	--------------------
	{
		name = "TakeServerRole",
		aliases = {"TakeServerRoles"},
		args = {"Player", "Roles"},
		disableModifiers = true,
		run = function(task: CommandAPI.Task)
			runTakeRole(task)
		end,
	},

    --------------------

}


return commands
