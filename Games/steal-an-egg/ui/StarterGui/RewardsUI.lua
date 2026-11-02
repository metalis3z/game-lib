-- Generated from ui/StarterGui/RewardsUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RewardsUI", { DisplayOrder = 3, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BackgroundTransparency = 0.08, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.48, 0.46), Visible = false }, { ["RewardsOpen"] = false })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.6 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.045, 0), BottomRightRadius = UDim.new(0.045, 0), TopLeftRadius = UDim.new(0.045, 0), TopRightRadius = UDim.new(0.045, 0) })
			I[5] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 0.82 })
			I[6] = new("UIScale", I[2], "UIScale")
			I[7] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.125), RichText = true, Size = UDim2.fromScale(0.76, 0.17), Text = "Join our Discord server to receive in-game moderator permissions!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 2.5 })
			I[9] = new("TextButton", I[2], "close", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(214, 32, 38), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.988, 0.022), Size = UDim2.fromScale(0.09, 0.115), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true }, { ["Static"] = true })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.22, 0), BottomRightRadius = UDim.new(0.22, 0), TopLeftRadius = UDim.new(0.22, 0), TopRightRadius = UDim.new(0.22, 0) })
				I[11] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
				I[12] = new("UIStroke", I[9], "UIStroke", { Thickness = 2.5 })
				I[13] = new("UIScale", I[9], "HoverScale")
			I[14] = new("ImageLabel", I[2], "Avatar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(58, 58, 64), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131450273598748"), Position = UDim2.fromScale(0.175, 0.42), Size = UDim2.fromScale(0.20625, 0.33) })
				I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
				I[16] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
			I[17] = new("TextLabel", I[2], "Handle", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 33, 0.635, 0), RichText = true, Size = UDim2.fromScale(0.3, 0.07), Text = "CL Studio Uncopylocked", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 2.5 })
			I[19] = new("Frame", I[2], "List", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.655, 0.42), Size = UDim2.fromScale(0.6, 0.4) })
				I[20] = new("UIListLayout", I[19], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.055, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[21] = new("Frame", I[19], "Follow", { BackgroundColor3 = Color3.fromRGB(44, 44, 50), BackgroundTransparency = 0.15, BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 0.263) })
					I[22] = new("UICorner", I[21], "UICorner", { BottomLeftRadius = UDim.new(0.28, 0), BottomRightRadius = UDim.new(0.28, 0), TopLeftRadius = UDim.new(0.28, 0), TopRightRadius = UDim.new(0.28, 0) })
					I[23] = new("UIStroke", I[21], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 0.75 })
					I[24] = new("TextLabel", I[21], "Desc", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.5), RichText = true, Size = UDim2.fromScale(0.8, 0.62), Text = "1. Join \"discord.gg/clstudio\"", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 2.5 })
					I[26] = new("ImageLabel", I[21], "Badge", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://110334941964845"), Position = UDim2.new(0, 280, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1, 0.5), Visible = false })
						I[27] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
				I[28] = new("Frame", I[19], "Group", { BackgroundColor3 = Color3.fromRGB(44, 44, 50), BackgroundTransparency = 0.15, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(1, 0.263) })
					I[29] = new("UICorner", I[28], "UICorner", { BottomLeftRadius = UDim.new(0.28, 0), BottomRightRadius = UDim.new(0.28, 0), TopLeftRadius = UDim.new(0.28, 0), TopRightRadius = UDim.new(0.28, 0) })
					I[30] = new("UIStroke", I[28], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 0.75 })
					I[31] = new("TextLabel", I[28], "Desc", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.5), RichText = true, Size = UDim2.fromScale(0.42, 0.62), Text = "2. Open a ticket", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 2.5 })
					I[33] = new("TextLabel", I[28], "Status", { AnchorPoint = Vector2.new(1, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.96, 0.5), RichText = true, Size = UDim2.fromScale(0.17, 0.44), Text = "not yet", TextColor3 = Color3.fromRGB(255, 150, 140), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
						I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 2.5 })
					I[35] = new("TextButton", I[28], "Join", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(58, 122, 235), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.665, 0.5), Size = UDim2.fromScale(0.19, 0.62), Text = "JOIN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, Visible = false }, { ["Static"] = true })
						I[36] = new("UICorner", I[35], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
						I[37] = new("UIStroke", I[35], "UIStroke", { Thickness = 2.5 })
						I[38] = new("UIScale", I[35], "HoverScale")
				I[39] = new("Frame", I[19], "Like", { BackgroundColor3 = Color3.fromRGB(44, 44, 50), BackgroundTransparency = 0.15, BorderSizePixel = 0, LayoutOrder = 3, Size = UDim2.fromScale(1, 0.263) })
					I[40] = new("UICorner", I[39], "UICorner", { BottomLeftRadius = UDim.new(0.28, 0), BottomRightRadius = UDim.new(0.28, 0), TopLeftRadius = UDim.new(0.28, 0), TopRightRadius = UDim.new(0.28, 0) })
					I[41] = new("UIStroke", I[39], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2, Transparency = 0.75 })
					I[42] = new("TextLabel", I[39], "Desc", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.5), RichText = true, Size = UDim2.fromScale(0.9, 0.62), Text = "3. Get Mod", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[43] = new("UIStroke", I[42], "UIStroke", { Thickness = 2.5 })
			I[44] = new("TextLabel", I[2], "Prize", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.775), RichText = true, Size = UDim2.fromScale(0.72, 0.088), Text = "FREE MODERATOR  !!!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true })
				I[45] = new("UIStroke", I[44], "UIStroke", { Thickness = 2.5 })
				I[46] = new("UIGradient", I[44], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(126, 235, 90)), ColorSequenceKeypoint.new(0.25, Color3.fromRGB(90, 200, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(214, 130, 255)), ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 150, 90)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 90, 120)) }) })
			I[47] = new("TextButton", I[2], "Verify", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(124, 226, 84), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(0.36, 0.13), Text = "Verify", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true }, { ["Static"] = true })
				I[48] = new("UICorner", I[47], "UICorner", { BottomLeftRadius = UDim.new(0.35, 0), BottomRightRadius = UDim.new(0.35, 0), TopLeftRadius = UDim.new(0.35, 0), TopRightRadius = UDim.new(0.35, 0) })
				I[49] = new("UIStroke", I[47], "UIStroke", { Thickness = 3 })
				I[50] = new("UIScale", I[47], "HoverScale")
			I[51] = new("ImageLabel", I[2], "Badge", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://110334941964845"), Position = UDim2.new(0, 213, 0.635, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.040625, 0.065), Visible = false })
				I[52] = new("UIAspectRatioConstraint", I[51], "UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
			I[53] = new("Frame", I[2], "Popup", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(196, 34, 40), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.2), Visible = false, ZIndex = 50 })
				I[54] = new("UICorner", I[53], "UICorner", { BottomLeftRadius = UDim.new(0.14, 0), BottomRightRadius = UDim.new(0.14, 0), TopLeftRadius = UDim.new(0.14, 0), TopRightRadius = UDim.new(0.14, 0) })
				I[55] = new("UIStroke", I[53], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 3 })
				I[56] = new("UIScale", I[53], "UIScale")
				I[57] = new("TextLabel", I[53], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.68), Text = "You must follow the user, join group and like the game!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 51 })
					I[58] = new("UIStroke", I[57], "UIStroke", { Thickness = 2.5 })
	return I[1]
end

return build
