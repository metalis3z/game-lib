-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/GiftProductSlot.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "GiftProductSlot", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.1125) })
		I[2] = new("ImageLabel", I[1], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://10975249705"), Position = UDim2.fromScale(0.075, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.875, 0.875), SizeConstraint = Enum.SizeConstraint.RelativeYY })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[4] = new("ImageButton", I[1], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.fromScale(0.9125, 0.5), Size = UDim2.fromScale(0.15, 0.75) })
			I[5] = new("ImageLabel", I[4], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://113844621753627"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.4, 1) })
			I[6] = new("ImageLabel", I[4], "Shine", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.new(0.5, 0, 0, 3), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, -6, 0.5, 0), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.25, ZIndex = -1 })
				I[7] = new("UIGradient", I[6], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3903559, 0.5625), NumberSequenceKeypoint.new(0.8208955, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[8] = new("ImageLabel", I[4], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -2 })
				I[9] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 89, 255)), ColorSequenceKeypoint.new(0.1799308, Color3.fromRGB(6, 115, 249)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 208, 255)) }), Rotation = -90 })
			I[10] = new("ImageLabel", I[4], "GiftTicket", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://73010289971468"), Position = UDim2.fromScale(0, 0.75), Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[11] = new("TextLabel", I[10], "Quantity", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7, 0.7), Size = UDim2.fromScale(0.7, 0.4), Text = "×4", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 2, Transparency = 0.875 })
		I[13] = new("TextLabel", I[1], "DisplayName", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.5), Size = UDim2.fromScale(0.65, 0.45), Text = "Standard Weapons Bundle", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 3), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
		I[14] = new("ImageLabel", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -1 }, nil, { "UIBackground" })
			I[15] = new("UIGradient", I[14], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0.5) }) })
	return I[1]
end

return build
