-- Generated from ui/ServerStorage/Gui_Before3Dv2/HotbarGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "HotbarGui", { DisplayOrder = 8, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextButton", I[1], "SlotTemplate", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromOffset(62, 62), Text = "", Visible = false }, { ["MontFix"] = true })
			I[3] = new("ViewportFrame", I[2], "View", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(5, 5), Size = UDim2.new(1, -10, 1, -10) })
				I[4] = new("UIGradient", I[3], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 232, 244)) }), Rotation = 90 })
			I[5] = new("TextLabel", I[2], "Key", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(5, 3), Size = UDim2.fromOffset(16, 16), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
				I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2 })
			I[7] = new("TextLabel", I[2], "Kg", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 3, 1, -16), Size = UDim2.new(1, -6, 0, 13), Text = "", TextColor3 = Color3.fromRGB(200, 235, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
				I[8] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2 })
			I[9] = new("TextLabel", I[2], "Count", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -30, 0, 3), Size = UDim2.fromOffset(26, 16), Text = "", TextColor3 = Color3.fromRGB(255, 240, 150), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 3 })
				I[10] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2 })
			I[11] = new("UIStroke", I[2], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(10, 10, 12), Thickness = 3.5 })
			I[12] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(74, 74, 82)), ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 22)) }), Rotation = 90 })
			I[13] = new("UIScale", I[2], "UIScale")
		I[14] = new("Frame", I[1], "Dock", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 1, -10), Size = UDim2.fromOffset(700, 124) }, nil, { "AutoScale" })
			I[15] = new("Frame", I[14], "Bar", { AnchorPoint = Vector2.new(0.5, 1), AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromOffset(0, 70) })
				I[16] = new("UIListLayout", I[15], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[17] = new("TextButton", I[14], "HatchAll", { AnchorPoint = Vector2.new(0.5, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 1, -80), Size = UDim2.fromOffset(210, 42), Text = "Open All", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true, Visible = false }, nil, { "UIButton" })
				I[18] = new("TextLabel", I[17], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Open All", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
					I[19] = new("UIStroke", I[18], "TextStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2.5 })
					I[20] = new("UIPadding", I[18], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6) })
				I[21] = new("UIStroke", I[17], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(40, 47, 57), Thickness = 3.5 })
				I[22] = new("UIGradient", I[17], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 176, 245)) }), Rotation = 90 })
				I[23] = new("Frame", I[17], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.34, 0), ZIndex = 2 })
				I[24] = new("Frame", I[17], "FxStitch", { BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 2 })
					I[25] = new("UIStroke", I[24], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5, Transparency = 0.5 })
				I[26] = new("ImageLabel", I[17], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
					I[27] = new("UIGradient", I[26], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 176, 245)) }), Rotation = 90 })
			I[28] = new("TextButton", I[14], "HarvestAll", { AnchorPoint = Vector2.new(0.5, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 112, 1, -80), Size = UDim2.fromOffset(210, 42), Text = "Harvest All", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true, Visible = false }, nil, { "UIButton" })
				I[29] = new("TextLabel", I[28], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Harvest All", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
					I[30] = new("UIStroke", I[29], "TextStroke", { Color = Color3.fromRGB(40, 47, 57), Thickness = 2.5 })
					I[31] = new("UIPadding", I[29], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6) })
				I[32] = new("UIStroke", I[28], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(40, 47, 57), Thickness = 3.5 })
				I[33] = new("UIGradient", I[28], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 226, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 170, 70)) }), Rotation = 90 })
				I[34] = new("Frame", I[28], "FxGloss", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.72, BorderSizePixel = 0, Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 0.34, 0), ZIndex = 2 })
				I[35] = new("Frame", I[28], "FxStitch", { BackgroundTransparency = 1, Position = UDim2.fromOffset(4, 4), Size = UDim2.new(1, -8, 1, -8), ZIndex = 2 })
					I[36] = new("UIStroke", I[35], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5, Transparency = 0.5 })
				I[37] = new("ImageLabel", I[28], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
					I[38] = new("UIGradient", I[37], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 226, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(66, 170, 70)) }), Rotation = 90 })
	return I[1]
end

return build
