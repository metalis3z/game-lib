-- // Listens directly to ShouldDeliverCallback, then calls all callbacks registered to this module.

local TextChatService = game:GetService("TextChatService")
local Chat = game:GetService("Chat")

local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))

local TextChannels = TextChatService:WaitForChild("TextChannels")

local ShouldDeliverCallbackRegistration = {}

type shouldDeliverCallbackType = (textChatMessage: TextChatMessage, targetTextSource: TextSource) -> any

local registeredTextChannels: {[TextChannel]: boolean} = {}
local registeredCallbacksByTextChannel: {[TextChannel]: {shouldDeliverCallbackType}} = {}

local function registerTextChannel(textChannel: TextChannel)
	textChannel.ShouldDeliverCallback = function(textChatMessage: TextChatMessage, targetTextSource: TextSource)
		ChatUtil.debugPrint(`ShouldDeliverCallback is being called for {targetTextSource.Name}: [{textChatMessage.TextSource.Name}]: {textChatMessage.Text}`)
		local registeredCallbacks = registeredCallbacksByTextChannel[textChannel]
		
		-- This message can only be sent to this player if every single callback agrees it should be.
		local allCallbacksApprove = true
		for _,callback in registeredCallbacks do
			local approved = callback(textChatMessage, targetTextSource)
			if not approved then
				allCallbacksApprove = false
			end
		end
		
		if allCallbacksApprove then
			ChatUtil.debugPrint("Allowing message")
			return true
		else
			ChatUtil.debugPrint("Rejecting message")
			return false
		end
	end
end

function ShouldDeliverCallbackRegistration.registerCallback(textChannel: TextChannel, callback: shouldDeliverCallbackType)
	if registeredCallbacksByTextChannel[textChannel] == nil then
		registeredCallbacksByTextChannel[textChannel] = {}
		if registeredTextChannels[textChannel] == nil then
			registerTextChannel(textChannel)
		end
	end
	table.insert(registeredCallbacksByTextChannel[textChannel], callback)
end

return ShouldDeliverCallbackRegistration