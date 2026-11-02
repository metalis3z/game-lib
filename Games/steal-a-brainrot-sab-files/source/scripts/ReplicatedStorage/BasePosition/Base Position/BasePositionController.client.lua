local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Net = require(ReplicatedStorage.Packages.Net)
local SetBasePosition = Net:RemoteFunction("PlotService/SetBasePosition")

local NotificationController
pcall(function()
	NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
end)

local Frame = script.Parent
local Header = Frame:WaitForChild("Header")
local CloseButton = Header:WaitForChild("Close")

local busy = false

local function selectPosition(number)
	if busy then return end
	busy = true

	local ok, message = SetBasePosition:InvokeServer(number)
	busy = false

	if ok then
		Frame.Visible = false
	else
		if NotificationController then
			NotificationController:Error(message or "Could not move base")
		end
	end
end

-- Wire up the 8 base buttons
for i = 1, 8 do
	local button = Frame:FindFirstChild("Base " .. i)
	if button and button:IsA("TextButton") then
		button.Activated:Connect(function()
			selectPosition(i)
		end)
	end
end

-- Close button
CloseButton.Activated:Connect(function()
	Frame.Visible = false
end)

-- Toggle the GUI with the B key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.B then
		Frame.Visible = not Frame.Visible
	end
end)