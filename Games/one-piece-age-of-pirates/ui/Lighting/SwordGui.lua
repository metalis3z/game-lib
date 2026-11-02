-- Generated from ui/Lighting/SwordGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SwordGui")
		I[2] = new("Frame", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(139, 119, 71), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(173, 143, 53), BorderSizePixel = 8, Position = UDim2.fromScale(0.3, 0.2), Size = UDim2.fromScale(0.5, 0.6) })
			I[3] = new("TextLabel", I[2], "TypeofSword", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.1), Size = UDim2.fromScale(1, 0.2), Text = "What Type of Sword?", TextColor3 = Color3.fromRGB(35, 35, 35) })
			I[4] = new("TextButton", I[2], "Cutlass", { BackgroundColor3 = Color3.fromRGB(122, 104, 62), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(188, 155, 57), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0.4), Size = UDim2.fromScale(0.27, 0.5), Text = "Cutlass", TextColor3 = Color3.fromRGB(15, 15, 15) })
			I[5] = new("TextButton", I[2], "Sabre", { BackgroundColor3 = Color3.fromRGB(122, 104, 62), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(188, 155, 57), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.68, 0.4), Size = UDim2.fromScale(0.27, 0.5), Text = "Sabre", TextColor3 = Color3.fromRGB(15, 15, 15) })
			I[6] = new("TextButton", I[2], "Katana", { BackgroundColor3 = Color3.fromRGB(122, 104, 62), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(188, 155, 57), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.365, 0.4), Size = UDim2.fromScale(0.27, 0.5), Text = "Katana", TextColor3 = Color3.fromRGB(15, 15, 15) })
	return I[1]
end

return build
