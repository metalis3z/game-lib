--!strict
-- LOCAL
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local StarterGui = game:GetService("StarterGui")


-- CLIENT COMMANDS
local clientCommands: CommandAPI.ClientCommands = {

	--------------------
	{
		name = "Mute",
		run = function(task: CommandAPI.Task)
			local getCoreGuiEnabled = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
			if getCoreGuiEnabled then
				StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
				task:onEnded(function()
					StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
				end)
			end
		end,
	},

	--------------------
}


return clientCommands