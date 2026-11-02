-- Generated from ui/ServerScriptService/ServerLog/ConsoleRepfirst/ConsoleGUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ConsoleGUI")
		I[2] = new("Frame", I[1], "Main", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(0.5, -350, 0.5, -192), Size = UDim2.fromOffset(701, 385), Style = Enum.FrameStyle.RobloxSquare, ZIndex = 4 })
			I[3] = new("Frame", I[2], "Controls", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 11, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Size = UDim2.new(1, 0, 0, 30), ZIndex = 5 })
				I[4] = new("Frame", I[3], "Settings", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Size = UDim2.new(0, 135, 1, 0), ZIndex = 5 })
					I[5] = new("Frame", I[4], "Info", { BackgroundColor3 = Color3.fromRGB(225, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(70, 0), Size = UDim2.fromOffset(30, 30), ZIndex = 5 })
						I[6] = new("Frame", I[5], "Border", { BackgroundColor3 = Color3.fromRGB(0, 81, 255), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 3), ZIndex = 5 })
						I[7] = new("Frame", I[5], "Border", { BackgroundColor3 = Color3.fromRGB(0, 81, 255), BorderSizePixel = 0, Size = UDim2.new(0, 3, 1, 0), ZIndex = 5 })
						I[8] = new("Frame", I[5], "Border", { BackgroundColor3 = Color3.fromRGB(0, 81, 255), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, -3, 1, 0), ZIndex = 5 })
						I[9] = new("Frame", I[5], "Border", { BackgroundColor3 = Color3.fromRGB(0, 81, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, -3), ZIndex = 5 })
						I[10] = new("Frame", I[5], "Center", { BackgroundColor3 = Color3.fromRGB(0, 81, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 1, -12), ZIndex = 5 })
						I[11] = new("TextButton", I[5], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 5 })
					I[12] = new("Frame", I[4], "Warning", { BackgroundColor3 = Color3.fromRGB(225, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(35, 0), Size = UDim2.fromOffset(30, 30), ZIndex = 5 })
						I[13] = new("Frame", I[12], "Border", { BackgroundColor3 = Color3.fromRGB(234, 98, 19), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 3), ZIndex = 5 })
						I[14] = new("Frame", I[12], "Border", { BackgroundColor3 = Color3.fromRGB(234, 98, 19), BorderSizePixel = 0, Size = UDim2.new(0, 3, 1, 0), ZIndex = 5 })
						I[15] = new("Frame", I[12], "Border", { BackgroundColor3 = Color3.fromRGB(234, 98, 19), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, -3, 1, 0), ZIndex = 5 })
						I[16] = new("Frame", I[12], "Border", { BackgroundColor3 = Color3.fromRGB(234, 98, 19), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, -3), ZIndex = 5 })
						I[17] = new("Frame", I[12], "Center", { BackgroundColor3 = Color3.fromRGB(234, 98, 19), BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 1, -12), ZIndex = 5 })
						I[18] = new("TextButton", I[12], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 5 })
					I[19] = new("Frame", I[4], "Error", { BackgroundColor3 = Color3.fromRGB(225, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(30, 30), ZIndex = 5 })
						I[20] = new("Frame", I[19], "Border", { BackgroundColor3 = Color3.fromRGB(223, 0, 0), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 3), ZIndex = 5 })
						I[21] = new("Frame", I[19], "Border", { BackgroundColor3 = Color3.fromRGB(223, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0, 3, 1, 0), ZIndex = 5 })
						I[22] = new("Frame", I[19], "Border", { BackgroundColor3 = Color3.fromRGB(223, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, -3, 1, 0), ZIndex = 5 })
						I[23] = new("Frame", I[19], "Border", { BackgroundColor3 = Color3.fromRGB(223, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, -3), ZIndex = 5 })
						I[24] = new("Frame", I[19], "Center", { BackgroundColor3 = Color3.fromRGB(223, 0, 0), BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 1, -12), ZIndex = 5 })
						I[25] = new("TextButton", I[19], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 5 })
					I[26] = new("Frame", I[4], "Output", { BackgroundColor3 = Color3.fromRGB(225, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(105, 0), Size = UDim2.fromOffset(30, 30), ZIndex = 5 })
						I[27] = new("Frame", I[26], "Border", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 3), ZIndex = 5 })
						I[28] = new("Frame", I[26], "Border", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.new(0, 3, 1, 0), ZIndex = 5 })
						I[29] = new("Frame", I[26], "Border", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, -3, 1, 0), ZIndex = 5 })
						I[30] = new("Frame", I[26], "Border", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, -3), ZIndex = 5 })
						I[31] = new("Frame", I[26], "Center", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 1, -12), ZIndex = 5 })
						I[32] = new("TextButton", I[26], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextSize = 14, ZIndex = 5 })
				I[33] = new("Frame", I[3], "Filter", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.fromOffset(148, 0), Size = UDim2.new(0, 200, 1, 0), ZIndex = 5 })
					I[34] = new("TextLabel", I[33], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Filter:", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5 })
					I[35] = new("TextBox", I[33], "TextFilter", { BackgroundColor3 = Color3.fromRGB(56, 56, 56), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Italic), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromOffset(45, 0), Size = UDim2.new(1, -45, 1, 0), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, ZIndex = 5 })
				I[36] = new("Frame", I[3], "Wrap", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.fromOffset(361, 0), Size = UDim2.new(0, 71, 1, 0), ZIndex = 5 })
					I[37] = new("TextLabel", I[36], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "Wrap", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5 })
					I[38] = new("Frame", I[36], "White", { BackgroundColor3 = Color3.fromRGB(188, 188, 188), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(40, 0), Size = UDim2.fromOffset(30, 30), ZIndex = 5 })
						I[39] = new("Frame", I[38], "Border", { BackgroundColor3 = Color3.fromRGB(188, 188, 188), BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 3), ZIndex = 5 })
						I[40] = new("Frame", I[38], "Border", { BackgroundColor3 = Color3.fromRGB(188, 188, 188), BorderSizePixel = 0, Size = UDim2.new(0, 3, 1, 0), ZIndex = 5 })
						I[41] = new("Frame", I[38], "Border", { BackgroundColor3 = Color3.fromRGB(188, 188, 188), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, -3, 1, 0), ZIndex = 5 })
						I[42] = new("Frame", I[38], "Border", { BackgroundColor3 = Color3.fromRGB(188, 188, 188), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, -3), ZIndex = 5 })
						I[43] = new("Frame", I[38], "Center", { BackgroundColor3 = Color3.fromRGB(188, 188, 188), BorderSizePixel = 0, Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 1, -12), ZIndex = 5 })
				I[44] = new("Frame", I[3], "Title", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.fromOffset(445, 0), Size = UDim2.new(1, -488, 1, 0), Visible = false, ZIndex = 5 })
					I[45] = new("TextLabel", I[44], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "nConsole", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 28, ZIndex = 5 })
				I[46] = new("Frame", I[3], "Close", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, -30, 1, 0), ZIndex = 5 })
					I[47] = new("TextButton", I[46], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "X", TextColor3 = Color3.fromRGB(255, 0, 0), TextSize = 32, ZIndex = 5 })
				I[48] = new("Frame", I[3], "Page", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.fromOffset(445, 0), Size = UDim2.new(1, -488, 1, 0), ZIndex = 5 })
					I[49] = new("TextButton", I[48], "Left", { BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromOffset(30, 30), Text = "<", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32, ZIndex = 5 })
					I[50] = new("TextBox", I[48], "CurrentPage", { BackgroundColor3 = Color3.fromRGB(68, 68, 68), BorderColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), Position = UDim2.fromOffset(35, 0), Size = UDim2.fromOffset(60, 30), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, ZIndex = 5 })
					I[51] = new("TextLabel", I[48], "MaxPages", { BackgroundColor3 = Color3.fromRGB(21, 21, 21), BorderColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromOffset(100, 0), Size = UDim2.fromOffset(60, 30), Text = "/ 1", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18, ZIndex = 5 })
					I[52] = new("TextButton", I[48], "Right", { BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderColor3 = Color3.fromRGB(0, 0, 0), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.new(1, -30, 0, 0), Size = UDim2.fromOffset(30, 30), Text = ">", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 32, ZIndex = 5 })
			I[53] = new("Frame", I[2], "Output", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 5, Position = UDim2.fromOffset(0, 45), Size = UDim2.new(1, 0, 1, -45), ZIndex = 4 })
				I[54] = new("Frame", I[53], "ScrollBar", { BackgroundColor3 = Color3.fromRGB(67, 67, 67), BorderSizePixel = 0, Position = UDim2.new(1, -5, 0, 0), Size = UDim2.new(0, 2, 1, 0), ZIndex = 5 })
				I[55] = new("Frame", I[53], "NoPage", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 5 })
	return I[1]
end

return build
