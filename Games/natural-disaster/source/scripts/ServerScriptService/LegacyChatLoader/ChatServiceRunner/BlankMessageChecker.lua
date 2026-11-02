-- // Rejects blank messages if AllowBlankMessages is set to false.

local Chat = game:GetService("Chat")
local TextChatService = game:GetService("TextChatService")

local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local ShouldDeliverCallbackRegistration = require(script.Parent.ShouldDeliverCallbackRegistration)

local TextChannels = TextChatService:WaitForChild("TextChannels")

local BlankMessageChecker = {}

function BlankMessageChecker.init()
	if ChatConstants.AllowBlankMessages == true then
		return
	end
	
	for _,textChannel: TextChannel in TextChannels:GetChildren() do
		ShouldDeliverCallbackRegistration.registerCallback(textChannel, function(textChatMessage, targetTextSource)
			return not ChatUtil.checkIsBlankString(textChatMessage.Text)
		end)
	end
end

return BlankMessageChecker