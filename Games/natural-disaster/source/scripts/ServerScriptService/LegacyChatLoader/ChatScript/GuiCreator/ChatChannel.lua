-- // Creates and manages the frame in which messages are displayed.

local Chat = game:GetService("Chat")

local Shared = Chat:WaitForChild("Shared")
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local ChatScript = script.Parent.Parent
local Message = require(script.Message)
local MessageLog = require(ChatScript.ChatInterface.MessageLog)

local ChatChannel = {}

function ChatChannel.create()
	local chatChannelParentFrame = Instance.new("Frame")
	chatChannelParentFrame.Name = "ChatChannelParentFrame"
	chatChannelParentFrame.BackgroundColor3 = ChatConstants.GuiColors.Background
	chatChannelParentFrame.BackgroundTransparency = 0.6
	chatChannelParentFrame.BorderSizePixel = 0
	chatChannelParentFrame.Position = UDim2.fromOffset(0, 2)
	chatChannelParentFrame.Size = UDim2.new(1, 0, 1, -46)

	local frameMessageLogDisplay = Instance.new("Frame")
	frameMessageLogDisplay.Name = "Frame_MessageLogDisplay"
	frameMessageLogDisplay.BackgroundTransparency = 1
	frameMessageLogDisplay.Size = UDim2.fromScale(1, 1)

	local scroller = Instance.new("ScrollingFrame")
	scroller.Name = "Scroller"
	scroller.Active = true
	scroller.BackgroundTransparency = 1
	scroller.BorderSizePixel = 0
	scroller.CanvasSize = UDim2.fromOffset(0, 0)
	scroller.Position = UDim2.fromOffset(0, 3)
	scroller.ScrollBarThickness = 4
	scroller.Selectable = false
	scroller.ScrollingDirection = Enum.ScrollingDirection.Y
	scroller.Size = UDim2.new(1, -4, 1, -6)
	
	scroller.AutomaticCanvasSize = Enum.AutomaticSize.Y

	local uIListLayout = Instance.new("UIListLayout")
	uIListLayout.Name = "UIListLayout"
	uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout.Parent = scroller

	scroller.Parent = frameMessageLogDisplay

	frameMessageLogDisplay.Parent = chatChannelParentFrame
	
	local lastAbsoluteCanvasSize = scroller.AbsoluteCanvasSize
	scroller:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
		if scroller.AbsoluteWindowSize.Y >= scroller.AbsoluteCanvasSize.Y then
			-- The current window size can fit all of its contents, which means no scroll bar exists yet
			return
		end
		
		task.wait() -- Wait for position to be set
		
		local newAbsoluteCanvasSize = scroller.AbsoluteCanvasSize
		local difference = newAbsoluteCanvasSize.Y - lastAbsoluteCanvasSize.Y
		
		local scrollablePixels = scroller.AbsoluteCanvasSize.Y - scroller.AbsoluteSize.Y
		local pixelsFromBottom = scrollablePixels - scroller.CanvasPosition.Y
		
		if pixelsFromBottom - math.max(0, difference) < 5 then
			-- Hacky workaround for scroller sometimes not shifting downwards properly
			scroller.CanvasPosition += Vector2.new(0, 999999999999)
		elseif difference > 0 then -- If difference is negative, an object is being removed, which causes the scroll bar to move down anyways
			-- Shift scroll bar down by Y difference
			scroller.CanvasPosition += Vector2.new(0, difference)
		end
		
		lastAbsoluteCanvasSize = newAbsoluteCanvasSize
	end)
	
	MessageLog.registerMessageAddedCallback(function(textChatMessage)
		local frame = Message.create(textChatMessage)
		frame.Parent = scroller
		frame.LayoutOrder = ChatConstants.MessageLogLimit
		
		-- Shift all other messages' LayoutOrders down by 1
		for _,v in scroller:GetChildren() do
			if v:IsA("Frame") then
				v.LayoutOrder -= 1
			end
		end
	end)
	
	MessageLog.registerMessageOverflowCallback(function(textChatMessage)
		-- Delete message
		local frame = scroller:FindFirstChild(textChatMessage.MessageId)
		if frame then
			frame:Destroy()
		end
	end)
	
	return chatChannelParentFrame
end

return ChatChannel