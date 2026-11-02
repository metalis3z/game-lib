-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/EquipmentButtonSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "EquipmentButtonSlot", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Size = UDim2.fromScale(1, 0.2) })
		I[2] = new("ImageButton", I[1], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13197584241"), Position = UDim2.fromScale(0.2, 0.5), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(4, 4), SizeConstraint = Enum.SizeConstraint.RelativeYY, SliceCenter = Rect.new(15, 15, 16, 16), ZIndex = 0 })
			I[4] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.7, 0.4), Text = "Assault Rifle", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.5, TextWrapped = true })
				I[5] = new("Frame", I[4], "Notification", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 124, 0.5, 0), Size = UDim2.fromScale(1.125, 1.125), SizeConstraint = Enum.SizeConstraint.RelativeYY })
					I[6] = new("TextLabel", I[5], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.75, 0.875), Text = "3", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[7] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[8] = new("ImageLabel", I[2], "LockedLeft", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17229230506"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.275, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.875, 0.375), SizeConstraint = Enum.SizeConstraint.RelativeYY, SliceCenter = Rect.new(15, 15, 16, 16), ZIndex = 0 })
			I[9] = new("ImageLabel", I[2], "LockedRight", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17229230506"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.725, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.875, 0.375), SizeConstraint = Enum.SizeConstraint.RelativeYY, SliceCenter = Rect.new(15, 15, 16, 16), ZIndex = 0 })
			I[10] = new("ImageLabel", I[2], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.975, 0.9), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, Visible = false, ZIndex = -1 })
				I[11] = new("UIGradient", I[10], "UIGradient", { Rotation = 180, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3019518, 0.5375), NumberSequenceKeypoint.new(1, 1) }) })
	return I[1]
end

return build
