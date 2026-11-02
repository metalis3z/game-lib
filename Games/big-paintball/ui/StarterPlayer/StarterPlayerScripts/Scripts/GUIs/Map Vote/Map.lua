-- Generated from ui/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Map Vote/Map.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "Map", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://5694537828"), LayoutOrder = -1, ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(0.24, 0.635), ZIndex = 2 })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0, 18), BottomRightRadius = UDim.new(0, 18), TopLeftRadius = UDim.new(0, 18), TopRightRadius = UDim.new(0, 18) })
		I[3] = new("UIGradient", I[1], "SelectedGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(227, 227, 227)), ColorSequenceKeypoint.new(1, Color3.fromRGB(116, 116, 116)) }), Rotation = 90 })
		I[4] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6) })
		I[5] = new("Frame", I[1], "Avatars", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.2), Size = UDim2.fromScale(1, 0.65) })
			I[6] = new("UIPadding", I[5], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0) })
		I[7] = new("Frame", I[1], "back", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1.025, 20, 1.025, 16) })
			I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0, 20), BottomRightRadius = UDim.new(0, 20), TopLeftRadius = UDim.new(0, 20), TopRightRadius = UDim.new(0, 20) })
		I[9] = new("ImageLabel", I[1], "GamemodeIcon", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://5694615393"), Position = UDim2.fromScale(0, 1), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1, 0.14), ZIndex = 3 })
		I[10] = new("TextLabel", I[1], "Gamemode", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.12, 1), Size = UDim2.fromScale(0.9, 0.14), Text = "Skill", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 30, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 3 })
		I[11] = new("TextLabel", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.175), Text = "Map Name!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 30, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 3 })
			I[12] = new("TextLabel", I[11], "shadow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.008, 0.06), Size = UDim2.fromScale(1, 1), Text = "Map Name!", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 30, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, ZIndex = 2 })
		I[13] = new("TextLabel", I[1], "PreviousMap", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -0.225), Size = UDim2.fromScale(1, 0.133), Text = "Last Map", TextColor3 = Color3.fromRGB(255, 255, 52), TextScaled = true, TextSize = 30, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, Visible = false, ZIndex = 3 })
			I[14] = new("TextLabel", I[13], "shadow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.008, 0.06), Size = UDim2.fromScale(1, 1), Text = "Last Map", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 30, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom, ZIndex = 2 })
	return I[1]
end

return build
