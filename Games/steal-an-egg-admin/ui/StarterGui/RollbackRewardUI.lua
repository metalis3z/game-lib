-- Generated from ui/StarterGui/RollbackRewardUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RollbackRewardUI", { DisplayOrder = 99, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "EzSrEBX9EzSr" })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.15, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.6) }, { ["_lemonadeUniqueId"] = "jkfLbdMAjkfL" })
			I[3] = new("ImageButton", I[2], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.988, 0.032), Selectable = false, Size = UDim2.fromScale(0.099128, 0.113789), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "lRFJo6fvlRFJ" })
				I[4] = new("UIScale", I[3], "ButtonUIScale", nil, { ["ButtonFXOwned"] = true, ["_lemonadeUniqueId"] = "PRdZXRrHPRdZ" })
				I[5] = new("ImageLabel", I[3], "DropShadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 4), ImageContent = Content.fromUri("rbxassetid://96735047582734"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.50886, 1.72969), SliceCenter = Rect.new(256, 256, 256, 256), SliceScale = 0.414815, ZIndex = 12 }, { ["_lemonadeUniqueId"] = "YuOJ4PQeYuOJ", ["oldp_SliceScale"] = 0.4 })
				I[6] = new("ImageLabel", I[3], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112096965608582"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Selectable = true, Size = UDim2.fromScale(1.13495, 1.30592), SliceCenter = Rect.new(64, 64, 64, 64), SliceScale = 0.2, ZIndex = 13 }, { ["_lemonadeUniqueId"] = "CiXRA8OQCiXR" })
					I[7] = new("ImageLabel", I[6], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131176354845909"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(1.325, 1.25), Visible = false, ZIndex = 14 }, { ["_lemonadeUniqueId"] = "WZGBUU1jWZGB" })
					I[8] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 9, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 0, 8)) }), Enabled = false, Rotation = 90 }, { ["_lemonadeUniqueId"] = "Tdx07vzHTdx0" })
				I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 1.14413 }, { ["_lemonadeUniqueId"] = "EymmXNnrEymm" })
			I[10] = new("Frame", I[2], "Contents", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "xsdcxplBxsdc" })
				I[11] = new("TextLabel", I[10], "Description", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.177), RichText = true, Size = UDim2.fromScale(0.964607, 0.280729), Text = "Your pet was stronger than intended due to a bug.\nSo its stats have been corrected.\n\nAs compenstation, you've received this reward below:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 7 }, { ["_lemonadeUniqueId"] = "fu9J6kIKfu9J" })
					I[12] = new("UITextSizeConstraint", I[11], "UITextSizeConstraint", { MaxTextSize = 60, MinTextSize = 10 }, { ["_lemonadeUniqueId"] = "cwqOxvTdcwqO" })
				I[13] = new("Frame", I[10], "ImageHolder", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.467903), Size = UDim2.fromScale(0.4, 0.35), ZIndex = 8 }, { ["_lemonadeUniqueId"] = "SBoAbytpSBoA" })
					I[14] = new("ImageLabel", I[13], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://105587107333631"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9, 0.9), ZIndex = 8 }, { ["_lemonadeUniqueId"] = "mSldV6UwmSld" })
					I[15] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "2DWjeFM02DWj" })
					I[16] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.035, 0), BottomRightRadius = UDim.new(0.035, 0), TopLeftRadius = UDim.new(0.035, 0), TopRightRadius = UDim.new(0.035, 0) }, { ["_lemonadeUniqueId"] = "Ral9u0ekRal9" })
					I[17] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(218, 218, 218), Thickness = 4.5629601 }, { ["_lemonadeUniqueId"] = "0kS2zcY00kS2", ["oldp_Thickness"] = 4.4000001 })
				I[18] = new("ImageButton", I[10], "Ok", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.905491), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.446375, 0, 0.067151, 25), SliceCenter = Rect.new(20, 20, 80, 80), SliceScale = 1.03704, ZIndex = 6 }, { ["_lemonadeUniqueId"] = "6IhDaFoU6IhD", ["oldp_SliceScale"] = 1 })
					I[19] = new("ImageLabel", I[18], "ConsoleButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/DefaultController/ButtonA@2x.png"), Position = UDim2.fromScale(1, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.4), Visible = false, ZIndex = 10 }, { ["ConsoleButton"] = "ButtonA", ["_lemonadeUniqueId"] = "5qXDXCTl5qXD" })
						I[20] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "wKkB4kPhwKkB" })
					I[21] = new("ImageLabel", I[18], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Interactable = false, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = true, Size = UDim2.fromScale(0.9, 0.8), SliceCenter = Rect.new(64, 64, 64, 64), SliceScale = 0.155556, ZIndex = -2 }, { ["_lemonadeUniqueId"] = "QnRHGsYWQnRH", ["oldp_SliceScale"] = 0.15 })
						I[22] = new("ImageLabel", I[21], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74603642649742"), ImageTransparency = 0.08, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.259259, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "1D2Isppx1D2I", ["oldp_SliceScale"] = 0.25 })
						I[23] = new("ImageLabel", I[21], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103855926983380"), ImageTransparency = 0.83, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1.3274601), TileSize = UDim2.fromScale(0.175, 0.525), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "C6Y4hBqQC6Y4" })
						I[24] = new("UIGradient", I[21], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 249, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 236, 0)) }), Rotation = 90 }, { ["_lemonadeUniqueId"] = "CiqrbdQICiqr" })
						I[25] = new("UIStroke", I[21], "UIStroke", { Color = Color3.fromRGB(0, 81, 12), Thickness = 2.07407 }, { ["_lemonadeUniqueId"] = "0g4i191t0g4i", ["oldp_Thickness"] = 2 })
					I[26] = new("TextLabel", I[18], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.6), Text = "Ok!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 }, { ["_lemonadeUniqueId"] = "7dhj8dBV7dhj" })
						I[27] = new("UIStroke", I[26], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.11111 }, { ["_lemonadeUniqueId"] = "ToPHBCvFToPH", ["oldp_Thickness"] = 3 })
					I[28] = new("UIGradient", I[18], "green gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(92, 239, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(163, 253, 28)) }), Rotation = -90 }, { ["_lemonadeUniqueId"] = "CBwKNjAcCBwK" })
					I[29] = new("UIScale", I[18], "ButtonUIScale", nil, { ["ButtonFXOwned"] = true, ["_lemonadeUniqueId"] = "Mmd4KELHMmd4" })
				I[30] = new("TextLabel", I[10], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.010879), RichText = true, Size = UDim2.fromScale(0.9, 0.135949), Text = "IMPORTANT PET UPDATE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 7 }, { ["_lemonadeUniqueId"] = "mGurUBD1mGur" })
					I[31] = new("UITextSizeConstraint", I[30], "UITextSizeConstraint", { MaxTextSize = 60, MinTextSize = 10 }, { ["_lemonadeUniqueId"] = "nLU35FZBnLU3" })
				I[32] = new("UIPadding", I[10], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4), PaddingTop = UDim.new(0, 4) }, { ["_lemonadeUniqueId"] = "dP41UcRPdP41" })
			I[33] = new("ImageLabel", I[2], "shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://130304595536693"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 35, 1, 35), SliceCenter = Rect.new(50, 50, 150, 150), SliceScale = 1.03704, ZIndex = -1 }, { ["_lemonadeUniqueId"] = "JXsSywDlJXsS", ["oldp_SliceScale"] = 1 })
			I[34] = new("UIScale", I[2], "TabControllerUIScale", nil, { ["_lemonadeUniqueId"] = "4AXIcIk04AXI" })
			I[35] = new("Frame", I[2], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.15), Visible = false, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "5aFr7Noe5aFr" })
				I[36] = new("TextLabel", I[35], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.675), Text = "Hey!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 2 }, { ["_lemonadeUniqueId"] = "Qj3x024YQj3x" })
					I[37] = new("UIStroke", I[36], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.11111 }, { ["_lemonadeUniqueId"] = "EI6QAzWcEI6Q", ["oldp_Thickness"] = 3 })
				I[38] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(0.24, 0), BottomRightRadius = UDim.new(0.24, 0), TopLeftRadius = UDim.new(0.24, 0), TopRightRadius = UDim.new(0.24, 0) }, { ["_lemonadeUniqueId"] = "X1gpbAXnX1gp" })
				I[39] = new("UIGradient", I[35], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 195, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(94, 239, 255)) }), Rotation = -90 }, { ["_lemonadeUniqueId"] = "hEzkzNiWhEzk" })
				I[40] = new("Frame", I[35], "background-side", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.5) }, { ["_lemonadeUniqueId"] = "KcBHOlD3KcBH" })
					I[41] = new("UIGradient", I[40], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 195, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(94, 239, 255)) }), Offset = Vector2.new(0, -0.5), Rotation = -90 }, { ["_lemonadeUniqueId"] = "oqtbRLc4oqtb" })
			I[42] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.15 }, { ["_lemonadeUniqueId"] = "QC0wI8K8QC0w" })
			I[43] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.035, 0), BottomRightRadius = UDim.new(0.035, 0), TopLeftRadius = UDim.new(0.035, 0), TopRightRadius = UDim.new(0.035, 0) }, { ["_lemonadeUniqueId"] = "0eowZJjh0eow" })
			I[44] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(42, 43, 49), Thickness = 4.5629601 }, { ["_lemonadeUniqueId"] = "uuSQklYquuSQ", ["oldp_Thickness"] = 4.4000001 })
	return I[1]
end

return build
