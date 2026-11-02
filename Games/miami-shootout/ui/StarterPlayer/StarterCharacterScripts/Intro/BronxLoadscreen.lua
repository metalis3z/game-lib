-- Generated from ui/StarterPlayer/StarterCharacterScripts/Intro/BronxLoadscreen.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BronxLoadscreen", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.6058558, 0.1546135), Size = UDim2.fromScale(0.3471074, 0.1408978) })
			I[3] = new("ImageLabel", I[2], "logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://15085052524"), Position = UDim2.fromScale(-0.1205669, 0.7699115), Size = UDim2.fromScale(1.2190192, 0.8584071) })
			I[4] = new("ImageButton", I[2], "play", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://11860172503"), Position = UDim2.fromScale(0.2458726, 1.5132743), Size = UDim2.fromScale(0.4242424, 0.5044248) })
				I[5] = new("Frame", I[4], "select", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1.0561224, 0), Visible = false })
			I[6] = new("ImageButton", I[2], "rules", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://11860186620"), Position = UDim2.fromScale(0.2120915, 2.1681416), Size = UDim2.fromScale(0.4935065, 0.5929204) })
				I[7] = new("Frame", I[6], "select", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0), Visible = false })
			I[8] = new("ImageButton", I[2], "store", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 255), ImageContent = Content.fromUri("rbxassetid://11860192643"), Position = UDim2.fromScale(0.209927, 2.9557521), Size = UDim2.fromScale(0.4935065, 0.5929204) })
				I[9] = new("Frame", I[8], "select", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0), Visible = false })
			I[10] = new("ImageLabel", I[2], "logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://15085052524"), Position = UDim2.fromScale(-0.1205669, 0.7699115), Size = UDim2.fromScale(1.2190192, 0.8584071) })
			I[11] = new("ImageLabel", I[2], "logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://15085052524"), Position = UDim2.fromScale(-0.1205669, 0.7699115), Size = UDim2.fromScale(1.2190192, 0.8584071) })
			I[12] = new("ImageLabel", I[2], "logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://15085052524"), Position = UDim2.fromScale(-0.1205669, 0.7699115), Size = UDim2.fromScale(1.2190192, 0.8584071) })
			I[13] = new("ImageLabel", I[2], "logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://15085052524"), Position = UDim2.fromScale(-0.1205669, 0.7699115), Size = UDim2.fromScale(1.2190192, 0.8584071) })
			I[14] = new("ImageLabel", I[2], "logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://15085052524"), Position = UDim2.fromScale(-0.1205669, 0.7699115), Size = UDim2.fromScale(1.2190192, 0.8584071) })
			I[15] = new("ImageLabel", I[2], "logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://15085052524"), Position = UDim2.fromScale(-0.1205669, 0.7699115), Size = UDim2.fromScale(1.2190192, 0.8584071) })
			I[16] = new("ImageLabel", I[2], "logo", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://15085052524"), Position = UDim2.fromScale(-0.1205669, 0.7699115), Size = UDim2.fromScale(1.2190192, 0.8584071) })
			I[17] = new("ImageButton", I[2], "ImageButton", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 85, 255), ImageContent = Content.fromUri("rbxassetid://12902741635"), Position = UDim2.fromScale(0.8242951, 0.4513274), Size = UDim2.fromOffset(100, 100) })
		I[18] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.659601 })
		I[19] = new("Frame", I[1], "Rules", { BackgroundColor3 = Color3.fromRGB(104, 104, 104), BackgroundTransparency = 0.25, Position = UDim2.fromScale(0.3741548, 0.2381546), Size = UDim2.fromScale(0.2516904, 0.5261846), Visible = false })
			I[20] = new("UICorner", I[19], "UICorner")
			I[21] = new("Frame", I[19], "Dark", { BackgroundColor3 = Color3.fromRGB(104, 104, 104), BackgroundTransparency = 0.25, Position = UDim2.fromScale(0.028662, 0.0272542), Size = UDim2.fromScale(0.9396911, 0.9442411) })
				I[22] = new("UICorner", I[21], "UICorner")
				I[23] = new("TextLabel", I[21], "title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, 0), Size = UDim2.fromScale(0.5970149, 0.1184834), Text = "GAME RULES", TextColor3 = Color3.fromRGB(170, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[24] = new("UITextSizeConstraint", I[23], "UITextSizeConstraint", { MaxTextSize = 48 })
				I[25] = new("TextLabel", I[21], "warning", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1402985, 0.1173913), Size = UDim2.fromScale(0.7164179, 0.1611374), Text = "Violating the rules may result in a kick/ban/warning by an admin/moderator depending on the severity and repeated offenses.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[26] = new("UITextSizeConstraint", I[25], "UITextSizeConstraint", { MaxTextSize = 68 })
				I[27] = new("TextLabel", I[21], "rule1", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/PatrickHand.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2124927, 0.3052454), Size = UDim2.fromScale(0.5701492, 0.1113744), Text = "1. Do not exploit (automatic permban)", TextColor3 = Color3.fromRGB(21, 45, 45), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[28] = new("UITextSizeConstraint", I[27], "UITextSizeConstraint", { MaxTextSize = 46 })
				I[29] = new("TextLabel", I[21], "rule2", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/PatrickHand.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1995753, 0.4163792), Size = UDim2.fromScale(0.6086906, 0.1189032), Text = "2. Do not kill anyone without reason from your current in game life (RDM/RK)", TextColor3 = Color3.fromRGB(21, 45, 45), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[30] = new("UITextSizeConstraint", I[29], "UITextSizeConstraint", { MaxTextSize = 45 })
				I[31] = new("TextLabel", I[21], "rule3", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/PatrickHand.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2124927, 0.5350416), Size = UDim2.fromScale(0.5701492, 0.1113744), Text = "3. IF YOU HAVE A GROUP DO NOT GO AROUND KILLING WORKERS OR U WILL BE BANNED.", TextColor3 = Color3.fromRGB(21, 45, 45), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[32] = new("UITextSizeConstraint", I[31], "UITextSizeConstraint", { MaxTextSize = 40 })
				I[33] = new("TextLabel", I[21], "rule4", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/PatrickHand.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2156694, 0.6411562), Size = UDim2.fromScale(0.5701492, 0.1113744), Text = "4. Have gun and cop fear", TextColor3 = Color3.fromRGB(21, 45, 45), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[34] = new("UITextSizeConstraint", I[33], "UITextSizeConstraint", { MaxTextSize = 46 })
				I[35] = new("TextButton", I[21], "TextButton", { BackgroundColor3 = Color3.fromRGB(170, 0, 0), FontFace = Font.new("rbxasset://fonts/families/PatrickHand.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2469512, 0.8649289), Size = UDim2.fromScale(0.5014926, 0.0995261), Text = "CLOSE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[36] = new("UICorner", I[35], "UICorner")
					I[37] = new("UITextSizeConstraint", I[35], "UITextSizeConstraint", { MaxTextSize = 42 })
				I[38] = new("TextLabel", I[21], "rule5", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/PatrickHand.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2124927, 0.7214634), Size = UDim2.fromScale(0.5701492, 0.1113744), Text = "5. Mass RK is a 1-3 day ban", TextColor3 = Color3.fromRGB(21, 45, 45), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[39] = new("UITextSizeConstraint", I[38], "UITextSizeConstraint", { MaxTextSize = 46 })
		I[40] = new("Frame", I[1], "Store", { BackgroundColor3 = Color3.fromRGB(104, 104, 104), BackgroundTransparency = 0.25, Position = UDim2.fromScale(0.3741548, 0.2381546), Size = UDim2.fromScale(0.2516904, 0.5261846), Visible = false })
			I[41] = new("UICorner", I[40], "UICorner")
			I[42] = new("TextLabel", I[40], "title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/DenkOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, 0), Size = UDim2.fromScale(0.5970149, 0.1184834), Text = "STORE (UNDER CONSTRUCTION)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[43] = new("UITextSizeConstraint", I[42], "UITextSizeConstraint", { MaxTextSize = 50 })
			I[44] = new("TextButton", I[40], "TextButton", { BackgroundColor3 = Color3.fromRGB(170, 0, 0), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2469512, 0.8649289), Size = UDim2.fromScale(0.5014926, 0.0995261), Text = "CLOSE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[45] = new("UICorner", I[44], "UICorner")
				I[46] = new("UITextSizeConstraint", I[44], "UITextSizeConstraint", { MaxTextSize = 42 })
	return I[1]
end

return build
