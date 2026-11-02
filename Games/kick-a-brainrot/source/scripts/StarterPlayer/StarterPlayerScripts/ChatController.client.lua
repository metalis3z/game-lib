--!strict
-- LOCATION: StarterPlayerScripts/ChatController

local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

local ChatController = {}

function ChatController:Init()
	TextChatService.OnIncomingMessage = function(message: TextChatMessage)
		local properties = Instance.new("TextChatMessageProperties")

		if message.TextSource then
			local player = Players:GetPlayerByUserId(message.TextSource.UserId)

			-- Apply the Gold VIP tag if the player has the attribute
			if player and player:GetAttribute("IsVIP") then
				properties.PrefixText = "<font color='#FFD700'>[VIP]</font> " .. message.PrefixText
			end
		end

		return properties
	end

	print("[ChatController] Initialized (VIP Chat Tags Active)")
end

ChatController:Init()

return ChatController