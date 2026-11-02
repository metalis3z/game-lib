-- // The global message log for every message sent by any player.

local Players = game:GetService("Players")
local Chat = game:GetService("Chat")

local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))

local ChatServiceRunner = script.Parent
local ServerChatConstants = require(ChatServiceRunner.ServerChatConstants)

local TextChatService = game:GetService("TextChatService")

local TextChannels = TextChatService:WaitForChild("TextChannels")

local ServerMessageLogs = {}

local globalChatLogs: {{speaker: Player, message: string}} = {}

local function logMessage(speaker: Player, message: string)
	if #globalChatLogs == ServerChatConstants.MessageLogsLimit then
		table.remove(globalChatLogs, 1)
	end
	table.insert(globalChatLogs, {
		speaker = speaker,
		message = message,
	})
	
	ChatUtil.debugPrint(`Message logged: [{speaker.Name}]: {message}`)
end

function ServerMessageLogs.getGlobalChatLog(): {TextChatMessage}
	return globalChatLogs
end

function ServerMessageLogs.init()
	local function onPlayerAdded(player: Player)
		player.Chatted:Connect(function(message)
			logMessage(player, message)
		end)
	end
	
	Players.PlayerAdded:Connect(onPlayerAdded)
	for _,player in Players:GetPlayers() do
		onPlayerAdded(player)
	end
end

return ServerMessageLogs