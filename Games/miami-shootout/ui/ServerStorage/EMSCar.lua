-- Generated from ui/ServerStorage/EMSCar.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "EMSCar", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(102, 102, 102), BackgroundTransparency = 0.2, Position = UDim2.fromScale(0.7183864, 0.7516425), Size = UDim2.fromScale(0.2439782, 0.2107232) })
			I[3] = new("UICorner", I[2], "UICorner")
			I[4] = new("TextLabel", I[2], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2643312, 0), Size = UDim2.fromScale(0.4713376, 0.2189349), Text = "SIREN CONTROL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[5] = new("UITextSizeConstraint", I[4], "UITextSizeConstraint", { MaxTextSize = 24 })
			I[6] = new("TextButton", I[2], "ON", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0699446, 0.2416303), Size = UDim2.fromScale(0.3789809, 0.1715976), Text = "Siren: ON", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[7] = new("UICorner", I[6], "UICorner")
				I[8] = new("UITextSizeConstraint", I[6], "UITextSizeConstraint", { MaxTextSize = 29 })
			I[9] = new("TextButton", I[2], "STOP", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5476516, 0.2416303), Size = UDim2.fromScale(0.3789809, 0.1715976), Text = "Siren: STOP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[10] = new("UICorner", I[9], "UICorner")
				I[11] = new("UITextSizeConstraint", I[9], "UITextSizeConstraint", { MaxTextSize = 29 })
			I[12] = new("ObjectValue", I[2], "Car")
			I[13] = new("TextButton", I[2], "Honk", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0699446, 0.4978591), Size = UDim2.fromScale(0.3789805, 0.1715976), Text = "Honk (H)", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[14] = new("UICorner", I[13], "UICorner")
				I[15] = new("UITextSizeConstraint", I[13], "UITextSizeConstraint", { MaxTextSize = 29 })
			I[16] = new("Frame", I[2], "lights", { BackgroundColor3 = Color3.fromRGB(102, 102, 102), BackgroundTransparency = 0.2, Position = UDim2.fromScale(-0.0029883, -0.4173013), Size = UDim2.fromScale(1.0029883, 0.3734551) })
				I[17] = new("UICorner", I[16], "UICorner")
				I[18] = new("TextLabel", I[16], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0727247, 0), Size = UDim2.fromScale(0.8541352, 0.3827384), Text = "LIGHTS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[19] = new("UITextSizeConstraint", I[18], "UITextSizeConstraint", { MaxTextSize = 24 })
				I[20] = new("TextButton", I[16], "On", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0668793, 0.4891717), Size = UDim2.fromScale(0.3789809, 0.4092631), Text = "ON", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[21] = new("UICorner", I[20], "UICorner")
					I[22] = new("UITextSizeConstraint", I[20], "UITextSizeConstraint", { MaxTextSize = 29 })
				I[23] = new("TextButton", I[16], "Off", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5420554, 0.4891717), Size = UDim2.fromScale(0.3789809, 0.4092631), Text = "OFF", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[24] = new("UICorner", I[23], "UICorner")
					I[25] = new("UITextSizeConstraint", I[23], "UITextSizeConstraint", { MaxTextSize = 29 })
			I[26] = new("Frame", I[2], "spotlight", { BackgroundColor3 = Color3.fromRGB(102, 102, 102), BackgroundTransparency = 0.2, Position = UDim2.fromScale(-2.8840516, 0.5992439), Size = UDim2.fromScale(0.7802489, 0.4007561) })
				I[27] = new("UICorner", I[26], "UICorner")
				I[28] = new("TextLabel", I[26], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1689702, 0), Size = UDim2.fromScale(0.6620595, 0.3075247), Text = "HEADLIGHTS", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[29] = new("UITextSizeConstraint", I[28], "UITextSizeConstraint", { MaxTextSize = 24 })
				I[30] = new("TextButton", I[26], "On", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.0749846, 0.4041637), Size = UDim2.fromScale(0.3833933, 0.374463), Text = "ON", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[31] = new("UICorner", I[30], "UICorner")
					I[32] = new("UITextSizeConstraint", I[30], "UITextSizeConstraint", { MaxTextSize = 29 })
				I[33] = new("TextButton", I[26], "Off", { BackgroundColor3 = Color3.fromRGB(161, 161, 161), BackgroundTransparency = 0.2, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.538609, 0.4041637), Size = UDim2.fromScale(0.3833933, 0.374463), Text = "OFF", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[34] = new("UICorner", I[33], "UICorner")
					I[35] = new("UITextSizeConstraint", I[33], "UITextSizeConstraint", { MaxTextSize = 29 })
		I[36] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.659601 })
	return I[1]
end

return build
