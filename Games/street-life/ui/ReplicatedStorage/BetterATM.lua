-- Generated from ui/ReplicatedStorage/BetterATM.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BetterATM", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4152249, 0.5334989) })
			I[3] = new("Folder", I[2], "Misc")
				I[4] = new("Sound", I[3], "Click", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 })
				I[5] = new("Sound", I[3], "Error", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 })
				I[6] = new("ObjectValue", I[3], "Part")
				I[7] = new("Sound", I[3], "Approved", { RollOffMode = Enum.RollOffMode.InverseTapered, Volume = 1 })
			I[8] = new("TextLabel", I[2], "Balance", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Guru.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5316667, 0.08), RichText = true, Size = UDim2.fromScale(0.45, 0.0666669), Text = "Account Balance $1000", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[9] = new("UITextSizeConstraint", I[8], "UITextSizeConstraint", { MaxTextSize = 30 })
			I[10] = new("TextLabel", I[2], "BANK", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1216667, 0.0222222), RichText = true, Size = UDim2.fromScale(0.1333333, 0.0822225), Text = "BANK", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[11] = new("TextLabel", I[2], "Game", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1216665, 0.08), RichText = true, Size = UDim2.fromScale(0.160462, 0.0666669), Text = "OF STREET LIFE", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[12] = new("Frame", I[2], "Interact", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.6422222), Size = UDim2.fromScale(0.8333333, 0.6444442) })
				I[13] = new("TextButton", I[12], "Deposit", { BackgroundColor3 = Color3.fromRGB(7, 7, 172), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.25, 0.2177608), Size = UDim2.fromScale(0.5000001, 0.1833492), Text = "Deposit", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[14] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
					I[15] = new("UITextSizeConstraint", I[13], "UITextSizeConstraint", { MaxTextSize = 30 })
				I[16] = new("TextButton", I[12], "Withdraw", { BackgroundColor3 = Color3.fromRGB(7, 7, 172), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.25, 0.490816), Size = UDim2.fromScale(0.5000001, 0.1833492), Text = "Withdraw", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[17] = new("UICorner", I[16], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
					I[18] = new("UITextSizeConstraint", I[16], "UITextSizeConstraint", { MaxTextSize = 30 })
				I[19] = new("Frame", I[12], "FrameWithdraw", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4990002, 0.4690064), Size = UDim2.fromScale(0.998, 0.7238348), Visible = false })
					I[20] = new("TextButton", I[19], "Withdraw", { BackgroundColor3 = Color3.fromRGB(7, 7, 172), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2499999, 0.4459468), Size = UDim2.fromScale(0.5000001, 0.2032911), Text = "Withdraw", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[21] = new("UICorner", I[20], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
						I[22] = new("UITextSizeConstraint", I[20], "UITextSizeConstraint", { MaxTextSize = 30 })
					I[23] = new("TextBox", I[19], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "$1,000", Position = UDim2.fromScale(0.2980886, 0.1102646), Size = UDim2.fromScale(0.4019114, 0.1543174), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[24] = new("UITextSizeConstraint", I[23], "UITextSizeConstraint", { MaxTextSize = 30 })
						I[25] = new("UICorner", I[23], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
						I[26] = new("UIStroke", I[23], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
					I[27] = new("TextButton", I[19], "Return", { BackgroundColor3 = Color3.fromRGB(7, 7, 172), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2499999, 0.720148), Size = UDim2.fromScale(0.5000001, 0.2032911), Text = "Return", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[28] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
						I[29] = new("UITextSizeConstraint", I[27], "UITextSizeConstraint", { MaxTextSize = 30 })
				I[30] = new("Frame", I[12], "FrameDeposit", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4990002, 0.4690064), Size = UDim2.fromScale(0.998, 0.7238348), Visible = false })
					I[31] = new("TextButton", I[30], "Deposit", { BackgroundColor3 = Color3.fromRGB(7, 7, 172), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2499999, 0.4459468), Size = UDim2.fromScale(0.5000001, 0.2032911), Text = "Deposit", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[32] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
						I[33] = new("UITextSizeConstraint", I[31], "UITextSizeConstraint", { MaxTextSize = 30 })
					I[34] = new("TextBox", I[30], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(178, 178, 178), PlaceholderText = "$1,000", Position = UDim2.fromScale(0.2980886, 0.1102646), Size = UDim2.fromScale(0.4019114, 0.1543174), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[35] = new("UITextSizeConstraint", I[34], "UITextSizeConstraint", { MaxTextSize = 30 })
						I[36] = new("UICorner", I[34], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
						I[37] = new("UIStroke", I[34], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 2 })
					I[38] = new("TextButton", I[30], "Return", { BackgroundColor3 = Color3.fromRGB(7, 7, 172), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2499999, 0.720148), Size = UDim2.fromScale(0.5000001, 0.2032911), Text = "Return", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[39] = new("UICorner", I[38], "UICorner", { BottomLeftRadius = UDim.new(0, 5), BottomRightRadius = UDim.new(0, 5), TopLeftRadius = UDim.new(0, 5), TopRightRadius = UDim.new(0, 5) })
						I[40] = new("UITextSizeConstraint", I[38], "UITextSizeConstraint", { MaxTextSize = 30 })
			I[41] = new("Frame", I[2], "Info", { BackgroundColor3 = Color3.fromRGB(7, 7, 172), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0833333, 0.2101154), Size = UDim2.fromScale(0.8333333, 0.1108148) })
				I[42] = new("UICorner", I[41], "UICorner", { BottomLeftRadius = UDim.new(0, 3), BottomRightRadius = UDim.new(0, 3), TopLeftRadius = UDim.new(0, 3), TopRightRadius = UDim.new(0, 3) })
				I[43] = new("TextLabel", I[41], "Service", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3496666, 0.4810698), RichText = true, Size = UDim2.fromScale(0.3006667, 0.5078424), Text = "Choose a service.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[44] = new("Frame", I[2], "Line", { BackgroundColor3 = Color3.fromRGB(7, 7, 172), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0833333, 0.1691853), Size = UDim2.fromScale(0.8333333, -0.006963) })
				I[45] = new("UICorner", I[44], "UICorner", { BottomLeftRadius = UDim.new(0, 3), BottomRightRadius = UDim.new(0, 3), TopLeftRadius = UDim.new(0, 3), TopRightRadius = UDim.new(0, 3) })
			I[46] = new("TextLabel", I[2], "User", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Guru.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5983334, 0.0355556), Size = UDim2.fromScale(0.3166667, 0.0533336), Text = "fakeflipsy", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[47] = new("UITextSizeConstraint", I[46], "UITextSizeConstraint", { MaxTextSize = 30 })
			I[48] = new("TextButton", I[2], "Close", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.9416667, -0.00104), Size = UDim2.fromScale(0.0583333, 0.07919), Text = "X", TextColor3 = Color3.fromRGB(7, 7, 172), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[49] = new("ImageLabel", I[2], "BankIcon", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://16198635346"), Position = UDim2.fromScale(0.02, 0.0155556), Size = UDim2.fromScale(0.0916667, 0.1222222) })
				I[50] = new("UICorner", I[49], "UICorner")
			I[51] = new("TextLabel", I[2], "Output", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.27, 0.8571059), RichText = true, Size = UDim2.fromScale(0.4583333, 0.0822225), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[52] = new("UICorner", I[2], "UICorner")
			I[53] = new("UIStroke", I[2], "UIStroke", { Thickness = 2 })
	return I[1]
end

return build
