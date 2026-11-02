-- Generated from ui/ReplicatedStorage/Assets/FieldExample.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "FieldExample", { BackgroundColor3 = Color3.fromRGB(107, 81, 55), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.0000001), Size = UDim2.fromOffset(219, 58), ZIndex = 100 })
		I[2] = new("TextLabel", I[1], "FieldName", { BackgroundColor3 = Color3.fromRGB(153, 117, 83), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2694064, 0), Size = UDim2.fromOffset(159, 58), Text = "Blue Flower", TextColor3 = Color3.fromRGB(167, 118, 75), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1000000 })
			I[3] = new("UICorner", I[2], "UICorner")
		I[4] = new("UICorner", I[1], "{0.5, 0},{2, 0}", { BottomLeftRadius = UDim.new(0.08, 0), BottomRightRadius = UDim.new(0.08, 0), TopLeftRadius = UDim.new(0.08, 0), TopRightRadius = UDim.new(0.08, 0) })
		I[5] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(209, 209, 209)) }), Rotation = 90 })
		I[6] = new("ImageLabel", I[1], "FieldImage", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://14783389170"), Size = UDim2.fromOffset(58, 58) })
		I[7] = new("TextButton", I[1], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(218, 58), TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextTransparency = 1 })
	return I[1]
end

return build
