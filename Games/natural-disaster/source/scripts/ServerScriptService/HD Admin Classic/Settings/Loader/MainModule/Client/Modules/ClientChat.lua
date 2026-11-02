-- Annoyingly HD Admin chat customization is severely limited with the new
-- TextChatService as the only way of modifying chat and bubble color correctly
-- is via .OnChatWindowAdded and .OnBubbleAdded which are single use callbacks.
-- I can't tap into these for HD Admin as it would potentially intefer with
-- the developers own custom callback functions. I can overcome this with future
-- applications like Nanoblox which can include documentation to enable/disable this,
-- however HD Admin is too widely used and with too little documentation and
-- communication/update channels to make this safe to implement. For now, the only
-- properties I will provide support in modifying is message.PrefixText which I can
-- do within the .SendingMessage event.



local module = {}



-- << RETRIEVE FRAMEWORK >>
local main = _G.HDAdminMain



-- This setsup ChatService related functions
local TextChatService = main.TextChatService
TextChatService.SendingMessage:Connect(function(message)
	local textSource = message.TextSource
	local sourcePlayer = textSource and main.players:FindFirstChild(textSource.Name)
	if not sourcePlayer then
		return
	end
	local chatTag = sourcePlayer:GetAttribute("ChatTag")
	local chatTagColor = sourcePlayer:GetAttribute("ChatTagColor")
	local chatName = sourcePlayer:GetAttribute("ChatName")
	local chatNameColor = sourcePlayer:GetAttribute("ChatNameColor")
	if message.TextSource then
		local tagPrefix = chatTag and `[{chatTag}]`
		if tagPrefix and chatTagColor then
			tagPrefix = `<font color='#{chatTagColor:ToHex()}'>{tagPrefix}</font>`
		end
		local namePrefix = `{chatName or sourcePlayer.DisplayName}:`
		if namePrefix and chatNameColor then
			namePrefix = `<font color='#{chatNameColor:ToHex()}'>{namePrefix}</font>`
		end
		local finalPrefix = namePrefix
		if tagPrefix then
			finalPrefix = tagPrefix.." "..namePrefix
		end
		--
		local prefixText = message.PrefixText
		local prefixTextMinusRich = string.match(prefixText, "<.*>(.*)<.*>")
		if not chatTag and prefixTextMinusRich then
			-- This is in case the developer has already added their own prefix text
			-- and we need to capture the start and end of their prefix text
			local ts,te = string.find(string.reverse(prefixText),string.reverse(prefixTextMinusRich))
			local s,e = string.len(prefixText)-te+1,string.len(prefixText)-ts+1
			if s and e then
				local startCapture = string.sub(prefixText, 1, s-1)
				local startCaptureMinusRich = string.match(startCapture, "<.*>(.*)<.*>")
				local endCapture = string.sub(prefixText, e+1)
				if startCaptureMinusRich then
					startCapture = startCapture.." "
				end
				finalPrefix = startCapture..finalPrefix..endCapture
			end
		end
		--
		message.PrefixText = finalPrefix
	end
	return message
end)



--[[
TextChatService.OnChatWindowAdded = function(message: TextChatMessage)
	return properties
end

TextChatService.OnBubbleAdded = function(message)
	if not message.TextSource then
		return
	end
	local player = main.players:GetPlayerByUserId(message.TextSource.UserId)
	if not player then
		return
	end

	-- This modifies the bubble
	local properties = Instance.new("BubbleChatMessageProperties")
	local bubbleTextColor = player:GetAttribute("BubbleTextColor")
	if bubbleTextColor then
		properties.TextColor3 = bubbleTextColor
	end
	local bubbleBackgroundColor = player:GetAttribute("BubbleBackgroundColor")
	if bubbleBackgroundColor then
		properties.BackgroundColor3 = bubbleBackgroundColor
	end

	return properties
end
--]]



return module