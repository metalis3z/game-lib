local TextChatService = game:GetService("TextChatService")
local Players         = game:GetService("Players")

local CHAT_COLORS = {
	Color3.new(253/255,  41/255,  67/255),
	Color3.new(  1/255, 162/255, 255/255),
	Color3.new(  2/255, 184/255,  87/255),
	BrickColor.new("Bright violet").Color,
	BrickColor.new("Bright orange").Color,
	BrickColor.new("Bright yellow").Color,
	BrickColor.new("Light reddish violet").Color,
	BrickColor.new("Brick yellow").Color,
}

local function GetNameValue(pName: string): number
	local value = 0
	for index = 1, #pName do
		local cValue       = string.byte(string.sub(pName, index, index))
		local reverseIndex = #pName - index + 1
		if #pName % 2 == 1 then
			reverseIndex = reverseIndex - 1
		end
		if reverseIndex % 4 >= 2 then
			cValue = -cValue
		end
		value = value + cValue
	end
	return value
end

local function ComputeChatColor(pName: string): Color3
	return CHAT_COLORS[(GetNameValue(pName) % #CHAT_COLORS) + 1]
end

local function ColorToHex(color: Color3): string
	return string.format("#%02X%02X%02X",
		math.floor(color.R * 255),
		math.floor(color.G * 255),
		math.floor(color.B * 255)
	)
end

local VERIFIED_SYMBOL = utf8.char(0xE000)

return {
	Start = function()
		TextChatService.OnIncomingMessage = function(message)
			script.Event:Fire(message)

			local player = message.TextSource
				and Players:GetPlayerByUserId(message.TextSource.UserId)

			if not player then
				return
			end

			local properties    = Instance.new("TextChatMessageProperties")
			local rolePrefix    = ""

			local role          = player:GetAttribute("Role")
			local originalPrefix = message.PrefixText or ""

			if role == "Lead" then
				rolePrefix = '<font color="#fa0909">[SPYDER]</font> '
			elseif role == "Dev" then
				rolePrefix = '<font color="#9fc1ff">[DEV]</font> '
			elseif role == "Tester" then
				rolePrefix = '<font color="#00aeff">[TESTER]</font> '
			elseif player:GetAttribute("VIP") then
				rolePrefix = '<font color="#FFD700">[VIP]</font> '
			end

			local customName  = player:GetAttribute("CustomName")
			local isVerified  = player:GetAttribute("Verified")
			local displayName = (customName and customName ~= "") and customName or player.Name

			local verifiedTag = isVerified and ("" .. VERIFIED_SYMBOL) or ""

			local nameColor = ComputeChatColor(displayName)
			local hexColor  = ColorToHex(nameColor)

			properties.PrefixText = string.format(
				"%s<font color='%s'>%s%s</font>:",
				rolePrefix,
				hexColor,
				displayName,
				verifiedTag
			)

			return properties
		end
	end,
}