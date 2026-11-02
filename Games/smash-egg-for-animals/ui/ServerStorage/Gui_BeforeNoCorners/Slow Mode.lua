-- Generated from ui/ServerStorage/Gui_BeforeNoCorners/Slow Mode.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "Slow Mode", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.2338528, 0.701978), Size = UDim2.fromScale(0.4677056, 0.1093586), Text = "" })
		I[2] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(2.0302353, 0.49547), RichText = true, Size = UDim2.fromScale(0.9464882, 0.6542285), Text = "Slow Mode", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
			I[3] = new("UIStroke", I[2], "Outer", { LineJoinMode = Enum.LineJoinMode.Miter, StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.1 })
		I[4] = new("UIStroke", I[1], "Outer", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(22, 26, 33), Thickness = 3 })
		I[5] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
		I[6] = new("Frame", I[1], "ToggleOn", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, LayoutOrder = 2, Position = UDim2.fromScale(0.7922418, 0.5000001), Selectable = true, Size = UDim2.fromScale(0.2750832, 0.6999999) })
			I[7] = new("UIGradient", I[6], "UiGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(51, 213, 78)), ColorSequenceKeypoint.new(1, Color3.fromRGB(195, 255, 0)) }), Rotation = -90 })
			I[8] = new("UIStroke", I[6], "Outer", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(22, 26, 33), Thickness = 3 })
			I[9] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.01, 0), BottomRightRadius = UDim.new(0.01, 0), TopLeftRadius = UDim.new(0.01, 0), TopRightRadius = UDim.new(0.01, 0) })
			I[10] = new("ImageLabel", I[6], "Bevel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://136393561370347"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(200, 200, 220, 220), SliceScale = 0.1, ZIndex = 0 })
		I[11] = new("ImageLabel", I[1], "Bevel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://136393561370347"), ImageTransparency = 0.82, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(200, 200, 220, 220), SliceScale = 0.1, ZIndex = 0 })
	return I[1]
end

return build
