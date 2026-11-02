local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))

function TextChatService.OnIncomingMessage(p1) --[[ Line: 6 | Upvalues: Players (copy) ]]
	local TextChatMessageProperties = Instance.new("TextChatMessageProperties")

	if p1.TextSource then
		TextChatMessageProperties.PrefixText = (if Players:GetPlayerByUserId(p1.TextSource.UserId):GetAttribute("VIP") then "<font color=\'#F5CD30\'>[VIP]</font> " else "") .. p1.PrefixText
	end

	return TextChatMessageProperties
end

local function DisplayBubble(p1, p2, p3) --[[ DisplayBubble | Line: 19 | Upvalues: Lib (copy) ]]
	if not (p1 and p2) then
		return
	end

	if p3 then
		p2 = "<font color=\'" .. p3 .. "\'>" .. p2 .. "</font>"
	end

	local v1 = Lib.Talk.Translate(nil, p2)

	game:GetService("TextChatService"):DisplayBubble(p1, v1)
	Lib.PlaySoundAt("bubble", p1.Position)
end

Lib.Inject("DisplayBubble", DisplayBubble)
Lib.Network:BindEvents({
	DisplayBubble = DisplayBubble
})

return {}