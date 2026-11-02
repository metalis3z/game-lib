-- Generated from ui/StarterPlayer/StarterPlayerScripts/UserInterface/LobbyVisuals/Default/QueuePadBoardGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("SurfaceGui", nil, "QueuePadBoardGui", { Brightness = 2, ClipsDescendants = true, MaxDistance = 1000, ResetOnSpawn = false, SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ZOffset = -1 })
		I[2] = new("Frame", I[1], "MainFrame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("TextLabel", I[2], "Warning", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.03, 0.99), Size = UDim2.fromScale(0.7, 0.025), Text = "WARNING! — POTENTIAL LOSS OF STREAK", TextColor3 = Color3.fromRGB(185, 207, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.86, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
			I[4] = new("Frame", I[2], "TeamSlotContainer", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[5] = new("Frame", I[2], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
				I[6] = new("Frame", I[5], "BottomBar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(171, 171, 171), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.1), ZIndex = 2 })
					I[7] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 41, 54)), ColorSequenceKeypoint.new(0.9429066, Color3.fromRGB(28, 62, 82)), ColorSequenceKeypoint.new(1, Color3.fromRGB(47, 103, 136)) }), Rotation = -90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6092384, 0.35), NumberSequenceKeypoint.new(1, 0.2875) }) })
				I[8] = new("Frame", I[5], "Outline", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.525), Size = UDim2.fromScale(0.6, 0.6), SizeConstraint = Enum.SizeConstraint.RelativeYY, ZIndex = 3 })
					I[9] = new("UICorner", I[8], "UICorner")
					I[10] = new("UIStroke", I[8], "UIStroke", { Color = Color3.fromRGB(114, 140, 255), Thickness = 15 })
				I[11] = new("Frame", I[5], "TopBar", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(171, 171, 171), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.15), ZIndex = 2 })
					I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 41, 54)), ColorSequenceKeypoint.new(0.9429066, Color3.fromRGB(28, 62, 82)), ColorSequenceKeypoint.new(1, Color3.fromRGB(47, 103, 136)) }), Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6092384, 0.35), NumberSequenceKeypoint.new(1, 0.2875) }) })
				I[13] = new("ImageLabel", I[5], "BGTxt", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://96968939344136"), ImageTransparency = 0.95, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromScale(0.2, 0.15) })
				I[14] = new("Frame", I[5], "BG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(171, 171, 171), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
					I[15] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 41, 54)), ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 47, 63)) }), Rotation = -90 })
	return I[1]
end

return build
