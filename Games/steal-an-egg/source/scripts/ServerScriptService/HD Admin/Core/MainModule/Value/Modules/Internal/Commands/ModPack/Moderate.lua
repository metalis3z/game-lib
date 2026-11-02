--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local getHumanoid = CommandAPI.getHumanoid
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")


-- LOCAL FUNCTIONS
local function resolveTargetUserId(targetArg: any): number?
	if typeof(targetArg) == "Instance" and targetArg:IsA("Player") then
		return targetArg.UserId
	end
	if typeof(targetArg) == "number" and targetArg > 0 then
		return targetArg
	end
	return nil
end


-- COMMANDS
local commands: CommandAPI.Commands = {

    --------------------
	{
		name = "Mute",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			task:keep("UntilTargetLeaves")
			task.client:run(target)
		end
	},
	
    --------------------
	{
		name = "Punish",
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local function updateChar()
				local char = target and target.Character
				if not char then return end
				char.Parent = nil
				task:onEnded(function()
					if char == target.Character then
						char.Parent = workspace
					else
						char:Destroy()
					end
				end)
			end
			task:keep("UntilTargetLeaves")
			task:redo(target, updateChar)
		end
	},

    --------------------
	--[[{
		name = "Warn",
		args = {"Player"},
		config = {
			WarnExpiryTime = 604800, -- 1 week
			WarnActions = {
				{Warns = 3, Action = "Kick"},
				{Warns = 4, Action = "ServerBan", Duration = 7200}, -- 2 hours
				{Warns = 5, Action = "PermBan", Duration = 172800}, -- 2 days
			},
		},
		run = function(task: CommandAPI.Task)
			CommandAPI.prompt("warn", task.caller, "Command Coming Soon")
		end
	},--]]

    --------------------
	{
		name = "Kick",
		args = {"Player", "Text"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local text = task:getArg("Text")
			local targetName = target.Name
			local kickMessage = "by ".. targetName.."\n\nReason: '"..text.."'\n"
			if #text < 1 then
				kickMessage = "By: ".. targetName
			end
			target:Kick(kickMessage)
		end
	},

    --------------------
	{
		name = "ServerBan",
		aliases = {"SBan"},
		args = {"Player", "Reason"},
		disableModifiers = true,
		run = function(task: CommandAPI.Task)
			local caller = task.caller :: Player
			local targetUserId = resolveTargetUserId(task.target)
			local reason = if typeof(task:getArg("Reason")) == "string" then task:getArg("Reason") else ""
			if not targetUserId then
				CommandAPI.prompt("error", caller, "Invalid user")
				return
			end
			if reason == "" then
				CommandAPI.prompt("error", caller, "Reason is required")
				return
			end
			local ServerAPI = require(script:FindFirstAncestor("HD Admin").Core.ServerAPI)
			local ok, result = ServerAPI.banAsync(targetUserId, {
				callerUserId = caller.UserId,
				scope = "server",
				reason = reason,
			})
			if ok then
				local getNameFromUserIdAsync = CommandAPI.getNameFromUserIdAsync
				local nameOk, name = getNameFromUserIdAsync(targetUserId)
				CommandAPI.prompt("success", caller, `Server-banned {if nameOk then name else tostring(targetUserId)}`)
			else
				CommandAPI.prompt("error", caller, tostring(result or "Failed to ban"))
			end
		end
	},

    --------------------
	{
		name = "UnServerBan",
		aliases = {"UnSBan", "UnsBan"},
		args = {"Player"},
		autoPreview = true,
		disableModifiers = true,
		run = function(task: CommandAPI.Task)
			local caller = task.caller :: Player
			local targetUserId = resolveTargetUserId(task.target)
			if not targetUserId then
				CommandAPI.prompt("error", caller, "Invalid user")
				return
			end
			local ServerAPI = require(script:FindFirstAncestor("HD Admin").Core.ServerAPI)
			local ok, err = ServerAPI.unbanAsync(targetUserId, nil, {
				callerUserId = caller.UserId,
				scope = "server",
			})
			if ok then
				local getNameFromUserIdAsync = CommandAPI.getNameFromUserIdAsync
				local nameOk, name = getNameFromUserIdAsync(targetUserId)
				CommandAPI.prompt("success", caller, `Cleared server ban for {if nameOk then name else tostring(targetUserId)}`)
			else
				CommandAPI.prompt("error", caller, tostring(err or "Failed to clear server ban"))
			end
		end
	},

    --------------------
	{
		name = "Follow",
		aliases	= {"JoinServer"},
		args = {"AnyUser"},
		run = function(task: CommandAPI.Task)
			local userId = tonumber(task:getArg("AnyUser"))
			local caller = task.caller
			if not userId or userId <= 0 then
				CommandAPI.prompt("error", caller, "Invalid User")
				return
			end
			if caller and userId == caller.UserId then
				CommandAPI.prompt("warn", caller, "You can't follow yourself!")
				return
			end
			local playerInServer = Players:GetPlayerByUserId(userId)
			if playerInServer then
				CommandAPI.prompt("warn", caller, `{playerInServer.DisplayName} is already in your server. Use ;goto {playerInServer.Name} to go to them`)
				return
			end
			local getNameFromUserIdAsync = CommandAPI.getNameFromUserIdAsync
			local success, name = getNameFromUserIdAsync(userId)
			if not success or typeof(name) ~= "string" then
				name = tostring(userId)
			end
			CommandAPI.prompt("info", caller, `Teleporting to {name}...`)
			local success, errorMessage, _, placeId, jobId = pcall(function()
				return TeleportService:GetPlayerPlaceInstanceAsync(userId)
			end)
			if success and placeId and jobId then
				pcall(function()
					return TeleportService:TeleportToPlaceInstance(
						placeId,
						jobId,
						caller
					)
				end)
				return
			end
			CommandAPI.prompt("error", caller, `Failed to teleport: {name} not in-game`)
		end
	},

    --------------------
	{
		name = "Team",
		aliases	= {"JoinTeam", "SwitchTeam"},
		args = {"Player", "Team"},
		run = function(task: CommandAPI.Task)
			local target = task.target
			local team = task:getArg("Team")
			if team then
				target.Team = team
				target.TeamColor = team.TeamColor
			end
		end
	},

    --------------------

}


return commands
