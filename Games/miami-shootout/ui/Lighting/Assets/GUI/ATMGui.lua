-- Generated from ui/Lighting/Assets/GUI/ATMGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ATMGui")
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(67, 67, 67), BackgroundTransparency = 0.1, Position = UDim2.fromScale(0.334, 0.244), Size = UDim2.fromScale(0.333, 0.511) })
			I[3] = new("TextBox", I[2], "TextBox", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.85, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromScale(0.2572115, 0.3557692), Size = UDim2.fromScale(0.4807692, 0.1201923), Text = "Amount Here", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[4] = new("UICorner", I[3], "UICorner")
			I[5] = new("TextButton", I[2], "withdraw", { BackgroundColor3 = Color3.fromRGB(102, 0, 153), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Modal = true, Position = UDim2.fromScale(0.2596154, 0.7836539), Size = UDim2.fromScale(0.4807692, 0.1201923), Text = "Withdraw", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[6] = new("UICorner", I[5], "UICorner")
			I[7] = new("TextButton", I[2], "depost", { BackgroundColor3 = Color3.fromRGB(102, 0, 153), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2596154, 0.6298077), Size = UDim2.fromScale(0.4807692, 0.1201923), Text = "Deposit", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("UICorner", I[7], "UICorner")
			I[9] = new("TextButton", I[2], "closeBtn", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.90625, 0), Size = UDim2.fromScale(0.09375, 0.0673077), Text = "X", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[10] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2596154, 0.4927884), Size = UDim2.fromScale(0.4807692, 0.1201923), Text = "Tip: The only way to send money to players directly from your bank is by using a check! (/check user amount)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[11] = new("TextLabel", I[2], "balance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2572115, 0.1538461), Size = UDim2.fromScale(0.4807692, 0.1201923), Text = "Balance: 0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[12] = new("TextLabel", I[2], "bankName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2067308, 0), Size = UDim2.fromScale(0.5841346, 0.1201923), Text = "Tha Bronx Trust Banking", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[13] = new("TextLabel", I[2], "copyright", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.9409554), Size = UDim2.fromScale(0.3485577, 0.0576923), Text = "Please follow all bank safety measures.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[14] = new("RemoteEvent", I[2], "close")
			I[15] = new("UICorner", I[2], "UICorner")
	return I[1]
end

return build
