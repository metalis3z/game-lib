-- Generated from ui/StarterGui/UpgradeBase.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "UpgradeBase", { ClipsDescendants = true, Face = Enum.NormalId.Right, LightInfluence = 1, MaxDistance = 1000, PixelsPerStud = 75, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "Slots", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.94), Size = UDim2.fromScale(0.95, 0.2), Text = "1/30 Slots", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 8.1420002 })
			I[4] = new("TextLabel", I[2], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(1, 1), Text = "1/30 Slots", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[5] = new("UIStroke", I[4], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5.5 })
			I[6] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5.5 })
		I[7] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.714 })
		I[8] = new("TextButton", I[1], "Upgrade", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Selectable = false, Size = UDim2.fromScale(0.7, 0.3), Text = "", ZIndex = 11 }, nil, { "Button" })
			I[9] = new("ImageLabel", I[8], "Lines", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://70945982360079"), ImageTransparency = 0.95, Position = UDim2.fromScale(0.1, 0.5), Size = UDim2.fromScale(0.25, 1), ZIndex = 3 })
			I[10] = new("ImageLabel", I[8], "Studs", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://85697657610499"), ImageTransparency = 0.31, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.332, 1.3), ZIndex = 0 })
			I[11] = new("ImageLabel", I[8], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16756014301"), ImageTransparency = 0.8, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[12] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(115, 255, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 0)) }), Rotation = 90 })
			I[13] = new("ImageLabel", I[8], "Lines", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://70945982360079"), ImageTransparency = 0.95, Position = UDim2.fromScale(0.9, 0.5), Size = UDim2.fromScale(0.25, 1), ZIndex = 3 })
			I[14] = new("TextLabel", I[8], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.8), Text = "$10.0b", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 15 })
				I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint", { AspectRatio = 3.632 })
				I[16] = new("UIStroke", I[14], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 6 })
					I[17] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(187, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 0)) }), Rotation = 90 })
			I[18] = new("UIStroke", I[8], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 4 })
				I[19] = new("UIGradient", I[18], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(187, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 0)) }), Rotation = 90 })
			I[20] = new("UIStroke", I[8], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(111, 111, 111), LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
				I[21] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(115, 255, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 0)) }), Rotation = 90 })
		I[22] = new("TextLabel", I[1], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.06), Size = UDim2.fromScale(0.95, 0.2), Text = "Upgrade Base", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
			I[23] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint", { AspectRatio = 8.1420002 })
			I[24] = new("TextLabel", I[22], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.45), Size = UDim2.fromScale(1, 1), Text = "Upgrade Base", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 5 })
				I[25] = new("UIStroke", I[24], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5.5 })
			I[26] = new("UIStroke", I[22], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5.5 })
	return I[1]
end

return build
