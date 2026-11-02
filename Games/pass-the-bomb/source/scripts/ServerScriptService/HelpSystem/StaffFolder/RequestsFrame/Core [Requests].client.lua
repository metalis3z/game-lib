--[[

	Documentation:
	# NTH | Help Request Core
	---------------
	Author:
	@ lightyns
	---------------
	Client-core for the help requests panel.
	---------------
	Last Edited:
	# 2021-03-10

--]]

--# Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

--# Modules
local Tween = require(script.Parent.Parent.Parent.Modules.Tween)

--# Variables
local player = Players.LocalPlayer

local helpSystemRemotes = ReplicatedStorage:WaitForChild("Help System")
local helpEvent = helpSystemRemotes:WaitForChild("Help Event")
local helpFunction = helpSystemRemotes:WaitForChild("Help Function")

local gui = script.Parent
local header = gui.Header
local screens = gui.Screens

local buttons = gui.Parent.Buttons
local requestsButton = buttons.Requests

local details = screens.Details
local scrollingFrame = screens.ScrollingFrame

local template = script.Template

local current

--## Dragging
local dragging
local dragInput
local dragStart
local startPos

--# Functions
local function updateDrag(input)
	local delta = input.Position - dragStart
	gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

local function updateIndicator()
	local queue = helpFunction:InvokeServer("Queue")
	if #queue <= 0 then
		requestsButton.Indicator.Visible = false
	else
		requestsButton.Indicator.Visible = true
	end
	requestsButton.Indicator.Text = (#queue >= 10 and "9+" or #queue)
end

local handler = {
	["Request"] = function(...)
		local args = {...}
		local requester = args[1]
		local reason = args[2]
		local clone = template:Clone()
		local pfp = Players:GetUserThumbnailAsync(requester.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
		local rank = requester:GetRoleInGroup(8025572)
		clone.Name = requester.Name
		clone.ProfilePicture.Image = pfp
		clone.Rank.Text = rank
		clone.Username.Text = requester.Name
		clone.Activated:Connect(function()
			current = requester.Name
			details.Username.Text = requester.Name
			details.Rank.Text = rank
			details.ProfilePicture.Image = pfp
			details.Reason.TextLabel.Text = reason
			Tween.CustomSpeed(1.5, details, { Position = UDim2.fromScale(0.5, 0) })
		end)
		clone.Parent = scrollingFrame
		updateIndicator()
	end,
	['Delete'] = function(...)
		local args = {...}
		local user = args[1]
		if user == current then
			current = nil
			details.Username.Text = 'Unknown User'
			details.Rank.Text = 'Unknown Rank'
			details.ProfilePicture.Image = 'rbxasset://textures/ui/GuiImagePlaceholder.png'
			details.Reason.TextLabel.Text = '-'
		end
		for _, v in ipairs(scrollingFrame:GetChildren()) do
			if v.Name == user then
				v:Destroy()
			end
		end
		updateIndicator()
	end,
}

local function onClientEvent(event, ...)
	handler[event](...)
end

--# Implicits
header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position

		local connection
		connection = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				connection:Disconnect()
				dragging = false
			end
		end)
	end
end)

header.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		updateDrag(input)
	end
end)

updateIndicator()

for _, v in ipairs(helpFunction:InvokeServer("Queue")) do
	handler['Request'](v.User, v.Reason)
end

helpEvent.OnClientEvent:Connect(onClientEvent)

details.Submit.Activated:Connect(function()
	local temp = current
	if not temp then
		return
	end
	local success = helpFunction:InvokeServer("Delete", temp)
	if not success then
		return
	end
	local target = Players:FindFirstChild(temp)
	if not target then
		return
	end
	local char = player.Character or player.CharacterAdded:Wait()
	local targetChar = target.Character or target.CharacterAdded:Wait()
	char:SetPrimaryPartCFrame((targetChar.PrimaryPart.CFrame*CFrame.Angles(0,math.rad(90),0)*CFrame.new(5+.2,0,0))*CFrame.Angles(0,math.rad(90),0))
	Tween.CustomSpeed(1.5, details, { Position = UDim2.fromScale(0.5, 1) })
	current = nil
end)

details.Delete.Activated:Connect(function()
	if not current then
		return
	end
	local success = helpFunction:InvokeServer("Delete", current)
	if not success then
		return
	end
	Tween.CustomSpeed(1.5, details, { Position = UDim2.fromScale(0.5, 1) })
	current = nil
end)

details.BackButton.Activated:Connect(function()
	current = nil
	Tween.CustomSpeed(1.5, details, { Position = UDim2.fromScale(0.5, 1) })
end)