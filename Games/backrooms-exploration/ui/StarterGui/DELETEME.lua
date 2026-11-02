-- Generated from ui/StarterGui/DELETEME.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "DELETEME", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(252, 255, 55), BackgroundTransparency = 0.55, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1018077, 0.1069444), Size = UDim2.fromScale(0.8120736, 0.7944444), Visible = false })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("UIStroke", I[2], "UIStroke", { Thickness = 4, Transparency = 0.55 })
			I[5] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.400042, 0.3146853), Size = UDim2.fromOffset(172, 46), Text = "Cheese Uncopylocked", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 80 })
				I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
			I[7] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8389332, 0.222028), Rotation = 35, Size = UDim2.fromOffset(172, 46), Text = "👑", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 81 })
				I[8] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
			I[9] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4094918, 0.4440559), Size = UDim2.fromOffset(172, 46), Text = "Made This File", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 75 })
				I[10] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
			I[11] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.8951049), Size = UDim2.fromOffset(172, 46), Text = "VIP", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 80 })
				I[12] = new("UIStroke", I[11], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
			I[13] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://111926035480507"), Size = UDim2.fromOffset(230, 151) })
			I[14] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4094918, 0.5681819), Size = UDim2.fromOffset(172, 46), Text = "DO NOT LEAK", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 65 })
				I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
			I[16] = new("ImageLabel", I[2], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://111926035480507"), Position = UDim2.fromScale(0.7580848, 0.7797203), Size = UDim2.fromOffset(230, 151) })
			I[17] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.400042, 0.9090909), Size = UDim2.fromOffset(172, 46), Text = "https://discord.gg/uu3TXW5Se3", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 30 })
				I[18] = new("UIStroke", I[17], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
			I[19] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8189836, 0.0594406), Size = UDim2.fromOffset(172, 46), Text = "VIP", TextColor3 = Color3.fromRGB(249, 209, 27), TextSize = 80 })
				I[20] = new("UIStroke", I[19], "UIStroke", { Color = Color3.fromRGB(96, 36, 1), Thickness = 4 })
	return I[1]
end

return build
