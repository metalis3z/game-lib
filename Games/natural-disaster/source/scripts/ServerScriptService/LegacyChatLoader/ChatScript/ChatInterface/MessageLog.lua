-- // A log of all recent messages, up to MessageLogLimit.

local TextChatService = game:GetService("TextChatService")
local Chat = game:GetService("Chat")
local Players = game:GetService("Players")

local Shared = Chat:WaitForChild("Shared")
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))

local ChatScript = script.Parent.Parent
local MutedPlayers = require(ChatScript.MutedPlayers)

local MessageLog = {}

local messageLog: {TextChatMessage} = {}
local messageAddedCallbacks: {(textChatMessage: TextChatMessage) -> (any)} = {}
local messageOverflowCallbacks: {(textChatMessage: TextChatMessage) -> (any)} = {}

function MessageLog.registerMessageAddedCallback(callback: (textChatMessage: TextChatMessage) -> (any))
	table.insert(messageAddedCallbacks, callback)
end

function MessageLog.registerMessageOverflowCallback(callback: (textChatMessage: TextChatMessage) -> (any))
	table.insert(messageOverflowCallbacks, callback)
end

function MessageLog.getLog()
	return messageLog
end

function MessageLog.init()
	TextChatService.MessageReceived:Connect(function(textChatMessage)
		if textChatMessage.Status ~= Enum.TextChatMessageStatus.Success and textChatMessage.Status ~= Enum.TextChatMessageStatus.TextFilterFailed then
			-- Ignore message due to miscellaneous error
			return
		end
		if textChatMessage.TextSource ~= nil and MutedPlayers.isMuted(Players:GetPlayerByUserId(textChatMessage.TextSource.UserId)) then
			-- Ignore message due to this player being muted
			return
		end
		
		ChatUtil.debugPrint(`Received message in TextChannel {textChatMessage.TextChannel.Name}: [{if textChatMessage.TextSource then textChatMessage.TextSource.Name else "System"}]: {textChatMessage.Text}`)
		if #messageLog == ChatConstants.MessageLogLimit then
			-- Remove oldest message and shift all elements back by one to make space
			local oldestTextChatMessage = messageLog[1]
			for _,callback in messageOverflowCallbacks do
				task.spawn(callback, oldestTextChatMessage)
			end
			table.remove(messageLog, 1)
		end
		table.insert(messageLog, textChatMessage)
		
		for _,callback in messageAddedCallbacks do
			task.spawn(callback, textChatMessage)
		end
	end)
end

return MessageLog