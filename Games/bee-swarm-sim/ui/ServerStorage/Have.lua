-- Generated from ui/ServerStorage/Have.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageLabel", nil, "Have", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(106, 83, 66), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=9882336844"), LayoutOrder = 2000, Position = UDim2.fromOffset(-58, 3), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 0, 0, 40), SliceCenter = Rect.new(192, 255, 192, 255), Visible = false, ZIndex = 6 })
		I[2] = new("TextLabel", I[1], "QName", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromOffset(5, 4), Size = UDim2.fromScale(0.9824046, 0.8780488), Text = "Equipment Inventory", TextColor3 = Color3.fromRGB(66, 66, 66), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.72, TextWrapped = true, ZIndex = 5 })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(66, 66, 66), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.2 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[5] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5590682, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5806988, Color3.fromRGB(197, 197, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(194, 194, 194)) }), Offset = Vector2.new(0, 0.2), Rotation = 85 })
		I[6] = new("TextLabel", I[1], "QName", { BackgroundColor3 = Color3.fromRGB(255, 138, 220), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromOffset(3, 2), Size = UDim2.fromScale(0.9824047, 0.8780488), Text = "Equipment Inventory", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.72, TextWrapped = true, ZIndex = 6 })
			I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(66, 66, 66), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.2 })
			I[8] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[9] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5590682, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5806988, Color3.fromRGB(197, 197, 197)), ColorSequenceKeypoint.new(1, Color3.fromRGB(194, 194, 194)) }), Offset = Vector2.new(0, 0.3), Rotation = 85 })
	return I[1]
end

return build
