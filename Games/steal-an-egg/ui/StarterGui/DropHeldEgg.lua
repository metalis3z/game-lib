-- Generated from ui/StarterGui/DropHeldEgg.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DropHeldEgg", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageButton", I[1], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126875624960627"), Position = UDim2.fromScale(0.4998998, 0.850655), PressedImageContent = Content.fromUri("rbxassetid://124217248402069"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.1465756, 0, 0.1097714, 25), SliceCenter = Rect.new(20, 20, 80, 80), ZIndex = 6 })
			I[3] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5831006, 0.4999996), Size = UDim2.fromScale(0.7337989, 0.6), Text = "Drop", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 6 })
				I[4] = new("UIStroke", I[3], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[5] = new("UIGradient", I[2], "red gradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }), Rotation = -90 })
			I[6] = new("ImageLabel", I[2], "ConsoleButton", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxasset://textures/ui/Controls/DefaultController/ButtonY@2x.png"), Position = UDim2.fromScale(1, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 0.4), Visible = false, ZIndex = 10 }, { ["ConsoleButton"] = "ButtonY" })
				I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
				I[8] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[9] = new("UIStroke", I[6], "UIStroke", { Thickness = 2 })
			I[10] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106896750589019"), Position = UDim2.fromScale(0.2436231, 0.4999996), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.7, 0.6), ZIndex = 6 })
				I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
			I[12] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 3.218827 })
			I[13] = new("UISizeConstraint", I[2], "UISizeConstraint", { MinSize = Vector2.new(155, 90) })
			I[14] = new("ImageLabel", I[2], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://131176354845909"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(0.92, 0.84), TileSize = UDim2.fromScale(0.3, 1), Visible = false, ZIndex = -1 })
	return I[1]
end

return build
