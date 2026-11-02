-- // Initializes all server-sided chat scripts.

local Chat = game:GetService("Chat")
local TextChatService = game:GetService("TextChatService")

if TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
	error("ChatVersion must be set to TextChatService for Basic Legacy Chat Rewrite to work!")
end

local Shared = Chat:WaitForChild("Shared")
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local ServerMessageLogs = require(script.ServerMessageLogs)
local ServerChatCommandsInterface = require(script.ServerChatCommandsInterface)
local WhisperChannels = require(script.WhisperChannels)
local TypingIndicator = require(script.TypingIndicator)
local SpeakerProperties = require(script.SpeakerProperties)
local BlankMessageChecker = require(script.BlankMessageChecker)

ServerMessageLogs.init()
ServerChatCommandsInterface.init()
WhisperChannels.init()
SpeakerProperties.init()
BlankMessageChecker.init()
TypingIndicator.init()

TextChatService.ChatWindowConfiguration.Enabled = false
TextChatService.ChatInputBarConfiguration.Enabled = false
TextChatService.ChannelTabsConfiguration.Enabled = false
TextChatService.BubbleChatConfiguration.Enabled = false

for _,v in script.ChatModules:GetChildren() do
	task.spawn(function()
		require(v)()
	end)
end