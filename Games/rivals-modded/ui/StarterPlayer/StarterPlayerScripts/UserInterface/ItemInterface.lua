-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/ItemInterface.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "ItemInterface", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
		I[2] = new("Frame", I[1], "Mouse", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, -18), Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "Scope", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
				I[5] = new("Frame", I[3], "Reticle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[6] = new("Frame", I[5], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
						I[7] = new("Frame", I[6], "Horizontal", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.5, 0, 0, 2) })
						I[8] = new("Frame", I[6], "Vertical", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0, 2, 0.5, 0) })
						I[9] = new("Frame", I[6], "Dot", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 50, 50), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.008, 0.008) })
							I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.5, 0), BottomRightRadius = UDim.new(0.5, 0), TopLeftRadius = UDim.new(0.5, 0), TopRightRadius = UDim.new(0.5, 0) })
						I[11] = new("Frame", I[6], "Left", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.25, 0.5), Size = UDim2.new(0.5, 0, 0, 4) })
						I[12] = new("Frame", I[6], "Right", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.75, 0.5), Size = UDim2.new(0.5, 0, 0, 4) })
						I[13] = new("Frame", I[6], "Top", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.25), Size = UDim2.new(0, 4, 0.5, 0) })
						I[14] = new("Frame", I[6], "Bottom", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.new(0, 4, 0.5, 0) })
				I[15] = new("Frame", I[3], "Blur", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
					I[16] = new("ImageLabel", I[15], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(15, 15, 15), ImageContent = Content.fromUri("rbxassetid://13466088854"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[17] = new("Frame", I[16], "Bottom", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 1, -1), Size = UDim2.fromScale(6, 6) })
						I[18] = new("Frame", I[16], "Left", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BorderSizePixel = 0, Position = UDim2.new(0, 1, 0.5, 0), Size = UDim2.fromScale(6, 6) })
						I[19] = new("Frame", I[16], "Right", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BorderSizePixel = 0, Position = UDim2.new(1, -1, 0.5, 0), Size = UDim2.fromScale(6, 6) })
						I[20] = new("Frame", I[16], "Top", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0, 1), Size = UDim2.fromScale(6, 6) })
				I[21] = new("Frame", I[3], "Circle", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[22] = new("ImageLabel", I[21], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(15, 15, 15), ImageContent = Content.fromUri("rbxassetid://13466076605"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
						I[23] = new("Frame", I[22], "Bottom", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(6, 6) })
						I[24] = new("Frame", I[22], "Left", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(6, 6) })
						I[25] = new("Frame", I[22], "Right", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(6, 6) })
						I[26] = new("Frame", I[22], "Top", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(15, 15, 15), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(6, 6) })
			I[27] = new("Frame", I[2], "Cooldowns", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.new(0.5, 48, 0.5, 48), Size = UDim2.fromOffset(48, 48) })
				I[28] = new("UIListLayout", I[27], "Layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
		I[29] = new("ImageLabel", I[1], "AimingVignette", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://14824249410"), ImageTransparency = 1, Position = UDim2.fromScale(0.5, 1), Size = UDim2.new(1, 0, 1, 36), ZIndex = 2 })
		I[30] = new("ImageLabel", I[1], "SpeedLinesThin", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16469372946"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1), Visible = false })
		I[31] = new("ImageLabel", I[1], "SpeedLinesThick", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16469373111"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1), Visible = false })
	return I[1]
end

return build
