-- Generated from ui/ReplicatedStorage/Assets/UI/FRAMEWORK/InfoOverlay/Blocks/Limited.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Limited", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 12), ZIndex = 11 })
		I[2] = new("Configuration", I[1], "settings")
			I[3] = new("NumberValue", I[2], "sort", { Value = 2 })
			I[4] = new("NumberValue", I[2], "maxSizeX", { Value = 300 })
			I[5] = new("NumberValue", I[2], "minSizeX", { Value = 25 })
		I[6] = new("TextLabel", I[1], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(20, 0), Size = UDim2.new(1, -20, 1, 0), Text = "Limited Time", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
			I[7] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 221, 51)), ColorSequenceKeypoint.new(0.209651, Color3.fromRGB(255, 138, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 88, 188)) }), Offset = Vector2.new(-0.2, 0.2), Rotation = -720 })
		I[8] = new("ImageLabel", I[1], "Icon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://4790581719"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0, 20, 1, 0) })
			I[9] = new("UIGradient", I[8], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 221, 51)), ColorSequenceKeypoint.new(0.209651, Color3.fromRGB(255, 138, 70)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 88, 188)) }), Offset = Vector2.new(-0.2, 0.2), Rotation = -720 })
	return I[1]
end

return build
