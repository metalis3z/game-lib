-- Generated from ui/StarterGui/Emotes.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Emotes", { Enabled = false, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(100, 100, 100), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1287159, 0.0769231), Size = UDim2.fromScale(0.1435535, 0.3287841) })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("TextLabel", I[2], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.0698915), Size = UDim2.fromScale(1, 0.1412628), Text = "EMOTES", TextColor3 = Color3.fromRGB(0, 170, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true })
			I[5] = new("ScrollingFrame", I[2], "ScrollingFrame", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 4), Position = UDim2.fromScale(0, 0.1405229), ScrollBarThickness = 5, Size = UDim2.fromScale(1.0000001, 0.8594771) })
				I[6] = new("UIListLayout", I[5], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.002, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[7] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Sturdy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[8] = new("UICorner", I[7], "UICorner")
				I[9] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Sturdy2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[10] = new("UICorner", I[9], "UICorner")
				I[11] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Turnup", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[12] = new("UICorner", I[11], "UICorner")
				I[13] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Hands", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[14] = new("UICorner", I[13], "UICorner")
				I[15] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Count", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[16] = new("UICorner", I[15], "UICorner")
				I[17] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Spit", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[18] = new("UICorner", I[17], "UICorner")
				I[19] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Hype", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[20] = new("UICorner", I[19], "UICorner")
				I[21] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Pushups", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[22] = new("UICorner", I[21], "UICorner")
				I[23] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Pockets", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[24] = new("UICorner", I[23], "UICorner")
				I[25] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Hoodie", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[26] = new("UICorner", I[25], "UICorner")
				I[27] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Dab", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[28] = new("UICorner", I[27], "UICorner")
				I[29] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Box", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[30] = new("UICorner", I[29], "UICorner")
				I[31] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Sturdy3", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[32] = new("UICorner", I[31], "UICorner")
				I[33] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Griddy", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[34] = new("UICorner", I[33], "UICorner")
				I[35] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "TakeTheL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[36] = new("UICorner", I[35], "UICorner")
				I[37] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Speed", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[38] = new("UICorner", I[37], "UICorner")
				I[39] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Lean", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[40] = new("UICorner", I[39], "UICorner")
				I[41] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Cross", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[42] = new("UICorner", I[41], "UICorner")
				I[43] = new("TextButton", I[5], "TextButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8980107, 0.6539856), Size = UDim2.fromScale(0.85, 0.035), Text = "Situps", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[44] = new("UICorner", I[43], "UICorner")
			I[45] = new("TextButton", I[2], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9274225, 0.0649748), Size = UDim2.fromScale(0.1441177, 0.1118805), Text = "X", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.5, TextWrapped = true })
				I[46] = new("UICorner", I[45], "UICorner")
			I[47] = new("UIStroke", I[2], "UIStroke")
	return I[1]
end

return build
