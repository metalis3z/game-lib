--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)


-- CLIENT COMMANDS
local clientCommands: CommandAPI.ClientCommands = {

	--------------------
	{
		name = "Warp",
		run = function(task: CommandAPI.Task)
			local localPlayer = game:GetService("Players").LocalPlayer
			local maxDistort = 1
			local increment = 0.005
			local distort = maxDistort-increment
			local distortDirection = -increment
			local RunService = game:GetService("RunService")
			local camera = workspace.CurrentCamera
			repeat RunService.RenderStepped:Wait()
				if distort < increment then
					distort = increment
					distortDirection = increment
				elseif distort > maxDistort then
					distort = maxDistort
					distortDirection = -increment
				end
				camera.CFrame = camera.CFrame*CFrame.new(0,0,0,distort,0,0,0,distort,0,0,0,1)
				distort = distort + distortDirection
			until distort > maxDistort
		end,
	},

	--------------------
}


return clientCommands
