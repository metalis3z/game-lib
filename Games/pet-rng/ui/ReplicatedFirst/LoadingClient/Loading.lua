-- Generated from ui/ReplicatedFirst/LoadingClient/Loading.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Loading", { DisplayOrder = 5, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "LoadingFrame", { BackgroundColor3 = Color3.fromRGB(31, 31, 31), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("ImageLabel", I[2], "Pattern", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://16662610657"), ImageTransparency = 0.85, Position = UDim2.fromScale(0.5, 0.498995), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(5, 5), SliceCenter = Rect.new(0, 256, 0, 256), TileSize = UDim2.fromOffset(45, 45) })
			I[4] = new("Frame", I[2], "LoadingBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(84, 84, 84), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.8771357), Size = UDim2.fromScale(0.4047497, 0.0581706) })
				I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[6] = new("UIStroke", I[4], "UIStroke", { Thickness = 5 })
				I[7] = new("Frame", I[4], "Bar", { BackgroundColor3 = Color3.fromRGB(85, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0005286, -0.0040417), Size = UDim2.fromScale(0.2611271, 1) })
					I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[9] = new("TextLabel", I[4], "Percentage", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0243902, 0.1090909), Size = UDim2.fromScale(0.9512194, 0.7454546), Text = "100/100%", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 4 })
			I[11] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4023666, 0.7833075), Size = UDim2.fromScale(0.1919127, 0.0491583), Text = "Loading Assets...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 4 })
			I[13] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16715549234"), Position = UDim2.fromScale(0.4999368, 0.4513081), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1768767, 0.3263797) })
				I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
				I[15] = new("UIStroke", I[13], "UIStroke", { Thickness = 5 })
				I[16] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint")
			I[17] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.05), Size = UDim2.fromScale(1, 0.058), Text = "Tip: Craft Extra Pets For Boosts!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 4 })
			I[19] = new("ImageButton", I[2], "Skip", { Active = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(85, 255, 0), ImageContent = Content.fromUri("rbxassetid://14874844571"), Position = UDim2.fromScale(0.4539447, 0.9218565), Selectable = false, Size = UDim2.fromScale(0.0914164, 0.067474) })
				I[20] = new("TextLabel", I[19], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.491, 0.468), Size = UDim2.fromScale(0.8718938, 0.5174398), Text = "Skip", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
					I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 4 })
				I[22] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint", { AspectRatio = 2.5 })
				I[23] = new("TextLabel", I[19], "TextLabel2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4992107, 0.4883809), Size = UDim2.fromScale(0.8718938, 0.5174398), Text = "Skip", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 4 })
	return I[1]
end

return build
