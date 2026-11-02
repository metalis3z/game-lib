--!strict

--[[

	Live feed of running command tasks for the Tasks page 

--]]


-- CONFIG
local PUBLISH_DELAY = 0.5


-- LOCAL
local Tasks = {}
local Players = game:GetService("Players")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local State = require(modules.Objects.State)
local TaskObject = require(modules.Objects.Task)
local deepCopyTable = require(modules.TableUtil.deepCopyTable)
local feedStarted = false


-- TYPES
export type FeedEntry = {
	commandKey: string,
	commandName: string,
	callerUserId: number | string,
	callerName: string,
	callerDisplayName: string,
	targetUserId: number?,
	targetName: string?,
	targetUserName: string?,
	startedAt: number,
	isPaused: boolean,
	args: any?,
	qualifiers: any?,
	modifiers: any?,
	entryUID: string?,
	hasPrompt: boolean?,
}


-- LOCAL FUNCTIONS
local function buildEntry(commandTask: any): FeedEntry
	local Commands = require(modules.Parent.Services.Commands) :: any
	local command = Commands.getCommand(commandTask.commandKey)
	local callerUserId = commandTask.callerUserId
	local callerName = "Server"
	local callerDisplayName = "Server"
	if typeof(callerUserId) == "number" then
		local caller = commandTask.caller or Players:GetPlayerByUserId(callerUserId)
		callerName = if caller then caller.Name else tostring(callerUserId)
		callerDisplayName = if caller then caller.DisplayName else tostring(callerUserId)
	end
	local targetName: string? = nil
	local targetUserName: string? = nil
	if commandTask.targetUserId then
		local target = commandTask.target or Players:GetPlayerByUserId(commandTask.targetUserId)
		targetName = if target then target.DisplayName else tostring(commandTask.targetUserId)
		targetUserName = if target then target.Name else tostring(commandTask.targetUserId)
	end
	return {
		commandKey = commandTask.commandKey,
		commandName = if command then command.name else commandTask.commandKey,
		callerUserId = callerUserId,
		callerName = callerName,
		callerDisplayName = callerDisplayName,
		targetUserId = commandTask.targetUserId,
		targetName = targetName,
		targetUserName = targetUserName,
		startedAt = commandTask.startedAt,
		isPaused = commandTask.isPaused == true,
		args = if typeof(commandTask.args) == "table" then deepCopyTable(commandTask.args) else nil,
		qualifiers = if typeof(commandTask.qualifiers) == "table" then deepCopyTable(commandTask.qualifiers) else nil,
		modifiers = if typeof(commandTask.modifiers) == "table" then deepCopyTable(commandTask.modifiers) else nil,
		entryUID = if typeof(commandTask.extra) == "table" then commandTask.extra.entryUID else nil,
		hasPrompt = typeof(commandTask.extra) == "table" and typeof(commandTask.extra.lastPromptConfig) == "table",
	}
end

local function publish(commandTask: any)
	if commandTask.isSubjob then
		return
	end
	local entry = buildEntry(commandTask)
	User.everyone:set("ActiveTasks", commandTask.UID, entry)
end

local function startFeed()
	if feedStarted then
		return
	end
	feedStarted = true

	for _, commandTask in TaskObject.getTasks() do
		if (commandTask :: any).isActive then
			publish(commandTask)
		end
	end

	TaskObject.updated:Connect(function(action: string, commandTask: any)
		local UID = commandTask.UID
		if action == "added" then
			task.delay(PUBLISH_DELAY, function()
				if commandTask.isActive then
					publish(commandTask)
				end
			end)
		elseif action == "changed" then
			if User.everyone:get("ActiveTasks", UID) then
				User.everyone:set("ActiveTasks", UID, "isPaused", commandTask.isPaused == true)
			end
		elseif action == "removed" then
			if User.everyone:get("ActiveTasks", UID) then
				User.everyone:set("ActiveTasks", UID, nil)
			end
		end
	end)
end


-- SETUP
local getStateVerifier = require(modules.VerifyUtil.getStateVerifier)

-- Only clients who can view the Tasks page receive the feed
User.everyone:verify(getStateVerifier("ActiveTasks", "Exclude", {}, nil, "Tasks"))
User.everyone:set("ActiveTasks", {})

State.verifyFirstFetch("ActiveTasks", startFeed)

require(script.Remotes).setup()

-- These must start with the server (never lazily) so saved entries replay on
-- startup and global broadcasts from other servers get received
require(script.PermTasks)
require(script.GlobalStatements)


return Tasks
