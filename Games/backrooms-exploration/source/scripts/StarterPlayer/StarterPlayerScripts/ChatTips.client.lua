local TextChatService = game:GetService("TextChatService")
local StarterGui = game:GetService("StarterGui")

local tips = {
	"[Tip] The Backrooms Are Endless, So Is This Game.",
	"[Tip] You Can Stumble Upon Many Levels Including: Poolrooms, And The Office.",
	"[Tip] Entity's May Lurk Be Carefull.",
	"[Tip] If You Hear Screaming Look The Other Way!",
	"[Tip] Light's Might Go Out, Best To Stay In The Light."
}

local SECONDS_BETWEEN_TIPS = 60
local BACKROOMS_HEX_COLOR = "#D4C47C" 

task.wait(5)

while true do
	local randomTip = tips[math.random(1, #tips)]

	local textChannels = TextChatService:FindFirstChild("TextChannels")
	if textChannels and textChannels:FindFirstChild("RBXSystem") then
		local formattedMessage = string.format("<font color='%s'><b>%s</b></font>", BACKROOMS_HEX_COLOR, randomTip)
		textChannels.RBXSystem:DisplaySystemMessage(formattedMessage)
	else
		pcall(function()
			StarterGui:SetCore("ChatMakeSystemMessage", {
				Text = randomTip,
				Color = Color3.fromHex(BACKROOMS_HEX_COLOR),
				Font = Enum.Font.SourceSansBold,
				TextSize = 18
			})
		end)
	end

	task.wait(SECONDS_BETWEEN_TIPS)
end