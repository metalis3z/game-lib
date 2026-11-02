-- Generated from ui/ServerStorage/SlowModeButton_BeforeRestyle.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "SlowModeButton_BeforeRestyle", { BackgroundColor3 = Color3.fromRGB(40, 44, 56), BackgroundTransparency = 0.12, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromOffset(0, 6), Size = UDim2.new(1, 0, 0, 44), Text = "" })
		I[2] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.07, 0.5), RichText = true, Size = UDim2.fromScale(0.5, 0.6), Text = "Slow Mode", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
			I[3] = new("UIStroke", I[2], "Outer", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.12 })
		I[4] = new("UIStroke", I[1], "Outer", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(22, 26, 33), Thickness = 3 })
		I[5] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
		I[6] = new("Frame", I[1], "ToggleOn", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, LayoutOrder = 2, Position = UDim2.fromScale(0.95, 0.5), Selectable = true, Size = UDim2.fromScale(0.36, 0.64), ZIndex = 2 })
			I[7] = new("UIGradient", I[6], "UiGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 110)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 40, 50)) }), Rotation = 90 })
			I[8] = new("UIStroke", I[6], "Outer", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(22, 26, 33), Thickness = 3 })
			I[9] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
			I[10] = new("ImageLabel", I[6], "Bevel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://136393561370347"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(200, 200, 220, 220), SliceScale = 0.1, ZIndex = 0 })
			I[11] = new("TextLabel", I[6], "State", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.18), Size = UDim2.fromScale(0.44, 0.64), Text = "OFF", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 3 })
				I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 2 })
			I[13] = new("Frame", I[6], "Knob", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.26, 0.5), Size = UDim2.fromScale(0.44, 0.82), ZIndex = 4 })
				I[14] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint")
				I[15] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
				I[16] = new("UIStroke", I[13], "UIStroke", { Thickness = 2.5 })
				I[17] = new("UIGradient", I[13], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 204, 214)) }), Rotation = 90 })
		I[18] = new("ImageLabel", I[1], "Bevel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://136393561370347"), ImageTransparency = 0.82, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(200, 200, 220, 220), SliceScale = 0.1, ZIndex = 0 })
	return I[1]
end

return build
