-- Generated from ui/ReplicatedStorage/InventoryAssets/CrateFrame.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "CrateFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.0434679, 0.0457873), Size = UDim2.fromScale(1, 1) })
		I[2] = new("Frame", I[1], "ItemHolder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.0000002, 0.4429768), Size = UDim2.fromScale(1.0063636, 0.6627358) })
			I[3] = new("UIGridLayout", I[2], "UIGridLayout", { CellPadding = UDim2.fromScale(0.02, 0.03), CellSize = UDim2.fromScale(0.25, 0.3), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
		I[5] = new("TextLabel", I[1], "CrateName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0584039, 0.883234), Size = UDim2.fromScale(0.91889, 0.2879909), Text = "Rainbow Scooter", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
			I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(67, 67, 67), Thickness = 2 })
		I[7] = new("Frame", I[1], "ItemHolder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.2), Size = UDim2.fromScale(1, 0.65) })
			I[8] = new("UIGridLayout", I[7], "UIGridLayout", { CellPadding = UDim2.fromScale(0.02, 0.03), CellSize = UDim2.fromScale(0.25, 0.3), HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[9] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint")
		I[10] = new("Frame", I[1], "CrateImageHolder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-0.095883, 0), Size = UDim2.fromScale(1.1427121, 1.0941278) })
			I[11] = new("ViewportFrame", I[10], "Icon", { BackgroundColor3 = Color3.fromRGB(200, 200, 200), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
		I[12] = new("Frame", I[1], "Right Side", { BackgroundColor3 = Color3.fromRGB(179, 179, 179), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = -1 })
			I[13] = new("UIGradient", I[12], "UIGradient", { Rotation = 45 })
			I[14] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
			I[15] = new("Frame", I[12], "TileClip", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.fromScale(0.4999999, 0.5057453), Size = UDim2.fromScale(0.9999999, 0.9885097) })
				I[16] = new("ImageLabel", I[15], "Tile", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4618197225"), ImageTransparency = 0.967, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(5, 5), SliceScale = 0, TileSize = UDim2.fromScale(0.125, 0.125) })
					I[17] = new("UIAspectRatioConstraint", I[16], "UIAspectRatioConstraint")
				I[18] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0, 15), BottomRightRadius = UDim.new(0, 15), TopLeftRadius = UDim.new(0, 15), TopRightRadius = UDim.new(0, 15) })
		I[19] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint")
		I[20] = new("TextButton", I[1], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 100, Size = UDim2.fromScale(1, 1), TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1.02 })
	return I[1]
end

return build
