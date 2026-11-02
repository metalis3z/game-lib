-- Generated from ui/StarterGui/SettingsBar.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SettingsBar", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Bar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(36, 36, 36), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0293402, 0.6663604), Size = UDim2.fromScale(0.0454082, 0.2178174) })
			I[3] = new("UIStroke", I[2], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(121, 121, 121), Thickness = 0 })
			I[4] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(25, 25, 25), Thickness = 2 })
			I[5] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.05, 8), BottomRightRadius = UDim.new(0.05, 8), TopLeftRadius = UDim.new(0.05, 8), TopRightRadius = UDim.new(0.05, 8) })
			I[6] = new("TextButton", I[2], "SpectateButton", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, -0.05), Size = UDim2.fromScale(0.8449088, 0.3097569), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[7] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(163, 163, 163), Thickness = 3 })
				I[8] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.05, 8), BottomRightRadius = UDim.new(0.05, 8), TopLeftRadius = UDim.new(0.05, 8), TopRightRadius = UDim.new(0.05, 8) })
				I[9] = new("UIStroke", I[6], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
				I[10] = new("TextButton", I[6], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0100059, 0.9819995), Selectable = false, Size = UDim2.fromScale(1.0800691, 0.3682504), Text = "SPECTATE", TextColor3 = Color3.fromRGB(183, 183, 183), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 3 })
				I[12] = new("ImageLabel", I[6], "EyeIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://299432427"), Position = UDim2.fromScale(0.5, 0.504), Size = UDim2.fromScale(0.9094815, 1.0857658) })
			I[13] = new("TextButton", I[2], "SettingsButton", { AnchorPoint = Vector2.new(0.025, 0.025), BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1, -0.5), Size = UDim2.fromScale(0.845, 0.31), Text = "", TextColor3 = Color3.fromRGB(254, 255, 255), TextSize = 14, TextWrapped = true })
				I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.05, 8), BottomRightRadius = UDim.new(0.05, 8), TopLeftRadius = UDim.new(0.05, 8), TopRightRadius = UDim.new(0.05, 8) })
				I[15] = new("UIStroke", I[13], "UIStroke", { Color = Color3.fromRGB(163, 163, 163), Thickness = 3 })
				I[16] = new("UIStroke", I[13], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
				I[17] = new("ImageLabel", I[13], "ImageLabel", { AnchorPoint = Vector2.new(0.025, 0.025), BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(232, 232, 232), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=14843657409"), ImageTransparency = 0.3, Position = UDim2.fromScale(0.12, 0.875), Size = UDim2.fromScale(0.8197887, -0.8240598) })
					I[18] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(0.05, 8), BottomRightRadius = UDim.new(0.05, 8), TopLeftRadius = UDim.new(0.05, 8), TopRightRadius = UDim.new(0.05, 8) })
				I[19] = new("TextButton", I[13], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.0099442, 0.9999996), Selectable = false, Size = UDim2.fromScale(1.0793308, 0.3683038), Text = "SETTINGS", TextColor3 = Color3.fromRGB(183, 183, 183), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 3 })
			I[21] = new("Frame", I[2], "SpectateMain", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), Position = UDim2.fromScale(8.5, 2.5), Size = UDim2.fromScale(4.6593165, 0.3349375) })
				I[22] = new("UIStroke", I[21], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
				I[23] = new("UICorner", I[21], "UICorner")
				I[24] = new("TextLabel", I[21], "PlayerName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.9866951), Text = "Nobody", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[25] = new("UIStroke", I[24], "UIStroke", { Color = Color3.fromRGB(161, 161, 161) })
				I[26] = new("TextButton", I[21], "Previous", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.3324681, 0), Size = UDim2.fromScale(0.291371, 0.9999996), Text = "<", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 1, TextWrapped = true })
					I[27] = new("UIStroke", I[26], "UIStroke", { Thickness = 3 })
					I[28] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0.05, 8), BottomRightRadius = UDim.new(0.05, 8), TopLeftRadius = UDim.new(0.05, 8), TopRightRadius = UDim.new(0.05, 8) })
					I[29] = new("UIStroke", I[26], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
				I[30] = new("TextButton", I[21], "Next", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0443542, 0), Size = UDim2.fromScale(0.291, 1), Text = ">", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[31] = new("UIStroke", I[30], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2 })
					I[32] = new("UIStroke", I[30], "UIStroke", { Thickness = 3 })
					I[33] = new("UICorner", I[30], "UICorner", { BottomLeftRadius = UDim.new(0.05, 8), BottomRightRadius = UDim.new(0.05, 8), TopLeftRadius = UDim.new(0.05, 8), TopRightRadius = UDim.new(0.05, 8) })
		I[34] = new("Frame", I[1], "MainFrame", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, -1.03), Size = UDim2.fromScale(0.479, 0.396), ZIndex = 3 })
			I[35] = new("Frame", I[34], "Settings", { Active = true, BackgroundColor3 = Color3.fromRGB(40, 40, 40), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Interactable = false, Position = UDim2.fromScale(0.31, -0.27), Size = UDim2.fromScale(0.4175495, 0.2510957) })
				I[36] = new("TextButton", I[35], "TextButton", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.098, 0.45), Selectable = false, Size = UDim2.fromScale(0.7604563, 0.5839248), Text = "Settings", TextColor3 = Color3.fromRGB(254, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[37] = new("UICorner", I[36], "UICorner", { BottomLeftRadius = UDim.new(0.3, 8), BottomRightRadius = UDim.new(0.3, 8), TopLeftRadius = UDim.new(0.3, 8), TopRightRadius = UDim.new(0.3, 8) })
					I[38] = new("UIAspectRatioConstraint", I[36], "UIAspectRatioConstraint", { AspectRatio = 4 })
			I[39] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(0.05, 8), BottomRightRadius = UDim.new(0.05, 8), TopLeftRadius = UDim.new(0.05, 8), TopRightRadius = UDim.new(0.05, 8) })
			I[40] = new("Frame", I[34], "MuteMusic", { Active = true, BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.041, 0.064), Size = UDim2.fromScale(0.391, 0.22) })
				I[41] = new("TextButton", I[40], "TextButton", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0200001, 0.1954546), Selectable = false, Size = UDim2.fromScale(0.5804998, 0.6095453), Text = "Mute Music", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 25, TextWrapped = true })
					I[42] = new("UICorner", I[41], "UICorner", { BottomLeftRadius = UDim.new(0.02, 8), BottomRightRadius = UDim.new(0.02, 8), TopLeftRadius = UDim.new(0.02, 8), TopRightRadius = UDim.new(0.02, 8) })
				I[43] = new("UICorner", I[40], "UICorner", { BottomLeftRadius = UDim.new(0.3, 8), BottomRightRadius = UDim.new(0.3, 8), TopLeftRadius = UDim.new(0.3, 8), TopRightRadius = UDim.new(0.3, 8) })
				I[44] = new("TextButton", I[40], "On-Off", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.57, 0.2), Selectable = false, Size = UDim2.fromScale(0.3880843, 0.605), Text = "Off", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 35, TextWrapped = true })
					I[45] = new("UICorner", I[44], "UICorner", { BottomLeftRadius = UDim.new(0.02, 8), BottomRightRadius = UDim.new(0.02, 8), TopLeftRadius = UDim.new(0.02, 8), TopRightRadius = UDim.new(0.02, 8) })
			I[46] = new("Frame", I[34], "HidePlayers", { Active = true, BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.567, 0.368), Size = UDim2.fromScale(0.391, 0.22) })
				I[47] = new("UICorner", I[46], "UICorner", { BottomLeftRadius = UDim.new(0.3, 8), BottomRightRadius = UDim.new(0.3, 8), TopLeftRadius = UDim.new(0.3, 8), TopRightRadius = UDim.new(0.3, 8) })
				I[48] = new("ImageButton", I[46], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(253, 253, 253), ImageContent = Content.fromUri("rbxassetid://7992557358"), ImageTransparency = 1, Position = UDim2.fromScale(1.0000001, -0.0000004), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(-0.4419453, 0.9209296) })
					I[49] = new("UICorner", I[48], "UICorner", { BottomLeftRadius = UDim.new(0.02, 8), BottomRightRadius = UDim.new(0.02, 8), TopLeftRadius = UDim.new(0.02, 8), TopRightRadius = UDim.new(0.02, 8) })
				I[50] = new("TextButton", I[46], "TextButton", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.02, 0.2), Selectable = false, Size = UDim2.fromScale(0.5380547, 0.6049999), Text = "Hide Players", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 40, TextWrapped = true })
					I[51] = new("UICorner", I[50], "UICorner", { BottomLeftRadius = UDim.new(0.02, 8), BottomRightRadius = UDim.new(0.02, 8), TopLeftRadius = UDim.new(0.02, 8), TopRightRadius = UDim.new(0.02, 8) })
				I[52] = new("TextButton", I[46], "On-Off", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.57, 0.2), Selectable = false, Size = UDim2.fromScale(0.3880843, 0.605), Text = "Off", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 35, TextWrapped = true })
					I[53] = new("UICorner", I[52], "UICorner", { BottomLeftRadius = UDim.new(0.02, 8), BottomRightRadius = UDim.new(0.02, 8), TopLeftRadius = UDim.new(0.02, 8), TopRightRadius = UDim.new(0.02, 8) })
			I[54] = new("Frame", I[34], "LowPerformance", { Active = true, BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.567, 0.063), Size = UDim2.fromScale(0.391, 0.22) })
				I[55] = new("UICorner", I[54], "UICorner", { BottomLeftRadius = UDim.new(0.3, 8), BottomRightRadius = UDim.new(0.3, 8), TopLeftRadius = UDim.new(0.3, 8), TopRightRadius = UDim.new(0.3, 8) })
				I[56] = new("TextButton", I[54], "TextButton", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.02, 0.2), Selectable = false, Size = UDim2.fromScale(0.5380547, 0.6049999), Text = "LPM", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 40, TextWrapped = true })
					I[57] = new("UICorner", I[56], "UICorner", { BottomLeftRadius = UDim.new(0.02, 8), BottomRightRadius = UDim.new(0.02, 8), TopLeftRadius = UDim.new(0.02, 8), TopRightRadius = UDim.new(0.02, 8) })
				I[58] = new("TextButton", I[54], "On-Off", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.57, 0.2), Selectable = false, Size = UDim2.fromScale(0.3880843, 0.605), Text = "Off", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 35, TextWrapped = true })
					I[59] = new("UICorner", I[58], "UICorner", { BottomLeftRadius = UDim.new(0.02, 8), BottomRightRadius = UDim.new(0.02, 8), TopLeftRadius = UDim.new(0.02, 8), TopRightRadius = UDim.new(0.02, 8) })
			I[60] = new("Frame", I[34], "MuteBoomboxes", { Active = true, BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.041, 0.368), Size = UDim2.fromScale(0.391, 0.22) })
				I[61] = new("UICorner", I[60], "UICorner", { BottomLeftRadius = UDim.new(0.3, 8), BottomRightRadius = UDim.new(0.3, 8), TopLeftRadius = UDim.new(0.3, 8), TopRightRadius = UDim.new(0.3, 8) })
				I[62] = new("TextButton", I[60], "TextButton", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.02, 0.2), Selectable = false, Size = UDim2.fromScale(0.5380547, 0.6049999), Text = "Mute BoomBoxes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextWrapped = true })
					I[63] = new("UICorner", I[62], "UICorner", { BottomLeftRadius = UDim.new(0.02, 8), BottomRightRadius = UDim.new(0.02, 8), TopLeftRadius = UDim.new(0.02, 8), TopRightRadius = UDim.new(0.02, 8) })
				I[64] = new("TextButton", I[60], "On-Off", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.57, 0.2), Selectable = false, Size = UDim2.fromScale(0.3880843, 0.605), Text = "Off", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 35, TextWrapped = true })
					I[65] = new("UICorner", I[64], "UICorner", { BottomLeftRadius = UDim.new(0.02, 8), BottomRightRadius = UDim.new(0.02, 8), TopLeftRadius = UDim.new(0.02, 8), TopRightRadius = UDim.new(0.02, 8) })
			I[66] = new("Frame", I[34], "Split-Bar", { BackgroundColor3 = Color3.fromRGB(70, 70, 70), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.49, 0.031), Size = UDim2.fromScale(0.0156969, 0.9393592) })
				I[67] = new("UICorner", I[66], "UICorner")
			I[68] = new("ImageLabel", I[34], "Fade", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(20, 20, 20), ImageContent = Content.fromUri("rbxassetid://14840801383"), ImageTransparency = 0.5, Position = UDim2.fromScale(0.5, 0.7973685), Size = UDim2.fromScale(1, 0.4052634) })
				I[69] = new("UICorner", I[68], "UICorner", { BottomLeftRadius = UDim.new(0.11, 8), BottomRightRadius = UDim.new(0.11, 8), TopLeftRadius = UDim.new(0.11, 8), TopRightRadius = UDim.new(0.11, 8) })
			I[70] = new("ImageLabel", I[34], "Pattern", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://14841319882"), ImageTransparency = 0.25, Position = UDim2.fromScale(0.495, 0.6), Size = UDim2.fromScale(1, 0.4) })
			I[71] = new("Frame", I[34], "Day/Night", { Active = true, BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.567, 0.675), Size = UDim2.fromScale(0.391, 0.22) })
				I[72] = new("UICorner", I[71], "UICorner", { BottomLeftRadius = UDim.new(0.3, 8), BottomRightRadius = UDim.new(0.3, 8), TopLeftRadius = UDim.new(0.3, 8), TopRightRadius = UDim.new(0.3, 8) })
				I[73] = new("ImageButton", I[71], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(253, 253, 253), ImageContent = Content.fromUri("rbxassetid://7992557358"), ImageTransparency = 1, Position = UDim2.fromScale(1.0000001, -0.0000004), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(-0.4419453, 0.9209296) })
					I[74] = new("UICorner", I[73], "UICorner", { BottomLeftRadius = UDim.new(0.02, 8), BottomRightRadius = UDim.new(0.02, 8), TopLeftRadius = UDim.new(0.02, 8), TopRightRadius = UDim.new(0.02, 8) })
				I[75] = new("TextButton", I[71], "TextButton", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.02, 0.2), Selectable = false, Size = UDim2.fromScale(0.5380547, 0.6049999), Text = "Time", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 40, TextWrapped = true })
					I[76] = new("UICorner", I[75], "UICorner", { BottomLeftRadius = UDim.new(0.02, 8), BottomRightRadius = UDim.new(0.02, 8), TopLeftRadius = UDim.new(0.02, 8), TopRightRadius = UDim.new(0.02, 8) })
				I[77] = new("TextButton", I[71], "On-Off", { BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Balthazar.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.57, 0.2), Selectable = false, Size = UDim2.fromScale(0.3880843, 0.605), Text = "Day", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 35, TextWrapped = true })
					I[78] = new("UICorner", I[77], "UICorner", { BottomLeftRadius = UDim.new(0.02, 8), BottomRightRadius = UDim.new(0.02, 8), TopLeftRadius = UDim.new(0.02, 8), TopRightRadius = UDim.new(0.02, 8) })
			I[79] = new("Frame", I[34], "FOV", { BackgroundColor3 = Color3.fromRGB(40, 40, 40), BorderSizePixel = 0, Position = UDim2.fromScale(0.041, 0.675), Size = UDim2.fromScale(0.391, 0.22) })
				I[80] = new("TextLabel", I[79], "Text", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0355399, 0.2383568), Size = UDim2.fromScale(0.3465209, 0.5157987), Text = "FOV", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
				I[81] = new("Frame", I[79], "WhiteBar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.3904707, 0.1424333), Size = UDim2.fromScale(0.0054442, 0.7058056) })
					I[82] = new("UIGradient", I[81], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1995012, 0), NumberSequenceKeypoint.new(0.8004988, 0), NumberSequenceKeypoint.new(1, 1) }) })
				I[83] = new("Frame", I[79], "FOVConfig", { BackgroundColor3 = Color3.fromRGB(30, 30, 30), BorderSizePixel = 0, Position = UDim2.fromScale(0.4545644, 0.0906352), Size = UDim2.fromScale(0.5183026, 0.8133137) })
					I[84] = new("UICorner", I[83], "UICorner", { BottomLeftRadius = UDim.new(0.2, 8), BottomRightRadius = UDim.new(0.2, 8), TopLeftRadius = UDim.new(0.2, 8), TopRightRadius = UDim.new(0.2, 8) })
					I[85] = new("Frame", I[83], "SetFOV", { BackgroundColor3 = Color3.fromRGB(42, 42, 42), BorderSizePixel = 0, Position = UDim2.fromScale(-0.2750765, 1.2190795), Size = UDim2.fromScale(0.7263101, 0.3635555), ZIndex = 2 })
						I[86] = new("UICorner", I[85], "UICorner", { BottomLeftRadius = UDim.new(0.25, 0), BottomRightRadius = UDim.new(0.25, 0), TopLeftRadius = UDim.new(0.25, 0), TopRightRadius = UDim.new(0.25, 0) })
						I[87] = new("TextButton", I[85], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = " ", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[88] = new("TextLabel", I[85], "Text", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1402537, 0.2247331), Size = UDim2.fromScale(0.7173579, 0.5415497), Text = "Set FOV", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[89] = new("UIGradient", I[85], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(207, 207, 207)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
						I[90] = new("ImageLabel", I[85], "Sample", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4560909609"), ImageTransparency = 0.6 })
					I[91] = new("TextBox", I[83], "FOVSet", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Light, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(168, 168, 168), PlaceholderText = "70 - 120", Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[92] = new("UICorner", I[79], "UICorner", { BottomLeftRadius = UDim.new(0.3, 8), BottomRightRadius = UDim.new(0.3, 8), TopLeftRadius = UDim.new(0.3, 8), TopRightRadius = UDim.new(0.3, 8) })
	return I[1]
end

return build
