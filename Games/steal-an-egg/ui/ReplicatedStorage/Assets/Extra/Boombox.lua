-- Generated from ui/ReplicatedStorage/Assets/Extra/Boombox.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Boombox", { Active = true, AlwaysOnTop = true, MaxDistance = 45, Size = UDim2.new(16.5, 150, 2.8599999, 26), StudsOffsetWorldSpace = Vector3.new(0, 1.7, 0) })
		I[2] = new("TextLabel", I[1], "PerSecond", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = -1, Size = UDim2.fromScale(0.2, 0.192), Text = "Expires In", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[3] = new("UIStroke", I[2], "UIStroke", { Thickness = 2.4000001 })
		I[4] = new("Frame", I[1], "Content", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.25, 0.08) })
			I[5] = new("TextLabel", I[4], "Label", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 2.7), Text = "5s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2.4000001 })
			I[7] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
			I[8] = new("UIStroke", I[4], "UIStroke", { Thickness = 2.4000001 })
			I[9] = new("Frame", I[4], "Bar", { BackgroundColor3 = Color3.fromRGB(149, 227, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
				I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.2, 0), BottomRightRadius = UDim.new(0.2, 0), TopLeftRadius = UDim.new(0.2, 0), TopRightRadius = UDim.new(0.2, 0) })
				I[11] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 235, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 145, 255)) }), Rotation = 90 })
		I[12] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
	return I[1]
end

return build
