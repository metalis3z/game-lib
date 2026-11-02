--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)


-- CLIENT COMMANDS
local clientCommands: CommandAPI.ClientCommands = {

	--------------------
	{
		name = "FieldOfView",
		run = function(task: CommandAPI.Task, fieldOfView: number)
			local localPlayer = game:GetService("Players").LocalPlayer
			task.extra.fieldOfView = fieldOfView
			-- A re-fired run (the slider changing) just re-applies the existing buff
			if task.extra.buff then
				task:updateBuffs(localPlayer, "Camera")
				return
			end
			task.extra.buff = task:buff(localPlayer, "Camera", function(hasEnded: boolean, originalValue: any)
				local camera = workspace.CurrentCamera
				local currentFieldOfView = camera.FieldOfView
				camera.FieldOfView = if hasEnded then originalValue else task.extra.fieldOfView
				return currentFieldOfView
			end)
		end,
	},

	--------------------
}


return clientCommands
