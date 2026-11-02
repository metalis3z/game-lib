-- // Sends private messages between two players.

local Players = game:GetService("Players")

local Chat = game:GetService("Chat")
local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))

local ChatScript = script.Parent.Parent
local MessageMode = require(ChatScript.ChatInterface.MessageMode)
local WhisperInterface = require(ChatScript.WhisperInterface)
local CurrentChannel = require(ChatScript.ChatInterface.CurrentChannel)

local localPlayer = Players.LocalPlayer

local whisper = {}

whisper.alternateNames = {"w"}

local targetPlayer: Player? = nil

function whisper.onSending(message: string): (boolean, boolean)
	local messageModeProperties = MessageMode.get()
	if messageModeProperties == nil then
		ChatUtil.debugPrint("No MessageMode")
		return false, false
	end
	if messageModeProperties.metadata == nil then
		ChatUtil.debugPrint("No metadata")
		return false, false
	end
	
	local commandName, targetPlayerName = ChatUtil.getCommandInfoFromMetadata(messageModeProperties.metadata)
	if commandName == nil then
		ChatUtil.debugPrint(`Metadata improperly formatted: {messageModeProperties.metadata}`)
		return false, false
	end
	
	local targetPlayer = Players:FindFirstChild(targetPlayerName)
	if targetPlayer == nil then
		ChatUtil.debugPrint("Target player does not exist")
		return false, false
	end
	
	local whisperChannel = WhisperInterface.getWhisperChannelAsync(targetPlayer)
	CurrentChannel.setOnlyForNextMessage(whisperChannel.Name)
	
	-- Send message, don't fire remote
	return false, true
end

function whisper.shouldEnableMessageMode(message: string): (boolean, string, string, Color3, string?)
	local targetPlayer, _failureReason = ChatUtil.getPlayerFromTextQuery(Players.LocalPlayer, ChatUtil.removeCommandFromMessage(message))
	if targetPlayer ~= nil and targetPlayer ~= localPlayer then
		return true, `whisper`, `To {targetPlayer.Name}`, Color3.fromRGB(102, 14, 102), "whisper:" .. targetPlayer.Name
	else
		return false, nil, nil, nil, nil
	end
end

return whisper