-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/AutoPoop.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "AutoPoop", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 43, 43), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1000, Position = UDim2.fromScale(0.5, -0.6), Size = UDim2.fromScale(1.633, 0.6), ZIndex = -2 })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
		I[3] = new("TextLabel", I[1], "Label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.7), Text = "AUTO", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 0 })
			I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 1.6 })
			I[5] = new("UIGradient", I[3], "UIGradient")
		I[6] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 93, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 34, 86)) }), Enabled = false, Rotation = 90 })
		I[7] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 2.5 })
		I[8] = new("UISizeConstraint", I[1], "UISizeConstraint", { MaxSize = Vector2.new(math.huge, 100) })
		I[9] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(57, 57, 57), Thickness = 2.5 })
			I[10] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 93, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 34, 86)) }), Rotation = 90 })
		I[11] = new("ImageLabel", I[1], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131176354845909"), ImageTransparency = 0.72, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000001, 0.9999999), TileSize = UDim2.fromScale(0.8, 2), ZIndex = -1 })
	return I[1]
end

return build
