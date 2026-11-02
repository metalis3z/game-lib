-- Generated from ui/_StarterGui-all.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "MainGui")
		I[2] = new("TextLabel", I[1], "Background", { BackgroundColor3 = Color3.fromRGB(203, 162, 111), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1), Text = "" })
		I[3] = new("TextButton", I[1], "MoneyGiver", { BackgroundColor3 = Color3.fromRGB(182, 145, 99), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.255, 0.02), Size = UDim2.fromScale(0.15, 0.065), Text = "Money Giver", TextColor3 = Color3.fromRGB(255, 205, 124), ZIndex = 10 })
		I[4] = new("Frame", I[1], "Money", { BackgroundColor3 = Color3.fromRGB(182, 145, 99), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 3, Position = UDim2.fromScale(0.055, 0.02), Size = UDim2.fromScale(0.15, 0.065), ZIndex = 10 })
			I[5] = new("TextLabel", I[4], "Value", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 185, 87), BorderSizePixel = 5, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.95, 1), Text = "0", TextColor3 = Color3.fromRGB(255, 205, 124), TextScaled = true, TextStrokeColor3 = Color3.fromRGB(255, 205, 124), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 10 })
			I[6] = new("TextLabel", I[4], "Sign", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 185, 87), BorderSizePixel = 5, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.05, 0), Size = UDim2.fromScale(0.9, 1), Text = "$", TextColor3 = Color3.fromRGB(255, 205, 124), TextScaled = true, TextStrokeColor3 = Color3.fromRGB(255, 205, 124), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10 })
		I[7] = new("TextButton", I[1], "Music", { BackgroundColor3 = Color3.fromRGB(182, 145, 99), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.655, 0.02), Size = UDim2.fromScale(0.15, 0.065), Text = "Turn Music Off", TextColor3 = Color3.fromRGB(255, 205, 124), ZIndex = 10 })
			I[8] = new("StringValue", I[7], "Status", { Value = "On" })
			I[9] = new("Sound", I[7], "Music")
		I[10] = new("TextButton", I[1], "Spawn", { BackgroundColor3 = Color3.fromRGB(182, 145, 99), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(126, 101, 47), BorderSizePixel = 3, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.455, 0.02), Size = UDim2.fromScale(0.15, 0.065), Text = "Set Spawn", TextColor3 = Color3.fromRGB(255, 205, 124), ZIndex = 10 })
	I[11] = new("ScreenGui", nil, "Stamina")
		I[12] = new("Frame", I[11], "Frame", { BackgroundColor3 = Color3.fromRGB(51, 109, 47), BackgroundTransparency = 0.2, BorderColor3 = Color3.fromRGB(24, 24, 24), BorderSizePixel = 3, Position = UDim2.fromScale(0.1, 0.85), Size = UDim2.fromScale(0.15, 0.075) })
			I[13] = new("Frame", I[12], "Frame", { BackgroundColor3 = Color3.fromRGB(78, 168, 73), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(24, 24, 24), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
			I[14] = new("TextLabel", I[12], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Stamina", TextColor3 = Color3.fromRGB(25, 25, 25), TextScaled = true, TextWrapped = true, ZIndex = 3 })
			I[15] = new("NumberValue", I[12], "Value", { Value = 100 })
	return { I[1], I[11] }
end

return build
