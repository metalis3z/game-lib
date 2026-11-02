-- Generated from ui/StarterGui/GymStats.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GymStats", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Strength", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(80, 80, 80), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.052), Size = UDim2.fromScale(0.2046667, 0.0272534), ZIndex = 3 })
			I[3] = new("Frame", I[2], "Color", { BackgroundColor3 = Color3.fromRGB(255, 170, 127), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000006, 0), Size = UDim2.fromScale(0.7404042, 1) })
				I[4] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
				I[5] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(255, 255, 255) })
			I[6] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
			I[7] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255) })
			I[8] = new("TextLabel", I[2], "Top", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.501, -0.7), Size = UDim2.fromScale(0.8709999, -1.1386712), Text = "Strength", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 5 })
			I[9] = new("TextLabel", I[2], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5010005, 0.5), Size = UDim2.fromScale(0.8709999, -1.0000007), Text = "9/100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.2, TextWrapped = true, ZIndex = 55555 })
		I[10] = new("Frame", I[1], "Stamina", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(80, 80, 80), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.117), Size = UDim2.fromScale(0.2046667, 0.0272534), ZIndex = 3 })
			I[11] = new("Frame", I[10], "Color", { BackgroundColor3 = Color3.fromRGB(0, 170, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000006, 0), Size = UDim2.fromScale(0.7404042, 1) })
				I[12] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
				I[13] = new("UIStroke", I[11], "UIStroke", { Color = Color3.fromRGB(255, 255, 255) })
			I[14] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.3, 0), BottomRightRadius = UDim.new(0.3, 0), TopLeftRadius = UDim.new(0.3, 0), TopRightRadius = UDim.new(0.3, 0) })
			I[15] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(255, 255, 255) })
			I[16] = new("TextLabel", I[10], "Top", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.501, -0.7), Size = UDim2.fromScale(0.8709999, -1.1386712), Text = "Stamina", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 5 })
			I[17] = new("TextLabel", I[10], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5010005, 0.5), Size = UDim2.fromScale(0.8709999, -1.0000007), Text = "9/100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.2, TextWrapped = true, ZIndex = 55555 })
	return I[1]
end

return build
