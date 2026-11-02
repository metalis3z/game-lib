-- // Displays a list of all available commands in chat.

local Chat = game:GetService("Chat")

local Shared = Chat:WaitForChild("Shared")
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))

local ChatScript = script.Parent.Parent
local SystemMessages = require(ChatScript.ChatInterface.SystemMessages)

local help = {}

help.alternateNames = {"?"}

function help.onSending(message: string): (boolean, boolean)
	local systemMessage = ChatConstants.SystemMessages.CommandHelp.Intro
	
	local availableCommandList: {string} = {}
	for _,v in script.Parent:GetChildren() do
		if v.Name ~= "template" and table.find(ChatConstants.BlacklistedCommands, v.Name) == nil then
			table.insert(availableCommandList, v.Name)
		end
	end
	
	table.sort(availableCommandList)
	
	for _,commandName in availableCommandList do
		local commandDescription = ChatConstants.SystemMessages.CommandHelp[commandName]
		if commandDescription ~= nil then
			commandDescription = string.format(commandDescription, ChatConstants.CommandPrefix, ChatConstants.CommandPrefix)
			systemMessage = systemMessage .. "\n" .. commandDescription
		else
			warn(`No description for command: {commandName}`)
		end
	end
	
	systemMessage = ChatUtil.sanitizeMessageForRichText(systemMessage)
	SystemMessages.displaySystemMessage(systemMessage)
	
	-- We're already done, don't send anything else
	return false, false
end

return help