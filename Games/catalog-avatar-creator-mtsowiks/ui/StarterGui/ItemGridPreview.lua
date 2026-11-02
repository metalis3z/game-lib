-- Generated from ui/StarterGui/ItemGridPreview.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ItemGridPreview", { DisplayOrder = 10, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "Themed" })
		I[2] = new("Frame", I[1], "wrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.7) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.5 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.0423, 0), BottomRightRadius = UDim.new(0.0423, 0), TopLeftRadius = UDim.new(0.0423, 0), TopRightRadius = UDim.new(0.0423, 0) })
			I[5] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), Thickness = 1.5 })
			I[6] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0.0265, 0), PaddingLeft = UDim.new(0.0176, 0), PaddingRight = UDim.new(0.0176, 0), PaddingTop = UDim.new(0.0265, 0) })
			I[7] = new("ScrollingFrame", I[2], "itemsWrapper", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png"), CanvasSize = UDim2.fromScale(0.975, 0), ElasticBehavior = Enum.ElasticBehavior.Always, LayoutOrder = 2, ScrollBarImageColor3 = Color3.fromRGB(229, 229, 230), ScrollBarThickness = 2, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.new(1, 0, 0.9385, -12), TopImageContent = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png") })
				I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.0168, 0), BottomRightRadius = UDim.new(0.0168, 0), TopLeftRadius = UDim.new(0.0168, 0), TopRightRadius = UDim.new(0.0168, 0) })
				I[9] = new("UIPadding", I[7], "UIPadding", { PaddingBottom = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2), PaddingTop = UDim.new(0, 2) })
				I[10] = new("Frame", I[7], "container", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0) })
					I[11] = new("UIGridLayout", I[10], "UIGridLayout", { CellPadding = UDim2.fromOffset(2, 8), CellSize = UDim2.new(0.1665, -2, 0.6, 0), FillDirectionMaxCells = 6, SortOrder = Enum.SortOrder.LayoutOrder })
						I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint", { AspectRatio = 0.7, AspectType = Enum.AspectType.ScaleWithParentSize })
					I[13] = new("Frame", I[10], "item", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.159, 0.9626351) })
						I[14] = new("Frame", I[13], "preview", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(43, 45, 51), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4999999, 0), Size = UDim2.fromScale(1, 0.7158489) })
							I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
							I[16] = new("ImageLabel", I[14], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=Asset&id=31101391&w=420&h=420"), ImageTransparency = 0.98, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) }, { ["SkipThemeImage"] = true })
							I[17] = new("Frame", I[14], "labels", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 6 })
								I[18] = new("UIListLayout", I[17], "UIListLayout", { Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder })
								I[19] = new("UIPadding", I[17], "UIPadding", { PaddingBottom = UDim.new(0.02, 0), PaddingLeft = UDim.new(0.02, 0), PaddingRight = UDim.new(0.02, 0), PaddingTop = UDim.new(0.02, 0) })
						I[20] = new("UIPadding", I[13], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(0.01, 0) })
						I[21] = new("TextLabel", I[13], "name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.74), Size = UDim2.fromScale(0.95, 0.08), Text = "Dominus Infernus", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextSize = 14, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[22] = new("TextLabel", I[13], "creator", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.83), RichText = true, Size = UDim2.fromScale(0.9999999, 0.066943), Text = "<font color=\"#d5d7dd\">By</font> <b>The best</b>", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[23] = new("TextLabel", I[13], "price", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), RichText = true, Size = UDim2.fromScale(1, 0.08), Text = "-", TextColor3 = Color3.fromRGB(237, 238, 238), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[24] = new("ImageLabel", I[13], "icon", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://113197611747052"), Position = UDim2.fromScale(-0.02, 0.97), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.15, 0.0879991), Visible = false })
						I[25] = new("TextButton", I[13], "viewCreator", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(230, 255, 70), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0000001, 0.8299999), Size = UDim2.fromScale(1, 0.066943), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 20 })
						I[26] = new("TextButton", I[13], "viewItem", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(34, 119, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1.0000001), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 10 }, nil, { "UIEffectSoundOnly" })
						I[27] = new("Folder", I[13], "skeleton")
							I[28] = new("Frame", I[27], "previewShimmer", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(43, 45, 51), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5000002, 0), Size = UDim2.fromScale(1, 0.715849), ZIndex = 10 })
								I[29] = new("UICorner", I[28], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
								I[30] = new("UIAspectRatioConstraint", I[28], "UIAspectRatioConstraint", { AspectRatio = 0.96, AspectType = Enum.AspectType.ScaleWithParentSize })
								I[31] = new("UIGradient", I[28], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(199, 199, 199)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Offset = Vector2.new(-1, 0) })
						I[32] = new("Frame", I[13], "contextButtonsEmote", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.358), Size = UDim2.fromScale(1, 0.716), ZIndex = 30 }, { ["SkipTheme"] = true })
							I[33] = new("UICorner", I[32], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) }, { ["SkipTheme"] = true })
							I[34] = new("TextButton", I[32], "pose", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(39, 163, 216), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 3, Size = UDim2.fromScale(1, 0.28), Text = "Pose", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
								I[35] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
								I[36] = new("UIPadding", I[34], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingTop = UDim.new(0.15, 0) }, { ["SkipTheme"] = true })
							I[37] = new("UIPadding", I[32], "UIPadding", { PaddingBottom = UDim.new(0.09, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.09, 0) })
							I[38] = new("UIListLayout", I[32], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.08, 0), SortOrder = Enum.SortOrder.LayoutOrder })
							I[39] = new("Frame", I[32], "row1", { BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0.28) })
								I[40] = new("UIListLayout", I[39], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
								I[41] = new("TextButton", I[39], "tryOn", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(0.65, 1), Text = "Try On", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
									I[42] = new("UICorner", I[41], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
									I[43] = new("UIPadding", I[41], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingTop = UDim.new(0.15, 0) }, { ["SkipTheme"] = true })
								I[44] = new("TextButton", I[39], "inspect", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(0.3, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
									I[45] = new("UICorner", I[44], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
									I[46] = new("ImageLabel", I[44], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(212, 212, 212), ImageContent = Content.fromUri("rbxassetid://89599939903201"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8) }, { ["SkipTheme"] = true })
									I[47] = new("UIStroke", I[44], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Center, Color = Color3.fromRGB(212, 212, 212), Thickness = 1.5 }, { ["SkipTheme"] = true })
							I[48] = new("Frame", I[32], "row2", { BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(1, 0.28) })
								I[49] = new("UIListLayout", I[48], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
								I[50] = new("TextButton", I[48], "buy", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 216, 134), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(0.65, 1), Text = "Buy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.8, TextWrapped = true, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
									I[51] = new("UICorner", I[50], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
									I[52] = new("UIPadding", I[50], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingTop = UDim.new(0.15, 0) }, { ["SkipTheme"] = true })
								I[53] = new("TextButton", I[48], "addToCart", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(0.3, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1, ZIndex = 30 }, { ["SkipTheme"] = true }, { "UIEffect" })
									I[54] = new("UICorner", I[53], "UICorner", { BottomLeftRadius = UDim.new(0.175, 0), BottomRightRadius = UDim.new(0.175, 0), TopLeftRadius = UDim.new(0.175, 0), TopRightRadius = UDim.new(0.175, 0) }, { ["SkipTheme"] = true })
									I[55] = new("ImageLabel", I[53], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(212, 212, 212), ImageContent = Content.fromUri("rbxassetid://80442995407260"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8) }, { ["SkipTheme"] = true })
									I[56] = new("UIStroke", I[53], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Center, Color = Color3.fromRGB(212, 212, 212), Thickness = 1.5 }, { ["SkipTheme"] = true })
			I[57] = new("UIListLayout", I[2], "UIListLayout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder })
			I[58] = new("TextLabel", I[2], "title", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(1, 0.0615), Text = "Item Grid Preview", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
