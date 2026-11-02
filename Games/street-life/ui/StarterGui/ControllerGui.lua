-- Generated from ui/StarterGui/ControllerGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ControllerGui", { Enabled = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(80, 80, 80), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4996653, 0.2630273), Size = UDim2.fromScale(0.46921, 0.4962779) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.04, 0), BottomRightRadius = UDim.new(0.04, 0), TopLeftRadius = UDim.new(0.04, 0), TopRightRadius = UDim.new(0.04, 0) })
			I[4] = new("TextLabel", I[2], "Top", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.1254052), Text = "Controller Support", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[5] = new("Frame", I[2], "Spawners", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(49, 49, 49), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2115054, 0.5830273), Size = UDim2.fromScale(0.3579404, 0.7512779) })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
				I[7] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(0, 170, 0), Thickness = 2 })
				I[8] = new("ScrollingFrame", I[5], "List", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(49, 49, 49), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 4), Position = UDim2.fromScale(0.5, 0.517), ScrollBarThickness = 5, Size = UDim2.fromScale(1, 0.967) })
					I[9] = new("UIListLayout", I[8], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.002, 0), SortOrder = Enum.SortOrder.LayoutOrder })
					I[10] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
			I[11] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 })
			I[12] = new("TextLabel", I[2], "SpawnerText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0325352, 0.1), Size = UDim2.fromScale(0.3579404, 0.0904052), Text = "Spawners", TextColor3 = Color3.fromRGB(0, 170, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.3, TextWrapped = true })
			I[13] = new("Frame", I[2], "Commands", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(49, 49, 49), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.7892517, 0.5830273), Size = UDim2.fromScale(0.3579404, 0.7512779) })
				I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
				I[15] = new("UIStroke", I[13], "UIStroke", { Thickness = 2 })
				I[16] = new("ScrollingFrame", I[13], "List", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(49, 49, 49), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 4), Position = UDim2.fromScale(0.5, 0.517), ScrollBarThickness = 5, Size = UDim2.fromScale(1, 0.967) })
					I[17] = new("UIListLayout", I[16], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.002, 0), SortOrder = Enum.SortOrder.LayoutOrder })
					I[18] = new("TextButton", I[16], "/signin", { BackgroundColor3 = Color3.fromRGB(100, 100, 100), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1014603, 0), Size = UDim2.fromScale(0.899, 0.037), Text = "/signin", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.2, TextWrapped = true })
						I[19] = new("UICorner", I[18], "UICorner")
						I[20] = new("UIStroke", I[18], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
					I[21] = new("TextButton", I[16], "/drop", { BackgroundColor3 = Color3.fromRGB(100, 100, 100), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1014603, 0), Size = UDim2.fromScale(0.899, 0.037), Text = "/drop", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.2, TextWrapped = true })
						I[22] = new("UICorner", I[21], "UICorner")
						I[23] = new("UIStroke", I[21], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
					I[24] = new("TextButton", I[16], "/respawn", { BackgroundColor3 = Color3.fromRGB(100, 100, 100), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1014603, 0), Size = UDim2.fromScale(0.899, 0.037), Text = "/respawn", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.2, TextWrapped = true })
						I[25] = new("UICorner", I[24], "UICorner")
						I[26] = new("UIStroke", I[24], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
					I[27] = new("TextButton", I[16], "/lock", { BackgroundColor3 = Color3.fromRGB(100, 100, 100), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1014603, 0), Size = UDim2.fromScale(0.899, 0.037), Text = "/lock", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.2, TextWrapped = true })
						I[28] = new("UICorner", I[27], "UICorner")
						I[29] = new("UIStroke", I[27], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
					I[30] = new("TextButton", I[16], "/unlock", { BackgroundColor3 = Color3.fromRGB(100, 100, 100), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1014603, 0), Size = UDim2.fromScale(0.899, 0.037), Text = "/unlock", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.2, TextWrapped = true })
						I[31] = new("UICorner", I[30], "UICorner")
						I[32] = new("UIStroke", I[30], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
					I[33] = new("TextButton", I[16], "!help", { BackgroundColor3 = Color3.fromRGB(100, 100, 100), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1014603, 0), Size = UDim2.fromScale(0.899, 0.037), Text = "/signout", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.2, TextWrapped = true })
						I[34] = new("UICorner", I[33], "UICorner")
						I[35] = new("UIStroke", I[33], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
					I[36] = new("TextButton", I[16], "/spawn pd", { BackgroundColor3 = Color3.fromRGB(100, 100, 100), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1014603, 0), Size = UDim2.fromScale(0.899, 0.037), Text = "/spawn pd", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.2, TextWrapped = true })
						I[37] = new("UICorner", I[36], "UICorner")
						I[38] = new("UIStroke", I[36], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
					I[39] = new("TextButton", I[16], "/spawn pd2", { BackgroundColor3 = Color3.fromRGB(100, 100, 100), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1014603, 0), Size = UDim2.fromScale(0.899, 0.037), Text = "/spawn pd2", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.2, TextWrapped = true })
						I[40] = new("UICorner", I[39], "UICorner")
						I[41] = new("UIStroke", I[39], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
			I[42] = new("TextLabel", I[2], "CommandsText", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6102815, 0.1), Size = UDim2.fromScale(0.3579404, 0.0904052), Text = "Commands", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(255, 255, 255), TextStrokeTransparency = 0.2, TextWrapped = true })
			I[43] = new("Frame", I[2], "Pay", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 0.1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4996065, 1.0801483), Size = UDim2.fromScale(0.3846835, 0.127389) })
				I[44] = new("TextLabel", I[43], "Text", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0227736, 0.0730541), Size = UDim2.fromScale(0.3798185, 0.8015607), Text = "/pay", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[45] = new("UIStroke", I[44], "UIStroke", { Thickness = 2 })
				I[46] = new("TextBox", I[43], "TextBox", { BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.4582287, 0.0915878), Size = UDim2.fromScale(0.5090071, 0.7907733), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[47] = new("UICorner", I[46], "UICorner")
					I[48] = new("UIStroke", I[46], "UIStroke", { Thickness = 2 })
					I[49] = new("UIStroke", I[46], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(150, 150, 150) })
					I[50] = new("UITextSizeConstraint", I[46], "UITextSizeConstraint", { MaxTextSize = 30, MinTextSize = 15 })
				I[51] = new("UIStroke", I[43], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255) })
				I[52] = new("UICorner", I[43], "UICorner")
		I[53] = new("TextButton", I[1], "Template", { BackgroundColor3 = Color3.fromRGB(100, 100, 100), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1014603, 0), Size = UDim2.fromScale(0.899, 0.037), Text = "Template", TextColor3 = Color3.fromRGB(0, 170, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0.3, TextWrapped = true, Visible = false })
			I[54] = new("UICorner", I[53], "UICorner")
			I[55] = new("UIStroke", I[53], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
		I[56] = new("TextButton", I[1], "Close", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6964401, 0.0148883), Size = UDim2.fromScale(0.0378302, 0.0496278), Text = "X", TextColor3 = Color3.fromRGB(255, 0, 4), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
	return I[1]
end

return build
