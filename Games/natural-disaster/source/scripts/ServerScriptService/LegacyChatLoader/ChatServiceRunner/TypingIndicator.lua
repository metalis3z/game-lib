-- // Handles indicators for when players are typing in chat.

local Chat = game:GetService("Chat")

local Shared = Chat:WaitForChild("Shared")
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local Remotes = Chat:WaitForChild("Remotes")
local TypedInChatBar = Remotes:WaitForChild("TypedInChatBar")
local StoppedTypingInChatBar = Remotes:WaitForChild("StoppedTypingInChatBar")

local TypingIndicator = {}

local playersTyping: {[Player]: boolean?} = {}
local playersTypingAnimateThreads: {[Player]: thread?} = {}
local playersTypingStopThreads: {[Player]: thread?} = {}

local function createGui(): BillboardGui
	local typingGui = Instance.new("BillboardGui")
	typingGui.Name = "TypingGui"
	typingGui.Size = UDim2.fromOffset(100, 100)
	typingGui.StudsOffset = Vector3.new(1.4, 0.7, 0)
	typingGui.ExtentsOffset = Vector3.new(0, 0, 1)
	typingGui.MaxDistance = 45

	local billboardFrame = Instance.new("Frame")
	billboardFrame.Name = "BillboardFrame"
	billboardFrame.BackgroundTransparency = 1
	billboardFrame.Position = UDim2.fromScale(0.5, -0.5)
	billboardFrame.Size = UDim2.fromScale(1, 1)

	local bubble = Instance.new("ImageLabel")
	bubble.Name = "Bubble"
	bubble.AnchorPoint = Vector2.new(0.5, 1)
	bubble.BackgroundTransparency = 1
	bubble.BorderSizePixel = 0
	bubble.Image = "rbxassetid://91960039863799"
	bubble.Position = UDim2.new(0.5, 0, 1, -14)
	bubble.Size = UDim2.fromOffset(50, 40)
	bubble.SliceCenter = Rect.new(5, 5, 15, 15)

	local bubbleText = Instance.new("TextLabel")
	bubbleText.Name = "BubbleText"
	bubbleText.AnchorPoint = Vector2.new(0.5, 0)
	bubbleText.BackgroundTransparency = 1
	bubbleText.ClipsDescendants = true
	bubbleText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
	bubbleText.Position = UDim2.fromScale(0.5, 0)
	bubbleText.Size = UDim2.fromScale(0.8, 1)
	bubbleText.Text = ""
	bubbleText.TextSize = 24
	bubbleText.TextXAlignment = Enum.TextXAlignment.Left

	local uIPadding = Instance.new("UIPadding")
	uIPadding.Name = "UIPadding"
	uIPadding.PaddingBottom = UDim.new(0, 12)
	uIPadding.PaddingLeft = UDim.new(0, 12)
	uIPadding.PaddingRight = UDim.new(0, 12)
	uIPadding.PaddingTop = UDim.new(0, 12)
	uIPadding.Parent = bubbleText

	bubbleText.Parent = bubble

	local tailFrame = Instance.new("Frame")
	tailFrame.Name = "TailFrame"
	tailFrame.AnchorPoint = Vector2.new(0.5, 0)
	tailFrame.BackgroundTransparency = 1
	tailFrame.Position = UDim2.new(0, -5, 1, -10)
	tailFrame.Rotation = 70
	tailFrame.Size = UDim2.fromOffset(10, 20)
	tailFrame.SizeConstraint = Enum.SizeConstraint.RelativeXX

	local tail = Instance.new("ImageLabel")
	tail.Name = "Tail"
	tail.AnchorPoint = Vector2.new(0.5, 0)
	tail.BackgroundTransparency = 1
	tail.BorderSizePixel = 0
	tail.Image = "rbxassetid://114342666659291"
	tail.Position = UDim2.fromScale(0.5, 0)
	tail.Size = UDim2.fromScale(1, 1)
	tail.Parent = tailFrame

	tailFrame.Parent = bubble

	bubble.Parent = billboardFrame

	billboardFrame.Parent = typingGui
	
	return typingGui
end

local function cancelPlayerTyping(player: Player)
	if playersTypingAnimateThreads[player] ~= nil then
		task.cancel(playersTypingAnimateThreads[player])
		playersTypingAnimateThreads[player] = nil
	end
	
	local character = player.Character
	if character ~= nil then
		local typingGui = character:FindFirstChild("TypingGui")
		if typingGui ~= nil then
			typingGui:Destroy()
		end
	end
	
	if playersTypingStopThreads[player] ~= nil then
		task.cancel(playersTypingStopThreads[player])
		playersTypingStopThreads[player] = nil
	end
end

local function onPlayerTyped(player: Player)
	local character = player.Character
	local typingGui = character:FindFirstChild("TypingGui")
	if typingGui == nil then
		local adornee = character:FindFirstChild("Head")
		if adornee == nil then
			adornee = character
		end
		
		typingGui = createGui()
		typingGui.Parent = character
		typingGui.Adornee = adornee
		
		local bubbleTextLabel: TextLabel = typingGui.BillboardFrame.Bubble.BubbleText
		
		playersTypingAnimateThreads[player] = task.spawn(function()
			while typingGui:IsDescendantOf(workspace) do
				bubbleTextLabel.Text = "."
				task.wait(.3)
				bubbleTextLabel.Text = ".."
				task.wait(.3)
				bubbleTextLabel.Text = "..."
				task.wait(.3)
			end
		end)
	end
	playersTyping[player] = true
	
	if playersTypingStopThreads[player] ~= nil then
		task.cancel(playersTypingStopThreads[player])
	end
	playersTypingStopThreads[player] = task.delay(3, function()
		playersTypingStopThreads[player] = nil
		cancelPlayerTyping(player)
	end)
end

function TypingIndicator.init()
	if not ChatConstants.ShowWhenPlayerIsTyping then
		return
	end
	
	TypedInChatBar.OnServerEvent:Connect(onPlayerTyped)
	StoppedTypingInChatBar.OnServerEvent:Connect(cancelPlayerTyping)
end

return TypingIndicator