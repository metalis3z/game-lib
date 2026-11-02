-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Base.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Base", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.425, 0.3), Size = UDim2.fromOffset(150, 300) })
		I[2] = new("ImageLabel", I[1], "pointer", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://93275307650678"), Position = UDim2.fromOffset(30, 30), Size = UDim2.fromOffset(40, 40), Visible = false })
			I[3] = new("ImageLabel", I[2], "pointer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(59, 177, 252), ImageContent = Content.fromUri("rbxassetid://93275307650678"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, 15, 1, 15), ZIndex = -1 })
		I[4] = new("UIScale", I[1], "UIScale")
		I[5] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(27, 30, 42), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3 })
			I[7] = new("Frame", I[5], "Blocks", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
				I[8] = new("UIListLayout", I[7], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder })
				I[9] = new("UIPadding", I[7], "UIPadding", { PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16), PaddingTop = UDim.new(0, 6) })
			I[10] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
		I[11] = new("ImageLabel", I[1], "shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://136933888934138"), ImageTransparency = 0.85, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 35, 1, 35), SliceCenter = Rect.new(50, 50, 150, 150), SliceScale = 0.8, ZIndex = -1 })
	return I[1]
end

return build
