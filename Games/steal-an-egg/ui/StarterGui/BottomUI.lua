-- Generated from ui/StarterGui/BottomUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BottomUI", { DisplayOrder = 5, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "BottomFrame", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.98, 0.89), Size = UDim2.fromScale(0.1235365, 0.1421053) })
			I[3] = new("Frame", I[2], "Holder", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 1.0000015), Size = UDim2.fromScale(3.99, 1.052822) })
				I[4] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.25), Text = "WEATHER EVENT", TextColor3 = Color3.fromRGB(255, 255, 225), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
					I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 2 })
				I[6] = new("Frame", I[3], "List", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(0.975, 0.3550445) })
					I[7] = new("UIListLayout", I[6], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0.045, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[8] = new("Frame", I[6], "x2Growth", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.8627684, 0.4382088), Size = UDim2.fromScale(0.1179005, 0.947468) })
						I[9] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint")
						I[10] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255)) }), Rotation = -90 })
						I[11] = new("UIScale", I[8], "UIScale")
						I[12] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
						I[13] = new("ImageButton", I[8], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://124780550888310"), Position = UDim2.fromScale(0.5149997, 0.462345), ScaleType = Enum.ScaleType.Fit, Selectable = false, Size = UDim2.fromScale(1.3999999, 1.3246899) })
							I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
						I[15] = new("TextLabel", I[8], "Timer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.015), Size = UDim2.fromScale(1.3, 0.5), Text = "3h25m", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 1.5 })
					I[17] = new("Frame", I[6], "x2Luck", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.118, 0.947) })
						I[18] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint")
						I[19] = new("UIGradient", I[17], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255)) }), Rotation = -90 })
						I[20] = new("UIScale", I[17], "UIScale")
						I[21] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
						I[22] = new("ImageButton", I[17], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://98348580228111"), Position = UDim2.fromScale(0.515, 0.5), ScaleType = Enum.ScaleType.Fit, Selectable = false, Size = UDim2.fromScale(1.25, 1.25) })
							I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
						I[24] = new("TextLabel", I[17], "Timer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.015), Size = UDim2.fromScale(1.3, 0.5), Text = "3h25m", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 1.5 })
					I[26] = new("Frame", I[6], "Luck", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.6573523, 0.3999999), Size = UDim2.fromScale(0.1447047, 1.2000002), Visible = false })
						I[27] = new("UIGradient", I[26], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 94, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = -90 })
						I[28] = new("UIScale", I[26], "UIScale")
						I[29] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
						I[30] = new("ImageButton", I[26], "Button", { AnchorPoint = Vector2.new(0, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1), ZIndex = 5 })
							I[31] = new("Frame", I[30], "Content", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 6 })
								I[32] = new("ImageLabel", I[31], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76170444938954"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.90625, 0.90625), ZIndex = 7 })
								I[33] = new("Frame", I[31], "Value", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.6), Size = UDim2.fromScale(0.75, 0.375), ZIndex = 7 })
									I[34] = new("TextLabel", I[33], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "x4.2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
										I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 1.5685185 }, { ["oldp_Thickness"] = 2 })
							I[36] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint")
				I[37] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 4.7410002 })
			I[38] = new("Frame", I[2], "Info", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.45, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9300627, 0.4321443), Size = UDim2.fromScale(3.1411285, 0.8288344), Visible = false })
				I[39] = new("UIStroke", I[38], "UIStroke", { Thickness = 2 })
				I[40] = new("TextLabel", I[38], "Description", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.925, Position = UDim2.fromScale(0.0238095, 0.9382716), RichText = true, Size = UDim2.fromScale(0.952381, 0.525), Text = "+50% Grow Speed!\nHigher <font color=\"#0055ff\">ELECTRIFIED</font> Fruit Chance!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[41] = new("UIStroke", I[40], "UIStroke", { Color = Color3.fromRGB(33, 37, 41), Thickness = 2 })
				I[42] = new("TextLabel", I[38], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0238095, 0.0617284), Size = UDim2.fromScale(0.952381, 0.35), Text = "THUNDERSTORM", TextColor3 = Color3.fromRGB(255, 255, 127), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[43] = new("UIStroke", I[42], "UIStroke", { Color = Color3.fromRGB(33, 37, 41), Thickness = 2 })
				I[44] = new("UIAspectRatioConstraint", I[38], "UIAspectRatioConstraint", { AspectRatio = 4.7410002 })
				I[45] = new("UICorner", I[38], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
	return I[1]
end

return build
