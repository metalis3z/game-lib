--!strict
-- LOCAL 
local Remotes = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local User = require(modules.Objects.User)
local Remote = require(modules.Objects.Remote)
local TaskObject = require(modules.Objects.Task)


-- FUNCTIONS
function Remotes.setup()
	Remote.new("EditTask", "Function", "Low"):onServerInvoke(function(player: Player, taskUID: unknown, action: unknown): (boolean, string?)
		local callerUser = User.getUser(player)
		if not callerUser then return false, "Caller not loaded" end
		if typeof(taskUID) ~= "string" then
			return false, "taskUID must be a string"
		end
		if action ~= "pause" and action ~= "resume" and action ~= "cancel" and action ~= "removeEntry" and action ~= "retrievePrompt" then
			return false, "action must be 'pause', 'resume', 'cancel', 'removeEntry' or 'retrievePrompt'"
		end
		if action == "retrievePrompt" then
			local commandTask = TaskObject.getTask(taskUID :: string) :: any
			if not commandTask or not commandTask.isActive then
				return false, "Task no longer exists"
			end
			if commandTask.callerUserId ~= player.UserId then
				return false, "Only the original caller can retrieve this prompt"
			end
			local config = if typeof(commandTask.extra) == "table" then commandTask.extra.lastPromptConfig else nil
			if typeof(config) ~= "table" then
				return false, "This task has no controls"
			end
			local Action = require(modules.Prompt.Action) :: any
			Action.unbind(commandTask)
			commandTask.caller = player
			commandTask.extra.suppressAutoPrompt = nil
			config.audience = player
			commandTask:bindPrompt(config)
			return true, nil
		end
		local Roles = require(modules.Parent.Services.Roles) :: any
		if not Roles.hasPermission(callerUser, "mayEditTasks") then
			return false, "Missing 'mayEditTasks' permission"
		end
		local PermTasks = require(script.Parent.PermTasks)
		if action == "removeEntry" then
			if not PermTasks.remove(taskUID :: string, "Tasks page remove") then
				return false, "Perm task no longer exists"
			end
			return true, nil
		end
		local commandTask = TaskObject.getTask(taskUID :: string) :: any
		if not commandTask or not commandTask.isActive then
			return false, "Task no longer exists"
		end
		if action == "pause" then
			if commandTask.isPaused then
				return false, "Task is already paused"
			end
			commandTask:pause()
		elseif action == "resume" then
			if not commandTask.isPaused then
				return false, "Task is not paused"
			end
			commandTask:resume()
		else
			local entryUID = if typeof(commandTask.extra) == "table" then commandTask.extra.entryUID else nil
			commandTask:destroy()
			if typeof(entryUID) == "string" then
				PermTasks.remove(entryUID, "Tasks page cancel")
			end
		end
		return true, nil
	end)
end


return Remotes
