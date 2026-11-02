-- // Handles custom system messages.

local TextChatService = game:GetService("TextChatService")
local Chat = game:GetService("Chat")

local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local Remotes = Chat:WaitForChild("Remotes")
local DisplaySystemMessage = Remotes:WaitForChild("DisplaySystemMessage")

local TextChannels = TextChatService:WaitForChild("TextChannels")

local SystemMessages = {}

function SystemMessages.displaySystemMessage(message: string, metadata: string?)
	local sytemChannel: TextChannel = TextChannels[ChatConstants.SystemMessageChannel]
	sytemChannel:DisplaySystemMessage(message, metadata)
end

function SystemMessages.init()
	DisplaySystemMessage.OnClientEvent:Connect(function(messageData: {text: string, textColor: Color3?})
		local text = messageData.text
		if messageData.textColor ~= nil then
			text = `<font color=#{messageData.textColor:ToHex()}>{text}</font>`
		end
		
		SystemMessages.displaySystemMessage(text)
	end)

	local message = string.format(ChatConstants.SystemMessages.Welcome.General, ChatConstants.CommandPrefix, ChatConstants.CommandPrefix) -- idk why I have to add this twice
	SystemMessages.displaySystemMessage(message)
end

return SystemMessages