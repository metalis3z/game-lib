-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/BowCharge.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BowCharge", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.5, -24, 0.5, 24), Size = UDim2.fromOffset(96, 48), Visible = false })
		I[2] = new("TextLabel", I[1], "Damage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.25), RichText = true, Size = UDim2.fromScale(1, 0.5), Text = "50%", TextColor3 = Color3.fromRGB(100, 255, 50), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[3] = new("ImageLabel", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=7730822940"), Position = UDim2.fromScale(0.5, 0.75), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 0.25), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.25, ZIndex = 0 })
			I[4] = new("Frame", I[3], "Divider2", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.875, BorderSizePixel = 0, Position = UDim2.fromScale(0.25, 0), Size = UDim2.new(0, 1, 1, 0), ZIndex = 2 })
			I[5] = new("Frame", I[3], "Divider3", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.875, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(0, 1, 1, 0), ZIndex = 2 })
			I[6] = new("Frame", I[3], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.6578125, 1) })
				I[7] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
			I[8] = new("Frame", I[3], "Effect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false })
				I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
				I[10] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(255, 127, 0), Thickness = 4 })
			I[11] = new("Frame", I[3], "KeyWhite", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = -1 })
				I[12] = new("ImageLabel", I[11], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=7730822940"), Position = UDim2.new(0.9, 0, 1, -8), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.1, 0, 0.75, 8), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.25, ZIndex = 0 })
				I[13] = new("ImageLabel", I[11], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=7730822940"), Position = UDim2.new(0.75, 0, 1, -8), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(0.1, 0, 0.75, 8), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.25, ZIndex = 0 })
				I[14] = new("Frame", I[11], "Circle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(-0.1, -2, 0.5, 0), Size = UDim2.new(1.5, -2, 1.5, -2), SizeConstraint = Enum.SizeConstraint.RelativeYY })
					I[15] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[16] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 10 })
				I[17] = new("UIStroke", I[11], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
				I[18] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0, 4), BottomRightRadius = UDim.new(0, 4), TopLeftRadius = UDim.new(0, 4), TopRightRadius = UDim.new(0, 4) })
			I[19] = new("Frame", I[3], "KeyColor", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
				I[20] = new("Frame", I[19], "Circle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(-0.1, -2, 0.5, 0), Size = UDim2.new(1.5, 4, 1.5, 4), SizeConstraint = Enum.SizeConstraint.RelativeYY })
					I[21] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[22] = new("UIStroke", I[20], "UIStroke", { Color = Color3.fromRGB(255, 215, 0), Thickness = 4 })
	return I[1]
end

return build
