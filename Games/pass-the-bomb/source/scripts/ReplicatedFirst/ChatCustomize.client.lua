
if game.Chat.BubbleChatEnabled == false then
	print("Bubblechat is disabled. Did you enable it from Chat properties?")
end

local settings = {	
	BubbleDuration = 15,
	MaxBubbles = 3,
	
	BackgroundColor3 = Color3.fromRGB(250, 250, 250),
	TextColor3 = Color3.fromRGB(41, 18, 74),
	TextSize = 19,
	Font = Enum.Font.GothamBold,
	Transparency = .1,
	CornerRadius = UDim.new(0, 12),
	TailVisible = false,
	Padding = 8,
	MaxWidth = 300,

	VerticalStudsOffset = 0,

	BubblesSpacing = 6,

	MinimizeDistance = 40,
	MaxDistance = 100,
}

pcall(function()
	game:GetService("Chat"):SetBubbleChatSettings(settings)
end)