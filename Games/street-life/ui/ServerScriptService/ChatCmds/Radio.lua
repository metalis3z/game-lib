-- Generated from ui/ServerScriptService/ChatCmds/Radio.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Radio", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { BackgroundColor3 = Color3.fromRGB(81, 81, 81), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.1320754, 0.1513002), Size = UDim2.fromScale(0.2797203, 0.2288995), Visible = false })
			I[3] = new("Frame", I[2], "Chatter", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.2013953), Size = UDim2.fromScale(1, 0.7866089) })
				I[4] = new("TextLabel", I[3], "Line1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, 0), Size = UDim2.fromScale(0.9818529, 0.2), Text = "Hi", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[5] = new("TextLabel", I[3], "Line5", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, 0.8), Size = UDim2.fromScale(0.9818529, 0.2000001), Text = "Hi", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[6] = new("TextLabel", I[3], "Line4", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, 0.6000001), Size = UDim2.fromScale(0.9818529, 0.2), Text = "Hi", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[7] = new("TextLabel", I[3], "Line3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, 0.4), Size = UDim2.fromScale(0.9818529, 0.2), Text = "Hi", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[8] = new("TextLabel", I[3], "Line2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0000001, 0.1999999), Size = UDim2.fromScale(0.9818529, 0.2), Text = "Hi", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[9] = new("UIListLayout", I[3], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Right })
			I[10] = new("TextButton", I[2], "Activate", { BackgroundColor3 = Color3.fromRGB(173, 0, 0), BackgroundTransparency = 0.1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3100097, 0.0410044), Size = UDim2.fromScale(0.3757732, 0.1554082), Text = "OFF", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[11] = new("UIStroke", I[10], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2, Transparency = 0.1 })
				I[12] = new("UICorner", I[10], "UICorner")
			I[13] = new("TextLabel", I[2], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1949588, -0.200814), Size = UDim2.fromScale(0.6186519, 0.2049123), Text = "RADIO", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 2, Transparency = 0.1 })
			I[15] = new("TextButton", I[2], "EA", { BackgroundColor3 = Color3.fromRGB(220, 58, 9), BackgroundTransparency = 0.1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8546226, 0.040656), Size = UDim2.fromScale(0.1262116, 0.1587643), Text = "!!!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[16] = new("UICorner", I[15], "UICorner")
				I[17] = new("UIStroke", I[15], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2, Transparency = 0.1 })
			I[18] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2, Transparency = 0.1 })
			I[19] = new("UICorner", I[2], "UICorner")
			I[20] = new("TextBox", I[2], "TextBox", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(81, 81, 81), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "Chat Here", Position = UDim2.fromScale(0.5025944, 1.1604921), Size = UDim2.fromOffset(180, 40), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true })
				I[21] = new("UICorner", I[20], "UICorner")
				I[22] = new("UIStroke", I[20], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2, Transparency = 0.1 })
			I[23] = new("ImageButton", I[2], "Send", { BackgroundColor3 = Color3.fromRGB(81, 81, 81), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 255), ImageContent = Content.fromUri("rbxassetid://3926307971"), ImageRectOffset = Vector2.new(684, 484), ImageRectSize = Vector2.new(36, 36), ImageTransparency = 0.2, Position = UDim2.fromScale(0.7411585, 1.0520487), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0968835, 0.2065593) })
				I[24] = new("UIStroke", I[23], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2, Transparency = 0.1 })
				I[25] = new("UICorner", I[23], "UICorner")
		I[26] = new("TextButton", I[1], "Min", { BackgroundColor3 = Color3.fromRGB(81, 81, 81), BackgroundTransparency = 0.5, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1081277, 0.1111111), Size = UDim2.fromScale(0.0189328, 0.0312138), Text = "+", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, ZIndex = 2 })
			I[27] = new("UIStroke", I[26], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
			I[28] = new("UICorner", I[26], "UICorner")
		I[29] = new("Sound", I[1], "Distress", { Volume = 3 })
	return I[1]
end

return build
