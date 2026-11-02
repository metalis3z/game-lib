-- Generated from ui/StarterGui/CreateAvatar.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "CreateAvatar", { DisplayOrder = 10, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "Themed" })
		I[2] = new("CanvasGroup", I[1], "container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.92, 0.85) })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.85 })
			I[4] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 3), PaddingLeft = UDim.new(0, 3), PaddingRight = UDim.new(0, 3), PaddingTop = UDim.new(0, 3) })
			I[5] = new("UISizeConstraint", I[2], "UISizeConstraint", { MinSize = Vector2.new(300, 300) })
			I[6] = new("Frame", I[2], "wrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.035, 0), BottomRightRadius = UDim.new(0.035, 0), TopLeftRadius = UDim.new(0.035, 0), TopRightRadius = UDim.new(0.035, 0) })
				I[8] = new("UIStroke", I[6], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(247, 245, 255), Thickness = 3, Transparency = 0.5 })
				I[9] = new("TextLabel", I[6], "title", { BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0126538, 0.0289383), Size = UDim2.fromScale(0.27, 0.055), Text = "Create Avatar", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[10] = new("TextButton", I[6], "closeButton", { AnchorPoint = Vector2.new(1, 0), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderSizePixel = 0, Position = UDim2.fromScale(0.9881614, 0.0219712), Size = UDim2.fromScale(0.0470877, 0.0731635), Text = "", ZIndex = 100 }, nil, { "UIEffect" })
					I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { DominantAxis = Enum.DominantAxis.Height })
					I[12] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.1780777, 0), BottomRightRadius = UDim.new(0.1780777, 0), TopLeftRadius = UDim.new(0.1780777, 0), TopRightRadius = UDim.new(0.1780777, 0) })
					I[13] = new("ImageLabel", I[10], "image", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9) })
				I[14] = new("Frame", I[6], "contentColumn", { BackgroundColor3 = Color3.fromRGB(22, 23, 26), BorderSizePixel = 0, Position = UDim2.fromScale(0.0118386, 0.1093786), Size = UDim2.fromScale(0.71, 0.7800863) })
					I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.025, 0), BottomRightRadius = UDim.new(0.025, 0), TopLeftRadius = UDim.new(0.025, 0), TopRightRadius = UDim.new(0.025, 0) })
					I[16] = new("Frame", I[14], "stageContent", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[17] = new("Frame", I[6], "previewColumn", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(43, 45, 51), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.9881613, 0.1093786), Size = UDim2.fromScale(0.25, 0.7800863) })
					I[18] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0.025, 0), BottomRightRadius = UDim.new(0.025, 0), TopLeftRadius = UDim.new(0.025, 0), TopRightRadius = UDim.new(0.025, 0) })
					I[19] = new("ImageLabel", I[17], "background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://83570005866923"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["SkipThemeImage"] = true })
						I[20] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(0.025, 0), BottomRightRadius = UDim.new(0.025, 0), TopLeftRadius = UDim.new(0.025, 0), TopRightRadius = UDim.new(0.025, 0) })
					I[21] = new("ViewportFrame", I[17], "viewport", { Ambient = Color3.fromRGB(202, 202, 202), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, LightColor = Color3.fromRGB(221, 221, 221), LightDirection = Vector3.new(0.5, -1, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[22] = new("TextButton", I[17], "detector", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "", ZIndex = -1 })
				I[23] = new("Frame", I[6], "bottomBar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.9780288), Size = UDim2.fromScale(0.9763228, 0.077) })
					I[24] = new("Frame", I[23], "left", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[25] = new("UIPadding", I[24], "UIPadding")
						I[26] = new("UIListLayout", I[24], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.013, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
						I[27] = new("Frame", I[24], "backButtonContainer", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(0.22, 1), ZIndex = 2 }, { ["SkipTheme"] = true })
							I[28] = new("UIAspectRatioConstraint", I[27], "UIAspectRatioConstraint", { AspectRatio = 3.5, AspectType = Enum.AspectType.ScaleWithParentSize })
							I[29] = new("UIPadding", I[27], "UIPadding")
							I[30] = new("Frame", I[27], "back", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
								I[31] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
								I[32] = new("UIStroke", I[30], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5, Transparency = 0.3 })
							I[33] = new("TextLabel", I[27], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.85, 0.67), Text = "Back", TextColor3 = Color3.fromRGB(237, 238, 238), TextScaled = true, TextWrapped = true, ZIndex = 3 })
							I[34] = new("TextButton", I[27], "button", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Text = "", ZIndex = 4 }, nil, { "UIEffectSoundOnly" })
					I[35] = new("Frame", I[23], "right", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
						I[36] = new("UIPadding", I[35], "UIPadding")
						I[37] = new("UIListLayout", I[35], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0.013, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
						I[38] = new("Frame", I[35], "continueButtonContainer", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(0.22, 1), ZIndex = 2 }, { ["SkipTheme"] = true })
							I[39] = new("UIAspectRatioConstraint", I[38], "UIAspectRatioConstraint", { AspectRatio = 3.5, AspectType = Enum.AspectType.ScaleWithParentSize })
							I[40] = new("UIPadding", I[38], "UIPadding")
							I[41] = new("Frame", I[38], "back", { BackgroundColor3 = Color3.fromRGB(0, 176, 111), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
								I[42] = new("UICorner", I[41], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
							I[43] = new("TextLabel", I[38], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.85, 0.67), Text = "Continue", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
							I[44] = new("TextButton", I[38], "button", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Text = "", ZIndex = 4 }, nil, { "UIEffectSoundOnly" })
					I[45] = new("Frame", I[23], "stageIndicator", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.85) })
						I[46] = new("Frame", I[45], "connector", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(70, 68, 77), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.8, 0, 0, 2) })
						I[47] = new("Frame", I[45], "segment1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 95, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.1, 0.5), Size = UDim2.fromScale(0, 1), ZIndex = 2 })
							I[48] = new("UIAspectRatioConstraint", I[47], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
							I[49] = new("UICorner", I[47], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
							I[50] = new("TextLabel", I[47], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
							I[51] = new("UIStroke", I[47], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
						I[52] = new("Frame", I[45], "segment2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, Position = UDim2.fromScale(0.3, 0.5), Size = UDim2.fromScale(0, 1), ZIndex = 2 })
							I[53] = new("UIAspectRatioConstraint", I[52], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
							I[54] = new("UICorner", I[52], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
							I[55] = new("UIStroke", I[52], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
							I[56] = new("TextLabel", I[52], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75), Text = "2", TextColor3 = Color3.fromRGB(213, 215, 221), TextScaled = true, TextWrapped = true })
						I[57] = new("Frame", I[45], "segment3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0, 1), ZIndex = 2 })
							I[58] = new("UIAspectRatioConstraint", I[57], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
							I[59] = new("UICorner", I[57], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
							I[60] = new("UIStroke", I[57], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
							I[61] = new("TextLabel", I[57], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75), Text = "3", TextColor3 = Color3.fromRGB(213, 215, 221), TextScaled = true, TextWrapped = true })
						I[62] = new("Frame", I[45], "segment4", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, Position = UDim2.fromScale(0.7, 0.5), Size = UDim2.fromScale(0, 1), ZIndex = 2 })
							I[63] = new("UIAspectRatioConstraint", I[62], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
							I[64] = new("UICorner", I[62], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
							I[65] = new("UIStroke", I[62], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
							I[66] = new("TextLabel", I[62], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75), Text = "4", TextColor3 = Color3.fromRGB(213, 215, 221), TextScaled = true, TextWrapped = true })
						I[67] = new("Frame", I[45], "segment5", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, Position = UDim2.fromScale(0.9, 0.5), Size = UDim2.fromScale(0, 1), ZIndex = 2 })
							I[68] = new("UIAspectRatioConstraint", I[67], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
							I[69] = new("UICorner", I[67], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
							I[70] = new("TextLabel", I[67], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.75), Text = "5", TextColor3 = Color3.fromRGB(213, 215, 221), TextScaled = true, TextWrapped = true })
							I[71] = new("UIStroke", I[67], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(70, 68, 77), Thickness = 1.5 })
				I[72] = new("Frame", I[6], "stageBadge", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderSizePixel = 0, Position = UDim2.fromScale(0.3655365, 0.0584996), Size = UDim2.fromScale(0.1244882, 0.07) })
					I[73] = new("UICorner", I[72], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[74] = new("TextLabel", I[72], "stageName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.7), Text = "Skin Tone", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextWrapped = true })
	return I[1]
end

return build
