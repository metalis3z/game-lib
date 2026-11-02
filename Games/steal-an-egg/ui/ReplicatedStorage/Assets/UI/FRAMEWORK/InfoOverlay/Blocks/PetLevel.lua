-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Blocks/PetLevel.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "PetLevel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 91, Size = UDim2.new(1, 0, 0, 88) })
		I[2] = new("TextLabel", I[1], "title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(1, 0, 0, 30), Text = "Level 1", TextColor3 = Color3.fromRGB(113, 255, 62), TextSize = 25, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(43, 43, 49), Thickness = 2 })
		I[4] = new("Frame", I[1], "Progress", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 3, Position = UDim2.new(0.5, 0, 0, 54), Size = UDim2.new(0.85, 0, 0, 8), ZIndex = 2 })
			I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[6] = new("Frame", I[4], "Bar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(0.33, 1), ZIndex = 5 })
				I[7] = new("UIStroke", I[6], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(17, 49, 58), Thickness = 2.5 })
				I[8] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(87, 216, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 255, 249)) }), Rotation = -90 })
				I[9] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[10] = new("Frame", I[4], "div", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.75, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.8, 0.5), Size = UDim2.new(0, 2, 1, 0), ZIndex = 5 })
			I[11] = new("Frame", I[4], "div_2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.75, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2, 0.5), Size = UDim2.new(0, 2, 1, 0), ZIndex = 5 })
			I[12] = new("Frame", I[4], "div_3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.75, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.6, 0.5), Size = UDim2.new(0, 2, 1, 0), ZIndex = 5 })
			I[13] = new("Frame", I[4], "div_4", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.75, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4, 0.5), Size = UDim2.new(0, 2, 1, 0), ZIndex = 5 })
		I[14] = new("TextLabel", I[1], "xp", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.new(0.5, 0, 0, 68), Size = UDim2.new(1, 0, 0, 20), Text = "250 / 5,000 XP", TextColor3 = Color3.fromRGB(43, 43, 49), TextSize = 20, TextWrapped = true })
		I[15] = new("TextLabel", I[1], "damage", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.new(0.5, 0, 0, 24), Size = UDim2.new(1, 0, 0, 30), Text = "+50% Damage", TextColor3 = Color3.fromRGB(255, 255, 0), TextSize = 18, TextWrapped = true })
			I[16] = new("UIStroke", I[15], "UIStroke", { Color = Color3.fromRGB(43, 43, 49), Thickness = 2 })
		I[17] = new("Configuration", I[1], "settings", nil, { ["boundsX"] = Vector2.new(65, 150) })
		I[18] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
	return I[1]
end

return build
