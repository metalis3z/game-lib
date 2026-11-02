-- Generated from ui/StarterGui/P2W.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "P2W", { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Second", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9847105, 0.54781), Size = UDim2.fromScale(0.2430437, 0.339295) })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 15), SortOrder = Enum.SortOrder.LayoutOrder })
			I[4] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 0.8868067, AspectType = Enum.AspectType.ScaleWithParentSize, DominantAxis = Enum.DominantAxis.Height })
			I[5] = new("TextButton", I[2], "Sanity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(238, 228, 218), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6188583, 0.0916017), Size = UDim2.fromScale(0.7622839, 0.1832037), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("ImageLabel", I[5], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://118449132151095"), ImageTransparency = 0.78, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.175, 0.6), ZIndex = 2 })
					I[7] = new("UICorner", I[6], "UICorner")
					I[8] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint", { AspectRatio = 3.6898737 })
				I[9] = new("Frame", I[5], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4902044, 0.4999996), Size = UDim2.fromScale(1.0051849, 0.7750002) })
					I[10] = new("TextLabel", I[9], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5031891, 0.5), Size = UDim2.fromScale(0.9344673, 1), Text = "INF Sanity", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 3 })
						I[11] = new("TextLabel", I[10], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4996795, 0.45), Size = UDim2.fromScale(0.986796, 1), Text = "INF Sanity", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 })
							I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(221, 63, 165)), ColorSequenceKeypoint.new(0.1111111, Color3.fromRGB(248, 28, 46)), ColorSequenceKeypoint.new(0.2222222, Color3.fromRGB(221, 109, 11)), ColorSequenceKeypoint.new(0.3333333, Color3.fromRGB(176, 226, 2)), ColorSequenceKeypoint.new(0.4444444, Color3.fromRGB(103, 254, 65)), ColorSequenceKeypoint.new(0.5555556, Color3.fromRGB(20, 253, 151)), ColorSequenceKeypoint.new(0.6666667, Color3.fromRGB(44, 189, 193)), ColorSequenceKeypoint.new(0.7777778, Color3.fromRGB(103, 105, 221)), ColorSequenceKeypoint.new(0.8888889, Color3.fromRGB(162, 20, 248)), ColorSequenceKeypoint.new(1, Color3.fromRGB(221, 63, 165)) }) }, nil, { "InfiniteGradient" })
							I[13] = new("UIStroke", I[11], "UIStroke")
							I[14] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint", { AspectRatio = 4.4131336 })
						I[15] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 4.4721847 })
					I[16] = new("UIListLayout", I[9], "1", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
					I[17] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint", { AspectRatio = 4.7858119 })
				I[18] = new("UIGradient", I[5], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(236, 0, 188)), ColorSequenceKeypoint.new(0.1111111, Color3.fromRGB(255, 15, 54)), ColorSequenceKeypoint.new(0.2222222, Color3.fromRGB(253, 134, 4)), ColorSequenceKeypoint.new(0.3333333, Color3.fromRGB(186, 235, 0)), ColorSequenceKeypoint.new(0.4444444, Color3.fromRGB(56, 255, 21)), ColorSequenceKeypoint.new(0.5555556, Color3.fromRGB(5, 253, 137)), ColorSequenceKeypoint.new(0.6666667, Color3.fromRGB(0, 186, 235)), ColorSequenceKeypoint.new(0.7777778, Color3.fromRGB(18, 50, 255)), ColorSequenceKeypoint.new(0.8888889, Color3.fromRGB(139, 3, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 0, 188)) }) }, nil, { "InfiniteGradient" })
				I[19] = new("UIStroke", I[5], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2.5 })
					I[20] = new("UIGradient", I[19], "ModdedRainbow", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 55, 85)), ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 180, 55)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 245, 80)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 255, 120)), ColorSequenceKeypoint.new(0.66, Color3.fromRGB(60, 220, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(135, 90, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 65, 210)) }), Offset = Vector2.new(0, 0.1), Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 1), NumberSequenceKeypoint.new(1, 0.5375) }) })
				I[21] = new("UICorner", I[5], "UICorner")
				I[22] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 3.6898737 })
	return I[1]
end

return build
