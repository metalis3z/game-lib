-- // The interface for getting client-sided chat commands.

local Chat = game:GetService("Chat")

local Shared = Chat:WaitForChild("Shared")
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local ChatCommandInterface = {}

type clientChatCommand = {
	alternateNames: {string}?,
	onSending: (message: string) -> (boolean, boolean),
	shouldEnableMessageMode: ((message: string) -> (boolean, string?, string?, Color3?, string?))?,
}

local commandModuleList: {[string]: {command: clientChatCommand, originalName: string}} = {}

function ChatCommandInterface.getCommandInfo(commandName: string): clientChatCommand?
	local commandModuleInfo = commandModuleList[commandName]
	if commandModuleInfo ~= nil then
		return commandModuleInfo.command, commandModuleInfo.originalName
	else
		return nil, nil
	end
end

function ChatCommandInterface.init()
	-- Cache all modules using their name and alternate names as keys
	for _,moduleInstance in script:GetChildren() do
		if moduleInstance.Name == "template" or table.find(ChatConstants.BlacklistedCommands, moduleInstance.Name) then 
			continue
		end
		local module: clientChatCommand = require(moduleInstance)
		commandModuleList[moduleInstance.Name] = {
			command = module,
			originalName = moduleInstance.Name,
		}
		if module.alternateNames ~= nil then
			for _,alternateName in module.alternateNames do
				commandModuleList[alternateName] = commandModuleList[moduleInstance.Name]
			end
		end
	end
end

return ChatCommandInterface