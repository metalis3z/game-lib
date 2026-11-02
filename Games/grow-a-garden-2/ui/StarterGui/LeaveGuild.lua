-- Generated from ui/StarterGui/LeaveGuild.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LeaveGuild", { Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "MainFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "Confirmation", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75) })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 1.5 })
				I[5] = new("Frame", I[3], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 0.2057633) })
					I[6] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(82, 168, 57)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(103, 209, 71)), ColorSequenceKeypoint.new(1, Color3.fromRGB(82, 168, 57)) }) })
					I[7] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(40, 27, 0), Thickness = 2 })
					I[8] = new("ImageLabel", I[5], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112886786873408"), ImageTransparency = 0.2, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.3, ZIndex = 0 })
						I[9] = new("ImageLabel", I[8], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118449132151095"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5000001, 0.5000005), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000002, 0.9999988), TileSize = UDim2.fromScale(0.11, 0.83), ZIndex = -9 })
					I[10] = new("ImageLabel", I[5], "Glow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(49, 89, 30), ImageContent = Content.fromUri("rbxassetid://73102555894125"), Position = UDim2.fromScale(0, -0.0000012), Size = UDim2.fromScale(0.1357245, 1.0000013), ZIndex = 0 })
					I[11] = new("TextLabel", I[5], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.518986, 0.5250002), Size = UDim2.fromScale(0.7665231, 0.8200648), Text = "Leave Guild?", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
						I[12] = new("UIStroke", I[11], "UIStroke", { Color = Color3.fromRGB(15, 50, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
						I[13] = new("TextLabel", I[11], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.465), Size = UDim2.fromScale(1, 1), Text = "Leave Guild?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(15, 50, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
							I[15] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.417962, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(215, 255, 189)) }), Rotation = 90 })
					I[16] = new("ImageLabel", I[5], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126331465318698"), Position = UDim2.fromScale(0.0158237, 0.5000005), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1019285, 0.7430518) })
						I[17] = new("UIAspectRatioConstraint", I[16], "UIAspectRatioConstraint")
				I[18] = new("Frame", I[3], "Buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.87), Size = UDim2.fromScale(0.8083604, 0.1483233) })
					I[19] = new("UIListLayout", I[18], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.045, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[20] = new("TextButton", I[18], "ConfirmButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(238, 228, 218), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 9, Position = UDim2.fromScale(0.7956514, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[21] = new("ImageLabel", I[20], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118449132151095"), ImageTransparency = 0.64, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.15, 0.5), ZIndex = 0 })
						I[22] = new("ImageLabel", I[20], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112886786873408"), ImageTransparency = 0.06, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.2, ZIndex = 0 })
						I[23] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint", { AspectRatio = 3.5 })
						I[24] = new("TextLabel", I[20], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.505, 0.55), Size = UDim2.fromScale(0.9, 0.9), Text = "Confirm", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[25] = new("TextLabel", I[24], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(1, 1), Text = "Confirm", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
								I[26] = new("UIGradient", I[25], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.417962, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(215, 255, 189)) }), Rotation = 90 })
								I[27] = new("UIStroke", I[25], "UIStroke", { Color = Color3.fromRGB(15, 50, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
							I[28] = new("UIStroke", I[24], "UIStroke", { Color = Color3.fromRGB(15, 50, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
						I[29] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(57, 179, 0)), ColorSequenceKeypoint.new(0.1468048, Color3.fromRGB(57, 179, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }), Rotation = -90 })
						I[30] = new("UIStroke", I[20], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(20, 48, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
					I[31] = new("TextButton", I[18], "CancelButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(238, 228, 218), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 9, Position = UDim2.fromScale(0.7956514, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[32] = new("ImageLabel", I[31], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118449132151095"), ImageTransparency = 0.64, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.15, 0.5), ZIndex = 0 })
						I[33] = new("ImageLabel", I[31], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112886786873408"), ImageTransparency = 0.06, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.2, ZIndex = 0 })
						I[34] = new("UIAspectRatioConstraint", I[31], "UIAspectRatioConstraint", { AspectRatio = 3.5 })
						I[35] = new("TextLabel", I[31], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.505, 0.55), Size = UDim2.fromScale(0.9, 0.9), Text = "Cancel", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[36] = new("TextLabel", I[35], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(1, 1), Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
								I[37] = new("UIStroke", I[36], "UIStroke", { Color = Color3.fromRGB(63, 0, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
								I[38] = new("UIGradient", I[36], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.417962, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 164, 164)) }), Rotation = 90 })
							I[39] = new("UIStroke", I[35], "UIStroke", { Color = Color3.fromRGB(63, 0, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
						I[40] = new("UIGradient", I[31], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(199, 0, 0)), ColorSequenceKeypoint.new(0.1468048, Color3.fromRGB(255, 14, 14)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 89, 89)) }), Rotation = -90 })
						I[41] = new("UIStroke", I[31], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(63, 0, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045 })
				I[42] = new("ImageLabel", I[3], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118449132151095"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.11, 0.17), ZIndex = -9 })
				I[43] = new("ImageLabel", I[3], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112886786873408"), ImageTransparency = 0.2, Position = UDim2.fromScale(0.5, 0.5017465), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.3, ZIndex = 0 })
				I[44] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(121, 62, 35)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(153, 77, 44)), ColorSequenceKeypoint.new(1, Color3.fromRGB(121, 62, 35)) }) })
				I[45] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(40, 27, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.01 })
				I[46] = new("TextLabel", I[3], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.9372548, 0.3884871), Text = "Are you sure you want to leave \"Guild Name\"?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[47] = new("UIStroke", I[46], "UIStroke", { Color = Color3.fromRGB(40, 27, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.06 })
				I[48] = new("UISizeConstraint", I[3], "UISizeConstraint", { MaxSize = Vector2.new(600, 600) })
	return I[1]
end

return build
