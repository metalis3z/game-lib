-- Generated from ui/StarterGui/ScreenGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ScreenGui", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["_lemonadeUniqueId"] = "2FIaX7x32FIa" })
		I[2] = new("Frame", I[1], "Top", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.05), Size = UDim2.fromScale(0.35, 0.075) }, { ["_lemonadeUniqueId"] = "445s9ULb445s" }, { "Advertisement" })
			I[3] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "M9OvwwqOM9Ov" })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center }, { ["_lemonadeUniqueId"] = "sJxjNKZzsJxj" })
				I[5] = new("ImageButton", I[3], "DoubleMoney", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(33, 248, 0), ImageContent = Content.fromUri("rbxassetid://130794554422804"), LayoutOrder = 40, Position = UDim2.fromScale(0.055914, 0.0709506), ResampleMode = Enum.ResamplerMode.Pixelated, Size = UDim2.fromScale(0.995, 1) }, { ["_lemonadeUniqueId"] = "3x3tTpkY3x3t" })
					I[6] = new("ImageLabel", I[5], "ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://139685528655648"), Position = UDim2.fromScale(0.025, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "lGL3ZunzlGL3" })
						I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 0.8873875, AspectType = Enum.AspectType.ScaleWithParentSize }, { ["_lemonadeUniqueId"] = "2bvHpYOI2bvH" })
						I[8] = new("TextLabel", I[6], "Multiplier", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.5, 0.5), Text = "2x", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "bzupSn8Mbzup" })
							I[9] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(9, 53, 49), Thickness = 3.5999999 }, { ["_lemonadeUniqueId"] = "Jus4BuMsJus4" })
					I[10] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 2.2 }, { ["_lemonadeUniqueId"] = "Gey72bBxGey7" })
					I[11] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.0260417, 0), BottomRightRadius = UDim.new(0.0260417, 0), TopLeftRadius = UDim.new(0.0260417, 0), TopRightRadius = UDim.new(0.0260417, 0) }, { ["_lemonadeUniqueId"] = "lYuOF0MWlYuO" })
					I[12] = new("TextLabel", I[5], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.679, 0.45), Size = UDim2.fromScale(0.4960024, 0.7133784), Text = "DOUBLE MONEY!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "L9qVN40uL9qV" })
						I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(9, 53, 49), Thickness = 3.5999999 }, { ["_lemonadeUniqueId"] = "hipjHtOEhipj" })
				I[14] = new("ImageButton", I[3], "MaxRebirths", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://93599833437411"), LayoutOrder = 110, Position = UDim2.fromScale(0.055914, 0.0709506), ResampleMode = Enum.ResamplerMode.Pixelated, Size = UDim2.fromScale(0.995, 1) }, { ["_lemonadeUniqueId"] = "qBgh1W3NqBgh" })
					I[15] = new("ImageLabel", I[14], "ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://105700007599688"), Position = UDim2.fromScale(0.025, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.212, 0.85) }, { ["_lemonadeUniqueId"] = "43bdZt2i43bd" })
						I[16] = new("ImageLabel", I[15], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://78137530993637"), Position = UDim2.fromScale(0.471874, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.3989296, 1.1764706) }, { ["_lemonadeUniqueId"] = "09taKULb09ta" })
						I[17] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint", { AspectRatio = 0.8873875, AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height }, { ["_lemonadeUniqueId"] = "4gZmX7Cg4gZm" })
					I[18] = new("TextLabel", I[14], "Time", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.677, 0.45), Size = UDim2.fromScale(0.5008027, 0.7083785), Text = "Max Speed!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 }, { ["_lemonadeUniqueId"] = "WdEwXhJpWdEw" })
						I[19] = new("UIStroke", I[18], "UIStroke", { Color = Color3.fromRGB(9, 53, 49), Thickness = 3.5999999 }, { ["_lemonadeUniqueId"] = "DsXKdNTnDsXK" })
					I[20] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint", { AspectRatio = 2.2 }, { ["_lemonadeUniqueId"] = "CxVEiOnnCxVE" })
					I[21] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(0.0260417, 0), BottomRightRadius = UDim.new(0.0260417, 0), TopLeftRadius = UDim.new(0.0260417, 0), TopRightRadius = UDim.new(0.0260417, 0) }, { ["_lemonadeUniqueId"] = "Cgz0KSXlCgz0" })
			I[22] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 4.6666665 }, { ["_lemonadeUniqueId"] = "NPGwqLKANPGw" })
	return I[1]
end

return build
