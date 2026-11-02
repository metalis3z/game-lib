--	// FileName: PrivateMessaging.lua
--	// Written by: Xsitsu
--	// Description: Module that handles all private messaging.

local Chat = game:GetService("Chat")
local RunService = game:GetService("RunService")
local ReplicatedModules = Chat:WaitForChild("ClientChatModules")
local ChatModules = Chat:WaitForChild("ChatModules")
local ChatConstants = require(ReplicatedModules:WaitForChild("ChatConstants"))
local ChatSettings = require(ReplicatedModules:WaitForChild("ChatSettings"))
local DisplayNameHelpers = require(ChatModules.Utility.DisplayNameHelpers)

local ChatLocalization = nil
pcall(function() ChatLocalization = require(game:GetService("Chat").ClientChatModules.ChatLocalization :: any) end)
if ChatLocalization == nil then ChatLocalization = {} end
if not ChatLocalization.FormatMessageToSend or not ChatLocalization.LocalizeFormattedMessage then
	function ChatLocalization:FormatMessageToSend(key,default) return default end
end

local errorTextColor = ChatSettings.ErrorMessageTextColor or Color3.fromRGB(245, 50, 50)
local errorExtraData = {ChatColor = errorTextColor}

local function GetWhisperChannelPrefix()
	if ChatConstants.WhisperChannelPrefix then
		return ChatConstants.WhisperChannelPrefix
	end
	return "To "
end

local function GetWhisperChannelId(userName)
	return GetWhisperChannelPrefix() .. userName
end

local function Run(ChatService)

	local function CanCommunicate(fromSpeaker, toSpeaker)
		if RunService:IsStudio() then
			return true
		end
		local fromPlayer = fromSpeaker:GetPlayer()
		local toPlayer = toSpeaker:GetPlayer()
		if fromPlayer and toPlayer then
			local success, canChat = pcall(function()
				return Chat:CanUsersChatAsync(fromPlayer.UserId, toPlayer.UserId)
			end)
			return success and canChat
		end
		return false
	end

	ChatService.SpeakerAdded:connect(function(speakerName)
		
	end)

	ChatService.SpeakerRemoved:connect(function(speakerName)
		local whisperChannelId = GetWhisperChannelId(speakerName)

		if (ChatService:GetChannel(whisperChannelId)) then
			ChatService:RemoveChannel(whisperChannelId)
		end
	end)
end

return Run
