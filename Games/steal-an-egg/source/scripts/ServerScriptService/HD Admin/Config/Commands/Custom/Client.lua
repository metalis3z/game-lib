--!strict
-- LOCAL
local CommandAPI = require(script:FindFirstAncestor("HD Admin").Core.CommandAPI)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")


-- COMMANDS
local clientCommands: CommandAPI.ClientCommands = {

	--------------------
	--[[{
		name = "Flash",
		run = function(task: CommandAPI.Task)
			local localPlayer = Players.LocalPlayer
			local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
			if not playerGui then
				return
			end
			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "HDCustomFlash"
			screenGui.IgnoreGuiInset = true
			screenGui.DisplayOrder = 999
			local frame = Instance.new("Frame")
			frame.BackgroundColor3 = Color3.new(1, 1, 1)
			frame.Size = UDim2.fromScale(1, 1)
			frame.Parent = screenGui
			screenGui.Parent = playerGui
			local tween = TweenService:Create(frame, TweenInfo.new(1), {BackgroundTransparency = 1})
			tween.Completed:Once(function()
				screenGui:Destroy()
			end)
			tween:Play()
		end,
	},--]]

	--------------------

}


return clientCommands
