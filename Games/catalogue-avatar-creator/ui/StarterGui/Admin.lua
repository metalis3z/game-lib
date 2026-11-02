-- Generated from ui/StarterGui/Admin.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Admin", { DisplayOrder = 13, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("CanvasGroup", I[1], "container", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, GroupTransparency = 1, Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromScale(0.33785, 0.7007289) })
			I[3] = new("Frame", I[2], "wrapper", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
				I[4] = new("UIStroke", I[3], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(247, 245, 255), Thickness = 2, Transparency = 0.5 })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.04, 0), BottomRightRadius = UDim.new(0.04, 0), TopLeftRadius = UDim.new(0.04, 0), TopRightRadius = UDim.new(0.04, 0) })
				I[6] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0.01, 0), PaddingLeft = UDim.new(0.02, 0), PaddingRight = UDim.new(0.02, 0), PaddingTop = UDim.new(0.01, 0) })
				I[7] = new("Frame", I[3], "topBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.1), ZIndex = 2 })
					I[8] = new("TextLabel", I[7], "label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.345, 0.9), Text = "Admin Panel", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[9] = new("TextButton", I[7], "closeButton", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 20, Position = UDim2.fromScale(1, 0.005), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 })
						I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.275, 0), BottomRightRadius = UDim.new(0.275, 0), TopLeftRadius = UDim.new(0.275, 0), TopRightRadius = UDim.new(0.275, 0) })
						I[11] = new("ImageLabel", I[9], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9) })
						I[12] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
					I[13] = new("TextLabel", I[7], "playerCount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), LayoutOrder = 10, Size = UDim2.fromScale(0.3, 0.9), Text = "Players: 0", TextColor3 = Color3.fromRGB(160, 160, 170), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
					I[14] = new("UIListLayout", I[7], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.Fill, Padding = UDim.new(0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[15] = new("UIPadding", I[7], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(0.01, 0), PaddingTop = UDim.new(0.125, 0) })
				I[16] = new("TextButton", I[3], "_", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, Position = UDim2.fromScale(0.5, 0.5), Selectable = false, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = -1 })
				I[17] = new("Frame", I[3], "body", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.88) })
					I[18] = new("Frame", I[17], "sidebar", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.28, 1) })
						I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.04, 0), BottomRightRadius = UDim.new(0.04, 0), TopLeftRadius = UDim.new(0.04, 0), TopRightRadius = UDim.new(0.04, 0) })
						I[20] = new("UIStroke", I[18], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(247, 245, 255), Transparency = 0.7 })
						I[21] = new("UIPadding", I[18], "UIPadding", { PaddingBottom = UDim.new(0.02, 0), PaddingLeft = UDim.new(0.03, 0), PaddingRight = UDim.new(0.03, 0), PaddingTop = UDim.new(0.02, 0) })
						I[22] = new("UIListLayout", I[18], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.015, 0), SortOrder = Enum.SortOrder.LayoutOrder })
					I[23] = new("Frame", I[17], "content", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.7, 1) })
						I[24] = new("Frame", I[23], "searchContainer", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.1) }, { ["isStatic"] = true })
							I[25] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
							I[26] = new("UIStroke", I[24], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
							I[27] = new("Frame", I[24], "wrapper", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
								I[28] = new("TextBox", I[27], "searchInput", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), LayoutOrder = 1, PlaceholderColor3 = Color3.fromRGB(70, 68, 77), PlaceholderText = "Search commands...", Position = UDim2.fromScale(0.1552605, 0.5000001), Size = UDim2.fromScale(0.812, 0.683), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
								I[29] = new("ImageLabel", I[27], "image", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(214, 213, 222), ImageContent = Content.fromUri("rbxassetid://130403244495092"), Position = UDim2.new(0, 4, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1157504, 0.7000001), ZIndex = 2 })
									I[30] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint")
								I[31] = new("UIListLayout", I[27], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
								I[32] = new("UIPadding", I[27], "UIPadding", { PaddingLeft = UDim.new(0, 4) })
							I[33] = new("ImageButton", I[24], "clear", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(214, 213, 222), ImageContent = Content.fromUri("rbxassetid://98988409041690"), LayoutOrder = 2, Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromScale(0.4, 0.4), Visible = false, ZIndex = 2 })
								I[34] = new("UIAspectRatioConstraint", I[33], "UIAspectRatioConstraint")
						I[35] = new("Frame", I[23], "itemsSection", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5000001, 0.985), Size = UDim2.fromScale(0.9750001, 0.8592201) })
							I[36] = new("ScrollingFrame", I[35], "itemsWrapper", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0.975, 0), ElasticBehavior = Enum.ElasticBehavior.Always, Position = UDim2.fromScale(0.5, 0.5), ScrollBarImageColor3 = Color3.fromRGB(229, 229, 230), ScrollBarThickness = 2, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 1) })
								I[37] = new("Frame", I[36], "container", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0) })
									I[38] = new("UIListLayout", I[37], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder })
									I[39] = new("UIPadding", I[37], "UIPadding", { PaddingBottom = UDim.new(0.005, 0), PaddingTop = UDim.new(0.005, 0) })
								I[40] = new("UIListLayout", I[36], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
							I[41] = new("Frame", I[35], "topFade", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1.0000001, 0.0301066), ZIndex = 2 })
								I[42] = new("UIGradient", I[41], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
							I[43] = new("Frame", I[35], "bottomFade", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1.0000001), Size = UDim2.fromScale(1, 0.04), ZIndex = 2 })
								I[44] = new("UIGradient", I[43], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
				I[45] = new("Frame", I[3], "detailOverlay", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 10 })
					I[46] = new("Frame", I[45], "detailFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.85, 0.75), ZIndex = 11 })
						I[47] = new("UICorner", I[46], "UICorner", { BottomLeftRadius = UDim.new(0.04, 0), BottomRightRadius = UDim.new(0.04, 0), TopLeftRadius = UDim.new(0.04, 0), TopRightRadius = UDim.new(0.04, 0) })
						I[48] = new("UIStroke", I[46], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(247, 245, 255), Thickness = 2, Transparency = 0.5 })
						I[49] = new("UIPadding", I[46], "UIPadding", { PaddingBottom = UDim.new(0.03, 0), PaddingLeft = UDim.new(0.04, 0), PaddingRight = UDim.new(0.04, 0), PaddingTop = UDim.new(0.03, 0) })
						I[50] = new("UIListLayout", I[46], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0) })
						I[51] = new("Frame", I[46], "header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.15) })
							I[52] = new("ImageLabel", I[51], "icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://6034258833"), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.15, 0.8) })
							I[53] = new("TextLabel", I[51], "title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.18, 0.4), Size = UDim2.fromScale(0.7, 0.6), Text = "Command Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[54] = new("TextLabel", I[51], "categoryLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.18, 0.65), Size = UDim2.fromScale(0.7, 0.3), Text = "Category", TextColor3 = Color3.fromRGB(160, 160, 170), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[55] = new("TextButton", I[51], "closeButton", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.1, 0.6), Text = "" })
								I[56] = new("UICorner", I[55], "UICorner", { BottomLeftRadius = UDim.new(0.275, 0), BottomRightRadius = UDim.new(0.275, 0), TopLeftRadius = UDim.new(0.275, 0), TopRightRadius = UDim.new(0.275, 0) })
								I[57] = new("ImageLabel", I[55], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9) })
								I[58] = new("UIAspectRatioConstraint", I[55], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
						I[59] = new("TextLabel", I[46], "description", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.12), Text = "Description goes here.", TextColor3 = Color3.fromRGB(160, 160, 170), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[60] = new("Frame", I[46], "argsContainer", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.5) })
							I[61] = new("UIListLayout", I[60], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.015, 0) })
							I[62] = new("UIPadding", I[60], "UIPadding", { PaddingTop = UDim.new(0.01, 0) })
						I[63] = new("Frame", I[46], "buttonRow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.12) })
							I[64] = new("TextButton", I[63], "executeButton", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(88, 101, 242), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.48, 1), Text = "Execute", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
								I[65] = new("UICorner", I[64], "UICorner", { BottomLeftRadius = UDim.new(0.08, 0), BottomRightRadius = UDim.new(0.08, 0), TopLeftRadius = UDim.new(0.08, 0), TopRightRadius = UDim.new(0.08, 0) })
								I[66] = new("UIStroke", I[64], "UIStroke", { Color = Color3.fromRGB(247, 245, 255), Transparency = 0.6 })
							I[67] = new("TextButton", I[63], "cancelButton", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(33, 34, 39), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.48, 1), Text = "Cancel", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
								I[68] = new("UICorner", I[67], "UICorner", { BottomLeftRadius = UDim.new(0.08, 0), BottomRightRadius = UDim.new(0.08, 0), TopLeftRadius = UDim.new(0.08, 0), TopRightRadius = UDim.new(0.08, 0) })
								I[69] = new("UIStroke", I[67], "UIStroke", { Color = Color3.fromRGB(247, 245, 255), Transparency = 0.5 })
			I[70] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.83, DominantAxis = Enum.DominantAxis.Height })
			I[71] = new("UISizeConstraint", I[2], "UISizeConstraint", { MinSize = Vector2.new(300, 300) })
			I[72] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
	return I[1]
end

return build
