-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/Pages/Contracts.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Contracts", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.6, 150, 0.5, 125) })
		I[2] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.25 })
		I[3] = new("ImageButton", I[1], "Modal", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Modal = true, Selectable = false, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
		I[4] = new("ScrollingFrame", I[1], "List", { Active = true, AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740413"), ClipsDescendants = false, MidImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740296"), Position = UDim2.new(0.5, 9, 0, 0), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarImageTransparency = 0.5, ScrollBarThickness = 10, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.new(0.875, 14, 1, 0), TopImageContent = Content.fromUri("http://www.roblox.com/asset/?id=5226740150"), VerticalScrollBarInset = Enum.ScrollBarInset.Always })
			I[5] = new("Frame", I[4], "Container", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.new(1, -8, 1, -8), SizeConstraint = Enum.SizeConstraint.RelativeXX })
				I[6] = new("UIListLayout", I[5], "Layout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder })
		I[7] = new("ImageButton", I[1], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1.025, 0.05), Size = UDim2.fromScale(0.1, 0.067) })
			I[8] = new("ImageLabel", I[7], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 50, 50), ImageContent = Content.fromUri("rbxassetid://17277885692"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.5, ZIndex = -2 })
				I[9] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(152, 152, 152)) }), Rotation = 90 })
			I[10] = new("ImageLabel", I[7], "Shine", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://17277885692"), ImageTransparency = 0.75, Position = UDim2.new(0.5, 0, 0, 3), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, -6, 0.5, 0), SliceCenter = Rect.new(15, 15, 16, 16), SliceScale = 0.35, ZIndex = -1 })
				I[11] = new("UIGradient", I[10], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3903559, 0.5625), NumberSequenceKeypoint.new(0.8208955, 1), NumberSequenceKeypoint.new(1, 1) }) })
			I[12] = new("ImageLabel", I[7], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://17838290166"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.875, 0.6) })
	return I[1]
end

return build
