-- Generated from ui/StarterGui/OutfitLoader.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "OutfitLoader", { DisplayOrder = 10, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "Themed" })
		I[2] = new("CanvasGroup", I[1], "container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(33, 34, 39), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromScale(0.75, 0.75) })
			I[3] = new("Frame", I[2], "wrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.035, 0), BottomRightRadius = UDim.new(0.035, 0), TopLeftRadius = UDim.new(0.035, 0), TopRightRadius = UDim.new(0.035, 0) })
				I[5] = new("UIStroke", I[3], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), Thickness = 3, Transparency = 0.5 })
				I[6] = new("TextButton", I[3], "_", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, Selectable = false, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = -1 })
				I[7] = new("TextButton", I[3], "closeButton", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 20, Position = UDim2.fromScale(0.987887, 0.0144879), Size = UDim2.fromScale(0.0497379, 0.0653637), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 }, nil, { "UIEffect" })
					I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
					I[9] = new("ImageLabel", I[7], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.9, 1, 0.9, 0) })
					I[10] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
				I[11] = new("Frame", I[3], "currentLoadedContainer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4679106, 0.0146644), Size = UDim2.fromScale(0.461152, 0.0662876) })
					I[12] = new("TextLabel", I[11], "label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0179999, 0.5000001), Size = UDim2.fromScale(0.4277031, 0.9), Text = "Currently Loaded:", TextColor3 = Color3.fromRGB(244, 244, 244), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[13] = new("ImageLabel", I[11], "icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=1&w=150&h=150"), Position = UDim2.fromScale(0.4629489, 0.5170173), Size = UDim2.fromScale(0.9, 0.9) }, { ["SkipThemeImage"] = true })
						I[14] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint")
						I[15] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[16] = new("TextLabel", I[11], "username", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.575, 0.5), Size = UDim2.fromScale(0.428, 0.5), Text = "Nobody", TextColor3 = Color3.fromRGB(244, 244, 244), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[17] = new("Frame", I[3], "outfitsSection", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.098), Size = UDim2.fromScale(0.9778869, 0.8867648) })
					I[18] = new("ScrollingFrame", I[17], "outfits", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png"), Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(229, 229, 230), ScrollBarThickness = 2, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 1), TopImageContent = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png") })
						I[19] = new("Frame", I[18], "container", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0) })
							I[20] = new("UIGridLayout", I[19], "UIGridLayout", { CellPadding = UDim2.fromOffset(2, 12), CellSize = UDim2.new(0.25, -2, 0.6, 0), FillDirectionMaxCells = 5, SortOrder = Enum.SortOrder.LayoutOrder })
								I[21] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint", { AspectRatio = 0.9, AspectType = Enum.AspectType.ScaleWithParentSize })
				I[22] = new("TextButton", I[3], "returnButton", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.011, 0.015), Size = UDim2.fromScale(0.0806892, 0.0663573), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 }, { ["isStatic"] = true }, { "UIEffect" })
					I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
					I[24] = new("ImageLabel", I[22], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://119399595654092"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7, 0.7) })
						I[25] = new("UIAspectRatioConstraint", I[24], "UIAspectRatioConstraint")
					I[26] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint", { AspectRatio = 1.5, AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
				I[27] = new("Frame", I[3], "searchContainer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.0995807, 0.014), Size = UDim2.fromScale(0.3617488, 0.0658515) }, { ["isStatic"] = true })
					I[28] = new("ImageButton", I[27], "clear", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(214, 213, 222), ImageContent = Content.fromUri("rbxassetid://98988409041690"), LayoutOrder = 2, Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromScale(0.4, 0.4), Visible = false, ZIndex = 2 })
						I[29] = new("UIAspectRatioConstraint", I[28], "UIAspectRatioConstraint")
					I[30] = new("Frame", I[27], "back", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.0167112), Size = UDim2.fromScale(1, 1) })
						I[31] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
						I[32] = new("UIStroke", I[30], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
					I[33] = new("Frame", I[27], "wrapper", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[34] = new("TextBox", I[33], "searchInput", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), LayoutOrder = 1, PlaceholderColor3 = Color3.fromRGB(70, 68, 77), PlaceholderText = "Enter Username", Position = UDim2.fromScale(0.1552605, 0.5000001), Size = UDim2.fromScale(0.8117987, 0.6832891), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
						I[35] = new("ImageLabel", I[33], "image", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(214, 213, 222), ImageContent = Content.fromUri("rbxassetid://130403244495092"), Position = UDim2.new(0, 4, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1157504, 0.7000001), ZIndex = 2 })
							I[36] = new("UIAspectRatioConstraint", I[35], "UIAspectRatioConstraint")
						I[37] = new("UIListLayout", I[33], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
						I[38] = new("UIPadding", I[33], "UIPadding", { PaddingLeft = UDim.new(0, 4) })
			I[39] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.27 })
			I[40] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
			I[41] = new("UISizeConstraint", I[2], "UISizeConstraint", { MinSize = Vector2.new(300, 300) })
	return I[1]
end

return build
