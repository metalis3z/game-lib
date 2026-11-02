-- // Keeps track of which channel the player is currently viewing.

local TextChatService = game:GetService("TextChatService")
local Chat = game:GetService("Chat")

local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))
local ChatScript = script.Parent.Parent

local TextChannels

local CurrentChannel = {}

local currentChannel: TextChannel?
local returnChannel: TextChannel?

function CurrentChannel.get(): TextChannel?
	return currentChannel
end

function CurrentChannel._onMessageSent()
	if returnChannel ~= nil then
		currentChannel = returnChannel
		ChatUtil.debugPrint(`Channel set back to {returnChannel}`)
		returnChannel = nil
	end
end

function CurrentChannel.set(channelName: string): boolean
	if TextChannels == nil then
		repeat task.wait() until TextChannels ~= nil
	end
	local newChannel = TextChannels:FindFirstChild(channelName)
	if newChannel == nil then
		warn(`Channel named "{channelName}" does not exist`)
		
		return false
	end
	ChatUtil.debugPrint(`Current channel: {newChannel}`)
	currentChannel = newChannel
	
	return true
end

function CurrentChannel.setOnlyForNextMessage(channelName: string)
	local lastChannel = currentChannel
	
	local success = CurrentChannel.set(channelName)
	if not success then
		return
	end
	
	returnChannel = lastChannel
end

function CurrentChannel.init()
	task.spawn(function()
		TextChannels = TextChatService:WaitForChild("TextChannels")
		CurrentChannel.set(ChatConstants.DefaultChannel)
	end)
end

return CurrentChannel