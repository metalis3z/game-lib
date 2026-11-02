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
	# 2021-03-09

--]]

--# Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

--# Modules
local Tween = require(script.Parent.Modules.Tween)

--# Variables
local buttonTween = TweenInfo.new(
	0.15,
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.Out,
	0,
	true
)

local containerTween = TweenInfo.new(
	0.3,
	Enum.EasingStyle.Quint,
	Enum.EasingDirection.Out
)

local helpSystemRemotes = ReplicatedStorage:WaitForChild("Help System")
local helpEvent = helpSystemRemotes:WaitForChild("Help Event")
local helpFunction = helpSystemRemotes:WaitForChild("Help Function")

local gui = script.Parent

local frame = gui.Frame

local container = frame.Container
local buttons = frame.Buttons

local header = container.Header
local screens = container.Screens

local requestsOn, requestsDebounce = false, false

--## Dragging
local dragging
local dragInput
local dragStart
local startPos

--# Functions
local function updateDrag(input)
	local delta = input.Position - dragStart
	container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

local function toggleRequests()
	local requestsFrame = frame['RequestsFrame']
	if not requestsFrame then
		return
	end
	if requestsDebounce then
		return
	end
	requestsDebounce = true
	if requestsOn then
		for _, v in ipairs(requestsFrame:GetDescendants()) do
			if v.Name ~= 'Template' and v.Parent.Name ~= 'Template' then
				if v:IsA("Frame") then
					Tween.Quick(v, { BackgroundTransparency = 1 })
				end
				if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
					Tween.Quick(v, { TextTransparency = 1, BackgroundTransparency = 1 })
				end
				if v:IsA("ImageButton") or v:IsA("ImageLabel") then
					Tween.Quick(v, { ImageTransparency = 1, BackgroundTransparency = 1 })
				end
			end
		end
		Tween.Quick(requestsFrame, { BackgroundTransparency = 1 }).Completed:Wait()
		requestsFrame.Visible = false
	else
		requestsFrame.Visible = true
		Tween.Quick(requestsFrame, { BackgroundTransparency = 0 })
		Tween.Quick(requestsFrame.Header, { BackgroundTransparency = 0 })
		Tween.Quick(requestsFrame.Header.Frame, { BackgroundTransparency = 0 })
		Tween.Quick(requestsFrame.Header.TextLabel, { TextTransparency = 0 })
		Tween.Quick(requestsFrame.Header.Title, { TextTransparency = 0 })
		for _, v in ipairs(requestsFrame.Screens.ScrollingFrame:GetChildren()) do
			if not (v:IsA("UIListLayout")) and not (v:IsA("UIPadding")) then
				Tween.Quick(v, { BackgroundTransparency = 0 })
				Tween.Quick(v.Rank, { TextTransparency = 0 })
				Tween.Quick(v.Username, { TextTransparency = 0 })
				Tween.Quick(v.ProfilePicture, { ImageTransparency = 0 })
			end
		end
		requestsFrame.Screens.Details.BackgroundTransparency = 0
		requestsFrame.Screens.Details.Rank.TextTransparency = 0
		requestsFrame.Screens.Details.Username.TextTransparency = 0
		requestsFrame.Screens.Details.HeaderReason.TextTransparency = 0
		requestsFrame.Screens.Details.HeaderUsername.TextTransparency = 0
		requestsFrame.Screens.Details.ProfilePicture.ImageTransparency = 0
		requestsFrame.Screens.Details.Submit.BackgroundTransparency = 0
		requestsFrame.Screens.Details.Submit.TextTransparency = 0
		requestsFrame.Screens.Details.Delete.BackgroundTransparency = 0
		requestsFrame.Screens.Details.Delete.TextTransparency = 0
		requestsFrame.Screens.Details.BackButton.BackgroundTransparency = 0
		requestsFrame.Screens.Details.BackButton.TextTransparency = 0
		requestsFrame.Screens.Details.Reason.TextLabel.TextTransparency = 0
	end
	requestsOn = not requestsOn
	requestsDebounce = false
end

local function closeGui()
	for _, v in ipairs(container:GetDescendants()) do
		if v:IsA("Frame") then
			Tween.Quick(v, { BackgroundTransparency = 1 })
		end
		if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
			Tween.Quick(v, { TextTransparency = 1, BackgroundTransparency = 1 })
		end
	end
	Tween.Quick(container, { BackgroundTransparency = 1 }).Completed:Wait()
	container.Visible = false
	screens.Success.Position = UDim2.fromScale(0.5, 1)
	screens.Error.Position = UDim2.fromScale(0.5, 1)
	screens.Submission.TextBox.Text = ''
end

local function openGui()
	container.Visible = true

	screens.Success.BackgroundTransparency = 0
	screens.Success.Cancel.BackgroundTransparency = 0
	screens.Success.Cancel.TextTransparency = 0
	screens.Success.TextLabel.TextTransparency = 0

	screens.Error.BackgroundTransparency = 0
	screens.Error.Cancel.BackgroundTransparency = 0
	screens.Error.Cancel.TextTransparency = 0
	screens.Error.TextLabel.TextTransparency = 0

	Tween.Quick(screens.Submission.Cancel, { TextTransparency = 0, BackgroundTransparency = 0 })
	Tween.Quick(screens.Submission.Submit, { TextTransparency = 0, BackgroundTransparency = 0 })
	Tween.Quick(screens.Submission.TextBox, { TextTransparency = 0, BackgroundTransparency = 0 })

	Tween.Quick(container.Header, { BackgroundTransparency = 0 })
	Tween.Quick(container.Header.Frame, { BackgroundTransparency = 0 })
	Tween.Quick(container.Header.Title, { TextTransparency = 0 })
	Tween.Quick(container.Header.TextLabel, { TextTransparency = 0 })

	Tween.Quick(container, { BackgroundTransparency = 0 }).Completed:Wait()
end

--# Implicits
for _, v in ipairs(buttons:GetChildren()) do
	if v:IsA("GuiButton") then
		local originalPos = v.Button.Position
		v.Button.Activated:Connect(function()
			if v.Name == 'Help' then
				coroutine.wrap(openGui)()
			end
			if v.Name == 'Requests' then
				coroutine.wrap(toggleRequests)()
			end
			local tween = TweenService:Create(v.Button, buttonTween, { Position = UDim2.fromScale(0.5, 0.5) })
			tween:Play()
			tween.Completed:Wait()
			v.Button.Position = originalPos
		end)
	end
end

screens.Submission.Submit.Activated:Connect(function()
	local success, response = helpFunction:InvokeServer("Submit", screens.Submission.TextBox.Text)
	if success == 'Success' then
		Tween.CustomSpeed(1.5, screens.Success, { Position = UDim2.fromScale(0.5, 0) })
	else
		screens.Error.TextLabel.Text = "<b><font color='#cf6679'>ERROR!</font></b>\n".. response
		Tween.CustomSpeed(1.5, screens.Error, { Position = UDim2.fromScale(0.5, 0) })
	end
end)


header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = container.Position

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

screens.Submission.Cancel.Activated:Connect(closeGui)
screens.Success.Cancel.Activated:Connect(closeGui)
screens.Error.Cancel.Activated:Connect(closeGui)