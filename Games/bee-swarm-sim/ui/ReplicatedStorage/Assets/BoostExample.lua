-- Generated from ui/ReplicatedStorage/Assets/BoostExample.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "BoostExample", { BackgroundColor3 = Color3.fromRGB(107, 81, 55), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0504732, -0.0018083), Size = UDim2.fromOffset(317, 98), ZIndex = 100 })
		I[2] = new("UICorner", I[1], "{0.5, 0},{2, 0}", { BottomLeftRadius = UDim.new(0.08, 0), BottomRightRadius = UDim.new(0.08, 0), TopLeftRadius = UDim.new(0.08, 0), TopRightRadius = UDim.new(0.08, 0) })
		I[3] = new("ImageLabel", I[1], "BoostImage", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://12875055914"), Position = UDim2.fromScale(0.0254549, 0.122449), Size = UDim2.fromOffset(74, 74), ZIndex = 999999999 })
		I[4] = new("TextLabel", I[1], "BoostName", { BackgroundColor3 = Color3.fromRGB(129, 98, 70), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2600914, 0), Size = UDim2.fromOffset(227, 47), Text = "Blueberry Juice", TextColor3 = Color3.fromRGB(85, 170, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1000000 })
			I[5] = new("UICorner", I[4], "UICorner")
		I[6] = new("TextBox", I[1], "AmountBox", { BackgroundColor3 = Color3.fromRGB(129, 98, 70), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Enter Boost Amount", Position = UDim2.fromScale(0.2599543, 0.5612245), Size = UDim2.fromOffset(227, 35), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 1000000 })
		I[7] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(209, 209, 209)) }), Rotation = 90 })
		I[8] = new("Frame", I[1], "Palka", { BackgroundColor3 = Color3.fromRGB(75, 56, 40), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2588934, 0.4897972), Size = UDim2.fromOffset(227, 2) })
	return I[1]
end

return build
