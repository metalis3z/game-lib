--!strict
local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

TextChatService.OnIncomingMessage = function(message: TextChatMessage)
	local props = Instance.new("TextChatMessageProperties")
	
	if message.TextSource then
		local player = Players:GetPlayerByUserId(message.TextSource.UserId)
		
		if player:GetAttribute("isVIP") == true and player:GetAttribute("isMVP") == false then
			props.PrefixText = "<font color='#F5CD30'>[VIP]</font> " .. message.PrefixText
		end
		
		if player:GetAttribute("isVIP") == false and player:GetAttribute("isMVP") == true then
			props.PrefixText = "<font color='#0097ff'>[MVP]</font> " .. message.PrefixText
		end
		
		if player:GetAttribute("isVIP") == true and player:GetAttribute("isMVP") == true then
			props.PrefixText = "<font color='#F5CD30'>[VIP]</font> <font color='#0097ff'>[MVP]</font> " .. message.PrefixText
		end
	end
	
	return props	
end