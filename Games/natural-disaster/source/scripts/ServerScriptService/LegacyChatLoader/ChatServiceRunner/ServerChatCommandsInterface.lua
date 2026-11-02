-- // The interface for the server side of chat commands.

local Chat = game:GetService("Chat")
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local Remotes = Chat:WaitForChild("Remotes")
local DisplaySystemMessage = Remotes:WaitForChild("DisplaySystemMessage")
local RunChatCommand = Remotes:WaitForChild("RunChatCommand")

local ShouldDeliverCallbackRegistration = require(script.Parent.ShouldDeliverCallbackRegistration)

local TextChannels = TextChatService:WaitForChild("TextChannels")

local ServerChatCommandsInterface = {}

type serverChatCommand = {
	onFired: ((player: Player, args: {string}?, metadataAfterCommandName: string?) -> {text: string, textColor: Color3?}?)?,
	metadataTriggeredShouldDeliverCallback: ((textChatMessage: TextChatMessage, targetTextSource: TextSource, metadataAfterCommandName: string) -> boolean)?,
}

local commandModules: {[string]: serverChatCommand} = {}

function ServerChatCommandsInterface.runCommand(player: Player, commandName: string, args: {string}?)
	ChatUtil.debugPrint(`Running command {commandName} for {player.Name} with arguments: {args and table.unpack(args)}`)
	
	local module = commandModules[commandName]
	
	assert(module ~= nil and module.onFired ~= nil, `Could not find server command "{commandName}"`)

	local returnMessageData = module.onFired(player, args)
	if returnMessageData ~= nil then
		DisplaySystemMessage:FireClient(player, returnMessageData)
	end
end

function ServerChatCommandsInterface.init()
	RunChatCommand.OnServerEvent:Connect(function(player, commandName: string, args: {}?, metadata: string?)
		local _commandName, metadataAfterCommandName: string? = nil, nil
		if metadata ~= nil then
			_commandName, metadataAfterCommandName = ChatUtil.getCommandInfoFromMetadata(metadata)
		end
		ServerChatCommandsInterface.runCommand(player, commandName, args, metadataAfterCommandName)
	end)
	
	for _,moduleInstance in script:GetChildren() do
		if moduleInstance.Name == "template" or table.find(ChatConstants.BlacklistedCommands, moduleInstance.Name) then
			continue
		end
		commandModules[moduleInstance.Name] = require(moduleInstance)
	end
	
	for _,textChannel: TextChannel in TextChannels:GetChildren() do
		ShouldDeliverCallbackRegistration.registerCallback(textChannel, function(textChatMessage, targetTextSource)
			local metadata = textChatMessage.Metadata
			if metadata ~= nil then
				local commandName, metadataAfterCommandName = ChatUtil.getCommandInfoFromMetadata(metadata)
				
				if commandName ~= nil then
					local module = commandModules[commandName]
					if module == nil then
						-- No module; we do not care
						return true
					end
					if module.metadataTriggeredShouldDeliverCallback ~= nil then
						ChatUtil.debugPrint(`Running metadataTriggeredShouldDeliverCallback`)
						return module.metadataTriggeredShouldDeliverCallback(textChatMessage, targetTextSource, metadataAfterCommandName)
					end
				end
			end

			-- No command metadata, or could not find an associated function
			return true
		end)
	end
end

return ServerChatCommandsInterface