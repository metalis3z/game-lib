-- Generated from ui/StarterGui/RobloxPlusUpsell.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "RobloxPlusUpsell", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "container", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0, 10), Size = UDim2.fromScale(0.3, 0.1) })
			I[3] = new("Frame", I[2], "upsell", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.9, 1) })
				I[4] = new("ImageLabel", I[3], "background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://83570005866923"), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
					I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.125, 0), BottomRightRadius = UDim.new(0.125, 0), TopLeftRadius = UDim.new(0.125, 0), TopRightRadius = UDim.new(0.125, 0) })
					I[6] = new("UIStroke", I[4], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.025, Transparency = 0.75 })
				I[7] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.125, 0), BottomRightRadius = UDim.new(0.125, 0), TopLeftRadius = UDim.new(0.125, 0), TopRightRadius = UDim.new(0.125, 0) })
				I[8] = new("TextLabel", I[3], "label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://16658221428", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5500031, 0.5), RichText = true, Size = UDim2.fromScale(0.8499941, 0.6), Text = "Pay <b>10% less</b> on every purchase", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[9] = new("TextButton", I[3], "button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 }, nil, { "UIEffectsSoundOnly" })
				I[10] = new("ImageLabel", I[3], "discount", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://89076814622908"), Position = UDim2.fromScale(0.02, 0.5), Size = UDim2.fromScale(0.6, 0.6) })
					I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
			I[12] = new("ImageButton", I[2], "close", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81024172191247"), ImageTransparency = 0.3, Size = UDim2.fromScale(0.5, 0.5) }, nil, { "UIEffectsSoundOnly" })
				I[13] = new("UIAspectRatioConstraint", I[12], "UIAspectRatioConstraint")
			I[14] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.015, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[15] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 7.0700002 })
	return I[1]
end

return build
