-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/Prompts/ViewPermissionsRoles.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "ViewPermissionsRoles", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8) })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.5 })
		I[3] = new("ImageLabel", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = 0 })
		I[4] = new("ImageLabel", I[1], "Glow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16810775940"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.75, 1.75), ZIndex = -1 })
		I[5] = new("ScrollingFrame", I[1], "List", { Active = true, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740413"), CanvasSize = UDim2.fromScale(0, 0), MidImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740296"), Position = UDim2.new(0.5, 9, 0.15, 0), ScrollBarThickness = 10, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.new(0.9, 14, 0.8, 0), TopImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740150"), VerticalScrollBarInset = Enum.ScrollBarInset.Always })
			I[6] = new("Frame", I[5], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.new(1, -8, 1, -8), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[7] = new("UIListLayout", I[6], "Layout", { SortOrder = Enum.SortOrder.LayoutOrder })
				I[8] = new("Frame", I[6], "Description", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(0.975, 0.04) })
					I[9] = new("TextLabel", I[8], "Description", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1), Text = " • Strict map pool of only the most competitive maps", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 31), TextTransparency = 0.25, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
					I[10] = new("Frame", I[8], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.0410257), SizeConstraint = Enum.SizeConstraint.RelativeXX })
						I[11] = new("TextLabel", I[10], "Guide", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1000, 1), Text = " • Strict map pool of only the most competitive maps", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 31), TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
				I[12] = new("TextLabel", I[6], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.075), Size = UDim2.fromScale(1, 0.05), Text = "Gameplay", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 31), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3 })
		I[13] = new("ImageButton", I[1], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.925, 0.075), Size = UDim2.fromScale(0.125, 0.1) })
			I[14] = new("ImageLabel", I[13], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 50, 50), ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -2 })
				I[15] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(152, 152, 152)) }), Rotation = 90 })
			I[16] = new("ImageLabel", I[13], "Shine", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.75, Position = UDim2.new(0.5, 0, 0, 3), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, -6, 0.5, 0), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.35, ZIndex = -1 })
				I[17] = new("UIGradient", I[16], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3903559, 0.5625), NumberSequenceKeypoint.new(0.8208955, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[18] = new("ImageLabel", I[13], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17838290166"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.875, 0.6) })
		I[19] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.075), Size = UDim2.fromScale(0.7, 0.1), Text = "Roles", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(31, 31, 31), TextWrapped = true, ZIndex = 3 })
	return I[1]
end

return build
