-- Generated from ui/ServerStorage/SirenControl.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "SirenControl", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(102, 102, 102), BackgroundTransparency = 0.2, Position = UDim2.fromScale(0.7183864, 0.7516425), Size = UDim2.fromScale(0.2439782, 0.2107232) })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2643312, 0), Size = UDim2.fromScale(0.4713376, 0.2189349), Text = "SIREN CONTROL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[5] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 24 })
			I[6] = new("TextButton", I[2], "WD", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.544586, 0.243421), Size = UDim2.fromScale(0.3789809, 0.1715976), Text = "Siren: WD", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[7] = new("UICorner", I[6], "UICorner")
				I[8] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint", { MaxTextSize = 29 })
			I[9] = new("TextButton", I[2], "WL", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.066879, 0.4842339), Size = UDim2.fromScale(0.3789809, 0.1715976), Text = "Siren: WL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[10] = new("UICorner", I[9], "UICorner")
				I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 29 })
			I[12] = new("TextButton", I[2], "YP", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.544586, 0.4842339), Size = UDim2.fromScale(0.3789809, 0.1715976), Text = "Siren: YP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[13] = new("UICorner", I[12], "UICorner")
				I[14] = new("UITextSizeConstraint", I[12], "UITextSizeConstraint", { MaxTextSize = 29 })
			I[15] = new("TextButton", I[2], "PRTY", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.066879, 0.7268374), Size = UDim2.fromScale(0.3789809, 0.1715976), Text = "Siren: PRTY", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[16] = new("UICorner", I[15], "UICorner")
				I[17] = new("UITextSizeConstraint", I[15], "UITextSizeConstraint", { MaxTextSize = 29 })
			I[18] = new("TextButton", I[2], "STOP", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.544586, 0.7268374), Size = UDim2.fromScale(0.3789809, 0.1715976), Text = "Siren: STOP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[19] = new("UICorner", I[18], "UICorner")
				I[20] = new("UITextSizeConstraint", I[18], "UITextSizeConstraint", { MaxTextSize = 29 })
			I[21] = new("ObjectValue", I[2], "Car")
			I[22] = new("Frame", I[2], "spotlight", { BackgroundColor3 = Color3.fromRGB(102, 102, 102), BackgroundTransparency = 0.2, Position = UDim2.fromScale(-2.8717892, 0.4098948), Size = UDim2.fromScale(0.7802489, 0.6764367) })
				I[23] = new("UICorner", I[22], "UICorner")
				I[24] = new("TextLabel", I[22], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2643312, 0), Size = UDim2.fromScale(0.4713376, 0.2189349), Text = "SPOTLIGHT", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[25] = new("UITextSizeConstraint", I[24], "UITextSizeConstraint", { MaxTextSize = 24 })
				I[26] = new("TextButton", I[22], "Left", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0471749, 0.4008766), Size = UDim2.fromScale(0.1740588, 0.3727914), Text = "<", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[27] = new("UICorner", I[26], "UICorner")
					I[28] = new("UITextSizeConstraint", I[26], "UITextSizeConstraint", { MaxTextSize = 29 })
				I[29] = new("TextButton", I[22], "Right", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7801657, 0.4008766), Size = UDim2.fromScale(0.1740588, 0.3727914), Text = ">", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[30] = new("UICorner", I[29], "UICorner")
					I[31] = new("UITextSizeConstraint", I[29], "UITextSizeConstraint", { MaxTextSize = 29 })
				I[32] = new("TextButton", I[22], "On", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3067968, 0.2871585), Size = UDim2.fromScale(0.3833933, 0.2415783), Text = "ON", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[33] = new("UICorner", I[32], "UICorner")
					I[34] = new("UITextSizeConstraint", I[32], "UITextSizeConstraint", { MaxTextSize = 29 })
				I[35] = new("TextButton", I[22], "Off", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3067968, 0.6283127), Size = UDim2.fromScale(0.3833933, 0.2415783), Text = "OFF", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[36] = new("UICorner", I[35], "UICorner")
					I[37] = new("UITextSizeConstraint", I[35], "UITextSizeConstraint", { MaxTextSize = 29 })
			I[38] = new("TextButton", I[2], "Honk", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.066879, 0.243421), Size = UDim2.fromScale(0.3789809, 0.1715976), Text = "Honk (H)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[39] = new("UICorner", I[38], "UICorner")
				I[40] = new("UITextSizeConstraint", I[38], "UITextSizeConstraint", { MaxTextSize = 29 })
			I[41] = new("Frame", I[2], "lights", { BackgroundColor3 = Color3.fromRGB(102, 102, 102), BackgroundTransparency = 0.2, Position = UDim2.fromScale(-0.0029883, -0.4173013), Size = UDim2.fromScale(1.0029883, 0.3734551) })
				I[42] = new("UICorner", I[41], "UICorner")
				I[43] = new("TextLabel", I[41], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0727247, 0), Size = UDim2.fromScale(0.8541352, 0.3827384), Text = "LIGHTS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[44] = new("UITextSizeConstraint", I[43], "UITextSizeConstraint", { MaxTextSize = 24 })
				I[45] = new("TextButton", I[41], "On", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0668793, 0.4891717), Size = UDim2.fromScale(0.3789809, 0.4092631), Text = "ON", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[46] = new("UICorner", I[45], "UICorner")
					I[47] = new("UITextSizeConstraint", I[45], "UITextSizeConstraint", { MaxTextSize = 29 })
				I[48] = new("TextButton", I[41], "Off", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5420554, 0.4891717), Size = UDim2.fromScale(0.3789809, 0.4092631), Text = "OFF", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[49] = new("UICorner", I[48], "UICorner")
					I[50] = new("UITextSizeConstraint", I[48], "UITextSizeConstraint", { MaxTextSize = 29 })
			I[51] = new("Frame", I[2], "misc", { BackgroundColor3 = Color3.fromRGB(102, 102, 102), BackgroundTransparency = 0.2, Position = UDim2.fromScale(-2.0618982, 0.7675518), Size = UDim2.fromScale(0.5862447, 0.3187798) })
				I[52] = new("UICorner", I[51], "UICorner")
				I[53] = new("TextLabel", I[51], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0788347, 0), Size = UDim2.fromScale(0.8419167, 0.3910678), Text = "COMPUTER", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[54] = new("UITextSizeConstraint", I[53], "UITextSizeConstraint", { MaxTextSize = 24 })
				I[55] = new("TextButton", I[51], "Database", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0773846, 0.4104782), Size = UDim2.fromScale(0.3789809, 0.4685876), Text = "NYPD Database", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[56] = new("UICorner", I[55], "UICorner")
					I[57] = new("UITextSizeConstraint", I[55], "UITextSizeConstraint", { MaxTextSize = 29 })
				I[58] = new("TextButton", I[51], "Lookup", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5396321, 0.4104782), Size = UDim2.fromScale(0.3789809, 0.4685876), Text = "Lookup License Plate", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[59] = new("UICorner", I[58], "UICorner")
					I[60] = new("UITextSizeConstraint", I[58], "UITextSizeConstraint", { MaxTextSize = 29 })
		I[61] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.659601 })
	return I[1]
end

return build
