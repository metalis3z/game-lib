-- Generated from ui/StarterGui/TestGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "TestGui")
		I[2] = new("TextButton", I[1], "TextButton", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.44, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -20), Size = UDim2.fromOffset(20, 20), Text = "[?]", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
		I[3] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false })
			I[4] = new("TextLabel", I[3], "age", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.44, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -105), Size = UDim2.fromOffset(300, 25), Text = "Memory Use:", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextXAlignment = Enum.TextXAlignment.Left })
			I[5] = new("TextLabel", I[3], "client", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.44, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -55), Size = UDim2.fromOffset(300, 25), Text = "Memory Use:", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextXAlignment = Enum.TextXAlignment.Left })
			I[6] = new("TextLabel", I[3], "server", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.44, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -80), Size = UDim2.fromOffset(300, 25), Text = "Memory Use:", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextXAlignment = Enum.TextXAlignment.Left })
			I[7] = new("TextLabel", I[3], "title", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.44, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(0, 0, 1, -135), Size = UDim2.fromOffset(300, 25), Text = "Debug stats", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextXAlignment = Enum.TextXAlignment.Left })
	return I[1]
end

return build
