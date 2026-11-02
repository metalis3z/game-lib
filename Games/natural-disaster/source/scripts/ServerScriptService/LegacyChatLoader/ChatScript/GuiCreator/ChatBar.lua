-- // Creates and manages the chat bar the player types in to send chat messages.

local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local Chat = game:GetService("Chat")
local StarterGui = game:GetService("StarterGui")

local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local Remotes = Chat:WaitForChild("Remotes")
local TypedInChatBar = Remotes:WaitForChild("TypedInChatBar")
local StoppedTypingInChatBar = Remotes:WaitForChild("StoppedTypingInChatBar")

local ChatScript = script.Parent.Parent
local ChatInterface = require(ChatScript.ChatInterface)
local MessageMode = require(ChatScript.ChatInterface.MessageMode)
local ChatCommandInterface = require(ChatScript.ChatCommandInterface)
local WindowFocused = require(ChatScript.ChatInterface.WindowFocused)
local ChatBarInfo = require(ChatScript.ChatInterface.ChatBarInfo)

local ChatBar = {}

local chatBarParentFrame

function ChatBar.create()
	local baseChatBarParentFrameSize = UDim2.new(1, 0, 0, 42)
	if ChatConstants.WindowResizeable then
		baseChatBarParentFrameSize += UDim2.fromOffset(-44, 0)
	end

	chatBarParentFrame = Instance.new("Frame")
	chatBarParentFrame.Name = "ChatBarParentFrame"
	chatBarParentFrame.BackgroundTransparency = 1
	chatBarParentFrame.Position = UDim2.new(0, 0, 1, -42)
	chatBarParentFrame.Size = baseChatBarParentFrameSize

	local frame = Instance.new("Frame")
	frame.Name = "Frame"
	frame.BackgroundColor3 = ChatConstants.GuiColors.Background
	frame.BackgroundTransparency = 0.6
	frame.BorderSizePixel = 0
	frame.Size = UDim2.fromScale(1, 1)

	local boxFrame = Instance.new("Frame")
	boxFrame.Name = "BoxFrame"
	boxFrame.BackgroundColor3 = ChatConstants.GuiColors.TextBoxBackground
	boxFrame.BackgroundTransparency = 0.6
	boxFrame.BorderSizePixel = 0
	boxFrame.Position = UDim2.fromOffset(7, 7)
	boxFrame.Size = UDim2.new(1, -14, 1, -14)

	local boxFrameCover = Instance.new("Frame")
	boxFrameCover.Name = "Cover"
	boxFrameCover.BackgroundColor3 = Color3.new(.5, .5, .5)
	boxFrameCover.BackgroundTransparency = 0.5
	boxFrameCover.BorderSizePixel = 0
	boxFrameCover.Size = UDim2.fromScale(1, 1)
	boxFrameCover.Visible = false
	boxFrameCover.ZIndex = 4
	boxFrameCover.Parent = boxFrame

	local chatBarFrame = Instance.new("Frame")
	chatBarFrame.Name = "ChatBarFrame"
	chatBarFrame.BackgroundTransparency = 1
	chatBarFrame.Position = UDim2.fromOffset(5, 5)
	chatBarFrame.Size = UDim2.new(1, -10, 1, -10)

	local chatBar = Instance.new("TextBox")
	chatBar.Name = "ChatBar"
	chatBar.BackgroundTransparency = 1
	chatBar.ClearTextOnFocus = false
	chatBar.CursorPosition = -1
	chatBar.FontFace = Font.new(
		"rbxasset://fonts/families/SourceSansPro.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	chatBar.Selectable = false
	chatBar.Size = UDim2.fromScale(1, 1)
	chatBar.Text = ""
	chatBar.TextColor3 = ChatConstants.GuiColors.TextBoxText
	chatBar.TextSize = 18
	chatBar.TextTransparency = 0.4
	chatBar.TextWrapped = true
	chatBar.TextXAlignment = Enum.TextXAlignment.Left
	chatBar.TextYAlignment = Enum.TextYAlignment.Top
	chatBar.Parent = chatBarFrame

	local placeholderText = Instance.new("TextLabel")
	placeholderText.Name = "PlaceholderText"
	placeholderText.BackgroundTransparency = 1
	placeholderText.FontFace = Font.new(
		"rbxasset://fonts/families/SourceSansPro.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	placeholderText.Size = UDim2.fromScale(1, 1)
	placeholderText.Text = `To chat click here or press "{string.char(ChatConstants.ChatKey.Value)}" key`
	placeholderText.TextColor3 = ChatConstants.GuiColors.TextBoxText
	placeholderText.TextSize = 18
	placeholderText.TextTransparency = 0.4
	placeholderText.TextWrapped = true
	placeholderText.TextXAlignment = Enum.TextXAlignment.Left
	placeholderText.TextYAlignment = Enum.TextYAlignment.Top
	placeholderText.Parent = chatBarFrame

	local messageModeLabel = Instance.new("TextButton")
	messageModeLabel.Name = "MessageMode"
	messageModeLabel.BackgroundTransparency = 1
	messageModeLabel.FontFace = Font.new(
		"rbxasset://fonts/families/SourceSansPro.json",
		Enum.FontWeight.Bold,
		Enum.FontStyle.Normal
	)
	messageModeLabel.Selectable = false
	messageModeLabel.Size = UDim2.fromScale(0, 1)
	messageModeLabel.Text = "[Team]"
	messageModeLabel.TextSize = 18
	messageModeLabel.TextTransparency = 0.4
	messageModeLabel.TextWrapped = true
	messageModeLabel.TextXAlignment = Enum.TextXAlignment.Left
	messageModeLabel.Visible = false
	messageModeLabel.Parent = chatBarFrame

	chatBarFrame.Parent = boxFrame

	boxFrame.Parent = frame

	frame.Parent = chatBarParentFrame

	local function onMessageModeChanged(newMessageModeProperties: MessageMode.messageModePropertiesType?)
		if newMessageModeProperties ~= nil then
			messageModeLabel.Text = string.format(ChatConstants.MessageModeSourceCasing, newMessageModeProperties.displayText)
			messageModeLabel.TextColor3 = newMessageModeProperties.color
			messageModeLabel.Visible = true

			local textSizeBounds = TextService:GetTextSize(messageModeLabel.Text, messageModeLabel.TextSize, messageModeLabel.Font, Vector2.new(math.huge, math.huge))
			messageModeLabel.Size = UDim2.fromOffset(textSizeBounds.X+2, textSizeBounds.Y)
			chatBar.Position = UDim2.fromOffset(textSizeBounds.X+2, 0)
			chatBar.Size = UDim2.new(1, -textSizeBounds.X-2, 1, 0)
		else
			-- Clear message mode
			messageModeLabel.Visible = false

			chatBar.Position = UDim2.fromOffset(0, 0)
			chatBar.Size = UDim2.fromScale(1, 1)
		end
	end


	local function onMessageEntered()
		if chatBar.Text == "" then
			return
		end
		if ChatConstants.AllowBlankMessages == false and ChatUtil.checkIsBlankString(chatBar.Text) == true then
			return
		end

		boxFrameCover.Visible = true
		chatBar.TextEditable = false

		ChatInterface.processMessageAsync(chatBar.Text)

		boxFrameCover.Visible = false
		chatBar.Text = ""
		chatBar.TextEditable =  true
	end

	chatBar.Focused:Connect(function()
		placeholderText.Visible = false
		WindowFocused.set(true)

		ChatBarInfo.set("focused", true)
		WindowFocused.update()
	end)

	chatBar.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			onMessageEntered()
		end

		if chatBar.Text == "" and messageModeLabel.Visible == false then
			placeholderText.Visible = true
		end

		WindowFocused.scheduleUnfocus()

		ChatBarInfo.set("focused", false)
		WindowFocused.update()

		if ChatConstants.ShowWhenPlayerIsTyping then
			StoppedTypingInChatBar:FireServer()
		end
	end)
	
	messageModeLabel.MouseButton1Down:Connect(function()
		MessageMode.set(nil)
	end)

	local chatBarTextAMomentAgo = ""
	chatBar:GetPropertyChangedSignal("Text"):Connect(function()
		if ChatConstants.ShowWhenPlayerIsTyping then
			if chatBar.Text == "" then
				StoppedTypingInChatBar:FireServer()
			else
				TypedInChatBar:FireServer()
			end
		end

		if chatBar.Text ~= "" then
			placeholderText.Visible = false
		end

		if string.len(chatBar.Text) > ChatConstants.MessageCharacterLimit then
			chatBar.Text = string.sub(chatBar.Text, 1, ChatConstants.MessageCharacterLimit)
		end

		if string.sub(chatBar.Text, 1, string.len(ChatConstants.CommandPrefix)) == ChatConstants.CommandPrefix then
			-- Player is typing a command
			local messageWithoutPrefix = string.sub(chatBar.Text, string.len(ChatConstants.CommandPrefix) + 1)
			local split = string.split(messageWithoutPrefix, " ")

			local command, originalCommandName = ChatCommandInterface.getCommandInfo(split[1])
			ChatUtil.debugPrint(command, originalCommandName)

			if command ~= nil then
				if MessageMode.get() == nil and command.shouldEnableMessageMode ~= nil then
					local shouldEnable, internalName, displayText, color, metadata = command.shouldEnableMessageMode(chatBar.Text)
					if shouldEnable then
						-- Set message mode
						chatBar.Text = ""
						MessageMode.set({
							commandName = originalCommandName,
							name = internalName,
							displayText = displayText,
							color = color,
							metadata = metadata
						})
					end
				end
			end
		end

		local textSizeBounds = TextService:GetTextSize(chatBar.Text, chatBar.TextSize, chatBar.Font, Vector2.new(chatBarFrame.AbsoluteSize.X, math.huge))
		chatBarParentFrame.Size = baseChatBarParentFrameSize + UDim2.fromOffset(0, textSizeBounds.Y - chatBar.TextSize)

		ChatBarInfo.set("text", chatBar.Text)

		-- If we don't do this, deleting the character after the message mode will immediately delete the message mode
		-- ex: Backspacing on "[Team] a" will delete everything, because the text changing registers before the clear message mode check
		task.wait()
		chatBarTextAMomentAgo = chatBar.Text
	end)

	local contextActionFunctions = {
		OpenChat = function()
			if StarterGui:GetCore("ChatActive") == false then	
				StarterGui:SetCore("ChatActive", true)
			end

			task.wait() -- Ensures the key used to focus on the chat bar doesn't get used as input in the chat bar
			chatBar:CaptureFocus()
		end,
	}

	local function handleAction(actionName: string, inputState: Enum.UserInputState, inputObject: InputObject)
		if inputState ~= Enum.UserInputState.Begin then
			return Enum.ContextActionResult.Pass
		end
		if contextActionFunctions[actionName] then
			contextActionFunctions[actionName](actionName, inputState, inputObject)
		end
	end

	local readyToDeleteMessageMode = false
	UserInputService.InputBegan:Connect(function(input, processed)
		if not processed then
			return
		end
		if input.KeyCode ~= Enum.KeyCode.Backspace then
			return
		end

		if chatBar:IsFocused() and MessageMode.get() ~= nil and chatBarTextAMomentAgo == "" then
			-- Backspaced on an empty chatbar; clear message mode
			MessageMode.set(nil)
		end
	end)

	ContextActionService:BindActionAtPriority("OpenChat", handleAction, false, 5, ChatConstants.ChatKey)
	MessageMode.getBindable().Event:Connect(onMessageModeChanged)

	return chatBarParentFrame
end

return ChatBar