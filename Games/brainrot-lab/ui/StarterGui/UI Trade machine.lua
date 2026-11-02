-- Generated from ui/StarterGui/UI Trade machine.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "UI Trade machine", { DisplayOrder = 150, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Ui TRadeMachine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 7 })
			I[3] = new("Frame", I[2], "Trade", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(7, 15, 24), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.32, 0.57) })
				I[4] = new("UIStroke", I[3], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(5, 16, 43), Thickness = 4, Transparency = 0.1 })
				I[5] = new("Frame", I[3], "Top", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(7, 181, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.0667849), Size = UDim2.fromScale(1, 0.1335699) })
					I[6] = new("UIStroke", I[5], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(5, 16, 43), Thickness = 4, Transparency = 0.1 })
					I[7] = new("Frame", I[5], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.45375), Size = UDim2.fromScale(1, 0.9075001) })
						I[8] = new("ImageLabel", I[7], "Layout", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://10509779001"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(0.99, 0.91), TileSize = UDim2.fromScale(0.04, 0.315), ZIndex = 0 })
							I[9] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 254, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 255, 0)) }), Rotation = 90 })
						I[10] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 254, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 255, 0)) }), Rotation = 90 })
						I[11] = new("ImageLabel", I[7], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://89670917453675"), Position = UDim2.fromScale(0.07, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.14, 1.256) })
							I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint")
						I[13] = new("TextLabel", I[7], "TitleUp", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.4632692), Size = UDim2.fromScale(0.7, 0.74), Text = "Trade", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
							I[14] = new("UIStroke", I[13], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
						I[15] = new("TextLabel", I[7], "TitleDown", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.5232691), Size = UDim2.fromScale(0.7, 0.74), Text = "Trade", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
							I[16] = new("UIStroke", I[15], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5 })
						I[17] = new("TextButton", I[7], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(156, 5, 5), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.93, 0.512), Size = UDim2.fromScale(0.105, 0.82), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
							I[18] = new("UIStroke", I[17], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(95, 10, 10), Thickness = 3 })
							I[19] = new("TextLabel", I[17], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.467), Size = UDim2.fromScale(0.86, 0.86), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
								I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(65, 1, 1), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.5 })
							I[21] = new("Frame", I[17], "Color", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.467), Size = UDim2.fromScale(1, 0.933), ZIndex = 0 })
								I[22] = new("ImageLabel", I[21], "Layout", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://10509779001"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(0.9, 0.9), TileSize = UDim2.fromScale(0.25, 0.25), ZIndex = 0 })
									I[23] = new("UIGradient", I[22], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 30, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(204, 10, 10)) }), Rotation = 90 })
								I[24] = new("UIGradient", I[21], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 125, 125)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 30, 30)) }), Rotation = 90 })
							I[25] = new("TextLabel", I[17], "TitleDown", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.515), Size = UDim2.fromScale(0.8600001, 0.8600001), Text = "X", TextColor3 = Color3.fromRGB(65, 1, 1), TextScaled = true, TextSize = 14, TextWrapped = true })
								I[26] = new("UIStroke", I[25], "UIStroke", { Color = Color3.fromRGB(65, 1, 1), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3.5 })
							I[27] = new("UIAspectRatioConstraint", I[17], "UIAspectRatioConstraint")
				I[28] = new("ScrollingFrame", I[3], "List", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0.1), Position = UDim2.fromScale(0.5000001, 0.5685), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 0, Size = UDim2.fromScale(1.0000001, 0.8437738) })
					I[29] = new("UIListLayout", I[28], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder })
					I[30] = new("Frame", I[28], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(7, 15, 24), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 5, Position = UDim2.fromScale(0.612, 0.2795889), Size = UDim2.fromScale(0.96, 0.2), Visible = false })
						I[31] = new("ImageButton", I[30], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://77970380601666"), Position = UDim2.fromScale(0.5, 1.1275448), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
							I[32] = new("Frame", I[31], "Content", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1862891, 0.5), Size = UDim2.fromScale(0.7868853, 0.7751938) })
								I[33] = new("TextLabel", I[32], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.4), Text = "Display Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
									I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 3 })
								I[35] = new("UIListLayout", I[32], "UIListLayout", { Padding = UDim.new(0.08, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
								I[36] = new("TextLabel", I[32], "SubTitle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.4748776, 1.6370493), Size = UDim2.fromScale(1, 0.35), Text = "@UserName", TextColor3 = Color3.fromRGB(200, 200, 200), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
									I[37] = new("UIStroke", I[36], "UIStroke", { Thickness = 2 })
							I[38] = new("ImageLabel", I[31], "PlaceHolder", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://100923610400120"), Position = UDim2.fromScale(0.0298063, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1445604, 0.751938) })
								I[39] = new("ViewportFrame", I[38], "ViewportFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9278351, 0.927835) })
									I[40] = new("ImageLabel", I[39], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
							I[41] = new("ImageButton", I[31], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0026326, 0.0000241), Size = UDim2.fromOffset(311, 60) })
						I[42] = new("UIAspectRatioConstraint", I[30], "UIAspectRatioConstraint", { AspectRatio = 5.1477919 })
				I[43] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 0.9049107 })
				I[44] = new("Frame", I[3], "SearchTrade", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(7, 7, 7), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4984186, 0.1872304), Size = UDim2.fromScale(0.9209262, 0.0627819) })
					I[45] = new("UICorner", I[44], "UICorner")
					I[46] = new("TextBox", I[44], "Box", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(207, 207, 207), PlaceholderText = "Search for a Player", Position = UDim2.fromScale(0.02, 0.5), Size = UDim2.fromScale(0.77, 0.59), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[47] = new("ImageButton", I[44], "Button", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://104793468329171"), Position = UDim2.fromScale(0.97, 0.5), ScaleType = Enum.ScaleType.Fit, Selectable = false, Size = UDim2.fromScale(0.0650793, 0.8305377) }, { ["DisableParent"] = true })
						I[48] = new("UIAspectRatioConstraint", I[47], "UIAspectRatioConstraint", { AspectRatio = 1.0143313 })
	return I[1]
end

return build
