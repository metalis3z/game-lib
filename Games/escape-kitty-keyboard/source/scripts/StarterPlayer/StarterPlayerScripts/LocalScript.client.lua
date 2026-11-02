local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

local VERIFIED_USERS = {
	[1580586066] = true,
	[7549348317] = true
}

TextChatService.OnIncomingMessage = function(message)
	local props = Instance.new("TextChatMessageProperties")

	if message.TextSource then
		local player = Players:GetPlayerByUserId(message.TextSource.UserId)
		if player then
			local nameColor = "#00a2ff"
			local displayName = player.DisplayName

		
			if VERIFIED_USERS[player.UserId] then
				props.PrefixText = string.format(
					'<font color="%s">%s</font><font color="#00a2ff"></font>:',
					nameColor,
					displayName
				)
			else
				props.PrefixText = string.format(
					'<font color="%s">%s</font>:',
					nameColor,
					displayName
				)
			end
		end
	end

	return props
end

print("[✅ VerifiedBadgeChat_Client] Loaded successfully — verified badge active.")
