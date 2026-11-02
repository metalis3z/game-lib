-- Generated from ui/StarterGui/OutfitsBackup.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "OutfitsBackup", { DisplayOrder = 10, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "Themed" })
		I[2] = new("CanvasGroup", I[1], "container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(33, 34, 39), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5000001, 0.4930672), Size = UDim2.fromScale(0.639443, 0.7861345) })
			I[3] = new("Frame", I[2], "wrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.035, 0), BottomRightRadius = UDim.new(0.035, 0), TopLeftRadius = UDim.new(0.035, 0), TopRightRadius = UDim.new(0.035, 0) })
				I[5] = new("UIStroke", I[3], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), Thickness = 3, Transparency = 0.5 })
				I[6] = new("TextButton", I[3], "closeButton", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 20, Position = UDim2.fromScale(0.987, 0.0167439), Size = UDim2.fromScale(0.0497379, 0.0653637), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1, ZIndex = 2 }, nil, { "UIEffect" })
					I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
					I[8] = new("ImageLabel", I[6], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.9, 1, 0.9, 0) })
					I[9] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
				I[10] = new("TextButton", I[3], "_", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Interactable = false, Selectable = false, Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = -1 })
				I[11] = new("Frame", I[3], "buttons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.975, 0.95) })
					I[12] = new("TextButton", I[11], "savedOutfits", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(58, 59, 68), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 23, Position = UDim2.fromScale(0.582195, 0.0000002), Size = UDim2.fromScale(0.41, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 }, { ["SkipTheme"] = true }, { "UIEffectSoundOnly" })
						I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(0.0342647, 0), BottomRightRadius = UDim.new(0.0342647, 0), TopLeftRadius = UDim.new(0.0342647, 0), TopRightRadius = UDim.new(0.0342647, 0) }, { ["SkipTheme"] = true })
						I[14] = new("UIStroke", I[12], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.0068529, Transparency = 0.5 }, { ["SkipTheme"] = true })
						I[15] = new("TextLabel", I[12], "action", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4378308, 0.0870655), Size = UDim2.fromScale(0.8033711, 0.0791653), Text = "Saved Outfits", TextColor3 = Color3.fromRGB(244, 244, 244), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top }, { ["SkipTheme"] = true })
						I[16] = new("UIStroke", I[12], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(255, 255, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.0075 }, { ["SkipTheme"] = true })
							I[17] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 185, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(239, 93, 162)) }), Rotation = 40 }, { ["SkipTheme"] = true })
						I[18] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 185, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(239, 93, 162)) }), Rotation = 40 }, { ["SkipTheme"] = true })
						I[19] = new("Frame", I[12], "itemsWrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5000001, 0.5414219), Size = UDim2.fromScale(0.9950001, 0.8708032) }, { ["SkipTheme"] = true })
							I[20] = new("Frame", I[19], "items", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0, 1) }, { ["SkipTheme"] = true })
								I[21] = new("UIListLayout", I[20], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder }, { ["SkipTheme"] = true })
					I[22] = new("TextButton", I[11], "outfitLoader", { AnchorPoint = Vector2.new(0, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(112, 114, 132), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 23, Position = UDim2.fromScale(0.007, 1), Size = UDim2.fromScale(0.5582195, 0.489), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 }, { ["SkipTheme"] = true }, { "UIEffectSoundOnly" })
						I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(0.0375, 0), BottomRightRadius = UDim.new(0.0375, 0), TopLeftRadius = UDim.new(0.0375, 0), TopRightRadius = UDim.new(0.0375, 0) }, { ["SkipTheme"] = true })
						I[24] = new("UIStroke", I[22], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.0075, Transparency = 0.5 }, { ["SkipTheme"] = true })
						I[25] = new("TextLabel", I[22], "action", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4323906, 0.1780481), Size = UDim2.fromScale(0.8116853, 0.1618922), Text = "Outfit Loader", TextColor3 = Color3.fromRGB(244, 244, 244), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top }, { ["SkipTheme"] = true })
						I[26] = new("UIStroke", I[22], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, BorderStrokePosition = Enum.BorderStrokePosition.Inner, Color = Color3.fromRGB(216, 220, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.0075 }, { ["SkipTheme"] = true })
							I[27] = new("UIGradient", I[26], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(247, 247, 247)), ColorSequenceKeypoint.new(0.404844, Color3.fromRGB(239, 245, 239)), ColorSequenceKeypoint.new(1, Color3.fromRGB(96, 202, 85)) }), Rotation = 104 }, { ["SkipTheme"] = true })
						I[28] = new("UIGradient", I[22], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(247, 247, 247)), ColorSequenceKeypoint.new(0.404844, Color3.fromRGB(239, 245, 239)), ColorSequenceKeypoint.new(1, Color3.fromRGB(96, 202, 85)) }), Rotation = 104 }, { ["SkipTheme"] = true })
						I[29] = new("Frame", I[22], "itemsWrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5788251), Size = UDim2.fromScale(0.995, 0.758) }, { ["SkipTheme"] = true })
							I[30] = new("Frame", I[29], "items", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0, 1) }, { ["SkipTheme"] = true })
								I[31] = new("UIListLayout", I[30], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["SkipTheme"] = true })
					I[32] = new("TextButton", I[11], "communityOutfits", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 23, Position = UDim2.fromScale(0.0072775, 0.0000001), Size = UDim2.fromScale(0.5578819, 0.489), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 }, nil, { "UIEffectSoundOnly" })
						I[33] = new("UICorner", I[32], "UICorner", { BottomLeftRadius = UDim.new(0.0375, 0), BottomRightRadius = UDim.new(0.0375, 0), TopLeftRadius = UDim.new(0.0375, 0), TopRightRadius = UDim.new(0.0375, 0) })
						I[34] = new("UIStroke", I[32], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.0075, Transparency = 0.5 })
						I[35] = new("TextLabel", I[32], "action", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4326522, 0.1780481), Size = UDim2.fromScale(0.8121766, 0.1618922), Text = "Community Outfits", TextColor3 = Color3.fromRGB(244, 244, 244), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
						I[36] = new("Frame", I[32], "itemsWrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5788251), Size = UDim2.fromScale(0.995, 0.758) })
							I[37] = new("Frame", I[36], "items", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0, 1) })
								I[38] = new("UIListLayout", I[37], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder })
			I[39] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.27 })
			I[40] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
			I[41] = new("UISizeConstraint", I[2], "UISizeConstraint", { MinSize = Vector2.new(300, 300) })
	return I[1]
end

return build
