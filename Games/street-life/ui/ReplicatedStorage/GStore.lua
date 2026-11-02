-- Generated from ui/ReplicatedStorage/GStore.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "GStore", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.3234344, 0.4342432) })
			I[3] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
			I[4] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 15), BottomRightRadius = UDim.new(0, 15), TopLeftRadius = UDim.new(0, 15), TopRightRadius = UDim.new(0, 15) })
			I[5] = new("TextLabel", I[2], "Namey", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1027569), Text = "Flipsy's GYM", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2 })
			I[7] = new("TextLabel", I[2], "Promo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3493014, 0.9115286), Size = UDim2.fromScale(0.3013972, 0.0734336), Text = "Street Life", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.5, TextWrapped = true })
				I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 2, Transparency = 0.5 })
			I[9] = new("Sound", I[2], "Kaching", { RollOffMaxDistance = 75, Volume = 2 })
			I[10] = new("Sound", I[2], "Error", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 })
			I[11] = new("Sound", I[2], "Press", { Volume = 0.8 })
			I[12] = new("ObjectValue", I[2], "Object")
			I[13] = new("TextButton", I[2], "Protein Shake", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.198065, 0.4478696), Size = UDim2.fromScale(0.3, 0.0759937), Text = "$50", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[14] = new("UIStroke", I[13], "Around", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[15] = new("TextLabel", I[13], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -1.2308598), Size = UDim2.fromScale(1, 1), Text = "Protein Shake", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 2 })
				I[17] = new("UICorner", I[13], "UICorner")
				I[18] = new("UIStroke", I[13], "UIStroke", { Thickness = 2 })
			I[19] = new("TextButton", I[2], "Protein Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7999386, 0.4478696), Size = UDim2.fromScale(0.3, 0.0759937), Text = "$50", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[20] = new("UIStroke", I[19], "Around", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
				I[21] = new("TextLabel", I[19], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, -1.2308598), Size = UDim2.fromScale(1, 1), Text = "Protein Bar", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[22] = new("UIStroke", I[21], "UIStroke", { Thickness = 2 })
				I[23] = new("UICorner", I[19], "UICorner")
				I[24] = new("UIStroke", I[19], "UIStroke", { Thickness = 2 })
			I[25] = new("TextButton", I[2], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.96008, 0.0438596), Size = UDim2.fromScale(0.0798403, 0.0877193), Text = "X", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[26] = new("UIStroke", I[25], "Around", { Thickness = 2 })
	return I[1]
end

return build
