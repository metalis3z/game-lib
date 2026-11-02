-- Generated from ui/StarterGui/questgui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "questgui", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(226, 226, 226), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0315871, 0.1036585), Size = UDim2.fromOffset(372, 594) })
			I[3] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://18928846645"), ImageTransparency = 0.95, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromOffset(372, 594), TileSize = UDim2.fromScale(0.25, 0.155), ZIndex = 0 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
			I[5] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(56, 56, 56), Thickness = 6.8000002 })
			I[6] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(176, 176, 176)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
			I[7] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.050505), Size = UDim2.fromOffset(372, 44), Text = "GUI", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(56, 56, 56), Thickness = 6.0999999 })
			I[9] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(226, 226, 226), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0611569, 0.038002), Size = UDim2.fromOffset(326, 352) })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
				I[11] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(56, 56, 56), Thickness = 6.8000002 })
				I[12] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(176, 176, 176)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -111 })
				I[13] = new("TextLabel", I[9], "TextLabel", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.0022096), Size = UDim2.fromOffset(326, 41), Text = "quest name llllllllllllllllllll", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 30, TextWrapped = true })
					I[14] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(56, 56, 56), Thickness = 3.7 })
				I[15] = new("Frame", I[9], "Frame", { BackgroundColor3 = Color3.fromRGB(226, 82, 82), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0401998, 0.1597222), Size = UDim2.fromOffset(300, 40) })
					I[16] = new("Frame", I[15], "Frame", { BackgroundColor3 = Color3.fromRGB(90, 226, 88), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0005366, -0.0158459), Size = UDim2.fromOffset(167, 40) })
				I[17] = new("Frame", I[9], "Frame", { BackgroundColor3 = Color3.fromRGB(226, 82, 82), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0401998, 0.293245), Size = UDim2.fromOffset(300, 40) })
					I[18] = new("Frame", I[17], "Frame", { BackgroundColor3 = Color3.fromRGB(90, 226, 88), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0005366, -0.0158459), Size = UDim2.fromOffset(167, 40) })
				I[19] = new("Frame", I[9], "Frame", { BackgroundColor3 = Color3.fromRGB(226, 82, 82), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0401998, 0.4296086), Size = UDim2.fromOffset(300, 40) })
					I[20] = new("Frame", I[19], "Frame", { BackgroundColor3 = Color3.fromRGB(90, 226, 88), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0005366, -0.0158459), Size = UDim2.fromOffset(167, 40) })
				I[21] = new("Frame", I[9], "Frame", { BackgroundColor3 = Color3.fromRGB(226, 82, 82), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0401998, 0.5631313), Size = UDim2.fromOffset(300, 40) })
					I[22] = new("Frame", I[21], "Frame", { BackgroundColor3 = Color3.fromRGB(90, 226, 88), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0005366, -0.0158459), Size = UDim2.fromOffset(167, 40) })
				I[23] = new("Frame", I[9], "Frame", { BackgroundColor3 = Color3.fromRGB(226, 82, 82), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0401998, 0.699495), Size = UDim2.fromOffset(300, 40) })
					I[24] = new("Frame", I[23], "Frame", { BackgroundColor3 = Color3.fromRGB(90, 226, 88), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0005366, -0.0158459), Size = UDim2.fromOffset(167, 40) })
				I[25] = new("Frame", I[9], "Frame", { BackgroundColor3 = Color3.fromRGB(226, 82, 82), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0401998, 0.8273359), Size = UDim2.fromOffset(300, 40) })
					I[26] = new("Frame", I[25], "Frame", { BackgroundColor3 = Color3.fromRGB(90, 226, 88), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0005366, -0.0158459), Size = UDim2.fromOffset(167, 40) })
	return I[1]
end

return build
