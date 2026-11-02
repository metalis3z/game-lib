-- Generated from ui/ReplicatedStorage/Assets/UI/PlotUpgrade/FirstUpgrade.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "FirstUpgrade", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.35), Selectable = false, Size = UDim2.fromScale(0.8, 1) })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://84780445803147"), Position = UDim2.fromScale(0.02, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.8, 0.8), Visible = false })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
		I[4] = new("TextLabel", I[1], "Cost", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.65, 0.8), Text = "$10M", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 3 })
		I[6] = new("CanvasGroup", I[1], "CanvasGroup", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -1 })
			I[7] = new("ImageLabel", I[6], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103855926983380"), ImageTransparency = 0.39, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.2, 0.4), ZIndex = 2 })
			I[8] = new("ImageLabel", I[6], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74603642649742"), ImageTransparency = 0.21, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.25, ZIndex = 2 })
		I[9] = new("UIStroke", I[1], "UIStroke", { Thickness = 4 })
		I[10] = new("Frame", I[1], "ProgressFill", { BackgroundColor3 = Color3.fromRGB(4, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = -14 })
		I[11] = new("UIGradient", I[1], "UIGradient")
	return I[1]
end

return build
