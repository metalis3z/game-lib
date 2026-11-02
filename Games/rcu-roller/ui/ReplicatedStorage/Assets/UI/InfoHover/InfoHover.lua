-- Generated from ui/ReplicatedStorage/Assets/UI/InfoHover/InfoHover.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "InfoHover", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(0.1597194, 0.4448094), Visible = false, ZIndex = 1500 })
		I[2] = new("Frame", I[1], "Main", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.4313967), ZIndex = 1500 })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.08, 0), BottomRightRadius = UDim.new(0.08, 0), TopLeftRadius = UDim.new(0.08, 0), TopRightRadius = UDim.new(0.08, 0) })
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5.5 })
			I[5] = new("ImageLabel", I[2], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://16022483002"), ImageTransparency = 0.97, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(960, 540), ZIndex = 1500 })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
		I[7] = new("ImageLabel", I[1], "Shadow", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://15555380274"), ImageTransparency = 0.7, Position = UDim2.fromScale(0.5, -0.16), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1.5, 1.309), SliceCenter = Rect.new(160, 160, 864, 864), ZIndex = 1499 })
		I[8] = new("Frame", I[1], "Holder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), ZIndex = 1500 })
			I[9] = new("UIListLayout", I[8], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.005, 0), SortOrder = Enum.SortOrder.LayoutOrder })
		I[10] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 0.638021 })
	return I[1]
end

return build
