-- Generated from ui/ReplicatedStorage/Store.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Store", { Enabled = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.3234344, 0.4342432) })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
			I[4] = new("TextButton", I[2], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.96008, 0.0438596), Size = UDim2.fromScale(0.0798403, 0.0877193), Text = "X", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[5] = new("UIStroke", I[4], "Around", { Thickness = 2 })
			I[6] = new("TextButton", I[2], "Pizza", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1716567, 0.4621553), Size = UDim2.fromScale(0.3, 0.0759937), Text = "$3", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[7] = new("UIStroke", I[6], "Around", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[8] = new("TextLabel", I[6], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -1.2308598), Size = UDim2.fromScale(1, 1), Text = "Pizza", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 2 })
				I[10] = new("UICorner", I[6], "UICorner")
				I[11] = new("UIStroke", I[6], "UIStroke", { Thickness = 2 })
			I[12] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 15), BottomRightRadius = UDim.new(0, 15), TopLeftRadius = UDim.new(0, 15), TopRightRadius = UDim.new(0, 15) })
			I[13] = new("TextLabel", I[2], "Namey", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1027569), Text = "Deli Store", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 2 })
			I[15] = new("TextButton", I[2], "Water", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.499002, 0.4621553), Size = UDim2.fromScale(0.3, 0.0759937), Text = "$2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[16] = new("UIStroke", I[15], "Around", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[17] = new("TextLabel", I[15], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -1.2308598), Size = UDim2.fromScale(1, 1), Text = "Water", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 2 })
				I[19] = new("UICorner", I[15], "UICorner")
				I[20] = new("UIStroke", I[15], "UIStroke", { Thickness = 2 })
			I[21] = new("TextButton", I[2], "Taco", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8283433, 0.4621553), Size = UDim2.fromScale(0.3, 0.0759937), Text = "$4", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[22] = new("UIStroke", I[21], "Around", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[23] = new("TextLabel", I[21], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -1.2308598), Size = UDim2.fromScale(1, 1), Text = "Taco", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[24] = new("UIStroke", I[23], "UIStroke", { Thickness = 2 })
				I[25] = new("UICorner", I[21], "UICorner")
				I[26] = new("UIStroke", I[21], "UIStroke", { Thickness = 2 })
			I[27] = new("TextButton", I[2], "AppleJuice", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1716567, 0.6473183), Size = UDim2.fromScale(0.3, 0.0759937), Text = "$3", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[28] = new("UIStroke", I[27], "Around", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[29] = new("TextLabel", I[27], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -1.2308598), Size = UDim2.fromScale(1, 1), Text = "Apple Juice", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 2 })
				I[31] = new("UICorner", I[27], "UICorner")
				I[32] = new("UIStroke", I[27], "UIStroke", { Thickness = 2 })
			I[33] = new("TextButton", I[2], "GrapeJuice", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.499002, 0.6473183), Size = UDim2.fromScale(0.3, 0.0759937), Text = "$3", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[34] = new("UIStroke", I[33], "Around", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[35] = new("TextLabel", I[33], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -1.2308598), Size = UDim2.fromScale(1, 1), Text = "Grape Juice", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[36] = new("UIStroke", I[35], "UIStroke", { Thickness = 2 })
				I[37] = new("UICorner", I[33], "UICorner")
				I[38] = new("UIStroke", I[33], "UIStroke", { Thickness = 2 })
			I[39] = new("TextButton", I[2], "CherryDrink", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8283433, 0.6501755), Size = UDim2.fromScale(0.3, 0.0759937), Text = "$5", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[40] = new("UIStroke", I[39], "Around", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[41] = new("TextLabel", I[39], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -1.2308598), Size = UDim2.fromScale(1, 1), Text = "Cherry Drink ", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[42] = new("UIStroke", I[41], "UIStroke", { Thickness = 2 })
				I[43] = new("UICorner", I[39], "UICorner")
				I[44] = new("UIStroke", I[39], "UIStroke", { Thickness = 2 })
			I[45] = new("TextLabel", I[2], "Promo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3493014, 0.9115286), Size = UDim2.fromScale(0.3013972, 0.0734336), Text = "Street Life", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.5, TextWrapped = true })
				I[46] = new("UIStroke", I[45], "UIStroke", { Thickness = 2, Transparency = 0.5 })
			I[47] = new("Sound", I[2], "Kaching", { RollOffMaxDistance = 75, Volume = 2 })
			I[48] = new("Sound", I[2], "Error", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 })
			I[49] = new("Sound", I[2], "Press", { Volume = 0.8 })
			I[50] = new("ObjectValue", I[2], "Object")
	return I[1]
end

return build
