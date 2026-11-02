-- Generated from ui/StarterPlayer/StarterPlayerScripts/GUI/BackpackController/Main/EquipBest.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "EquipBest", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, -0.5), Size = UDim2.fromScale(1.4, 0.5), Visible = false, ZIndex = -100 })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 2.5 })
		I[3] = new("TextLabel", I[1], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.85, 0.7), Text = "Equip Best", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = -90 })
			I[4] = new("UIGradient", I[3], "UIGradient")
			I[5] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(0, 88, 6), Thickness = 1.2162963 }, { ["oldp_Thickness"] = 1.6 })
		I[6] = new("ImageLabel", I[1], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131176354845909"), ImageTransparency = 0.72, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000001, 0.9999999), TileSize = UDim2.fromScale(0.8, 2), Visible = false, ZIndex = -100 })
		I[7] = new("UISizeConstraint", I[1], "UISizeConstraint", { MaxSize = Vector2.new(math.huge, 100) })
		I[8] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(0, 88, 6), Enabled = false, Thickness = 1.900463 }, { ["oldp_Thickness"] = 2.5 })
		I[9] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(17, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 181, 15)) }), Rotation = 90 })
		I[10] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
		I[11] = new("UIScale", I[1], "ButtonUIScale")
		I[12] = new("ImageLabel", I[1], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://73214197551985"), Interactable = false, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = true, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(64, 64, 64, 64), SliceScale = 0.15, ZIndex = -100 })
			I[13] = new("ImageLabel", I[12], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131176354845909"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000001, 0.9999999), TileSize = UDim2.fromScale(0.5, 1.25), Visible = false, ZIndex = 51 })
			I[14] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 249, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 236, 0)) }), Rotation = 90 })
	return I[1]
end

return build
