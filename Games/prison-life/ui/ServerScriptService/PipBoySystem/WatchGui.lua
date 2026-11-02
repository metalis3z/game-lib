-- Generated from ui/ServerScriptService/PipBoySystem/WatchGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "WatchGui", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Spawner", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.2009956, 0.2105116), Size = UDim2.fromScale(0.5677057, 0.5119284), Visible = false })
			I[3] = new("TextButton", I[2], "Next", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.949595, 0.9029126), Size = UDim2.fromScale(0.050405, 0.0970874), Text = ">", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[4] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint", { AspectRatio = 1.12 })
			I[5] = new("TextButton", I[2], "Back", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.9029126), Size = UDim2.fromScale(0.050405, 0.0970874), Text = "<", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 1.12 })
			I[7] = new("TextLabel", I[2], "CS", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1368137, 0.2621359), Size = UDim2.fromScale(0.7254726, 0.4737864), Text = "Comming Soon!", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[8] = new("UIAspectRatioConstraint", I[7], "UIAspectRatioConstraint", { AspectRatio = 3.3032787 })
			I[9] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2.1572816 })
		I[10] = new("Frame", I[1], "Settings", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.2156362, 0.2445328), Size = UDim2.fromScale(0.5677057, 0.5119284), Visible = false })
			I[11] = new("TextButton", I[10], "Back", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.9009709), Size = UDim2.fromScale(0.050405, 0.0970874), Text = "<", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[12] = new("TextButton", I[10], "Next", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.949595, 0.9009709), Size = UDim2.fromScale(0.050405, 0.0970874), Text = ">", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[13] = new("TextLabel", I[10], "ShowingEnabled", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.049505, 0.2446602), Size = UDim2.fromScale(0.180018, 0.0970874), Text = "Showing : ", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[14] = new("TextButton", I[13], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.995, 0), Size = UDim2.fromScale(0.33, 1), Text = "Yes", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[15] = new("UITextSizeConstraint", I[14], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[16] = new("TextLabel", I[10], "Enabled", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.049505, 0.3417476), Size = UDim2.fromScale(0.180018, 0.0970874), Text = "Enabled : ", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[17] = new("TextButton", I[16], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.995, 0), Size = UDim2.fromScale(0.33, 1), Text = "Yes", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[18] = new("UITextSizeConstraint", I[17], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[19] = new("TextLabel", I[10], "AntikillEnabled", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.049505, 0.438835), Size = UDim2.fromScale(0.180018, 0.0970874), Text = "AntiKill : ", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[20] = new("TextButton", I[19], "TextButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.995, 0), Size = UDim2.fromScale(0.33, 1), Text = "Yes", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[21] = new("UITextSizeConstraint", I[20], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[22] = new("TextLabel", I[10], "ThemesSelected", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5508551, 0.2427184), Size = UDim2.fromScale(0.180018, 0.0970874), Text = "Theme :", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[23] = new("ScrollingFrame", I[10], "Colors", { Active = true, BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5508551, 0.3631068), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.3294329, 0.5048544) })
				I[24] = new("UIListLayout", I[23], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder })
				I[25] = new("TextButton", I[23], "Yellow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(200, 50), Text = "Yellow", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[26] = new("UITextSizeConstraint", I[25], "UITextSizeConstraint", { MaxTextSize = 14 })
				I[27] = new("TextButton", I[23], "Green", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(200, 50), Text = "Green", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[28] = new("TextButton", I[23], "Red", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(200, 50), Text = "Red", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[29] = new("UITextSizeConstraint", I[28], "UITextSizeConstraint", { MaxTextSize = 14 })
				I[30] = new("TextButton", I[23], "Blue", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromOffset(200, 50), Text = "Blue", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[31] = new("TextLabel", I[10], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4086409, 0), Size = UDim2.fromScale(0.180018, 0.0970874), Text = "Settings", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
			I[32] = new("Frame", I[10], "Warn", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.2880288, 1), Size = UDim2.fromScale(0.4509451, 0.3980583), Visible = false })
				I[33] = new("TextLabel", I[32], "Warn", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.9999999, 0.1853659), Text = "Warning : If you want disable the Pip-Boy, you can no longer use it! (unless you reactivate it by pressing \"P\".)", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[34] = new("UITextSizeConstraint", I[33], "UITextSizeConstraint", { MaxTextSize = 38 })
				I[35] = new("TextLabel", I[32], "AYS", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.1853659), Size = UDim2.fromScale(0.9999999, 0.1853659), Text = "Are you sure?", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[36] = new("UITextSizeConstraint", I[35], "UITextSizeConstraint", { MaxTextSize = 14 })
				I[37] = new("TextButton", I[32], "Yes", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6007984, 0.7512195), Size = UDim2.fromScale(0.3992016, 0.2439024), Text = "Yes", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[38] = new("UITextSizeConstraint", I[37], "UITextSizeConstraint", { MaxTextSize = 14 })
				I[39] = new("TextButton", I[32], "No", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.7512195), Size = UDim2.fromScale(0.3992016, 0.2439024), Text = "No", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[40] = new("UITextSizeConstraint", I[39], "UITextSizeConstraint", { MaxTextSize = 14 })
		I[41] = new("Frame", I[1], "AntiKill", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.15, Position = UDim2.fromScale(0.3340876, 0.2809607), Size = UDim2.fromScale(0.4077316, 0.5234657), Visible = false })
			I[42] = new("ImageLabel", I[41], "CharEnemi", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://10055884369"), Position = UDim2.fromScale(0.0122583, 0.1339806), Size = UDim2.fromScale(0.6301475, 0.8643678) })
			I[43] = new("TextButton", I[41], "Return", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7123632, 0.4330097), Size = UDim2.fromScale(0.2468694, 0.0896552), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[44] = new("UICorner", I[43], "UICorner")
				I[45] = new("UIGradient", I[43], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(191, 0, 0)), ColorSequenceKeypoint.new(0.4359401, Color3.fromRGB(227, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 76, 76)) }) })
				I[46] = new("TextLabel", I[43], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.2833786, 0.0774359), Size = UDim2.fromScale(1.2826087, 0.7948718), Text = "Return", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[47] = new("ImageLabel", I[43], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://10106722119"), Position = UDim2.fromScale(0.7098656, 0.0096703), Size = UDim2.fromScale(0.2391304, 0.9230769) })
			I[48] = new("TextButton", I[41], "Accept", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7104099, 0.3242718), Size = UDim2.fromScale(0.2468694, 0.0827586), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, Visible = false })
				I[49] = new("UICorner", I[48], "UICorner")
				I[50] = new("UIGradient", I[48], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(29, 218, 0)), ColorSequenceKeypoint.new(0.4758735, Color3.fromRGB(68, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(110, 255, 78)) }) })
				I[51] = new("TextLabel", I[48], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.2837351, 0.0688889), Size = UDim2.fromScale(1.2826087, 0.8611111), Text = "Accept", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[52] = new("ImageLabel", I[48], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=168702841"), Position = UDim2.fromScale(0.668179, -0.0666666), Size = UDim2.fromScale(0.326087, 1.1111112) })
			I[53] = new("Folder", I[41], "Names")
				I[54] = new("TextLabel", I[53], "Name3", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6008471, 0.6640777), Size = UDim2.fromScale(0.4847943, 0.091954), Text = "Name :", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, TextWrapped = true, Visible = false })
				I[55] = new("TextLabel", I[53], "Name2", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6008471, 0.7184466), Size = UDim2.fromScale(0.4812165, 0.1011494), Text = "Name :", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Visible = false })
				I[56] = new("TextLabel", I[53], "Name1", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6008471, 0.7825243), Size = UDim2.fromScale(0.4794275, 0.0965517), Text = "Name :", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14, Visible = false })
				I[57] = new("StringValue", I[53], "DisplayName")
			I[58] = new("TextButton", I[41], "Torso", { BackgroundColor3 = Color3.fromRGB(255, 85, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2713005, 0.459307), Size = UDim2.fromScale(0.1091234, 0.1149425), Text = "Torso", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextWrapped = true })
				I[59] = new("UICorner", I[58], "UICorner")
			I[60] = new("TextButton", I[41], "Legs", { BackgroundColor3 = Color3.fromRGB(255, 85, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3351131, 0.7060291), Size = UDim2.fromScale(0.1091234, 0.1149425), Text = "Leg", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextWrapped = true })
				I[61] = new("UICorner", I[60], "UICorner")
			I[62] = new("TextButton", I[41], "Arms2", { BackgroundColor3 = Color3.fromRGB(255, 85, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.445392, 0.5074903), Size = UDim2.fromScale(0.1091234, 0.1149425), Text = "Arm", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextWrapped = true })
				I[63] = new("UICorner", I[62], "UICorner")
			I[64] = new("TextButton", I[41], "Head", { BackgroundColor3 = Color3.fromRGB(255, 85, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2727671, 0.2289405), Size = UDim2.fromScale(0.1091234, 0.1149425), Text = "Head", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextWrapped = true })
				I[65] = new("UICorner", I[64], "UICorner")
			I[66] = new("UICorner", I[41], "UICorner")
			I[67] = new("TextButton", I[41], "Legs2", { BackgroundColor3 = Color3.fromRGB(255, 85, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1971287, 0.663896), Size = UDim2.fromScale(0.1091234, 0.1149425), Text = "Leg", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextWrapped = true })
				I[68] = new("UICorner", I[67], "UICorner")
			I[69] = new("TextButton", I[41], "Arms", { BackgroundColor3 = Color3.fromRGB(255, 85, 0), BackgroundTransparency = 0.5, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1329933, 0.4188417), Size = UDim2.fromScale(0.1091234, 0.1149425), Text = "Arm", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, TextWrapped = true })
				I[70] = new("UICorner", I[69], "UICorner")
			I[71] = new("Sound", I[41], "Select", { Volume = 1 })
			I[72] = new("Sound", I[41], "PowerOut")
		I[73] = new("Frame", I[1], "Stats", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.2009956, 0.2105116), Size = UDim2.fromScale(0.5677057, 0.5119284), Visible = false })
			I[74] = new("ImageLabel", I[73], "Character", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png"), Position = UDim2.fromScale(0.3294329, 0.1786408), Size = UDim2.fromScale(0.340234, 0.6407767) })
				I[75] = new("UIAspectRatioConstraint", I[74], "UIAspectRatioConstraint", { AspectRatio = 1.1454545 })
			I[76] = new("TextLabel", I[73], "Health", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0963096, 0.0504854), Size = UDim2.fromScale(0.180018, 0.0970874), Text = "Healths : 0", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[77] = new("UIAspectRatioConstraint", I[76], "UIAspectRatioConstraint", { AspectRatio = 4 })
			I[78] = new("TextLabel", I[73], "DisplayName", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7776778, 0.1941748), Size = UDim2.fromScale(0.180018, 0.0970874), Text = "Display Name : dummy", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[79] = new("UIAspectRatioConstraint", I[78], "UIAspectRatioConstraint", { AspectRatio = 4 })
			I[80] = new("TextLabel", I[73], "Name", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7776778, 0.0504854), Size = UDim2.fromScale(0.180018, 0.0970874), Text = "Name : dummy", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[81] = new("UIAspectRatioConstraint", I[80], "UIAspectRatioConstraint", { AspectRatio = 4 })
			I[82] = new("TextButton", I[73], "Next", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.949595, 0.9029126), Size = UDim2.fromScale(0.050405, 0.0970874), Text = ">", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[83] = new("UIAspectRatioConstraint", I[82], "UIAspectRatioConstraint", { AspectRatio = 1.12 })
			I[84] = new("TextButton", I[73], "Back", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.9029126), Size = UDim2.fromScale(0.050405, 0.0970874), Text = "<", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[85] = new("UIAspectRatioConstraint", I[84], "UIAspectRatioConstraint", { AspectRatio = 1.12 })
			I[86] = new("TextLabel", I[73], "armingLaser", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0963096, 0.1786408), Size = UDim2.fromScale(0.180018, 0.0970874), Text = "Arming laser : 0s", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[87] = new("UIAspectRatioConstraint", I[86], "UIAspectRatioConstraint", { AspectRatio = 4 })
			I[88] = new("TextLabel", I[73], "Time", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0963096, 0.7223301), Size = UDim2.fromScale(0.180018, 0.0970874), Text = "Time : 0:0:0", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[89] = new("UIAspectRatioConstraint", I[88], "UIAspectRatioConstraint", { AspectRatio = 4 })
			I[90] = new("UIAspectRatioConstraint", I[73], "UIAspectRatioConstraint", { AspectRatio = 2.1572816 })
		I[91] = new("Frame", I[1], "Warn", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.3520695, 0.3963415), Size = UDim2.fromScale(0.2915408, 0.2017893), Visible = false })
			I[92] = new("TextButton", I[91], "No", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.7536946), Size = UDim2.fromScale(0.3454231, 0.2463054), Text = "No", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[93] = new("UIAspectRatioConstraint", I[92], "UIAspectRatioConstraint", { AspectRatio = 4 })
			I[94] = new("TextButton", I[91], "Yes", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6528497, 0.7536946), Size = UDim2.fromScale(0.3454231, 0.2463054), Text = "Yes", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
				I[95] = new("UIAspectRatioConstraint", I[94], "UIAspectRatioConstraint", { AspectRatio = 4 })
			I[96] = new("TextLabel", I[91], "TItle", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.9982729, 0.7536946), Text = "do you want to reactivate the pip-boy?", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[97] = new("UIAspectRatioConstraint", I[96], "UIAspectRatioConstraint", { AspectRatio = 3.7777777 })
			I[98] = new("UIAspectRatioConstraint", I[91], "UIAspectRatioConstraint", { AspectRatio = 2.8522167 })
	return I[1]
end

return build
