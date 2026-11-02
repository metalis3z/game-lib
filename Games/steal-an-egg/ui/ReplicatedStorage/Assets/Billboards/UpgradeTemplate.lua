-- Generated from ui/ReplicatedStorage/Assets/Billboards/UpgradeTemplate.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "UpgradeTemplate", { MaxDistance = 50, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ImageButton", I[1], "Upgrade", { AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(185, 185, 185), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.85, 0.85), ZIndex = 101 })
			I[3] = new("UIGradient", I[2], "Blue", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(112, 217, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 158, 255)) }), Enabled = false, Rotation = 90 })
			I[4] = new("UIGradient", I[2], "Green", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(211, 211, 0)) }), Rotation = 90 })
			I[5] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 3.5 })
			I[6] = new("UIStroke", I[2], "UIStroke", { Thickness = 5.3000002, ZIndex = 33333 }, { ["ThicknessUDim"] = UDim.new(0.2, 0) })
			I[7] = new("UIGradient", I[2], "Gray", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(165, 165, 165)), ColorSequenceKeypoint.new(1, Color3.fromRGB(165, 165, 165)) }), Rotation = 90 })
			I[8] = new("ImageLabel", I[2], "BG", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://79536815056224"), ImageTransparency = 0.4, Position = UDim2.fromScale(0.5, 0), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(1, 4), ZIndex = 101 })
				I[9] = new("UIGradient", I[8], "Blue", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(112, 217, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 158, 255)) }), Enabled = false, Rotation = 90 })
				I[10] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0.14, 0), BottomRightRadius = UDim.new(0.14, 0), TopLeftRadius = UDim.new(0.14, 0), TopRightRadius = UDim.new(0.14, 0) })
				I[11] = new("UIGradient", I[8], "Gray", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(165, 165, 165)), ColorSequenceKeypoint.new(1, Color3.fromRGB(165, 165, 165)) }), Enabled = false, Rotation = 90 })
				I[12] = new("UIGradient", I[8], "Green", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(211, 211, 0)) }), Rotation = 90 })
				I[13] = new("UIGradient", I[8], "Red", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 189)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 60, 63)) }), Enabled = false, Rotation = 90 })
			I[14] = new("TextLabel", I[2], "Cost", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.55, 0.35), Size = UDim2.fromScale(0.7, 0.6), Text = "$18", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 103 }, { ["Shadow"] = "" })
				I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 3.3499999 }, { ["ThicknessUDim"] = UDim.new(0.25, 0) })
			I[16] = new("TextLabel", I[2], "Weight", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.55, 0.74), Size = UDim2.fromScale(0.6, 0.26), Text = "Level 2 > Level 3", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 103 }, { ["Shadow"] = "" })
				I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 3.325 }, { ["ThicknessUDim"] = UDim.new(0.25, 0) })
			I[18] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://130826176835013"), Position = UDim2.fromScale(0.16, 0.5), Size = UDim2.fromScale(0.8, 0.8), ZIndex = 120 })
				I[19] = new("UIAspectRatioConstraint", I[18], "UIAspectRatioConstraint")
			I[20] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[21] = new("UIGradient", I[2], "Red", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 189)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 60, 63)) }), Enabled = false, Rotation = 90 })
			I[22] = new("UIScale", I[2], "ButtonUIScale")
	return I[1]
end

return build
