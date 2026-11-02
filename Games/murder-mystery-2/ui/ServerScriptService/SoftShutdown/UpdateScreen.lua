-- Generated from ui/ServerScriptService/SoftShutdown/UpdateScreen.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "UpdateScreen", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Main", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 1000000000 })
			I[3] = new("Frame", I[2], "Tape", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.1) })
				I[4] = new("Frame", I[3], "DropShadow", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.35) })
					I[5] = new("UIGradient", I[4], "UIGradient", { Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
				I[6] = new("ImageLabel", I[3], "LinesImage", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(36, 32, 33), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(218, 171, 64), ImageContent = Content.fromUri("rbxassetid://6533316055"), Position = UDim2.fromScale(0, 1), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(200, 400), ZIndex = 2 })
			I[7] = new("Frame", I[2], "Tape", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(-0.4, 0.1), Rotation = -25, Size = UDim2.fromScale(1, 0.1) })
				I[8] = new("ImageLabel", I[7], "LinesImage", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(36, 32, 33), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(218, 171, 64), ImageContent = Content.fromUri("rbxassetid://6533316055"), Position = UDim2.fromScale(0, 1), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(200, 400), ZIndex = 2 })
					I[9] = new("UIGradient", I[8], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.015, 0), NumberSequenceKeypoint.new(0.985, 0), NumberSequenceKeypoint.new(1, 1) }) })
				I[10] = new("Frame", I[7], "DropShadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.99), Size = UDim2.fromScale(1, 0.35) })
					I[11] = new("UIGradient", I[10], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
			I[12] = new("Frame", I[2], "Tape", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.4, 0.04), Rotation = -346, Size = UDim2.fromScale(1, 0.1) })
				I[13] = new("ImageLabel", I[12], "LinesImage", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(36, 32, 33), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(218, 171, 64), ImageContent = Content.fromUri("rbxassetid://6533316055"), Position = UDim2.fromScale(0, 1), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(200, 400), ZIndex = 2 })
					I[14] = new("UIGradient", I[13], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.015, 0), NumberSequenceKeypoint.new(0.985, 0), NumberSequenceKeypoint.new(1, 1) }) })
				I[15] = new("Frame", I[12], "DropShadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.99), Size = UDim2.fromScale(1, 0.35) })
					I[16] = new("UIGradient", I[15], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
			I[17] = new("Frame", I[2], "Banner", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(31, 31, 31), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0.35) })
				I[18] = new("TextLabel", I[17], "\"Game Shutdown\"", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.1), Size = UDim2.fromScale(0.95, 0.3), Text = "GAME SHUTDOWN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[19] = new("UIGradient", I[18], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 178, 34)), ColorSequenceKeypoint.new(0.442596, Color3.fromRGB(254, 177, 34)), ColorSequenceKeypoint.new(0.753744, Color3.fromRGB(178, 128, 15)), ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 128, 15)) }), Rotation = -90 })
				I[20] = new("TextLabel", I[17], "\"A Developer\"", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.38), Size = UDim2.fromScale(0.95, 0.2), Text = "A DEVELOPER HAS SHUTDOWN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[21] = new("UIGradient", I[20], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.920133, Color3.fromRGB(166, 166, 166)), ColorSequenceKeypoint.new(1, Color3.fromRGB(161, 161, 161)) }), Rotation = 90 })
				I[22] = new("TextLabel", I[17], "\"The Game\"", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.54), Size = UDim2.fromScale(0.95, 0.2), Text = "THE GAME", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[23] = new("UIGradient", I[22], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.920133, Color3.fromRGB(166, 166, 166)), ColorSequenceKeypoint.new(1, Color3.fromRGB(161, 161, 161)) }), Rotation = 90 })
				I[24] = new("TextLabel", I[17], "\"Please Rejoin\"", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.78), Size = UDim2.fromScale(0.95, 0.15), Text = "Please Wait While We Teleport You To A New Server!", TextColor3 = Color3.fromRGB(247, 65, 112), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[25] = new("UIGradient", I[24], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.920133, Color3.fromRGB(166, 166, 166)), ColorSequenceKeypoint.new(1, Color3.fromRGB(161, 161, 161)) }), Rotation = 90 })
			I[26] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(39, 41, 45)), ColorSequenceKeypoint.new(1, Color3.fromRGB(52, 55, 61)) }), Rotation = -90 })
	return I[1]
end

return build
