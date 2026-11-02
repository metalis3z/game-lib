-- // Renders and animates chat bubbles.

-- Some of this code is ripped from the original BubbleChat script.

local Players = game:GetService("Players")
local TextService = game:GetService("TextService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Chat = game:GetService("Chat")

local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local MAX_BUBBLE_WIDTH = 400

local MAX_TOTAL_BUBBLE_HEIGHT = 150

local NEAR_BUBBLE_DISTANCE = 45
local MAX_BUBBLE_DISTANCE = 80

local MIN_BUBBLE_LIFETIME = 12
local MAX_BUBBLE_LIFETIME = 20

local MIN_BUBBLE_LIFETIME_SELF = 8
local MAX_BUBBLE_LIFETIME_SELF = 15

local BUBBLE_FADE_TIME = 1.5

local function getMessageLength(message: string): number
	return utf8.len(utf8.nfcnormalize(message)) or 0
end

local ELLIPSES = "..."
local MaxChatMessageLength = 128 -- max chat message length, including null terminator and ellipses.
local MaxChatMessageLengthExclusive = MaxChatMessageLength - getMessageLength(ELLIPSES) - 1

local ChatScript = script.Parent
local MessageLog = require(ChatScript.ChatInterface.MessageLog)

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local resizeBubbleTweenInfo = TweenInfo.new(.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local shiftBubblesUpTweenInfo = TweenInfo.new(.07, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

local BubbleChat = {}

local chatBubbleQueues: {[PVInstance]: {BillboardGui}} = {} -- Most recent goes in front.

local function sanitizeChatLine(msg)
	if getMessageLength(msg) > MaxChatMessageLengthExclusive then
		local byteOffset = (utf8.offset(msg, MaxChatMessageLengthExclusive + getMessageLength(ELLIPSES) + 1) or 1) - 1
		return string.sub(msg, 1, byteOffset)
	else
		return msg
	end
end

local function lerpLength(msg: string, min: number, max: number): number
	return min + (max - min) * math.min(getMessageLength(msg) / 75.0, 1.0)
end

local function removeOldestFromQueue(adornee: PVInstance)
	local queue = chatBubbleQueues[adornee]
	if queue == nil then
		return
	end

	local oldestBubble = queue[#queue]
	if oldestBubble == nil then
		return
	end

	oldestBubble:Destroy()
	queue[#queue] = nil
	-- ChatUtil.debugPrint(queue)
end

local function addBubbleToQueue(adornee: PVInstance, chatBubble: BillboardGui, lifetime: number)
	local queue = chatBubbleQueues[adornee]
	if queue == nil then
		queue = {}
		chatBubbleQueues[adornee] = queue

		adornee.Destroying:Connect(function()
			chatBubbleQueues[adornee] = nil
		end)
	end

	local gap = 4
	local newChatBubbleSizeY = chatBubble.BillboardFrame.ChatBubble.AbsoluteSize.Y
	local totalYSpaceUsed = newChatBubbleSizeY
	for _,v in queue do
		if v.Parent == nil then
			continue
		end

		-- Shift all bubbles upwards to make space
		local shiftUp = newChatBubbleSizeY+gap
		local newPosition = v.BillboardFrame.Position - UDim2.fromOffset(0, shiftUp)
		TweenService:Create(v.BillboardFrame, shiftBubblesUpTweenInfo, {Position = newPosition}):Play()
		totalYSpaceUsed += v.BillboardFrame.ChatBubble.AbsoluteSize.Y

		-- Grey out text
		v.BillboardFrame.ChatBubble.BubbleText.TextTransparency = 0.5
	end
	if totalYSpaceUsed > MAX_TOTAL_BUBBLE_HEIGHT then
		removeOldestFromQueue(adornee)
	end

	table.insert(queue, 1, chatBubble)
	-- ChatUtil.debugPrint(queue)

	task.delay(lifetime+BUBBLE_FADE_TIME, function()
		if chatBubble.Parent ~= nil then -- Need to first check to make sure this hasn't already been destroyed
			removeOldestFromQueue(adornee)
		end
	end)
end

function BubbleChat.createBubbleFromTextChatMessage(textChatMessage: TextChatMessage)
	local textSource = textChatMessage.TextSource
	if textSource == nil then
		-- System messages have no physical source
		return
	end

	local adornee: PVInstance

	local player = Players:GetPlayerByUserId(textSource.UserId)
	local character = player.Character
	if character == nil then
		return
	end

	adornee = character:FindFirstChild("Head")
	if adornee == nil then
		adornee = character
	end

	BubbleChat.createBubble(adornee, textChatMessage.Text, player == localPlayer)
end

function BubbleChat.createBubble(adornee: PVInstance, message: string, sentBySelf: boolean?)
	-- Create chat bubble gui
	local chatBubbleGui = Instance.new("BillboardGui")
	chatBubbleGui.Name = "ChatBubbleGui"
	chatBubbleGui.Size = UDim2.fromOffset(400, 250)

	local billboardFrame = Instance.new("Frame")
	billboardFrame.Name = "BillboardFrame"
	billboardFrame.AnchorPoint = Vector2.new(0.5, 0)
	billboardFrame.BackgroundTransparency = 1
	billboardFrame.Position = UDim2.fromScale(0.5, -0.5)
	billboardFrame.Size = UDim2.fromScale(1, 1)

	local smallTalkBubble = Instance.new("ImageLabel")
	smallTalkBubble.Name = "SmallTalkBubble"
	smallTalkBubble.AnchorPoint = Vector2.new(0.5, 1)
	smallTalkBubble.BackgroundTransparency = 1
	smallTalkBubble.BorderSizePixel = 0
	smallTalkBubble.Image = "rbxasset://textures/ui/dialog_white.png"
	smallTalkBubble.ImageColor3 = ChatConstants.GuiColors.BubbleBackground
	smallTalkBubble.Position = UDim2.fromScale(0.5, 1)
	smallTalkBubble.ScaleType = Enum.ScaleType.Slice
	smallTalkBubble.Size = UDim2.fromOffset(40, 30)
	smallTalkBubble.SliceCenter = Rect.new(5, 5, 15, 15)
	smallTalkBubble.Visible = false

	local smallTalkBubbleText = Instance.new("TextLabel")
	smallTalkBubbleText.Name = "BubbleText"
	smallTalkBubbleText.BackgroundTransparency = 1
	smallTalkBubbleText.ClipsDescendants = true
	smallTalkBubbleText.Font = ChatConstants.BubbleFont
	smallTalkBubbleText.Size = UDim2.fromScale(1, 1)
	smallTalkBubbleText.Text = "..."
	smallTalkBubbleText.TextColor3 = ChatConstants.GuiColors.BubbleText
	smallTalkBubbleText.TextSize = ChatConstants.BubbleTextSize

	local smallTalkBubbleUIPadding = Instance.new("UIPadding")
	smallTalkBubbleUIPadding.Name = "UIPadding"
	smallTalkBubbleUIPadding.PaddingBottom = UDim.new(0, 12)
	smallTalkBubbleUIPadding.PaddingLeft = UDim.new(0, 12)
	smallTalkBubbleUIPadding.PaddingRight = UDim.new(0, 12)
	smallTalkBubbleUIPadding.PaddingTop = UDim.new(0, 12)
	smallTalkBubbleUIPadding.Parent = smallTalkBubbleText

	smallTalkBubbleText.Parent = smallTalkBubble

	local chatBubbleTailFrame = Instance.new("Frame")
	chatBubbleTailFrame.Name = "ChatBubbleTailFrame"
	chatBubbleTailFrame.BackgroundTransparency = 1
	chatBubbleTailFrame.Position = UDim2.fromScale(0.5, 1)
	chatBubbleTailFrame.Size = UDim2.fromScale(0.5, 0.5)
	chatBubbleTailFrame.SizeConstraint = Enum.SizeConstraint.RelativeXX

	local chatBubbleTail = Instance.new("ImageLabel")
	chatBubbleTail.Name = "ChatBubbleTail"
	chatBubbleTail.BackgroundTransparency = 1
	chatBubbleTail.BorderSizePixel = 0
	chatBubbleTail.Image = "rbxasset://textures/ui/dialog_tail.png"
	chatBubbleTail.ImageColor3 = ChatConstants.GuiColors.BubbleBackground
	chatBubbleTail.Position = UDim2.fromScale(-0.5, 0)
	chatBubbleTail.Size = UDim2.fromScale(1, 0.5)
	chatBubbleTail.Parent = chatBubbleTailFrame

	chatBubbleTailFrame.Parent = smallTalkBubble

	smallTalkBubble.Parent = billboardFrame

	local chatBubble = Instance.new("ImageLabel")
	chatBubble.Name = "ChatBubble"
	chatBubble.AnchorPoint = Vector2.new(0.5, 1)
	chatBubble.BackgroundTransparency = 1
	chatBubble.BorderSizePixel = 0
	chatBubble.Image = "rbxasset://textures/ui/dialog_white.png"
	chatBubble.ImageColor3 = ChatConstants.GuiColors.BubbleBackground
	chatBubble.Position = UDim2.fromScale(0.5, 1)
	chatBubble.ScaleType = Enum.ScaleType.Slice
	chatBubble.SliceCenter = Rect.new(5, 5, 15, 15)
	chatBubble.Visible = false

	local bubbleText = Instance.new("TextLabel")
	bubbleText.Name = "BubbleText"
	bubbleText.BackgroundTransparency = 1
	bubbleText.ClipsDescendants = true
	bubbleText.Font = ChatConstants.BubbleFont
	bubbleText.Size = UDim2.fromScale(1, 1)
	bubbleText.Text = ""
	bubbleText.TextColor3 = ChatConstants.GuiColors.BubbleText
	bubbleText.TextSize = ChatConstants.BubbleTextSize
	bubbleText.TextWrapped = true

	local uiPadding = Instance.new("UIPadding")
	uiPadding.Name = "UIPadding"
	uiPadding.PaddingBottom = UDim.new(0, 12)
	uiPadding.PaddingLeft = UDim.new(0, 12)
	uiPadding.PaddingRight = UDim.new(0, 12)
	uiPadding.PaddingTop = UDim.new(0, 12)
	uiPadding.Parent = bubbleText

	bubbleText.Parent = chatBubble

	chatBubble.Parent = billboardFrame

	local chatBubbleTail1 = Instance.new("ImageLabel")
	chatBubbleTail1.Name = "ChatBubbleTail"
	chatBubbleTail1.BackgroundTransparency = 1
	chatBubbleTail1.BorderSizePixel = 0
	chatBubbleTail1.Image = "rbxasset://textures/ui/dialog_tail.png"
	chatBubbleTail1.ImageColor3 = ChatConstants.GuiColors.BubbleBackground
	chatBubbleTail1.Position = UDim2.new(0.5, -14, 1, 0)
	chatBubbleTail1.Size = UDim2.fromOffset(30, 14)
	chatBubbleTail1.Visible = false
	chatBubbleTail1.Parent = billboardFrame

	billboardFrame.Parent = chatBubbleGui

	------------------------------------
	
	message = ChatUtil.convertRichTextEscapeStrings(message)

	local textSizeBounds = TextService:GetTextSize(message, bubbleText.TextSize, bubbleText.Font, Vector2.new(MAX_BUBBLE_WIDTH, math.huge))
	local multiline = textSizeBounds.Y > bubbleText.TextSize
	if not multiline then
		-- Single-line messages have less vertical padding
		uiPadding.PaddingTop = UDim.new(0, uiPadding.PaddingTop.Offset/2)
		uiPadding.PaddingBottom = UDim.new(0, uiPadding.PaddingBottom.Offset/2)
	end

	local chatBubbleSize = UDim2.fromOffset(
		textSizeBounds.X + uiPadding.PaddingLeft.Offset + uiPadding.PaddingRight.Offset + 1, -- Text size is JUST barely too small on mobile, for some reason
		textSizeBounds.Y + uiPadding.PaddingTop.Offset + uiPadding.PaddingBottom.Offset
	)

	-- Start a little bigger than normal and animate to regular size
	chatBubble.Size = UDim2.fromOffset(chatBubbleSize.X.Offset+10, chatBubbleSize.Y.Offset+10)

	local resizeTween = TweenService:Create(chatBubble, resizeBubbleTweenInfo, {Size = chatBubbleSize})
	resizeTween:Play()

	task.delay(resizeBubbleTweenInfo.Time, function()
		bubbleText.Text = message
	end)

	chatBubbleGui.Adornee = adornee
	chatBubbleGui.Parent = adornee

	local lifetime: number
	if sentBySelf then
		chatBubbleGui.StudsOffset = Vector3.new(0, 1.8, 0)
		lifetime = lerpLength(bubbleText.Text, MIN_BUBBLE_LIFETIME_SELF, MAX_BUBBLE_LIFETIME_SELF)
	else
		chatBubbleGui.StudsOffset = Vector3.new(0, 2.4, 0)
		lifetime = lerpLength(bubbleText.Text, MIN_BUBBLE_LIFETIME, MAX_BUBBLE_LIFETIME)
	end
	Debris:AddItem(chatBubbleGui, lifetime + BUBBLE_FADE_TIME + 0.1)

	task.delay(lifetime, function()
		local tweenInfo = TweenInfo.new(BUBBLE_FADE_TIME, Enum.EasingStyle.Linear)
		for _,v in chatBubbleGui:GetDescendants() do
			if v:IsA("ImageLabel") then
				TweenService:Create(v, tweenInfo, {ImageTransparency = 1}):Play()
			elseif v:IsA("TextLabel") then
				TweenService:Create(v, tweenInfo, {TextTransparency = 1}):Play()
			end
		end
	end)

	addBubbleToQueue(adornee, chatBubbleGui, lifetime)
end

function BubbleChat.init()
	MessageLog.registerMessageAddedCallback(BubbleChat.createBubbleFromTextChatMessage)

	task.spawn(function()
		while true do
			task.wait()
			for player,queue in chatBubbleQueues do
				if #queue == 0 then 
					continue
				end

				local mostRecentChatBubble = queue[1]

				local adornee: PVInstance = mostRecentChatBubble.Adornee
				local distanceFromAdornee = (camera.CFrame.Position - adornee:GetPivot().Position).Magnitude

				for i=1,#queue do
					local bubbleGui = queue[i]
					if bubbleGui.Parent == nil then
						continue
					end
					local billboardFrame = bubbleGui.BillboardFrame

					if distanceFromAdornee < NEAR_BUBBLE_DISTANCE then
						-- Display all
						if i == 1 then
							billboardFrame.ChatBubble.Visible = true
							billboardFrame.ChatBubbleTail.Visible = true

							billboardFrame.SmallTalkBubble.Visible = false

							bubbleGui.Enabled = true
						else
							billboardFrame.ChatBubble.Visible = true
							billboardFrame.ChatBubbleTail.Visible = false

							billboardFrame.SmallTalkBubble.Visible = false

							bubbleGui.Enabled = true
						end
					elseif distanceFromAdornee < MAX_BUBBLE_DISTANCE and i == 1 then
						-- Hide all except the most recent bubble, which will be turned into a small talk bubble
						billboardFrame.ChatBubble.Visible = false
						billboardFrame.ChatBubbleTail.Visible = false

						billboardFrame.SmallTalkBubble.Visible = true

						bubbleGui.Enabled = true
					else
						-- Hide all
						bubbleGui.Enabled = false
					end
				end
			end
		end
	end)
end

return BubbleChat