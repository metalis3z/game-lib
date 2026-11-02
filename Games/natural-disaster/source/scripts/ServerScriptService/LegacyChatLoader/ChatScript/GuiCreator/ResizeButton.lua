-- // Creates and manages a draggable button that can resize the chat window.

local Chat = game:GetService("Chat")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local Shared = Chat:WaitForChild("Shared")
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local camera = workspace.CurrentCamera
local guiInsetMin, guiInsetMax = GuiService:GetGuiInset()

local ResizeButton = {}

function ResizeButton.create()
	local resizeButton = Instance.new("ImageButton")
	resizeButton.Name = "ResizeButton"
	resizeButton.BackgroundColor3 = ChatConstants.GuiColors.Background
	resizeButton.BackgroundTransparency = 0.6
	resizeButton.BorderSizePixel = 0
	resizeButton.Position = UDim2.new(1, -42, 1, -42)
	resizeButton.Selectable = false
	resizeButton.Size = UDim2.fromOffset(42, 42)

	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "ImageLabel"
	imageLabel.BackgroundTransparency = 1
	imageLabel.Image = "rbxassetid://261880743"
	imageLabel.ImageTransparency = 0.6
	imageLabel.Position = UDim2.fromScale(0.2, 0.2)
	imageLabel.Size = UDim2.fromScale(0.8, 0.8)
	imageLabel.Parent = resizeButton

	local dragThread: thread? = nil

	local function beginDragging()
		if dragThread ~= nil then
			return
		end
		local topFrame: Frame = resizeButton.Parent
		if topFrame == nil then
			return
		end

		dragThread = task.spawn(function()
			local mouseLocation = UserInputService:GetMouseLocation()
			local sizeMinimum, sizeMaximum = ChatConstants.ChatWindowSizeBoundsPixels.Minimum, ChatConstants.ChatWindowSizeBoundsPixels.Maximum
			if not ChatConstants.DefaultChatEnabled then
				sizeMinimum = Vector2.new(sizeMinimum.X, 42)
				sizeMaximum = Vector2.new(sizeMaximum.X, 42)
			end

			local defaultChatWindowSizeScale = ChatConstants.DefaultChatWindowSizeScale

			--[[
			-- Offset of the mouse's position relative to the button on first click
			local attachPointOffset = Vector2.new(
				(resizeButton.AbsolutePosition.X - mouseLocation.X),
				(resizeButton.AbsolutePosition.Y + 60 - mouseLocation.Y) -- The Y value of AbsolutePosition is 60px too far up because god knows why
			)
			]]

			while task.wait() do
				mouseLocation = UserInputService:GetMouseLocation()

				local sizeToPoint = mouseLocation
				sizeToPoint += Vector2.new(4, 4)
				sizeToPoint -= Vector2.new(0, 60) -- The Y value of AbsolutePosition is 60px too far up because god knows why

				local newSizePixels = Vector2.new(
					math.clamp(sizeToPoint.X - topFrame.AbsolutePosition.X, sizeMinimum.X, sizeMaximum.X),
					math.clamp(sizeToPoint.Y - topFrame.AbsolutePosition.Y, sizeMinimum.Y, sizeMaximum.Y)
				)

				-- Snap either axis to default size if close enough
				local safeAreaPixels: Vector2 = camera.ViewportSize - guiInsetMin - guiInsetMax
				local minimumSize = ChatConstants.ChatWindowSizeBoundsPixels.Minimum
				local defaultChatWindowSizePixels = safeAreaPixels * defaultChatWindowSizeScale

				local offsetToDefaultSize = defaultChatWindowSizePixels - newSizePixels
				local newX, newY = newSizePixels.X, newSizePixels.Y

				if math.abs(offsetToDefaultSize.X) < 10 then
					newX = defaultChatWindowSizePixels.X
				end
				if math.abs(offsetToDefaultSize.Y) < 10 then
					newY = defaultChatWindowSizePixels.Y
				end

				newSizePixels = Vector2.new(newX, newY)

				local newSize = UDim2.fromOffset(newSizePixels.X, newSizePixels.Y)

				topFrame.Size = newSize
			end
		end)
	end

	local function stopDragging()
		if dragThread ~= nil then
			task.cancel(dragThread)
			dragThread = nil
		end
	end

	resizeButton.MouseButton1Down:Connect(beginDragging)
	UserInputService.InputEnded:Connect(function(input, _gameProcessedEvent)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			stopDragging()
		end
	end)

	return resizeButton
end

return ResizeButton