-- Generated from ui/Lighting/HakiGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "HakiGui")
		I[2] = new("ImageLabel", I[1], "Background", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(47, 47, 47), BorderSizePixel = 10, Position = UDim2.fromScale(0.3, 0.2), Size = UDim2.fromScale(0.5, 0.6) })
			I[3] = new("ImageLabel", I[2], "Kenbunshoku", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 2, ImageContent = Content.fromUri("rbxassetid://189357258"), Position = UDim2.fromScale(0.175, 0.35), Size = UDim2.fromScale(0.25, 0.35), ZIndex = 3 })
				I[4] = new("ImageLabel", I[3], "ImageLabel", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(47, 47, 47), BorderSizePixel = 3, Position = UDim2.fromScale(0, 1.02), Size = UDim2.fromScale(1, 0.3), ZIndex = 3 })
					I[5] = new("TextLabel", I[4], "BoatName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(213, 187, 83), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Kenbunshoku - $10000", TextColor3 = Color3.fromRGB(25, 25, 25), ZIndex = 3 })
				I[6] = new("ImageLabel", I[3], "Border", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(47, 47, 47), BorderSizePixel = 3, Position = UDim2.fromScale(0, -0.01), Size = UDim2.fromScale(1, 1), ZIndex = 3 })
				I[7] = new("ImageLabel", I[3], "Picture", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(47, 47, 47), BorderSizePixel = 3, Position = UDim2.fromScale(0, -0.01), Size = UDim2.fromScale(1, 1), ZIndex = 3 })
				I[8] = new("ImageLabel", I[3], "Border2", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(47, 47, 47), BorderSizePixel = 3, Position = UDim2.fromScale(0, 1.02), Size = UDim2.fromScale(1, 0.3), ZIndex = 3 })
				I[9] = new("TextButton", I[3], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "" })
			I[10] = new("ImageLabel", I[2], "Busoshoku", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 2, ImageContent = Content.fromUri("rbxassetid://189357318"), Position = UDim2.fromScale(0.575, 0.35), Size = UDim2.fromScale(0.25, 0.35), ZIndex = 3 })
				I[11] = new("ImageLabel", I[10], "ImageLabel", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(47, 47, 47), BorderSizePixel = 3, Position = UDim2.fromScale(0, 1.02), Size = UDim2.fromScale(1, 0.3), ZIndex = 3 })
					I[12] = new("TextLabel", I[11], "BoatName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(213, 187, 83), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Busoshoku - $10000", TextColor3 = Color3.fromRGB(25, 25, 25), ZIndex = 3 })
				I[13] = new("ImageLabel", I[10], "Border", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(47, 47, 47), BorderSizePixel = 3, Position = UDim2.fromScale(0, -0.01), Size = UDim2.fromScale(1, 1), ZIndex = 3 })
				I[14] = new("ImageLabel", I[10], "Picture", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(47, 47, 47), BorderSizePixel = 3, Position = UDim2.fromScale(0, -0.01), Size = UDim2.fromScale(1, 1), ZIndex = 3 })
				I[15] = new("ImageLabel", I[10], "Border2", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 0.4, BorderColor3 = Color3.fromRGB(47, 47, 47), BorderSizePixel = 3, Position = UDim2.fromScale(0, 1.02), Size = UDim2.fromScale(1, 0.3), ZIndex = 3 })
				I[16] = new("TextButton", I[10], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "" })
			I[17] = new("ImageLabel", I[2], "Title", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 2, ImageTransparency = 0.2, Position = UDim2.fromScale(0, 0.04), Size = UDim2.fromScale(1, 0.15), ZIndex = 3 })
				I[18] = new("TextLabel", I[17], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(25, 25, 25), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Haki", TextColor3 = Color3.fromRGB(25, 25, 25) })
			I[19] = new("ImageLabel", I[2], "Exit", { Active = true, BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 2, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=138680039"), ImageTransparency = 0.2, Position = UDim2.fromScale(0.01, 0.01), Size = UDim2.fromScale(0.05, 0.075), ZIndex = 3 })
				I[20] = new("TextButton", I[19], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "" })
	return I[1]
end

return build
