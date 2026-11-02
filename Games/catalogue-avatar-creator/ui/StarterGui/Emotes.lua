-- Generated from ui/StarterGui/Emotes.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Emotes", { DisplayOrder = 12, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "Themed" })
		I[2] = new("CanvasGroup", I[1], "container", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromScale(0.33785, 0.7007289) })
			I[3] = new("Frame", I[2], "wrapper", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
				I[4] = new("UIStroke", I[3], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(247, 245, 255), Thickness = 2, Transparency = 0.5 })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.04, 0), BottomRightRadius = UDim.new(0.04, 0), TopLeftRadius = UDim.new(0.04, 0), TopRightRadius = UDim.new(0.04, 0) })
				I[6] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0.01, 0), PaddingLeft = UDim.new(0.02, 0), PaddingRight = UDim.new(0.02, 0), PaddingTop = UDim.new(0.01, 0) })
				I[7] = new("Frame", I[3], "topBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.1), ZIndex = 2 })
					I[8] = new("Frame", I[7], "categoryDropdown", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 10, Position = UDim2.fromScale(0.380407, 0.0500674), Size = UDim2.fromScale(0.479, 1) })
						I[9] = new("Frame", I[8], "back", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
							I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
							I[11] = new("UIStroke", I[9], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(240, 239, 249), Thickness = 1.5 })
						I[12] = new("TextLabel", I[8], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0405411, 0.4999999), Size = UDim2.fromScale(0.789993, 0.6650005), Text = "Category", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
						I[13] = new("TextButton", I[8], "button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 })
						I[14] = new("ImageLabel", I[8], "image", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(214, 213, 222), ImageContent = Content.fromUri("rbxassetid://97937990215558"), Position = UDim2.fromScale(0.9759997, 0.525), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1454655, 0.7) })
						I[15] = new("ScrollingFrame", I[8], "dropdown", { Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png"), CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0, 0.7), ScrollBarThickness = 3, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.new(1, 1, 0.3, 0), TopImageContent = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png"), Visible = false, ZIndex = 0 }, nil, { "dropdown" })
							I[16] = new("UICorner", I[15], "UICorner")
							I[17] = new("UIListLayout", I[15], "UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder })
							I[18] = new("UIStroke", I[15], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
							I[19] = new("Frame", I[15], "bottomBuffer", { BackgroundColor3 = Color3.fromRGB(30, 45, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 99999, Position = UDim2.fromScale(0, 0.7583923), Size = UDim2.fromScale(1, 0.035), ZIndex = -1 })
							I[20] = new("Frame", I[15], "topBuffer", { BackgroundColor3 = Color3.fromRGB(30, 45, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -999999999, Size = UDim2.fromScale(1, 0.1), ZIndex = -1 })
							I[21] = new("TextButton", I[15], "choice", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.new(1, 0, 0, 31), Text = "Choice", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = -1 })
								I[22] = new("UIPadding", I[21], "UIPadding", { PaddingBottom = UDim.new(0.175, 0), PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0), PaddingTop = UDim.new(0.175, 0) })
							I[23] = new("ObjectValue", I[15], "Boundary")
					I[24] = new("TextButton", I[7], "closeButton", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 20, Position = UDim2.fromScale(1, 0.005), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 }, nil, { "UIEffect" })
						I[25] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0.275, 0), BottomRightRadius = UDim.new(0.275, 0), TopLeftRadius = UDim.new(0.275, 0), TopRightRadius = UDim.new(0.275, 0) })
						I[26] = new("ImageLabel", I[24], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9) })
						I[27] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
					I[28] = new("UIListLayout", I[7], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.Fill, Padding = UDim.new(0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[29] = new("UIPadding", I[7], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(0.01, 0), PaddingTop = UDim.new(0.125, 0) })
					I[30] = new("TextLabel", I[7], "label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.0000001), Size = UDim2.fromScale(0.345, 0.9), Text = "Emotes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[31] = new("TextButton", I[3], "_", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, Position = UDim2.fromScale(0.5, 0.5), Selectable = false, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = -1 })
				I[32] = new("Frame", I[3], "searchContainer", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.975), Size = UDim2.fromScale(0.7, 0.1), ZIndex = 2 }, { ["isStatic"] = true })
					I[33] = new("ImageButton", I[32], "clear", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(214, 213, 222), ImageContent = Content.fromUri("rbxassetid://98988409041690"), LayoutOrder = 2, Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromScale(0.4, 0.4), Visible = false, ZIndex = 2 })
						I[34] = new("UIAspectRatioConstraint", I[33], "UIAspectRatioConstraint")
					I[35] = new("Frame", I[32], "back", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.0167112), Size = UDim2.fromScale(1, 1) })
						I[36] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
						I[37] = new("UIStroke", I[35], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
					I[38] = new("Frame", I[32], "wrapper", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[39] = new("TextBox", I[38], "searchInput", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), LayoutOrder = 1, PlaceholderColor3 = Color3.fromRGB(70, 68, 77), PlaceholderText = "Search Emotes", Position = UDim2.fromScale(0.1552605, 0.5000001), Size = UDim2.fromScale(0.8117987, 0.6832891), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
						I[40] = new("ImageLabel", I[38], "image", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(214, 213, 222), ImageContent = Content.fromUri("rbxassetid://130403244495092"), Position = UDim2.new(0, 4, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1157504, 0.7000001), ZIndex = 2 })
							I[41] = new("UIAspectRatioConstraint", I[40], "UIAspectRatioConstraint")
						I[42] = new("UIListLayout", I[38], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
						I[43] = new("UIPadding", I[38], "UIPadding", { PaddingLeft = UDim.new(0, 4) })
				I[44] = new("Frame", I[3], "itemsSection", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5000001, 0.985), Size = UDim2.fromScale(0.9750001, 0.8592201) })
					I[45] = new("ScrollingFrame", I[44], "itemsWrapper", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png"), CanvasSize = UDim2.fromScale(0.975, 0), ElasticBehavior = Enum.ElasticBehavior.Always, Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(229, 229, 230), ScrollBarThickness = 2, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 1), TopImageContent = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png") })
						I[46] = new("Frame", I[45], "container", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0) })
							I[47] = new("UIGridLayout", I[46], "UIGridLayout", { CellPadding = UDim2.fromOffset(2, 8), CellSize = UDim2.new(0.333, -2, 0.6, 0), FillDirectionMaxCells = 6, SortOrder = Enum.SortOrder.LayoutOrder })
								I[48] = new("UIAspectRatioConstraint", I[47], "UIAspectRatioConstraint", { AspectRatio = 0.75, AspectType = Enum.AspectType.ScaleWithParentSize })
							I[49] = new("Frame", I[46], "item", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.159, 0.9626351) })
								I[50] = new("Frame", I[49], "preview", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(43, 45, 51), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4999999, 0), Size = UDim2.fromScale(1, 0.7400001) })
									I[51] = new("UICorner", I[50], "UICorner", { BottomLeftRadius = UDim.new(0.075, 0), BottomRightRadius = UDim.new(0.075, 0), TopLeftRadius = UDim.new(0.075, 0), TopRightRadius = UDim.new(0.075, 0) })
									I[52] = new("ImageLabel", I[50], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=Asset&id=31101391&w=420&h=420"), ImageTransparency = 0.98, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
									I[53] = new("Frame", I[50], "labels", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
										I[54] = new("UIListLayout", I[53], "UIListLayout", { Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder })
										I[55] = new("UIPadding", I[53], "UIPadding", { PaddingBottom = UDim.new(0.02, 0), PaddingLeft = UDim.new(0.02, 0), PaddingRight = UDim.new(0.02, 0), PaddingTop = UDim.new(0.02, 0) })
								I[56] = new("UIPadding", I[49], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(0.01, 0) })
								I[57] = new("TextLabel", I[49], "name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.78), Size = UDim2.fromScale(0.95, 0.0951945), Text = "Dominus Infernus", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextSize = 14, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
								I[58] = new("TextLabel", I[49], "price", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0000001, 0.9999996), RichText = true, Size = UDim2.fromScale(1, 0.103057), Text = "-", TextColor3 = Color3.fromRGB(237, 238, 238), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
								I[59] = new("ImageLabel", I[49], "icon", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://113197611747052"), Position = UDim2.fromScale(-0.02, 0.97), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.15, 0.0879991), Visible = false })
								I[60] = new("TextButton", I[49], "viewCreator", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(230, 255, 70), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0000001, 0.8299999), Size = UDim2.fromScale(1, 0.066943), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 20 })
								I[61] = new("TextButton", I[49], "viewItem", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(34, 119, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1.0000001), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 10 })
						I[62] = new("UIListLayout", I[45], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
					I[63] = new("Frame", I[44], "bottomFade", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1.0000001), Size = UDim2.fromScale(1, 0.04), ZIndex = 2 })
						I[64] = new("UIGradient", I[63], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
					I[65] = new("Frame", I[44], "topFade", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1.0000001, 0.0301066), ZIndex = 2 })
						I[66] = new("UIGradient", I[65], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
			I[67] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.83, DominantAxis = Enum.DominantAxis.Height })
			I[68] = new("UISizeConstraint", I[2], "UISizeConstraint", { MinSize = Vector2.new(300, 300) })
			I[69] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
	I[23].Value = I[3]
	return I[1]
end

return build
