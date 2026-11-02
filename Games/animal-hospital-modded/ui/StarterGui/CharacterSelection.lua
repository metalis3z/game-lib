-- Generated from ui/StarterGui/CharacterSelection.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CharacterSelection", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Selection", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(60, 77, 147), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4996308, 0.6281402), Size = UDim2.fromScale(0.6764041, 0.9094682), Visible = false }, { ["Blur"] = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Enabled = false, Thickness = 2 })
			I[4] = new("TextButton", I[2], "close", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(207, 26, 38), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9710984, 0.0519248), Size = UDim2.fromScale(0.0562235, 0.0672485), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint")
				I[6] = new("UIStroke", I[4], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 14, 0), Thickness = 2 })
			I[7] = new("ScrollingFrame", I[2], "inv", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.4962102, 0.5268801), ScrollBarThickness = 10, Size = UDim2.fromScale(0.9924204, 0.9430485) })
				I[8] = new("Frame", I[7], "inv", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(60, 77, 147), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.497822, 0.3489247), Selectable = true, SelectionGroup = true, Size = UDim2.fromScale(0.9757313, 0.6331984) })
					I[9] = new("UIStroke", I[8], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
					I[10] = new("Frame", I[8], "Options", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4972371, 0.5), Selectable = true, SelectionGroup = true, Size = UDim2.fromScale(0.9548013, 0.7391609) })
						I[11] = new("UIGradient", I[10], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }), Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.8) }) })
						I[12] = new("UIListLayout", I[10], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
						I[13] = new("ImageButton", I[10], "classes", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.1623367, 0.4238898), SelectionGroup = true, Size = UDim2.fromScale(0.3246735, 0.8100567) })
							I[14] = new("UIStroke", I[13], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
							I[15] = new("TextLabel", I[13], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.500096, 0.853698), Size = UDim2.fromScale(1.0062175, 0.285491), Text = "CHARACTERS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
								I[16] = new("UIStroke", I[15], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
								I[17] = new("UIPadding", I[15], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0.2, 0), PaddingRight = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
							I[18] = new("UIGradient", I[13], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
							I[19] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint", { AspectRatio = 0.9942277 })
							I[20] = new("ImageLabel", I[13], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://137206656419125"), Size = UDim2.fromScale(1.0031776, 0.9973871) })
						I[21] = new("ImageButton", I[10], "anomalies", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.1623367, 0.4238898), SelectionGroup = true, Size = UDim2.fromScale(0.3246735, 0.8100567) })
							I[22] = new("UIStroke", I[21], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
							I[23] = new("TextLabel", I[21], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.500096, 0.853698), Size = UDim2.fromScale(1.0062175, 0.285491), Text = "ANOMALIES", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
								I[24] = new("UIStroke", I[23], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
								I[25] = new("UIPadding", I[23], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0.2, 0), PaddingRight = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
							I[26] = new("UIGradient", I[21], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
							I[27] = new("UIAspectRatioConstraint", I[21], "UIAspectRatioConstraint", { AspectRatio = 0.9942277 })
							I[28] = new("ImageLabel", I[21], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://113443060910964"), Size = UDim2.fromScale(1.0031776, 0.9973871) })
						I[29] = new("ImageButton", I[10], "custom", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.1623367, 0.4238898), SelectionGroup = true, Size = UDim2.fromScale(0.3246735, 0.8100567) })
							I[30] = new("UIStroke", I[29], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
							I[31] = new("TextLabel", I[29], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.500096, 0.853698), Size = UDim2.fromScale(1.0062175, 0.285491), Text = "CUSTOM", TextColor3 = Color3.fromRGB(255, 247, 0), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
								I[32] = new("UIStroke", I[31], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
								I[33] = new("UIPadding", I[31], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0.2, 0), PaddingRight = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
							I[34] = new("UIGradient", I[29], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
							I[35] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint", { AspectRatio = 0.9942277 })
							I[36] = new("ImageLabel", I[29], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://96488583332462"), Size = UDim2.fromScale(1.0031776, 0.9973871) })
					I[37] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.8, Color3.fromRGB(252, 252, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 165, 167)) }), Rotation = 90 })
				I[38] = new("TextLabel", I[7], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.497822, 0.0499999), Size = UDim2.fromScale(0.2708946, 0.0757494), Text = "Select An Option", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
					I[39] = new("UIStroke", I[38], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
					I[40] = new("UIAspectRatioConstraint", I[38], "UIAspectRatioConstraint", { AspectRatio = 4.5210814 })
					I[41] = new("UIPadding", I[38], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0.2, 0), PaddingRight = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
			I[42] = new("TextBox", I[2], "Nametag", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255, 255, 255), PlaceholderText = "ROLEPLAY NAME", Position = UDim2.fromScale(0.0272769, 0.5930559), Size = UDim2.fromScale(0.2291257, 0.064603), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[43] = new("UIStroke", I[42], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
				I[44] = new("UIGradient", I[42], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
			I[45] = new("TextButton", I[2], "submit", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(46, 207, 37), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.359628, 0.5920063), Size = UDim2.fromScale(0.086305, 0.0665804), Text = "SUBMIT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[46] = new("UIStroke", I[45], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(0, 255, 0), Thickness = 2 })
		I[47] = new("Frame", I[1], "AnomalySelection", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(60, 77, 147), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4996308, 0.4988805), Size = UDim2.fromScale(0.6764041, 0.9094682), Visible = false }, { ["Blur"] = true })
			I[48] = new("UIStroke", I[47], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Enabled = false, Thickness = 2 })
			I[49] = new("TextButton", I[47], "close", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(207, 26, 38), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9710984, 0.0519248), Size = UDim2.fromScale(0.0562235, 0.0672485), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[50] = new("UIAspectRatioConstraint", I[49], "UIAspectRatioConstraint")
				I[51] = new("UIStroke", I[49], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 14, 0), Thickness = 2 })
			I[52] = new("ScrollingFrame", I[47], "inv", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.4962102, 0.5268801), ScrollBarThickness = 10, Size = UDim2.fromScale(0.9924204, 0.9430485) })
				I[53] = new("Frame", I[52], "inv", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(60, 77, 147), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.497822, 0.4742879), Selectable = true, SelectionGroup = true, Size = UDim2.fromScale(0.9757314, 0.8839247) })
					I[54] = new("UIStroke", I[53], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
					I[55] = new("UIGradient", I[53], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.8, Color3.fromRGB(252, 252, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 165, 167)) }), Rotation = 90 })
					I[56] = new("ScrollingFrame", I[53], "ScrollingFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0184642, 0.0821504), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.9430919, 0.8943539) })
						I[57] = new("UICorner", I[56], "UICorner")
						I[58] = new("UIStroke", I[56], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
						I[59] = new("ImageButton", I[56], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.1623367, 0.4238898), SelectionGroup = true, Size = UDim2.fromScale(0.3246735, 0.8100567), Visible = false })
							I[60] = new("UIStroke", I[59], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
							I[61] = new("TextLabel", I[59], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.500096, 0.853698), Size = UDim2.fromScale(1.0062175, 0.285491), Text = "TEMPLATE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
								I[62] = new("UIStroke", I[61], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
								I[63] = new("UIPadding", I[61], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0.2, 0), PaddingRight = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
							I[64] = new("UIGradient", I[59], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
							I[65] = new("ViewportFrame", I[59], "ViewportFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(230, 230, 230), Size = UDim2.fromScale(1.0021982, 0.9956432) })
								I[66] = new("WorldModel", I[65], "WorldModel")
									I[67] = new("Part", I[66], "cam", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-72.0589981, 3.891, -314.0490112, 0.9453843, -0.0244671, -0.3250385, 0.0000346, 0.9971864, -0.0749622, 0.325958, 0.0708569, 0.9427251), Size = Vector3.new(1, 1, 1), TopSurface = Enum.SurfaceType.Smooth })
						I[68] = new("UIGridLayout", I[56], "UIGridLayout", { CellPadding = UDim2.fromScale(0.001, 0.001), CellSize = UDim2.fromScale(0.2, 0.15), FillDirectionMaxCells = 5 })
				I[69] = new("TextLabel", I[52], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.497822, 0.0499999), Size = UDim2.fromScale(0.2708946, 0.0757494), Text = "ANOMALIES", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
					I[70] = new("UIStroke", I[69], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
					I[71] = new("UIAspectRatioConstraint", I[69], "UIAspectRatioConstraint", { AspectRatio = 4.5210814 })
					I[72] = new("UIPadding", I[69], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0.2, 0), PaddingRight = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
		I[73] = new("Frame", I[1], "PremadeSelection", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(60, 77, 147), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4996308, 0.4988805), Size = UDim2.fromScale(0.6764041, 0.9094682), Visible = false }, { ["Blur"] = true })
			I[74] = new("UIStroke", I[73], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Enabled = false, Thickness = 2 })
			I[75] = new("TextButton", I[73], "close", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(207, 26, 38), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9710984, 0.0519248), Size = UDim2.fromScale(0.0562235, 0.0672485), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[76] = new("UIAspectRatioConstraint", I[75], "UIAspectRatioConstraint")
				I[77] = new("UIStroke", I[75], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 14, 0), Thickness = 2 })
			I[78] = new("ScrollingFrame", I[73], "inv", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.4962102, 0.5268801), ScrollBarThickness = 10, Size = UDim2.fromScale(0.9924204, 0.9430485) })
				I[79] = new("Frame", I[78], "inv", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(60, 77, 147), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.497822, 0.4742879), Selectable = true, SelectionGroup = true, Size = UDim2.fromScale(0.9757314, 0.8839247) })
					I[80] = new("UIStroke", I[79], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
					I[81] = new("UIGradient", I[79], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.8, Color3.fromRGB(252, 252, 252)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 165, 167)) }), Rotation = 90 })
					I[82] = new("ScrollingFrame", I[79], "ScrollingFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0184642, 0.0821504), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.9430919, 0.8943539) })
						I[83] = new("UICorner", I[82], "UICorner")
						I[84] = new("UIStroke", I[82], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
						I[85] = new("ImageButton", I[82], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.1623367, 0.4238898), SelectionGroup = true, Size = UDim2.fromScale(0.3246735, 0.8100567), Visible = false })
							I[86] = new("UIStroke", I[85], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
							I[87] = new("TextLabel", I[85], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.500096, 0.853698), Size = UDim2.fromScale(1.0062175, 0.285491), Text = "TEMPLATE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
								I[88] = new("UIStroke", I[87], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
								I[89] = new("UIPadding", I[87], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0.2, 0), PaddingRight = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
							I[90] = new("UIGradient", I[85], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
							I[91] = new("ViewportFrame", I[85], "ViewportFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LightColor = Color3.fromRGB(230, 230, 230), Size = UDim2.fromScale(0.9967515, 0.9956432) })
								I[92] = new("WorldModel", I[91], "WorldModel")
						I[93] = new("UIGridLayout", I[82], "UIGridLayout", { CellPadding = UDim2.fromScale(0.001, 0.001), CellSize = UDim2.fromScale(0.2, 0.15), FillDirectionMaxCells = 5 })
				I[94] = new("TextLabel", I[78], "text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.497822, 0.0499999), Size = UDim2.fromScale(0.2708946, 0.0757494), Text = "CHARACTERS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
					I[95] = new("UIStroke", I[94], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
					I[96] = new("UIAspectRatioConstraint", I[94], "UIAspectRatioConstraint", { AspectRatio = 4.5210814 })
					I[97] = new("UIPadding", I[94], "UIPadding", { PaddingBottom = UDim.new(0.2, 0), PaddingLeft = UDim.new(0.2, 0), PaddingRight = UDim.new(0.2, 0), PaddingTop = UDim.new(0.2, 0) })
	return I[1]
end

return build
