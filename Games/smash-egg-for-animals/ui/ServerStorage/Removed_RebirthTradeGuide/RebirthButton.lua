-- Generated from ui/ServerStorage/Removed_RebirthTradeGuide/RebirthButton.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "RebirthButton", { AutoButtonColor = false, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.new(0.5, 0, 0, 228), Size = UDim2.fromOffset(86, 98), Text = "" }, { ["MontFix"] = true }, { "UIButton" })
		I[2] = new("Frame", I[1], "Face", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 1, -7), ZIndex = 2 })
			I[3] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
				I[4] = new("UIGradient", I[3], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 170, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 84, 230)) }), Rotation = 90 })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[6] = new("TextLabel", I[2], "Label", { AnchorPoint = Vector2.new(0.5, 1), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 1, -5), Size = UDim2.new(1, -8, 0, 26), Text = "Rebirth", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 17, ZIndex = 4 }, { ["MontFix"] = true })
				I[7] = new("UIStroke", I[6], "TextStroke", { Color = Color3.fromRGB(36, 23, 51), Thickness = 2.5 })
			I[8] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[9] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
			I[10] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 170, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 84, 230)) }), Rotation = 90 })
			I[11] = new("ImageLabel", I[2], "IconImage", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://105823629876720"), Position = UDim2.fromScale(0.4883721, 0.467033), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(60, 60), ZIndex = 3 })
		I[12] = new("Frame", I[1], "Lip", { BackgroundColor3 = Color3.fromRGB(92, 52, 170), Size = UDim2.new(1, 0, 1.03, -7) })
			I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[14] = new("UIStroke", I[12], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(36, 23, 51), Thickness = 3 })
	return I[1]
end

return build
