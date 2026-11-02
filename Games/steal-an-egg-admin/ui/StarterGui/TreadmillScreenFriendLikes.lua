-- Generated from ui/StarterGui/TreadmillScreenFriendLikes.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "TreadmillScreenFriendLikes", { AlwaysOnTop = true, ClipsDescendants = true, LightInfluence = 1, MaxDistance = 1000, PixelsPerStud = 160, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ZOffset = 2 }, { ["_lemonadeUniqueId"] = "kEhFy9ymkEhF" })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "9nD8a55r9nD8" })
			I[3] = new("Frame", I[2], "Main", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.02, 0.98), Size = UDim2.fromScale(0.7, 0.1) }, { ["_lemonadeUniqueId"] = "4bc7gp4C4bc7" })
				I[4] = new("UIGridLayout", I[3], "UIGridLayout", { CellPadding = UDim2.fromScale(0.05, 0.1), CellSize = UDim2.fromScale(0.2, 0.6), FillDirectionMaxCells = 4, SortOrder = Enum.SortOrder.LayoutOrder, StartCorner = Enum.StartCorner.BottomLeft, VerticalAlignment = Enum.VerticalAlignment.Bottom }, { ["_lemonadeUniqueId"] = "nIGN5bysnIGN" })
					I[5] = new("UIAspectRatioConstraint", I[4], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "AXyJrzI6AXyJ" })
				I[6] = new("Frame", I[3], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.3, 1), Visible = false }, { ["_lemonadeUniqueId"] = "zG3DaUIozG3D" })
					I[7] = new("ImageButton", I[6], "Button", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Selectable = false, Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "L07SdLSsL07S" })
						I[8] = new("ImageLabel", I[7], "PlayerIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://119333642694596"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "gML0FFXjgML0" })
							I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "nu6H5De4nu6H" })
							I[10] = new("UIAspectRatioConstraint", I[8], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "fZ5gbmMkfZ5g" })
							I[11] = new("ImageLabel", I[8], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(255, 0, 132), ImageContent = Content.fromUri("rbxassetid://128759136149416"), Position = UDim2.fromScale(0.85, 0.85), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.45, 0.45) }, { ["_lemonadeUniqueId"] = "emsrP6x1emsr" })
								I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "uYrf1FuAuYrf" })
								I[13] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "YL1vTTptYL1v" })
			I[14] = new("Frame", I[2], "Profile", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.2), Visible = false }, { ["_lemonadeUniqueId"] = "udyAMahbudyA" })
				I[15] = new("Frame", I[14], "Frame", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1.2), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "AvYFfXCAAvYF" })
					I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) }, { ["_lemonadeUniqueId"] = "HYkr0KjVHYkr" })
				I[17] = new("Frame", I[14], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "k1p9uAnBk1p9" })
					I[18] = new("Frame", I[17], "Icon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.05, 0.6), Size = UDim2.fromScale(0.2, 0.6) }, { ["_lemonadeUniqueId"] = "2PMYWrMm2PMY" })
						I[19] = new("ImageLabel", I[18], "PlayerIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(124, 124, 124), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://119333642694596"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) }, { ["_lemonadeUniqueId"] = "Wvdu9oZPWvdu" })
							I[20] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "jk1uhWbPjk1u" })
							I[21] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "AAyl1g6CAAyl" })
							I[22] = new("ImageLabel", I[19], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://89391293321436"), Position = UDim2.fromScale(0.85, 0.85), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.45, 0.45) }, { ["_lemonadeUniqueId"] = "bi7PZ98Abi7P" })
								I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) }, { ["_lemonadeUniqueId"] = "Kob8drQ2Kob8" })
								I[24] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint", nil, { ["_lemonadeUniqueId"] = "QtNrlqUOQtNr" })
					I[25] = new("TextLabel", I[17], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3, 0.6), Size = UDim2.fromScale(0.6, 0.3), Text = "sat_omr liked this video", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left }, { ["_lemonadeUniqueId"] = "CJEi0cv1CJEi" })
	return I[1]
end

return build
