-- Generated from ui/StarterGui/Main.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Main", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("ImageLabel", I[1], "CD", { BackgroundColor3 = Color3.fromRGB(43, 43, 43), BackgroundTransparency = 1, BorderMode = Enum.BorderMode.Middle, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(43, 43, 43), ImageContent = Content.fromUri("rbxassetid://3570695787"), ImageTransparency = 0.3, Position = UDim2.fromScale(0.3460607, 0.009), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.0450601, 0.0419289), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.12, Visible = false })
			I[3] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4380986, 0.1673777), Size = UDim2.fromScale(0.4208425, 0.6471764), Text = "3", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0.8, TextWrapped = true })
				I[4] = new("UITextSizeConstraint", I[3], "UITextSizeConstraint", { MaxTextSize = 20 })
			I[5] = new("ImageButton", I[2], "alarm", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://3926307971"), ImageRectOffset = Vector2.new(604, 404), ImageRectSize = Vector2.new(36, 36), LayoutOrder = 4, Position = UDim2.fromScale(0.1, 0.088), Size = UDim2.fromScale(0.3380987, 0.7265541), ZIndex = 2 })
			I[6] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.2401011 })
		I[7] = new("TextLabel", I[1], "PlayersRemain", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.634, 0.015), Size = UDim2.fromScale(0.0272227, 0.0269287), Text = "111", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0.8, TextWrapped = true, Visible = false, ZIndex = 3 })
			I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint", { AspectRatio = 2.0911434 })
			I[9] = new("UITextSizeConstraint", I[7], "UITextSizeConstraint", { MaxTextSize = 20 })
		I[10] = new("ImageLabel", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(43, 43, 43), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(43, 45, 41), ImageContent = Content.fromUri("rbxassetid://3570695787"), ImageTransparency = 0.3, Position = UDim2.fromScale(0.3937208, 0.0097817), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.2206488, 0.04097), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.6666667, ZIndex = 2 })
			I[11] = new("TextLabel", I[10], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.032694, 0.069809), Size = UDim2.fromScale(0.9343323, 0.847932), Text = "THE DROP WILL START SOON!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 20, TextStrokeTransparency = 0.8, TextWrapped = true, ZIndex = 3 })
				I[12] = new("UITextSizeConstraint", I[11], "UITextSizeConstraint", { MaxTextSize = 20 })
			I[13] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 11.2259941 })
		I[14] = new("ImageLabel", I[1], "PL", { BackgroundColor3 = Color3.fromRGB(43, 43, 43), BackgroundTransparency = 1, BorderMode = Enum.BorderMode.Middle, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(43, 43, 43), ImageContent = Content.fromUri("rbxassetid://3570695787"), ImageTransparency = 0.3, Position = UDim2.fromScale(0.6170174, 0.009), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.0450601, 0.0419289), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 0.12, Visible = false })
			I[15] = new("ImageButton", I[14], "person", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://3926307971"), ImageRectOffset = Vector2.new(884, 4), ImageRectSize = Vector2.new(36, 36), Position = UDim2.fromScale(0.1, 0.087), Size = UDim2.fromScale(0.337413, 0.7616397), ZIndex = 2 })
				I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0, 60), BottomRightRadius = UDim.new(0, 60), TopLeftRadius = UDim.new(0, 60), TopRightRadius = UDim.new(0, 60) })
			I[17] = new("TextLabel", I[14], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0075876, 0), Size = UDim2.fromScale(0.8346531, 0.9620711), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true })
				I[18] = new("UITextSizeConstraint", I[17], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[19] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint", { AspectRatio = 2.2401011 })
	return I[1]
end

return build
