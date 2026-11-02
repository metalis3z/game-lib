--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local getNameFromUserIdAsync = CommandAPI.getNameFromUserIdAsync
local colourRoleName = CommandAPI.colourRoleName
local runPromptCommand = CommandAPI.runPromptCommand
local modules = script:FindFirstAncestor("HD Admin").Core.MainModule.Value.Modules
local runVoteCommand = require(modules.CommandUtil.runVoteCommand)
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local TeleportService = game:GetService("TeleportService")


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
			scope = "perm",
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
			scope = "perm",
		})
		if ok then
			table.insert(successes, colourRoleName(role))
		else
			table.insert(failures, `{role.name} ({err})`)
		end
	end
	reportResults(caller, "Removed", nameFor(targetUserId), successes, failures)
end

local function runCountdownCommand(promptType: CommandAPI.PromptType, task: CommandAPI.Task, fromServer: boolean?)
	local targets = task:getArg("OptionalPlayers", true) or Players:GetPlayers()
	local integer = task:getArg("CountdownTime")
	if typeof(integer) ~= "number" or integer < 1 then
		integer = 3
	end
	integer = math.floor(integer)
	for _, target in targets do
		task.janitor:add(CommandAPI.prompt(promptType, target, tostring(integer), {
			fromUserId = if fromServer then nil else task.callerUserId,
			fromServer = fromServer,
			duration = integer,
			countdown = integer,
		}))
	end
	task.wait(integer)
end


-- COMMANDS
local commands: CommandAPI.Commands = {

	--------------------
	{
		name = "GivePermRole",
		aliases = {"GivePermRoles", "GivePermanentRole", "GivePermanentRoles"},
		args = {"AnyUser", "Roles"},
		disableModifiers = true,
		run = function(task: CommandAPI.Task)
			runGiveRole(task)
		end,
	},

	--------------------
	{
		name = "TakePermRole",
		aliases = {"TakePermRoles", "TakePermanentRole", "TakePermanentRoles"},
		args = {"AnyUser", "Roles"},
		disableModifiers = true,
		run = function(task: CommandAPI.Task)
			runTakeRole(task)
		end,
	},

	--------------------
	{
		name = "ServerMessage",
		aliases	= {"SM", "SMessage"},
		stackable = true,
		args = {"OptionalPlayers", "OptionalColor", "Text"},
		run = function(task: CommandAPI.Task)
			local targets = task:getArg("OptionalPlayers", true) or Players:GetPlayers()
			local color = task:getArg("OptionalColor", true)
			local text = task:getArg("Text")
			runPromptCommand("message", task, targets, text, {
				fromServer = true,
				color = color,
			})
		end
	},

    --------------------
	{
		name = "PrivateMessage",
		aliases = {"PM"},
		stackable = true,
		args = {"Player", "Text"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local text = task:getArg("Text")
			CommandAPI.prompt("privateMessage", target, text, {
				fromUserId = task.callerUserId,
			})
		end
	},

    --------------------
	{
		name = "ServerPrivateMessage",
		aliases	= {"SPM"},
		stackable = true,
		args = {"Player", "Text"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local text = task:getArg("Text")
			CommandAPI.prompt("privateMessage", target, text, {
				fromServer = true,
			})
		end
	},

    --------------------
	{
		name = "Alert",
		aliases = {},
		stackable = true,
		args = {"OptionalPlayers", "Text"},
		run = function(task: CommandAPI.Task)
			local targets = task:getArg("OptionalPlayers", true) or Players:GetPlayers()
			local text = task:getArg("Text")
			for _, target in targets do
				CommandAPI.prompt("alert", target, text, {
					fromUserId = task.callerUserId,
				})
			end
		end
	},

    --------------------
	{
		name = "ServerAlert",
		aliases	= {"SAlert"},
		stackable = true,
		args = {"OptionalPlayers", "Text"},
		run = function(task: CommandAPI.Task)
			local targets = task:getArg("OptionalPlayers", true) or Players:GetPlayers()
			local text = task:getArg("Text")
			for _, target in targets do
				CommandAPI.prompt("alert", target, text, {
					fromServer = true,
				})
			end
		end
	},

    --------------------
	{
		name = "CountdownHint",
		aliases = {"Countdown2", "CD2"},
		stackable = true,
		args = {"OptionalPlayers", "CountdownTime"},
		run = function(task: CommandAPI.Task)
			runCountdownCommand("hint", task)
		end
	},

    --------------------
	{
		name = "CountdownNotice",
		aliases = {"Countdown", "Countdown1", "CD", "CD1"},
		stackable = true,
		args = {"OptionalPlayers", "CountdownTime"},
		run = function(task: CommandAPI.Task)
			runCountdownCommand("info", task)
		end
	},

    --------------------
	{
		name = "ServerCountdownNotice",
		aliases = {"Countdown3", "CD3", "CDS"},
		stackable = true,
		args = {"OptionalPlayers", "CountdownTime"},
		run = function(task: CommandAPI.Task)
			runCountdownCommand("info", task, true)
		end
	},

    --------------------
	{
		name = "Vote",
		aliases = {"Poll"},
		stackable = true,
		autoPreview = true,
		disableModifiers = true,
		disableGlobalModifiers = true,
		args = {"OptionalPlayers", "OptionalVoteTime", "OptionalShareResults", {arg = "Text", display = "Question"}, "Fields"},
		run = runVoteCommand,
	},

    --------------------
	{
		name = "Shutdown",
		args = {},
		cooldown = 10,
		run = function(task: CommandAPI.Task)
			local getNameFromUserIdAsync = CommandAPI.getNameFromUserIdAsync
			local callerId = task.callerUserId
			local success, callerNameOrWarning = getNameFromUserIdAsync(callerId)
			local callerName = if success then callerNameOrWarning else "Server"
			local kickMessage = `The server has been shutdown by {callerName}`
			for _, player in Players:GetPlayers() do
				CommandAPI.prompt("message", player, "Shutting down server...", {
					title = "Server Shutdown",
					fromUserId = callerId,
				})
			end
			task:keep("Indefinitely")
			task.wait(3)
			for _, player in Players:GetPlayers() do
				player:Kick(kickMessage)
			end
			Players.PlayerAdded:Connect(function(player)
				player:Kick(kickMessage)
			end)
		end
	},

    --------------------
	{
		name = "LockServer",
		aliases = {"ServerLock", "SLock"},
		undoAliases = {"OpenServer"},
		args = {"Role"},
		run = function(task: CommandAPI.Task)
			-- We make sure the caller can't lock the server for a rank above their own
			local role = task:getArg("Role")
			local roleName = role and role.name
			local roleRank = role and role.rank or 0
			local ServerAPI = require(script:FindFirstAncestor("HD Admin").Core.ServerAPI)
			local _, callerTopRole = ServerAPI.getTopRoleAsync(task.callerUserId)
			local callerTopRank = if typeof(callerTopRole) == "table" then callerTopRole.rank else 0
			local callerRoleIsLowerThanGiven = role and callerTopRank < roleRank
			if callerRoleIsLowerThanGiven then
				CommandAPI.prompt("warn", task.caller, `Cannot use role '{roleName}' as your highest owned one is below`)
				return
			end
			local function getMessage(lockStatus: string, ignoreRole: boolean?)
				local newMessage = `The server has been {lockStatus}`
				if roleName and ignoreRole ~= true then
					newMessage = newMessage .. ` for ranks below '{roleName}'`
				end
				return newMessage
			end
			task:keep("Indefinitely")
			local initialMessage = getMessage("locked")
			for _, player in Players:GetPlayers() do
				CommandAPI.prompt("hint", player, initialMessage)
			end
			task:onEndedForGood(function()
				local endMessage = getMessage("unlocked", true)
				for _, player in Players:GetPlayers() do
					CommandAPI.prompt("hint", player, endMessage)
				end
			end)
			local function checkToKickPlayer(player: Player, isNewPlayer: boolean?)
				-- Player keeps in only if their top rank is at or above the locked role
				-- No role specified means the server is locked for everyone
				local _, playerTopRole = ServerAPI.getTopRoleAsync(player)
				local playerTopRank = if typeof(playerTopRole) == "table" then playerTopRole.rank else 0
				local hasRoleEqualOrAbove = if role then playerTopRank >= roleRank else false
				if hasRoleEqualOrAbove then
					return
				end
				local kickMessage = `The server is locked`
				if roleName then
					kickMessage = kickMessage..` for ranks below '{roleName}'`
				end
				player:Kick(kickMessage)
				for _, player in Players:GetPlayers() do
					CommandAPI.prompt("hint", player, `Server Lock: {player.Name} attempted to join`)
				end
			end
			task.janitor:add(Players.PlayerAdded:Connect(function(player: Player)
				checkToKickPlayer(player, true)
			end))
		end
	},

    --------------------
	{
		name = "Place",
		args = {"Player", "Integer"},
		run = function(task: CommandAPI.Task)
			local caller = task.caller
			local target = task.target
			local integer = task:getArg("Integer")
			local success, placeInfo = pcall(function()
				return MarketplaceService:GetProductInfo(integer)
			end)
			local placeName = placeInfo and placeInfo.Name
			if typeof(placeName) ~= "string" then
				CommandAPI.prompt("error", caller, `{integer} is an invalid placeId`)
				return
			end
			local function onActivate()
				local resolved = false
				local connection: RBXScriptConnection? = nil
				connection = TeleportService.TeleportInitFailed:Connect(function(player, _result, message)
					if player ~= target then return end
					if connection then connection:Disconnect() end
					resolved = true
					CommandAPI.prompt("error", target, `Teleport failed: {message}`)
				end)
				task.janitor:add(connection)
				local ok, err = pcall(function()
					TeleportService:Teleport(integer, target)
				end)
				if not ok then
					CommandAPI.prompt("error", target, `Teleport failed: {err}`)
					return
				end
				while not resolved and task.isActive and target.Parent do
					task.wait(0.2)
				end
			end
			task:keep("UntilTargetLeaves")
			task:bindPrompt({
				title = "Teleport",
				deactivate = false,
				endOnClose = true,
				text = `Click to teleport to '{placeName}' ({integer})`,
				buttons = {
					{
						label = "Teleport",
						onActivate = onActivate,
					},
				},
			})
		end
	},

    --------------------
	{
		name = "ClearAll",
		aliases = {"ClrAll", "ResetAll"},
		description = "Clears EVERY task, including those on targets",
		args = {"Caller"},
		run = function(task: CommandAPI.Task)
			-- This clears all non-player specific tasks
			local callerToClear: Player = task.target
			local tasks = CommandAPI.getTasks() :: {CommandAPI.Task}
			for _, targetTask: CommandAPI.Task in tasks do
				if not targetTask.target then
					targetTask:destroy()
				end
			end
		end
	},

    --------------------

}


return commands
