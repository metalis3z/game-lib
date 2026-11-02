-- Generated from ui/StarterGui/Gifting.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Gifting", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageButton", I[1], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(25, 25, 25), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5168609593"), ImageTransparency = 1, Size = UDim2.fromScale(0.98, 0.0785), ZIndex = 3 })
			I[3] = new("ImageLabel", I[2], "Avatar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=56721213&w=420&h=420"), Position = UDim2.fromScale(0, -0.0000022), Size = UDim2.fromScale(0.1877418, 1) })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 0.979028 })
			I[5] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 5.2147574 })
			I[6] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, 0.1), Size = UDim2.fromScale(0.7296817, 0.5224252), Text = "N/A", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 19, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
				I[7] = new("TextLabel", I[6], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.6500006), Size = UDim2.fromScale(0.9623474, 1), Text = "(@N/A)", TextColor3 = Color3.fromRGB(232, 232, 232), TextScaled = true, TextSize = 15, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6 })
					I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint", { AspectRatio = 7.0089998 })
					I[9] = new("UITextSizeConstraint", I[7], "UITextSizeConstraint", { MaxTextSize = 15 })
				I[10] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 7.2835555 })
				I[11] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint", { MaxTextSize = 19 })
		I[12] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4931594, 0), Size = UDim2.fromScale(0.325, 0.5477668) })
			I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
			I[14] = new("ImageButton", I[12], "Btn", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), ImageTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 3 })
			I[15] = new("ImageLabel", I[12], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13107696249"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.72, 1) })
				I[16] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint")
			I[17] = new("TextLabel", I[12], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5050055, 0.8018836), RichText = true, Size = UDim2.fromScale(1, 0.227), Text = "SPECIAL COSMETICS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top })
				I[18] = new("TextLabel", I[17], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4985754, 0.6523852), RichText = true, Size = UDim2.fromScale(1, 1), Text = "99 ROBUX", TextColor3 = Color3.fromRGB(158, 255, 174), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top })
					I[19] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint", { AspectRatio = 6.9667144 })
					I[20] = new("UITextSizeConstraint", I[18], "UITextSizeConstraint", { MaxTextSize = 14 })
				I[21] = new("UITextSizeConstraint", I[17], "UITextSizeConstraint", { MaxTextSize = 18 })
				I[22] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint", { AspectRatio = 6.118453 })
		I[23] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.35, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.353857, 0.3325942), Visible = false })
			I[24] = new("Frame", I[23], "ReceiverMagic", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(-0.2840997, 0.5), Size = UDim2.fromScale(0.536, 1.2) })
				I[25] = new("Frame", I[24], "Receiver", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.35, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.8333333), Visible = false })
					I[26] = new("Frame", I[25], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0000001, 0.0466417), Size = UDim2.fromScale(0.1552164, 0.1124688) })
						I[27] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint", { AspectRatio = 1.2333333 })
						I[28] = new("ImageLabel", I[26], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://14470821093"), Position = UDim2.fromScale(0.5328964, 0.5), Size = UDim2.fromScale(0.4594595, 0.5666667) })
							I[29] = new("UIAspectRatioConstraint", I[28], "UIAspectRatioConstraint")
					I[30] = new("TextBox", I[25], "TextBox", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClearTextOnFocus = false, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(212, 212, 212), PlaceholderText = "Search Username", Position = UDim2.fromScale(0.57639, 0.0469177), Size = UDim2.fromScale(0.8423469, 0.1124688), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[31] = new("UITextSizeConstraint", I[30], "UITextSizeConstraint", { MaxTextSize = 20 })
						I[32] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint", { AspectRatio = 6.6932015 })
					I[33] = new("ScrollingFrame", I[25], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 3), Position = UDim2.fromScale(0.5, 0.584038), ScrollBarThickness = 6, Size = UDim2.fromScale(0.9600001, 0.8319243), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar })
						I[34] = new("UIListLayout", I[33], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
					I[35] = new("TextLabel", I[25], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.4443282, 0.1874481), Text = "SEND TO?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
						I[36] = new("UIAspectRatioConstraint", I[35], "UIAspectRatioConstraint", { AspectRatio = 2.1183519 })
						I[37] = new("UITextSizeConstraint", I[35], "UITextSizeConstraint", { MaxTextSize = 35 })
			I[38] = new("TextButton", I[23], "Send", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.35, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2239004, 1.0230001), Size = UDim2.fromScale(1.5521996, 0.093724), Text = "SEND GIFT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, Visible = false })
				I[39] = new("UITextSizeConstraint", I[38], "UITextSizeConstraint", { MaxTextSize = 20 })
			I[40] = new("TextLabel", I[23], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.6918354, 0.1874481), Text = "SELECT A GAMEPASS TO GIFT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 2 })
				I[41] = new("UITextSizeConstraint", I[40], "UITextSizeConstraint", { MaxTextSize = 35 })
			I[42] = new("ScrollingFrame", I[23], "ScrollingFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromOffset(0, 1000), Position = UDim2.fromScale(0.5, 0.5), ScrollBarThickness = 6, Size = UDim2.fromScale(0.96, 1), VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar })
				I[43] = new("UIGridLayout", I[42], "UIGridLayout", { CellPadding = UDim2.fromScale(0, 0), CellSize = UDim2.fromScale(0.6, 0.52), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
					I[44] = new("UIAspectRatioConstraint", I[43], "UIAspectRatioConstraint")
			I[45] = new("UIAspectRatioConstraint", I[23], "UIAspectRatioConstraint", { AspectRatio = 1.6666666 })
	return I[1]
end

return build
