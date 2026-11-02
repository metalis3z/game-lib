-- Generated from ui/StarterGui/Rewards.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Rewards", { DisplayOrder = 2, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.01), Size = UDim2.fromScale(0.3, 0.1) })
			I[3] = new("ImageButton", I[2], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Selectable = false, Size = UDim2.fromScale(1, 1) })
				I[4] = new("ImageLabel", I[3], "InletTexture", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://103855926983380"), ImageTransparency = 0.72, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1.3274567), TileSize = UDim2.fromScale(0.175, 0.525), Visible = false, ZIndex = -1 })
				I[5] = new("ImageLabel", I[3], "BevelEffect", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://74603642649742"), ImageTransparency = 0.08, Position = UDim2.fromScale(0.4999999, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.9999999, 0.9999999), SliceCenter = Rect.new(13, 13, 129, 129), SliceScale = 0.25, ZIndex = -1 })
				I[6] = new("UIStroke", I[3], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(20, 48, 0), StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.045, ZIndex = 2 })
				I[7] = new("ImageLabel", I[3], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://101419934580189"), Position = UDim2.fromScale(0.8818631, 0.4851851), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.167, 0.709), Visible = false })
				I[8] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 3.9183209 })
				I[9] = new("Frame", I[3], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[10] = new("TextLabel", I[9], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5927802, 0.5), Size = UDim2.fromScale(0.8144407, 1.0637285), Text = "UNLOCK INGAME MODERATOR!", TextColor3 = Color3.fromRGB(252, 252, 252), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 7 })
						I[11] = new("UIStroke", I[10], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.3 })
					I[12] = new("ImageLabel", I[9], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://76913704941705"), Position = UDim2.fromScale(0.0979894, 0.427999), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2, 0.9), Visible = false })
					I[13] = new("UIListLayout", I[9], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[14] = new("ImageLabel", I[3], "Pattern", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90325592797235"), ImageTransparency = 0.75, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(75, 75), ZIndex = -1 })
				I[15] = new("UIGradient", I[3], "ModdedRainbow", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255, 170, 0)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 127)) }), Offset = Vector2.new(0, 0.1), Rotation = -16 })
			I[16] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.8099999 })
			I[17] = new("ImageLabel", I[2], "Sunburst", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://94777715473697"), ImageTransparency = 0.46, Position = UDim2.fromScale(0.4816246, 0.4827883), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(2, 2.2), ZIndex = -111 })
	return I[1]
end

return build
