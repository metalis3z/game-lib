-- Generated from ui/StarterGui/Notification System.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Notification System", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "list", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.9107611, 0.5217077), Size = UDim2.fromScale(0.1776557, 0.869267) })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
		I[4] = new("Frame", I[1], "Error", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.11), Size = UDim2.fromScale(1, 0.086) })
			I[5] = new("TextLabel", I[4], "Header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.592, 0.494), Size = UDim2.fromScale(0.789, 0.648), Text = "", TextColor3 = Color3.fromRGB(255, 70, 73), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 2 })
				I[6] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[7] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(31, 31, 31)), ColorSequenceKeypoint.new(1, Color3.fromRGB(39, 39, 39)) }), Rotation = 25 })
			I[8] = new("Frame", I[4], "Filler", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 70, 73), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.011456, 0.9999999), ZIndex = 3 })
			I[9] = new("Frame", I[4], "decal", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
				I[10] = new("ImageLabel", I[9], "background_shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(24, 24, 24), ImageContent = Content.fromUri("rbxassetid://3523728077"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.1280071, 1.8636364), ZIndex = 0 })
					I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 2.6686997 })
				I[12] = new("ImageLabel", I[9], "icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 70, 73), ImageContent = Content.fromUri("rbxassetid://7072725342"), Position = UDim2.fromScale(0.09, 0.485), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.09, 0.485) })
					I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint", { AspectRatio = 1.008 })
			I[14] = new("Frame", I[4], "bar", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 70, 73), BorderSizePixel = 0, Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0.01, 0.05), ZIndex = 3 })
		I[15] = new("Frame", I[1], "Info", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.11), Size = UDim2.fromScale(1, 0.086) })
			I[16] = new("TextLabel", I[15], "Header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5921952, 0.4942219), Size = UDim2.fromScale(0.789, 0.648), Text = "", TextColor3 = Color3.fromRGB(220, 220, 220), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 2 })
				I[17] = new("UITextSizeConstraint", I[16], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[18] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(31, 31, 31)), ColorSequenceKeypoint.new(1, Color3.fromRGB(39, 39, 39)) }), Rotation = 25 })
			I[19] = new("Frame", I[15], "decal", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
				I[20] = new("ImageLabel", I[19], "background_shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(24, 24, 24), ImageContent = Content.fromUri("rbxassetid://3523728077"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.1280071, 1.8636364), ZIndex = 0 })
					I[21] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint", { AspectRatio = 2.6686997 })
				I[22] = new("ImageLabel", I[19], "icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(240, 240, 240), ImageContent = Content.fromUri("rbxassetid://7072717857"), Position = UDim2.fromScale(0.0895631, 0.4852974), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.09, 0.485) })
					I[23] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint", { AspectRatio = 1.008 })
			I[24] = new("Frame", I[15], "Filler", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(220, 220, 220), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.011456, 1), ZIndex = 3 })
			I[25] = new("Frame", I[15], "bar", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(220, 220, 220), BorderSizePixel = 0, Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0.01, 0.05), ZIndex = 3 })
		I[26] = new("Frame", I[1], "Success", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.11), Size = UDim2.fromScale(1, 0.086) })
			I[27] = new("TextLabel", I[26], "Header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.592, 0.494), Size = UDim2.fromScale(0.7890307, 0.6476991), Text = "", TextColor3 = Color3.fromRGB(35, 240, 110), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 2 })
				I[28] = new("UITextSizeConstraint", I[27], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[29] = new("UIGradient", I[26], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(31, 31, 31)), ColorSequenceKeypoint.new(1, Color3.fromRGB(39, 39, 39)) }), Rotation = 25 })
			I[30] = new("Frame", I[26], "decal", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
				I[31] = new("ImageLabel", I[30], "background_shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(24, 24, 24), ImageContent = Content.fromUri("rbxassetid://3523728077"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.1280071, 1.8636364), ZIndex = 0 })
					I[32] = new("UIAspectRatioConstraint", I[31], "UIAspectRatioConstraint", { AspectRatio = 2.6686997 })
				I[33] = new("ImageLabel", I[30], "icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(35, 240, 110), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=6023426926"), Position = UDim2.fromScale(0.0895631, 0.4852974), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.09, 0.485) })
					I[34] = new("UIAspectRatioConstraint", I[33], "UIAspectRatioConstraint", { AspectRatio = 1.008 })
			I[35] = new("Frame", I[26], "Filler", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(35, 240, 110), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.011456, 1), ZIndex = 3 })
			I[36] = new("Frame", I[26], "bar", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(35, 240, 110), BorderSizePixel = 0, Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0.01, 0.05), ZIndex = 3 })
		I[37] = new("Frame", I[1], "Warning", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.11), Size = UDim2.fromScale(1, 0.086) })
			I[38] = new("TextLabel", I[37], "Header", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.592, 0.494), Size = UDim2.fromScale(0.789, 0.648), Text = "", TextColor3 = Color3.fromRGB(240, 175, 45), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 2 })
				I[39] = new("UITextSizeConstraint", I[38], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[40] = new("UIGradient", I[37], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(31, 31, 31)), ColorSequenceKeypoint.new(1, Color3.fromRGB(39, 39, 39)) }), Rotation = 25 })
			I[41] = new("Frame", I[37], "decal", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
				I[42] = new("ImageLabel", I[41], "background_shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(24, 24, 24), ImageContent = Content.fromUri("rbxassetid://3523728077"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.1280071, 1.8636364), ZIndex = 0 })
					I[43] = new("UIAspectRatioConstraint", I[42], "UIAspectRatioConstraint", { AspectRatio = 2.6686997 })
				I[44] = new("ImageLabel", I[41], "icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(240, 175, 45), ImageContent = Content.fromUri("rbxassetid://7072980286"), Position = UDim2.fromScale(0.0895631, 0.4852974), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.09, 0.485) })
					I[45] = new("UIAspectRatioConstraint", I[44], "UIAspectRatioConstraint", { AspectRatio = 1.008 })
			I[46] = new("Frame", I[37], "Filler", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(240, 175, 45), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.011456, 1), ZIndex = 3 })
			I[47] = new("Frame", I[37], "bar", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(240, 175, 45), BorderSizePixel = 0, Position = UDim2.fromScale(1, 1), Size = UDim2.fromScale(0.01, 0.05), ZIndex = 3 })
	return I[1]
end

return build
