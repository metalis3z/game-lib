-- // Initializes all client-sided chat scripts.

local Chat = game:GetService("Chat")
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

if not TextChatService:CanUserChatAsync(Players.LocalPlayer.UserId) then
	-- Player can't use chat at all; don't even bother initializing chat
	return
end

local Shared = Chat:WaitForChild("Shared")
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))

local ChatInterface = require(script.ChatInterface)
local GuiCreator = require(script.GuiCreator)
local ChatCommandInterface = require(script.ChatCommandInterface)
local WhisperInterface = require(script.WhisperInterface)
local MutedPlayers = require(script.MutedPlayers)
local BubbleChat = require(script.BubbleChat)

ChatInterface.init()
ChatCommandInterface.init()
GuiCreator.create()
WhisperInterface.init()
MutedPlayers.init()

if ChatConstants.BubbleChatEnabled then
	BubbleChat.init()
end