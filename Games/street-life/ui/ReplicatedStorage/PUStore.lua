-- Generated from ui/ReplicatedStorage/PUStore.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "PUStore", { Enabled = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.3234344, 0.4342432) })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 15), BottomRightRadius = UDim.new(0, 15), TopLeftRadius = UDim.new(0, 15), TopRightRadius = UDim.new(0, 15) })
			I[5] = new("TextLabel", I[2], "Namey", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1027569), Text = "Flipsy Smokes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2 })
			I[7] = new("TextButton", I[2], "Banana", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1862112, 0.3253549), Size = UDim2.fromScale(0.3, 0.0759937), Text = "$100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("UIStroke", I[7], "Around", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[9] = new("TextLabel", I[7], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -1.2308598), Size = UDim2.fromScale(1, 1), Text = "Banana", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 2 })
				I[11] = new("UICorner", I[7], "UICorner")
				I[12] = new("UIStroke", I[7], "UIStroke", { Thickness = 2 })
			I[13] = new("TextLabel", I[2], "Promo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3493014, 0.9115286), Size = UDim2.fromScale(0.3013972, 0.0734336), Text = "Street Life", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.5, TextWrapped = true })
				I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 2, Transparency = 0.5 })
			I[15] = new("Sound", I[2], "Kaching", { RollOffMaxDistance = 75, Volume = 2 })
			I[16] = new("Sound", I[2], "Error", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 })
			I[17] = new("Sound", I[2], "Press", { Volume = 0.8 })
			I[18] = new("ObjectValue", I[2], "Object")
			I[19] = new("TextButton", I[2], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.96008, 0.0438596), Size = UDim2.fromScale(0.0798403, 0.0877193), Text = "X", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[20] = new("UIStroke", I[19], "Around", { Thickness = 2 })
			I[21] = new("TextButton", I[2], "Watermelon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5001751, 0.3253549), Size = UDim2.fromScale(0.3, 0.0759937), Text = "$100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[22] = new("UIStroke", I[21], "Around", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[23] = new("TextLabel", I[21], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -1.2308598), Size = UDim2.fromScale(1, 1), Text = "Watermelon", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 2 })
				I[25] = new("UICorner", I[21], "UICorner")
				I[26] = new("UIStroke", I[21], "UIStroke", { Thickness = 2 })
			I[27] = new("TextButton", I[2], "Strawberry", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8266143, 0.3253549), Size = UDim2.fromScale(0.3, 0.0759937), Text = "$100", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[28] = new("UIStroke", I[27], "Around", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[29] = new("TextLabel", I[27], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -1.2308598), Size = UDim2.fromScale(1, 1), Text = "Strawberry", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 2 })
				I[31] = new("UICorner", I[27], "UICorner")
				I[32] = new("UIStroke", I[27], "UIStroke", { Thickness = 2 })
	return I[1]
end

return build
