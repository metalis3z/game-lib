-- Generated from ui/StarterGui/Message.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Message", { DisplayOrder = 100, Enabled = false, ResetOnSpawn = false })
		I[2] = new("ImageLabel", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.135, 300, 0.135, 300), SliceCenter = Rect.new(20, 20, 80, 80), ZIndex = 3 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.5 })
			I[4] = new("TextLabel", I[2], "Desc", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.025), Size = UDim2.fromScale(0.925, 0.525), Text = "Bubble pop-up description?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 7 })
				I[5] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 30, MinTextSize = 10 })
			I[6] = new("ImageButton", I[2], "Yes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.25, 0.85), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.45, 0.24), SliceCenter = Rect.new(10, 10, 40, 40), Visible = false, ZIndex = 6 })
				I[7] = new("TextLabel", I[6], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "Yes", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
					I[8] = new("UITextSizeConstraint", I[7], "UITextSizeConstraint", { MaxTextSize = 60 })
			I[9] = new("ImageButton", I[2], "No", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 46, 137), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.75, 0.85), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.45, 0.24), SliceCenter = Rect.new(10, 10, 40, 40), Visible = false, ZIndex = 6 })
				I[10] = new("TextLabel", I[9], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "No", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
					I[11] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 60 })
			I[12] = new("ImageButton", I[2], "Ok", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.85), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.5, 0.25), SliceCenter = Rect.new(10, 10, 40, 40), ZIndex = 6 })
				I[13] = new("TextLabel", I[12], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "Ok!", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
					I[14] = new("UITextSizeConstraint", I[13], "UITextSizeConstraint", { MaxTextSize = 60 })
			I[15] = new("ImageButton", I[2], "Cancel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 46, 137), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.5, 0.88), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.45, 0.2), SliceCenter = Rect.new(10, 10, 40, 40), Visible = false, ZIndex = 6 })
				I[16] = new("TextLabel", I[15], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "Cancel", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
					I[17] = new("UITextSizeConstraint", I[16], "UITextSizeConstraint", { MaxTextSize = 40 })
			I[18] = new("ImageButton", I[2], "Option 1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.25, 0.665), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.45, 0.18), SliceCenter = Rect.new(10, 10, 40, 40), Visible = false, ZIndex = 6 })
				I[19] = new("TextLabel", I[18], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "Option", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
					I[20] = new("UITextSizeConstraint", I[19], "UITextSizeConstraint", { MaxTextSize = 40 })
			I[21] = new("ImageButton", I[2], "Option 2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.75, 0.665), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.45, 0.18), SliceCenter = Rect.new(10, 10, 40, 40), Visible = false, ZIndex = 6 })
				I[22] = new("TextLabel", I[21], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.8), Text = "Option", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
					I[23] = new("UITextSizeConstraint", I[22], "UITextSizeConstraint", { MaxTextSize = 40 })
	return I[1]
end

return build
