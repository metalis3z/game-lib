-- Generated from ui/StarterGui/PreRobuxPrompt.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PreRobuxPrompt", { ClipToDeviceSafeArea = false, DisplayOrder = 2147483647, Enabled = false, ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "ProductPurchaseModal", { AutoLocalize = false, BorderSizePixel = 0, ZIndex = 200 }, nil, { "data-testid=--foundation-sheet--surface", "gui-object-defaults", "size-full" })
			I[3] = new("ImageButton", I[2], "Backdrop", { AutoButtonColor = false, AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(10, 10, 14), BackgroundTransparency = 0.25, BorderSizePixel = 0, Position = UDim2.fromScale(-0.5, -0.5), Size = UDim2.fromScale(2, 2) }, nil, { "x-default-transparency", "gui-object-defaults", "data-testid=--foundation-sheet--backdrop" })
			I[4] = new("Frame", I[2], "SheetContainer", { AutoLocalize = false, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), ZIndex = 2 }, nil, { "align-y-center", "padding-medium", "gui-object-defaults", "size-full", "anchor-center-center", "col" })
				I[5] = new("UISizeConstraint", I[4], "SizeConstraint", { MaxSize = Vector2.new(480, 600) })
				I[6] = new("Folder", I[4], "Shadow")
					I[7] = new("ImageLabel", I[6], "Shadow", { AutoLocalize = false, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxasset://LuaPackages/Packages/_Index/FoundationImages/FoundationImages/SpriteSheets/img_set_1x_4.png"), ImageRectOffset = Vector2.new(300, 478), ImageRectSize = Vector2.new(33, 33), ImageTransparency = 0.9, Position = UDim2.new(0, -16, 0.5, 0), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 32, 0, 273), SliceCenter = Rect.new(16, 16, 17, 17), SliceScale = 2 }, nil, { "gui-object-defaults", "anchor-center-left" })
				I[8] = new("ImageButton", I[4], "Sheet", { AutoButtonColor = false, AutoLocalize = false, BorderSizePixel = 0, ClipsDescendants = true, Selectable = false, SelectionBehaviorDown = Enum.SelectionBehavior.Stop, SelectionBehaviorLeft = Enum.SelectionBehavior.Stop, SelectionBehaviorRight = Enum.SelectionBehavior.Stop, SelectionBehaviorUp = Enum.SelectionBehavior.Stop, SelectionGroup = true, ZIndex = 2 }, nil, { "data-testid=--foundation-sheet", "radius-large", "gui-object-defaults", "size-full-0", "stroke-standard", "bg-surface-100", "auto-y", "stroke-default" })
					I[9] = new("Frame", I[8], "Content", { AutoLocalize = false, BorderSizePixel = 0 }, nil, { "gui-object-defaults", "size-full-0", "items-center", "clip", "auto-y", "col" })
						I[10] = new("ImageButton", I[9], "Actions", { AutoButtonColor = false, AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 3 }, nil, { "gui-object-defaults", "size-full-0", "data-testid=--foundation-sheet--actions", "auto-y", "row", "gap-small" })
							I[11] = new("UIStroke", I[10], "Stroke", { Color = Color3.fromRGB(208, 217, 251), Thickness = 0, Transparency = 0.88 }, nil, { "data-testid=--foundation-sheet--actions--stroke" })
							I[12] = new("UIPadding", I[10], "Padding", { PaddingBottom = UDim.new(0, 20), PaddingLeft = UDim.new(0, 20), PaddingRight = UDim.new(0, 20), PaddingTop = UDim.new(0, 20) })
							I[13] = new("Frame", I[10], "1", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 1 }, nil, { "align-y-center", "auto-xy", "gui-object-defaults", "size-full-0", "gap-medium", "wrap", "row", "align-x-center" })
								I[14] = new("ImageButton", I[13], "BuyRobux", { AutoButtonColor = false, AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(51, 95, 255), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 40) }, nil, { "x-default-transparency", "gui-object-defaults", "gap-small", "padding-medium", "data-testid=--foundation-button", "align-y-center", "clip", "row", "align-x-center" })
									I[15] = new("UIStroke", I[14], "Stroke", { Transparency = 1 }, nil, { "data-testid=--foundation-button--stroke" })
									I[16] = new("UIFlexItem", I[14], "FlexItem", { FlexMode = Enum.UIFlexMode.Fill }, nil, { "data-testid=--foundation-button--flex-item" })
									I[17] = new("TextLabel", I[14], "Text", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 2, Text = "Purchase with Robux", TextColor3 = Color3.fromRGB(247, 247, 248) }, nil, { "gui-object-defaults", "size-0-full", "text-color-defaults", "auto-x", "data-testid=--foundation-button--text", "text-title-medium", "shrink", "text-truncate-end", "text-size-defaults", "text-defaults" })
									I[18] = new("UICorner", I[14], "CornerRadius", nil, nil, { "data-testid=--foundation-button--corner-radius" })
								I[19] = new("ImageButton", I[13], "BuyTokens", { AutoButtonColor = false, AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(51, 95, 255), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 40) }, nil, { "x-default-transparency", "gui-object-defaults", "gap-small", "padding-medium", "data-testid=--foundation-button", "align-y-center", "clip", "row", "align-x-center" })
									I[20] = new("UIStroke", I[19], "Stroke", { Transparency = 1 }, nil, { "data-testid=--foundation-button--stroke" })
									I[21] = new("UIFlexItem", I[19], "FlexItem", { FlexMode = Enum.UIFlexMode.Fill }, nil, { "data-testid=--foundation-button--flex-item" })
									I[22] = new("TextLabel", I[19], "Text", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 2, Text = "Purchase with Tokens", TextColor3 = Color3.fromRGB(247, 247, 248) }, nil, { "gui-object-defaults", "size-0-full", "text-color-defaults", "auto-x", "data-testid=--foundation-button--text", "text-title-medium", "shrink", "text-truncate-end", "text-size-defaults", "text-defaults" })
									I[23] = new("UICorner", I[19], "CornerRadius", nil, nil, { "data-testid=--foundation-button--corner-radius" })
						I[24] = new("Frame", I[9], "Header", { AutoLocalize = false, BorderSizePixel = 0, ZIndex = 2 }, nil, { "data-testid=--foundation-sheet--header", "gui-object-defaults", "size-full-0", "auto-y", "col" })
							I[25] = new("Frame", I[24], "Content", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 1 }, nil, { "align-y-center", "gui-object-defaults", "size-full-1400", "auto-y", "padding-y-small", "padding-right-medium", "items-center", "margin-left-small", "row", "gap-small" })
								I[26] = new("ImageButton", I[25], "CloseAffordance", { AutoButtonColor = false, AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromOffset(40, 40) }, nil, { "align-y-center", "auto-xy", "gui-object-defaults", "data-testid=--foundation-sheet--header--close-affordance", "clip", "row", "align-x-center" })
									I[27] = new("UIPadding", I[26], "Padding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 8) })
									I[28] = new("TextLabel", I[26], "Icon", { AutoLocalize = false, BorderSizePixel = 0, FontFace = Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(24, 24), Text = "x", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 24 }, nil, { "gui-object-defaults", "text-color-defaults", "data-testid=--foundation-icon", "text-size-defaults", "text-defaults" })
									I[29] = new("UICorner", I[26], "CornerRadius", nil, nil, { "data-testid=--foundation-sheet--header--close-affordance--corner-radius" })
								I[30] = new("Frame", I[25], "SubContent", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 1 }, nil, { "shrink", "gui-object-defaults", "size-full-0", "items-center", "gap-small", "auto-y", "row" })
									I[31] = new("Frame", I[30], "ModalHeader", { AutoLocalize = false, BorderSizePixel = 0 }, nil, { "align-y-center", "auto-xy", "gui-object-defaults", "align-x-start", "row" })
										I[32] = new("Frame", I[31], "RightSide", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(0.5, 1), Visible = false }, nil, { "align-y-center", "gui-object-defaults", "align-x-right", "row", "gap-large" })
											I[33] = new("TextLabel", I[32], "RobuxPrice", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 2, RichText = true, Text = "<font family=\"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json\" weight=\"400\">robux</font> 2,147,483,647" }, nil, { "text-size-defaults", "auto-xy", "gui-object-defaults", "text-label-medium", "text-color-defaults", "content-emphasis", "text-align-x-right", "text-defaults" })
										I[34] = new("Frame", I[31], "LeftSide", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(0.5, 1) }, nil, { "align-y-center", "gui-object-defaults", "align-x-start", "row", "gap-small" })
											I[35] = new("TextLabel", I[34], "RobuxAmount", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 1, Text = "Buy item" }, nil, { "content-default", "auto-xy", "gui-object-defaults", "text-align-x-left", "text-color-defaults", "text-heading-small", "text-size-defaults", "text-defaults" })
							I[36] = new("Frame", I[24], "BottomBorder", { AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(208, 217, 251), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 1) }, nil, { "x-default-transparency", "gui-object-defaults", "data-testid=--foundation-sheet--header--bottom-border" })
						I[37] = new("ImageButton", I[9], "Content", { AutoButtonColor = false, AutoLocalize = false, BorderSizePixel = 0, ClipsDescendants = true, Selectable = false, Size = UDim2.fromScale(1, 1) }, nil, { "gui-object-defaults", "size-full-0", "data-testid=--foundation-sheet--content", "auto-y", "fill" })
							I[38] = new("UIPadding", I[37], "Padding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) })
							I[39] = new("ScrollingFrame", I[37], "ScrollingFrame", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.new(1, 0, 0, 72), ClipsDescendants = false, ScrollBarImageColor3 = Color3.fromRGB(208, 217, 251), ScrollBarImageTransparency = 1, ScrollBarThickness = 6, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 1) })
								I[40] = new("Frame", I[39], "ScrollingFrame", { AutoLocalize = false, BorderSizePixel = 0 }, nil, { "align-x-center", "padding-x-medium", "gui-object-defaults", "col", "gap-medium", "auto-y", "size-full-0" })
									I[41] = new("Frame", I[40], "SheetContentContainer", { AutoLocalize = false, BorderSizePixel = 0 }, nil, { "align-x-center", "gui-object-defaults", "col", "align-y-center", "size-full-0", "auto-y", "gap-medium" })
										I[42] = new("Frame", I[41], "ProductDetailsContainer", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 1 }, nil, { "align-x-center", "gui-object-defaults", "col", "align-y-center", "size-full-0", "auto-y", "gap-medium" })
											I[43] = new("Frame", I[42], "ProductDetails", { AutoLocalize = false, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0) }, nil, { "align-y-center", "gui-object-defaults", "align-x-left", "gap-small", "auto-y", "row" })
												I[44] = new("Frame", I[43], "ItemDetailsFrame", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.new(1, -78, 0, 0) }, nil, { "gap-small", "auto-y", "gui-object-defaults", "col" })
													I[45] = new("Frame", I[44], "ItemDetails", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 2 }, nil, { "align-y-center", "auto-xy", "gui-object-defaults", "row", "gap-small" })
													I[46] = new("TextLabel", I[45], "ItemCost", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 1, RichText = true, Text = "<font family=\"rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json\" weight=\"400\">robux</font> 100" }, nil, { "text-align-x-left", "gui-object-defaults", "text-title-medium", "text-size-defaults", "auto-xy", "text-wrap", "content-emphasis", "text-color-defaults", "text-defaults" })
													I[47] = new("TextLabel", I[44], "ItemName", { AutoLocalize = false, BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0), Text = "Test product 1" }, nil, { "text-align-x-left", "gui-object-defaults", "text-title-medium", "text-size-defaults", "auto-xy", "text-wrap", "content-emphasis", "text-color-defaults", "text-defaults" })
												I[48] = new("ImageLabel", I[43], "ItemIcon", { AutoLocalize = false, BorderSizePixel = 0, ImageContent = Content.fromUri("https://www.roblox.com/thumbs/asset.ashx?assetid=116630871540498&x=100&y=100&format=png"), Position = UDim2.fromOffset(5, 5), Size = UDim2.fromOffset(72, 72) }, nil, { "gui-object-defaults" })
					I[49] = new("ImageButton", I[8], "CloseAffordance", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, AutoLocalize = false, BorderSizePixel = 0, Position = UDim2.new(1, -20, 0, 20), Size = UDim2.fromOffset(40, 40), Visible = false }, nil, { "align-y-center", "auto-xy", "gui-object-defaults", "align-x-center", "clip", "row", "data-testid=--foundation-sheet--close-affordance" })
						I[50] = new("UIPadding", I[49], "Padding", { PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 8) })
						I[51] = new("TextLabel", I[49], "Icon", { AutoLocalize = false, BorderSizePixel = 0, FontFace = Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(24, 24), Text = "x", TextColor3 = Color3.fromRGB(247, 247, 248), TextSize = 24 }, nil, { "gui-object-defaults", "text-color-defaults", "data-testid=--foundation-icon", "text-size-defaults", "text-defaults" })
						I[52] = new("UICorner", I[49], "CornerRadius", nil, nil, { "data-testid=--foundation-sheet--close-affordance--corner-radius" })
		I[53] = new("StyleLink", I[1], "FoundationStyleLink")
	return I[1]
end

return build
