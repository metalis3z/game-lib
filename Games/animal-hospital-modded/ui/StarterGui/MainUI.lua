-- Generated from ui/StarterGui/MainUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MainUI", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Global", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.176), Size = UDim2.fromScale(0.4868515, 0.0775011), ZIndex = 5 })
			I[3] = new("Frame", I[2], "MessageFrame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.75, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.8818043), Visible = false }, { ["OriginalTransparency"] = 0.75 })
				I[4] = new("UIGradient", I[3], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2991543, 0), NumberSequenceKeypoint.new(0.6997886, 0), NumberSequenceKeypoint.new(1, 1) }) })
				I[5] = new("TextLabel", I[3], "Message", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4879175, 0.5279616), Size = UDim2.fromScale(2, 0.9), Text = "Aura-ful Message", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 40, TextWrapped = true })
					I[6] = new("UIStroke", I[5], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.05 })
			I[7] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder })
		I[8] = new("Frame", I[1], "Countdown", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.1839695), Size = UDim2.fromOffset(116, 116), Visible = false, ZIndex = 100 })
			I[9] = new("TextLabel", I[8], "Int", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9568965, 0.8706896), Text = "3", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[10] = new("UIStroke", I[9], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.07 })
			I[11] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint")
		I[12] = new("Frame", I[1], "PollVoting", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.75, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0122137), Size = UDim2.fromScale(0.2953379, 0.2192088), Visible = false }, { ["OriginalTransparency"] = 0.75 })
			I[13] = new("UIGradient", I[12], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2848837, 0), NumberSequenceKeypoint.new(0.7082452, 0), NumberSequenceKeypoint.new(1, 1) }) })
			I[14] = new("Frame", I[12], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(0.0741819, 0.21469) })
				I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
				I[16] = new("UIListLayout", I[14], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.4, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[17] = new("TextButton", I[14], "LeftButton", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(14, 136, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(-5.5923195, 0.5000001), Size = UDim2.fromScale(5.1869998, 1.28), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
					I[18] = new("UIStroke", I[17], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(8, 70, 0), Thickness = 3 })
					I[19] = new("TextLabel", I[17], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5023379, 0.4668458), Size = UDim2.fromScale(1.0046759, 0.7183436), Text = "SAMPLE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(5, 39, 0), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.25 })
					I[21] = new("Frame", I[17], "Color", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4650259), Size = UDim2.fromScale(1, 0.9096492) })
						I[22] = new("ImageLabel", I[21], "Layout", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://10509779001"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(0.97, 0.885), TileSize = UDim2.fromScale(0.07, 0.325), ZIndex = 0 })
							I[23] = new("UIGradient", I[22], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(145, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(29, 218, 0)) }), Rotation = 90 })
						I[24] = new("UIGradient", I[21], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(136, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(136, 255, 0)) }), Rotation = 90 })
					I[25] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint", { AspectRatio = 4.0523438 })
				I[26] = new("TextButton", I[14], "RightButton", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(136, 0, 2), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(3.2935252, 0.4183055), Size = UDim2.fromScale(5.1870518, 1.2803051), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
					I[27] = new("UIStroke", I[26], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 0, 1), Thickness = 3 })
					I[28] = new("TextLabel", I[26], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5023379, 0.4668458), Size = UDim2.fromScale(1.0046759, 0.7183436), Text = "SAMPLE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[29] = new("UIStroke", I[28], "UIStroke", { Color = Color3.fromRGB(5, 39, 0), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.25 })
					I[30] = new("Frame", I[26], "Color", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4650259), Size = UDim2.fromScale(1, 0.9096492) })
						I[31] = new("ImageLabel", I[30], "Layout", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://10509779001"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(0.97, 0.885), TileSize = UDim2.fromScale(0.07, 0.325), ZIndex = 0 })
							I[32] = new("UIGradient", I[31], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 125, 125)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 30, 30)) }), Rotation = 90 })
						I[33] = new("UIGradient", I[30], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 140)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 140)) }), Rotation = 90 })
					I[34] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint", { AspectRatio = 4.0514183 })
			I[35] = new("Frame", I[12], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4977668, 0.3621629), Size = UDim2.fromScale(0.962602, 0.1671521) })
				I[36] = new("UIStroke", I[35], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14 })
				I[37] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[38] = new("TextLabel", I[35], "LeftVotes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2899739, 1.6277574), Size = UDim2.fromScale(0.23, 0.75), Text = "0 Votes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[39] = new("UIStroke", I[38], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14 })
				I[40] = new("TextLabel", I[35], "RightVotes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7068413, 1.6277574), Size = UDim2.fromScale(0.23, 0.75), Text = "0 Votes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[41] = new("UIStroke", I[40], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14 })
				I[42] = new("TextLabel", I[35], "Question", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5020221, -0.8930759), Size = UDim2.fromScale(0.455, 1.125), Text = "Sample Question?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[43] = new("UIStroke", I[42], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 })
				I[44] = new("Frame", I[35], "Left", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(0.5, 1) })
					I[45] = new("ImageLabel", I[44], "Layout", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://10509779001"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.07, 0.325), ZIndex = 0 })
						I[46] = new("UIGradient", I[45], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(145, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(29, 218, 0)) }), Rotation = 90 })
					I[47] = new("Frame", I[44], "LeftPercent", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.6550002, 0.5), Size = UDim2.fromScale(0.92, 0.5) })
						I[48] = new("UIAspectRatioConstraint", I[47], "UIAspectRatioConstraint", { AspectRatio = 10.2222223 })
						I[49] = new("TextLabel", I[47], "LeftPercent", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "50%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
							I[50] = new("UIStroke", I[49], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14 })
							I[51] = new("UIAspectRatioConstraint", I[49], "UIAspectRatioConstraint", { AspectRatio = 10.2222223 })
				I[52] = new("Frame", I[35], "Right", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.5, 1) })
					I[53] = new("ImageLabel", I[52], "Layout", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://10509779001"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.07, 0.325), ZIndex = 0 })
						I[54] = new("UIGradient", I[53], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 125, 125)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 30, 30)) }), Rotation = 90 })
					I[55] = new("Frame", I[52], "RightPercent", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.3500001, 0.5), Size = UDim2.fromScale(0.92, 0.5) })
						I[56] = new("UIAspectRatioConstraint", I[55], "UIAspectRatioConstraint", { AspectRatio = 10.2222223 })
						I[57] = new("TextLabel", I[55], "LeftPercent", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "50%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[58] = new("UIStroke", I[57], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14 })
							I[59] = new("UIAspectRatioConstraint", I[57], "UIAspectRatioConstraint", { AspectRatio = 10.2222223 })
				I[60] = new("UIAspectRatioConstraint", I[35], "UIAspectRatioConstraint", { AspectRatio = 16.666666 })
			I[61] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint", { AspectRatio = 2.8941026 })
		I[62] = new("Frame", I[1], "Events", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9587775, 0.9145038), Size = UDim2.fromOffset(100, 100) })
			I[63] = new("UIListLayout", I[62], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0.1, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
	return I[1]
end

return build
