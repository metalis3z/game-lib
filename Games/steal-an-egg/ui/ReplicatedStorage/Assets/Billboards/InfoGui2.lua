-- Generated from ui/ReplicatedStorage/Assets/Billboards/InfoGui2.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "InfoGui2", { Active = true, MaxDistance = 150, ResetOnSpawn = false, Size = UDim2.fromScale(7.6999998, 5.4000001) })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.5) })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
			I[4] = new("Frame", I[2], "Traits", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.6) })
				I[5] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[6] = new("ImageLabel", I[4], "Temp", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://92654347410499"), Size = UDim2.fromScale(1.1, 1.1), Visible = false })
					I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
				I[8] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", { AspectRatio = 3 })
			I[9] = new("Frame", I[2], "HP", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.65), Size = UDim2.fromScale(0.8, 0.8) }, { ["HoverSound"] = "" })
				I[10] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 232, 0)) }), Enabled = false, Rotation = 90 })
				I[11] = new("ImageLabel", I[9], "Green", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://79536815056224"), ImageTransparency = 0.4, Position = UDim2.fromScale(0.5000001, 0.0000009), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1.0000002, 0.9999992), TileSize = UDim2.fromScale(0.24, 2.5999999), ZIndex = 3 })
					I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 204, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 204, 0)) }) })
				I[13] = new("TextLabel", I[9], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "1,000 / 2,500 HP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 50 }, { ["Shadow"] = "" })
					I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 2 }, { ["ThicknessUDim"] = UDim.new(0, 2) })
				I[15] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectRatio = 10 })
				I[16] = new("ImageLabel", I[9], "Border", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 0.4, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.203, 2.0250001), ZIndex = 0 })
					I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 4 }, { ["ThicknessUDim"] = UDim.new(0, 4) })
						I[18] = new("UIGradient", I[17], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.2474049, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(98, 147, 0)) }), Enabled = false, Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4027432, 1), NumberSequenceKeypoint.new(0.5985038, 1), NumberSequenceKeypoint.new(1, 0) }) })
				I[19] = new("ImageLabel", I[9], "Red", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://79536815056224"), Position = UDim2.fromScale(1, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.24, 2.5999999) })
					I[20] = new("UIGradient", I[19], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 49, 52)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 49, 52)) }) })
				I[21] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 }, { ["ThicknessUDim"] = UDim.new(0, 2) })
			I[22] = new("TextLabel", I[2], "CharRarity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.2), Text = "Basic Block", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
				I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 2 }, { ["ThicknessUDim"] = UDim.new(0, 2) })
			I[24] = new("TextLabel", I[2], "CharName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.25), Text = "Basic Block", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[25] = new("UIStroke", I[24], "UIStroke", { Thickness = 2 }, { ["ThicknessUDim"] = UDim.new(0, 2) })
	return I[1]
end

return build
