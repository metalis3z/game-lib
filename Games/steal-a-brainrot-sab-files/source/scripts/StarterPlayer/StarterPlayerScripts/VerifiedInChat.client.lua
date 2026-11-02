local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local VERIFIED_ICON = utf8.char(0xE000)

local verifiedUsers = {
	["melleurpro"] = true, -- Change this to your username
	["Viveur292I"] = true -- Change this to another username
	["Planix_DEV"] = true -- Change this to another username
}

TextChatService.OnIncomingMessage = function(message)

	local properties = Instance.new("TextChatMessageProperties")

	if message.TextSource then

		local player = Players:GetPlayerByUserId(message.TextSource.UserId)

		if player and verifiedUsers[player.Name] then

			properties.PrefixText = player.DisplayName .. VERIFIED_ICON .. ":"
		end
	end

	return properties
end