--!strict
-- LOCAL
local TAGS = {script.Name}
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)


-- COMMANDS
local commands: CommandAPI.Commands = {

	--------------------
	--[[{
		name = "Flash",
		args = {"Player"},
		tags = TAGS,
		run = function(task: CommandAPI.Task)
			local target = task.target
			task.client:run(target)
		end,
	},--]]

	--------------------

}


return commands
