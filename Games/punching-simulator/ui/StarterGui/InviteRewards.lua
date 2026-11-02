-- Generated from ui/StarterGui/InviteRewards.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "InviteRewards", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(132, 40, 246), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.625), Visible = false, ZIndex = 0 })
			I[3] = new("ImageButton", I[2], "InviteRewards", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://12489985753"), ImageTransparency = 1, Position = UDim2.fromScale(0.9954257, 0.0446514), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1000238, 0.1750417), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 6 }, nil, { "PopButton", "UIToggleButton" })
				I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(-0.05, 0) })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[6] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.64, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(188, 4, 0)) }), Rotation = 90 })
				I[7] = new("UIStroke", I[3], "UIStroke", { Thickness = 3 })
				I[8] = new("ImageLabel", I[3], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13704067744"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55), ZIndex = 6 })
				I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[10] = new("TextLabel", I[2], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.0482393), Size = UDim2.fromScale(0.8, 0.05195), Text = "INVITE REWARDS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
				I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 2 })
				I[12] = new("TextLabel", I[10], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "INVITE REWARDS", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[13] = new("UIStroke", I[12], "UIStroke", { Thickness = 2 })
			I[14] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
			I[15] = new("Frame", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.042456), Size = UDim2.fromScale(1, 0.084912) })
				I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 4 })
				I[17] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 248, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 144, 0)) }), Rotation = 90 })
			I[18] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(104, 0, 255)), ColorSequenceKeypoint.new(0.3833334, Color3.fromRGB(136, 38, 238)), ColorSequenceKeypoint.new(1, Color3.fromRGB(102, 0, 239)) }), Rotation = 90 })
			I[19] = new("Frame", I[2], "Dark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 5 })
			I[20] = new("Frame", I[2], "Opening", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 36, 71), ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.5), Visible = false, ZIndex = 5 })
				I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 5 })
				I[22] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
				I[23] = new("ImageLabel", I[20], "Marker", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 255, 0), ImageContent = Content.fromUri("rbxassetid://1074545642"), Position = UDim2.fromScale(0.5, 0.056), Size = UDim2.fromScale(0.0243902, 0.1121831), ZIndex = 10 })
					I[24] = new("Frame", I[23], "Line", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 4.6657982), Size = UDim2.fromScale(0.2, 8.5), ZIndex = 10 })
				I[25] = new("Frame", I[20], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(157, 147, 238), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 0.8999999), ZIndex = 0 })
					I[26] = new("UIListLayout", I[25], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.01, 0), VerticalAlignment = Enum.VerticalAlignment.Center })
			I[27] = new("Frame", I[2], "Content", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(157, 147, 238), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(0.975, 0.8), Visible = false, ZIndex = 0 })
				I[28] = new("Frame", I[27], "Rewards", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.7, 0.5), Size = UDim2.fromScale(0.5908869, 1.2093376) })
					I[29] = new("UIGridLayout", I[28], "UIGridLayout", { CellPadding = UDim2.fromScale(0.015, 0.025), CellSize = UDim2.fromScale(0.3, 0.35), FillDirectionMaxCells = 3, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[30] = new("Frame", I[27], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(36, 4, 158), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.7, 0.5), Size = UDim2.fromScale(0.575, 0.95) })
					I[31] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0.025, 0), BottomRightRadius = UDim.new(0.025, 0), TopLeftRadius = UDim.new(0.025, 0), TopRightRadius = UDim.new(0.025, 0) })
				I[32] = new("ImageLabel", I[27], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14315885660"), Position = UDim2.fromScale(0.173084, 0.4363372), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.269, 0.672), ZIndex = 4 })
					I[33] = new("ImageLabel", I[32], "Sunburst", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://8574506083"), Position = UDim2.fromScale(0.5, 0.45), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.75, 1.75) })
						I[34] = new("UIAspectRatioConstraint", I[33], "UIAspectRatioConstraint")
						I[35] = new("UIScale", I[33], "UIScale", { Scale = 0.9 })
						I[36] = new("UIGradient", I[33], "UIGradient", { Rotation = 90 })
				I[37] = new("ImageButton", I[27], "Back", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13810832668"), Position = UDim2.fromScale(0.175, 0.9), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.2, 0.2), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
					I[38] = new("TextLabel", I[37], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(0.8, 0.7), Text = "Back", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
						I[39] = new("UIStroke", I[38], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
			I[40] = new("Frame", I[2], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.175), Size = UDim2.fromScale(0.95, 0.1331677) })
				I[41] = new("UIListLayout", I[40], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[42] = new("Frame", I[40], "Friends", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 47, 182), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.091033, 0.5000001), Size = UDim2.fromScale(0.1820657, 0.6661651), ZIndex = 0 })
					I[43] = new("TextLabel", I[42], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.55), Text = "Invited: 0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[44] = new("UIStroke", I[43], "UIStroke", { Thickness = 1.5 })
				I[45] = new("Frame", I[40], "Notice", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 47, 182), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.6264698, 0.7871345), Size = UDim2.fromScale(0.4009798, 0.6661651), ZIndex = 0 })
					I[46] = new("TextLabel", I[45], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.55), Text = "Invited friends must join!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[47] = new("UIStroke", I[46], "UIStroke", { Thickness = 1.5 })
				I[48] = new("ImageButton", I[40], "InviteBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14457136175"), Position = UDim2.fromScale(0.0805854, 0.6538307), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1611706, 0.7583418), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "InviteButton" })
					I[49] = new("TextLabel", I[48], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(0.8520001, 0.45), Text = "INVITE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
						I[50] = new("UIStroke", I[49], "UIStroke", { Thickness = 1.5 })
			I[51] = new("Frame", I[2], "Pages", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.6287965), Size = UDim2.fromScale(1, 0.7424071) })
				I[52] = new("Frame", I[51], "Friends", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[53] = new("Frame", I[52], "Content", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(157, 147, 238), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4146422), Size = UDim2.fromScale(0.9750001, 0.7423614), ZIndex = 0 })
						I[54] = new("Frame", I[53], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 80, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.6131676), Size = UDim2.fromScale(1, 1.3105454), ZIndex = 0 })
							I[55] = new("Frame", I[54], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(157, 147, 238), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.4960175), Size = UDim2.fromScale(1.0000001, 1.0079648) })
								I[56] = new("ScrollingFrame", I[55], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(157, 147, 238), BackgroundTransparency = 1, BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png"), CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5, 0.5), ScrollBarThickness = 5, Selectable = false, Size = UDim2.fromScale(1, 1), TopImageContent = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png") })
									I[57] = new("UIListLayout", I[56], "UIListLayout", { Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[58] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.5288447 })
	return I[1]
end

return build
