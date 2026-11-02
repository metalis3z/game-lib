-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/PickWeapons.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "PickWeapons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.4, 100, 0.4, 100) })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.5 })
		I[3] = new("ScrollingFrame", I[1], "List", { Active = true, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740413"), CanvasSize = UDim2.fromScale(0, 0), ClipsDescendants = false, MidImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740296"), Position = UDim2.fromScale(0.5, 0.25), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarImageTransparency = 0.5, ScrollBarThickness = 10, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(1, 1), TopImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740150"), VerticalScrollBarInset = Enum.ScrollBarInset.Always })
			I[4] = new("Frame", I[3], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[5] = new("UIGridLayout", I[4], "Layout", { CellPadding = UDim2.fromScale(0, 0), CellSize = UDim2.fromScale(0.2, 0.2), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
		I[6] = new("ImageButton", I[1], "Modal", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Modal = true, Selectable = false, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
		I[7] = new("Frame", I[1], "ChosenWeapons", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.125), Size = UDim2.fromScale(0.133, 0.2) })
			I[8] = new("UIListLayout", I[7], "Layout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[9] = new("Frame", I[1], "Header", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0, -10), Size = UDim2.fromScale(0.625, 0.1), ZIndex = 0 })
			I[10] = new("UIListLayout", I[9], "Layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[11] = new("Frame", I[9], "FreeWeapons", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Position = UDim2.new(0.5, 0, 0, -10), Size = UDim2.fromScale(1, 1.5), ZIndex = 0 })
				I[12] = new("ImageLabel", I[11], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(88, 32, 255), ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -2 })
				I[13] = new("TextLabel", I[11], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.35), Size = UDim2.fromScale(0.875, 0.6), Text = "LIMITED TIME EVENT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
					I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 2, Transparency = 0.875 })
				I[15] = new("TextLabel", I[11], "Description", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.875, 0.25), Text = "Locked weapons are free to use for a limited time!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.25, TextWrapped = true, ZIndex = 3 })
					I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 2, Transparency = 0.875 })
				I[17] = new("ImageLabel", I[11], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17899510254"), ImageTransparency = 0.75, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -1 })
					I[18] = new("UICorner", I[17], "UICorner")
			I[19] = new("Frame", I[9], "Map", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.5, 0, 0, -10), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
				I[20] = new("ImageLabel", I[19], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -1 })
					I[21] = new("UIGradient", I[20], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.125, 0.375), NumberSequenceKeypoint.new(0.375, 0.05), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(0.625, 0.05), NumberSequenceKeypoint.new(0.875, 0.375), NumberSequenceKeypoint.new(1, 1) }) })
				I[22] = new("TextLabel", I[19], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.875, 0.7), Text = "Map: Backrooms", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
	return I[1]
end

return build
