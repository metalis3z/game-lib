-- // Handles general chat functionality.

local TextChatService = game:GetService("TextChatService")
local Chat = game:GetService("Chat")

local TextChannels = TextChatService:WaitForChild("TextChannels")

local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local Remotes = Chat:WaitForChild("Remotes")
local RunChatCommand = Remotes:WaitForChild("RunChatCommand")

local CurrentChannel = require(script.CurrentChannel)
local MessageLog = require(script.MessageLog)
local MessageMode = require(script.MessageMode)
local WindowFocused = require(script.WindowFocused)
local ChatCommandInterface = require(script.Parent.ChatCommandInterface)
local SystemMessages = require(script.SystemMessages)

local processingMessage = false

local ChatInterface = {}

function ChatInterface.isProcessingMessage()
	return processingMessage
end

function ChatInterface.processMessageAsync(message: string)
	if processingMessage then
		return
	end
	
	processingMessage = true
	
	local metadata: string? = nil
	
	local rawCommandName: string? = nil
	
	local commandInfo = ChatUtil.getCommandInfoFromMessage(message)
	local messageModeProperties = MessageMode.get()
	
	if commandInfo.rawCommandName ~= nil then
		-- We can tell this is a command from the contents of the message
		rawCommandName = commandInfo.rawCommandName
	elseif messageModeProperties ~= nil then
		-- We can tell this is a command from a MessageMode existing
		rawCommandName = messageModeProperties.commandName
	end
	
	if rawCommandName ~= nil then
		local command, originalCommandName = ChatCommandInterface.getCommandInfo(rawCommandName)
		if command ~= nil then
			-- Player is running a command
			ChatUtil.debugPrint(`Running command: {originalCommandName}. Arguments: {table.concat(commandInfo.arguments, ", ")}`)
			
			if messageModeProperties ~= nil and messageModeProperties.metadata ~= nil then
				metadata = messageModeProperties.metadata
			end
			
			local shouldFireRemote, shouldSendToChat = command.onSending(message)
			if shouldFireRemote then
				RunChatCommand:FireServer(originalCommandName, commandInfo.arguments, metadata)
			end
			
			if not shouldSendToChat then
				-- Great, nothing else left to do here
				processingMessage = false
				return
			end
		end
	end
	
	local channel = CurrentChannel.get()
	if channel == nil then
		warn("No channel selected")
		processingMessage = false
		return
	end
	
	ChatUtil.debugPrint(`Sending message: {message}`)
	task.spawn(function()
		channel:SendAsync(message, metadata)
		CurrentChannel._onMessageSent()
	end)
	processingMessage = false 
end

function ChatInterface.init()
	CurrentChannel.init()
	MessageLog.init()
	WindowFocused.init()
	SystemMessages.init()
end

return ChatInterface