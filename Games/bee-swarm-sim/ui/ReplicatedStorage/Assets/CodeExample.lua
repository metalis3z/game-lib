-- Generated from ui/ReplicatedStorage/Assets/CodeExample.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "CodeExample", { BackgroundColor3 = Color3.fromRGB(107, 81, 55), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, -0.0000001), Size = UDim2.fromOffset(316, 98), ZIndex = 100 })
		I[2] = new("TextLabel", I[1], "CodeName", { BackgroundColor3 = Color3.fromRGB(153, 117, 83), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0170744, 0), Size = UDim2.fromOffset(219, 47), Text = "extraboost", TextColor3 = Color3.fromRGB(167, 118, 75), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1000000 })
			I[3] = new("UICorner", I[2], "UICorner")
		I[4] = new("TextLabel", I[1], "CodeUses", { BackgroundColor3 = Color3.fromRGB(186, 143, 101), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0170744, 0.5204082), Size = UDim2.fromOffset(219, 47), Text = "Left 5 uses", TextColor3 = Color3.fromRGB(158, 104, 50), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1000000 })
			I[5] = new("UICorner", I[4], "UICorner")
		I[6] = new("TextButton", I[1], "DeleteButton", { BackgroundColor3 = Color3.fromRGB(255, 18, 1), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7291886, 0.0918367), Size = UDim2.fromOffset(80, 80), Text = "Delete", TextColor3 = Color3.fromRGB(225, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 999999999 })
			I[7] = new("UICorner", I[6], "UICorner")
		I[8] = new("TextButton", I[1], "CheckButton", { BackgroundColor3 = Color3.fromRGB(250, 255, 162), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7323531, 0.5510204), Size = UDim2.fromOffset(80, 41), Text = "Check", TextColor3 = Color3.fromRGB(201, 225, 161), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 999999999 })
			I[9] = new("UICorner", I[8], "UICorner")
		I[10] = new("UICorner", I[1], "{0.5, 0},{2, 0}", { BottomLeftRadius = UDim.new(0.08, 0), BottomRightRadius = UDim.new(0.08, 0), TopLeftRadius = UDim.new(0.08, 0), TopRightRadius = UDim.new(0.08, 0) })
		I[11] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(209, 209, 209)) }), Rotation = 90 })
		I[12] = new("Frame", I[1], "Palka", { BackgroundColor3 = Color3.fromRGB(75, 56, 40), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0170744, 0.49), Size = UDim2.fromOffset(219, 2) })
	return I[1]
end

return build
