-- Generated from ui/StarterGui/CaptureTheEggUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CaptureTheEggUI", { DisplayOrder = 6, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "XJROc7SKXJRO" })
		I[2] = new("Frame", I[1], "Board", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.085), Size = UDim2.fromScale(0.4, 0.06) }, { ["_lemonadeUniqueId"] = "SqtWJlMcSqtW" })
			I[3] = new("ImageLabel", I[2], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://16857574577"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(2, 4.5) }, { ["_lemonadeUniqueId"] = "TGg0bS3hTGg0" })
			I[4] = new("Frame", I[2], "Rows", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1.25), ZIndex = 2 }, { ["_lemonadeUniqueId"] = "CUk0bLb5CUk0" })
				I[5] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "jWTYpsEKjWTY" })
				I[6] = new("Frame", I[4], "Leader", { BackgroundColor3 = Color3.fromRGB(255, 214, 89), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.2, 1) }, { ["_lemonadeUniqueId"] = "ZVkv5xTlZVkv" })
					I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height }, { ["_lemonadeUniqueId"] = "bw66AbXXbw66" })
					I[8] = new("ImageLabel", I[6], "Avatar", { BackgroundColor3 = Color3.fromRGB(35, 35, 45), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=89659291&w=100&h=100"), Size = UDim2.fromScale(1, 1), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "ZviDfsBfZviD" })
						I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "IQ93Oh1hIQ93" })
						I[10] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(255, 214, 89), Thickness = 2, Transparency = 0.08 }, { ["_lemonadeUniqueId"] = "06KsG02406Ks" })
						I[11] = new("TextLabel", I[8], "Timer", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1.1), Size = UDim2.fromScale(1, 0.3), Text = "0s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "6hqTpg9f6hqT" })
							I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 0.1, Transparency = 0.04 }, { ["_lemonadeUniqueId"] = "npo0OD1vnpo0" })
					I[13] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "6iRbCBNd6iRb" })
					I[14] = new("UIGradient", I[6], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "jLQIOMHBjLQI" })
				I[15] = new("Frame", I[4], "Second", { BackgroundColor3 = Color3.fromRGB(213, 213, 213), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.2, 0.85) }, { ["_lemonadeUniqueId"] = "IwUmlpiWIwUm" })
					I[16] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height }, { ["_lemonadeUniqueId"] = "T3TI8zZvT3TI" })
					I[17] = new("ImageLabel", I[15], "Avatar", { BackgroundColor3 = Color3.fromRGB(35, 35, 45), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=89659291&w=100&h=100"), Size = UDim2.fromScale(1, 1), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "Sz65j7YoSz65" })
						I[18] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "O9ULL0aGO9UL" })
						I[19] = new("UIStroke", I[17], "UIStroke", { Color = Color3.fromRGB(213, 213, 213), Thickness = 2, Transparency = 0.08 }, { ["_lemonadeUniqueId"] = "pXRI42bzpXRI" })
						I[20] = new("TextLabel", I[17], "Timer", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1.1), Size = UDim2.fromScale(1, 0.3), Text = "0s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "YOXfAEEuYOXf" })
							I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 0.1, Transparency = 0.04 }, { ["_lemonadeUniqueId"] = "D5SyCXeOD5Sy" })
					I[22] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "LS6Wn8DPLS6W" })
					I[23] = new("UIGradient", I[15], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "TWxSDpFBTWxS" })
				I[24] = new("Frame", I[4], "Third", { BackgroundColor3 = Color3.fromRGB(204, 141, 96), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.2, 0.85) }, { ["_lemonadeUniqueId"] = "Zui4Y7AKZui4" })
					I[25] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height }, { ["_lemonadeUniqueId"] = "KnV0nprbKnV0" })
					I[26] = new("ImageLabel", I[24], "Avatar", { BackgroundColor3 = Color3.fromRGB(35, 35, 45), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=89659291&w=100&h=100"), Size = UDim2.fromScale(1, 1), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "RHZRIciARHZR" })
						I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "lIuh6NH1lIuh" })
						I[28] = new("UIStroke", I[26], "UIStroke", { Color = Color3.fromRGB(204, 141, 96), Thickness = 2, Transparency = 0.08 }, { ["_lemonadeUniqueId"] = "g0rpsYQMg0rp" })
						I[29] = new("TextLabel", I[26], "Timer", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1.1), Size = UDim2.fromScale(1, 0.3), Text = "0s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "UOXwkB60UOXw" })
							I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 0.1, Transparency = 0.04 }, { ["_lemonadeUniqueId"] = "MmM2rKTZMmM2" })
					I[31] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "Fj71OsznFj71" })
					I[32] = new("UIGradient", I[24], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "P6MT1PSgP6MT" })
				I[33] = new("Frame", I[4], "You", { BackgroundColor3 = Color3.fromRGB(138, 138, 138), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.2, 0.85) }, { ["_lemonadeUniqueId"] = "2PO0ucT52PO0" })
					I[34] = new("UIAspectRatioConstraint", I[33], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height }, { ["_lemonadeUniqueId"] = "w6OSnVKMw6OS" })
					I[35] = new("ImageLabel", I[33], "Avatar", { BackgroundColor3 = Color3.fromRGB(35, 35, 45), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=89659291&w=100&h=100"), Size = UDim2.fromScale(1, 1), ZIndex = 5 }, { ["_lemonadeUniqueId"] = "PyHFubFtPyHF" })
						I[36] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "K75JjU39K75J" })
						I[37] = new("UIStroke", I[35], "UIStroke", { Color = Color3.fromRGB(138, 138, 138), Thickness = 2, Transparency = 0.08 }, { ["_lemonadeUniqueId"] = "WYaVRv2mWYaV" })
						I[38] = new("TextLabel", I[35], "Timer", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1.1), Size = UDim2.fromScale(1, 0.3), Text = "0s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "fsobXkYifsob" })
							I[39] = new("UIStroke", I[38], "UIStroke", { Thickness = 0.1, Transparency = 0.04 }, { ["_lemonadeUniqueId"] = "LFGFrhmULFGF" })
						I[40] = new("TextLabel", I[35], "YouLabel", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.1), Size = UDim2.fromScale(1, 0.3), Text = "YOU!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["_lemonadeUniqueId"] = "wpmtplGQwpmt" })
							I[41] = new("UIStroke", I[40], "UIStroke", { Thickness = 0.1, Transparency = 0.04 }, { ["_lemonadeUniqueId"] = "v9nBZ0Htv9nB" })
					I[42] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "LACYUVXzLACY" })
					I[43] = new("UIGradient", I[33], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) }, { ["_lemonadeUniqueId"] = "iUyQRnnTiUyQ" })
			I[44] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -1.25), Size = UDim2.fromScale(0.5, 0.5), Text = "CAPTURE THE EGG", TextColor3 = Color3.fromRGB(255, 214, 89), TextScaled = true, TextWrapped = true, ZIndex = 4 }, { ["_lemonadeUniqueId"] = "qN2V84rPqN2V" })
				I[45] = new("UIStroke", I[44], "UIStroke", { Color = Color3.fromRGB(35, 26, 5), Thickness = 2.5 }, { ["_lemonadeUniqueId"] = "6JhJmtwW6JhJ" })
			I[46] = new("TextLabel", I[2], "Subtitle", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, -0.75), Size = UDim2.fromScale(0.5, 0.35), Text = "HOLD THE EGG TO EARN TIME", TextColor3 = Color3.fromRGB(255, 244, 216), TextScaled = true, TextWrapped = true, ZIndex = 4 }, { ["_lemonadeUniqueId"] = "t1HXWStbt1HX" })
				I[47] = new("UIStroke", I[46], "UIStroke", { Color = Color3.fromRGB(35, 26, 5), Thickness = 2.5 }, { ["_lemonadeUniqueId"] = "IHLT43KEIHLT" })
	return I[1]
end

return build
