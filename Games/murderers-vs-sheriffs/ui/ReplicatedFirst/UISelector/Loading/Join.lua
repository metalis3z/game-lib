-- Generated from ui/ReplicatedFirst/UISelector/Loading/Join.rbxm by _tools/rbxm2lua.luau
-- UI builder: local gui = require(this)(); gui.Parent = game.Players.LocalPlayer.PlayerGui (or StarterGui)

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("ScreenGui", nil, "Join", { DisplayOrder = 11, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "BG", { BackgroundColor3 = Color3.fromRGB(12, 12, 12), Size = UDim2.fromScale(1, 1) })
		I[3] = new("Frame", I[1], "Friends", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(39, 39, 39), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[4] = new("TextLabel", I[3], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1), Text = "Joining a friend?", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 36, ZIndex = 2 })
			I[5] = new("TextButton", I[3], "Play", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 1, -3), Size = UDim2.new(0.5, 0, 0.15, -6), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "Play", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, TextStrokeTransparency = 0.7, ZIndex = 2 })
			I[6] = new("Frame", I[3], "FriendsList", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.1), Size = UDim2.fromScale(1, 0.75), ZIndex = 2 })
				I[7] = new("Frame", I[6], "ScrollBar", { BackgroundColor3 = Color3.fromRGB(83, 83, 83), BorderSizePixel = 0, Position = UDim2.new(1, -7, 0, 3), Size = UDim2.new(0, 3, 1, -6) })
				I[8] = new("ScrollingFrame", I[6], "ScrollingFrame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ElasticBehavior = Enum.ElasticBehavior.Never, Position = UDim2.fromOffset(3, 3), ScrollBarThickness = 10, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.new(1, -6, 1, -6), ZIndex = 2 })
					I[9] = new("Frame", I[8], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -15, 1, 0) })
						I[10] = new("Frame", I[9], "FriendFrame", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(121, 121, 121), BackgroundTransparency = 0.9, Size = UDim2.new(1, -1, 0, 50) })
							I[11] = new("TextLabel", I[10], "FriendName", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 6, 0.5, 0), Size = UDim2.new(0.5, -12, 0.5, 0), Text = "OnlyTwentyCharacters", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[12] = new("TextButton", I[10], "Join", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0.5), Size = UDim2.new(0.15, 0, 1, -4), Style = Enum.ButtonStyle.RobloxRoundDefaultButton, Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, Visible = false })
								I[13] = new("TextLabel", I[12], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(-2, -2), Size = UDim2.new(1, 4, 1, 4), Text = "Join", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.3, TextWrapped = true })
							I[14] = new("TextLabel", I[10], "Hardcore", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.85, -3, 0.5, 0), Size = UDim2.fromScale(0.35, 0.5), Text = "Hardcore", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
							I[15] = new("TextLabel", I[10], "Server", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), Position = UDim2.new(1, -6, 0.5, 0), Size = UDim2.fromScale(0.35, 0.5), Text = "Testing Server", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
							I[16] = new("Frame", I[10], "GoldServer", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.85, -3, 0.5, 0), Size = UDim2.fromScale(0.35, 0.5), Visible = false })
								I[17] = new("TextLabel", I[16], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.85, 1), Text = "1v1 Mode", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
								I[18] = new("ImageLabel", I[16], "Gold", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4801544128"), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
							I[19] = new("Frame", I[10], "Server1v1", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.85, -3, 0.5, 0), Size = UDim2.fromScale(0.35, 0.5), Visible = false })
								I[20] = new("TextLabel", I[19], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "1v1 Mode", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
								I[21] = new("ImageLabel", I[19], "Gold", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4801544128"), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
							I[22] = new("TextLabel", I[10], "Assassin", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.85, -3, 0.5, 0), Size = UDim2.fromScale(0.35, 0.5), Text = "Assassin", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
						I[23] = new("UIListLayout", I[9], "UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })
			I[24] = new("UISizeConstraint", I[3], "UISizeConstraint", { MaxSize = Vector2.new(600, 500) })
			I[25] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 1.3 })
			I[26] = new("Frame", I[3], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.95, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.1), Size = UDim2.fromScale(1, 0.9), ZIndex = 2 })
		I[27] = new("TextLabel", I[1], "LoadingOld", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Loading", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 48, Visible = false, ZIndex = 2 })
		I[28] = new("Frame", I[1], "Retry", { Active = true, BackgroundColor3 = Color3.fromRGB(44, 44, 44), BorderColor3 = Color3.fromRGB(20, 20, 20), BorderSizePixel = 5, Position = UDim2.new(0.5, -200, 0.5, -100), Size = UDim2.fromOffset(400, 200), Visible = false })
			I[29] = new("TextButton", I[28], "Retry", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 3, 1, -53), Size = UDim2.new(1, -6, 0, 50), Style = Enum.ButtonStyle.RobloxRoundButton, Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, TextStrokeTransparency = 0.7 })
			I[30] = new("TextLabel", I[28], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 30), Text = "Error: Server is full or player has left.", TextColor3 = Color3.fromRGB(255, 90, 93), TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true })
			I[31] = new("TextLabel", I[28], "Retrying", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 30), Size = UDim2.new(1, 0, 0, 30), Text = "Retrying...", TextColor3 = Color3.fromRGB(179, 179, 179), TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true })
			I[32] = new("ImageLabel", I[28], "Spinner", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=337617808"), Position = UDim2.new(0.5, -25, 0, 70), Size = UDim2.fromOffset(50, 50) })
		I[33] = new("Frame", I[1], "Loading", { Active = true, BackgroundColor3 = Color3.fromRGB(44, 44, 44), BorderColor3 = Color3.fromRGB(20, 20, 20), BorderSizePixel = 5, Position = UDim2.new(0.5, -200, 0.5, -100), Size = UDim2.fromOffset(400, 120), Visible = false })
			I[34] = new("TextLabel", I[33], "Retrying", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(0, 4), Size = UDim2.new(1, 0, 0.5, -20), Text = "Joining Friend...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 28, TextStrokeTransparency = 0.7, TextWrapped = true })
			I[35] = new("ImageLabel", I[33], "Spinner", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("https://www.roblox.com/asset/?id=337617808"), Position = UDim2.new(0.5, 0, 0.5, -6), Size = UDim2.new(0.5, -6, 0.5, -6), SizeConstraint = Enum.SizeConstraint.RelativeYY })
	return I[1]
end

return build
