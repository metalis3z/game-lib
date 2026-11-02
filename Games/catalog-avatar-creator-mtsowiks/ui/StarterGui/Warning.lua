-- Generated from ui/StarterGui/Warning.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Warning", { DisplayOrder = 1200, Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "Themed" })
		I[2] = new("Frame", I[1], "backdrop", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.35, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["SkipTheme"] = true })
			I[3] = new("TextButton", I[2], "_", { AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "" })
		I[4] = new("CanvasGroup", I[1], "container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.65), ZIndex = 2 })
			I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 1.89 })
			I[6] = new("UISizeConstraint", I[4], "UISizeConstraint", { MinSize = Vector2.new(480, 254) })
			I[7] = new("Frame", I[4], "wrapper", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(18, 18, 21), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
				I[9] = new("UIPadding", I[7], "UIPadding", { PaddingBottom = UDim.new(0.068, 0), PaddingLeft = UDim.new(0.0359, 0), PaddingRight = UDim.new(0.0359, 0), PaddingTop = UDim.new(0.068, 0) })
				I[10] = new("UIListLayout", I[7], "UIListLayout", { Padding = UDim.new(0.0449, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[11] = new("Frame", I[7], "header", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.fromScale(1, 0.1517) })
					I[12] = new("TextLabel", I[11], "icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.63), Text = "⚠️", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextWrapped = true })
						I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint", { DominantAxis = Enum.DominantAxis.Height })
					I[14] = new("TextLabel", I[11], "title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0635, 0.5), Size = UDim2.fromScale(0.6, 0.78), Text = "Warning", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[15] = new("TextLabel", I[7], "message", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0.0955), Text = "Our systems detected a possibly inappropriate avatar.", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[16] = new("Frame", I[7], "reasonCard", { BackgroundColor3 = Color3.fromRGB(33, 34, 39), BorderSizePixel = 0, LayoutOrder = 3, Size = UDim2.fromScale(1, 0.4213) })
					I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
					I[18] = new("UIPadding", I[16], "UIPadding", { PaddingBottom = UDim.new(0.1333, 0), PaddingLeft = UDim.new(0.0276, 0), PaddingRight = UDim.new(0.0276, 0), PaddingTop = UDim.new(0.1333, 0) })
					I[19] = new("UIListLayout", I[16], "UIListLayout", { Padding = UDim.new(0.18, 0), SortOrder = Enum.SortOrder.LayoutOrder })
					I[20] = new("TextLabel", I[16], "reasonLabel", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Size = UDim2.fromScale(1, 0.26), Text = "Reason:", TextColor3 = Color3.fromRGB(247, 247, 248), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[21] = new("TextLabel", I[16], "reasonValue", { BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(1, 0.56), Text = "This avatar may not be appropriate for all ages. Please try again with a new concept, we apologize for the inconvenience.", TextColor3 = Color3.fromRGB(237, 238, 238), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[22] = new("Frame", I[7], "footer", { BackgroundTransparency = 1, LayoutOrder = 4, Size = UDim2.fromScale(1, 0.1966) })
					I[23] = new("TextButton", I[22], "continueButton", { AnchorPoint = Vector2.new(1, 1), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(51, 95, 255), BorderSizePixel = 0, Position = UDim2.fromScale(1.011, 1.114), Size = UDim2.fromScale(0.28, 0.9), Text = "" }, nil, { "UIEffectSoundOnly" })
						I[24] = new("UICorner", I[23], "UICorner", { BottomLeftRadius = UDim.new(0.23, 0), BottomRightRadius = UDim.new(0.23, 0), TopLeftRadius = UDim.new(0.23, 0), TopRightRadius = UDim.new(0.23, 0) })
						I[25] = new("TextLabel", I[23], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.82, 0.58), Text = "I Understand", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true }, { ["SkipTheme"] = true })
	return I[1]
end

return build
