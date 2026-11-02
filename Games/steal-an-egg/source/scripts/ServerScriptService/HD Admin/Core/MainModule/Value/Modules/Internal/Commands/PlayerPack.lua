--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)


-- COMMANDS
local commands: CommandAPI.Commands = {

	--------------------
	{
		name = "Reset",
		aliases = {"Refresh", "Re"},
		args = {"Player"},
		run = function(task: CommandAPI.Task)
			local player: Player = task.target
			local targetUserId = player.UserId
			local tasks = CommandAPI.getTasks(nil, targetUserId)
			for _, targetTask in tasks do
				targetTask:destroy()
			end
		end
	},

	--------------------

}


return commands
