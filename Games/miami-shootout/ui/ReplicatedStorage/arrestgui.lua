-- Generated from ui/ReplicatedStorage/arrestgui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "arrestgui", { ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { BackgroundColor3 = Color3.fromRGB(34, 34, 34), BackgroundTransparency = 0.1, Position = UDim2.fromScale(0.7280686, 0.1103746), Size = UDim2.fromScale(0.2112891, 0.7783819) })
			I[3] = new("TextLabel", I[2], "arresting", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1371841, 0), Size = UDim2.fromScale(0.7220216, 0.1240695), Text = "Arresting:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[4] = new("UITextSizeConstraint", I[3], "UITextSizeConstraint", { MaxTextSize = 59 })
			I[5] = new("UICorner", I[2], "UICorner")
			I[6] = new("Folder", I[2], "charges")
				I[7] = new("TextButton", I[6], "Assault", { BackgroundColor3 = Color3.fromRGB(117, 117, 117), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1125357, 0.1109675), Size = UDim2.fromScale(0.1431972, 0.0577761), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[8] = new("UICorner", I[7], "UICorner")
					I[9] = new("NumberValue", I[7], "timer", { Value = 120 })
					I[10] = new("TextLabel", I[7], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.1794872, 0), Size = UDim2.fromScale(4, 1), Text = "Assault - 120 seconds", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[11] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 22 })
					I[12] = new("UITextSizeConstraint", I[7], "UITextSizeConstraint", { MaxTextSize = 39 })
				I[13] = new("TextButton", I[6], "Obstruction", { BackgroundColor3 = Color3.fromRGB(117, 117, 117), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1125357, 0.187075), Size = UDim2.fromScale(0.143, 0.058), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[14] = new("UICorner", I[13], "UICorner")
					I[15] = new("NumberValue", I[13], "timer", { Value = 80 })
					I[16] = new("TextLabel", I[13], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.1794872, 0), Size = UDim2.fromScale(4, 1), Text = "Obstruction - 80 seconds", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[17] = new("UITextSizeConstraint", I[16], "UITextSizeConstraint", { MaxTextSize = 38 })
					I[18] = new("UITextSizeConstraint", I[13], "UITextSizeConstraint", { MaxTextSize = 39 })
				I[19] = new("TextButton", I[6], "Fleeing", { BackgroundColor3 = Color3.fromRGB(117, 117, 117), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1125357, 0.2692275), Size = UDim2.fromScale(0.143, 0.058), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[20] = new("UICorner", I[19], "UICorner")
					I[21] = new("NumberValue", I[19], "timer", { Value = 160 })
					I[22] = new("TextLabel", I[19], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.1794872, 0), Size = UDim2.fromScale(4, 1), Text = "Fleeing/Eluding - 160 seconds", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[23] = new("UITextSizeConstraint", I[22], "UITextSizeConstraint", { MaxTextSize = 38 })
					I[24] = new("UITextSizeConstraint", I[19], "UITextSizeConstraint", { MaxTextSize = 39 })
				I[25] = new("TextButton", I[6], "Trespassing", { BackgroundColor3 = Color3.fromRGB(117, 117, 117), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1125357, 0.3500662), Size = UDim2.fromScale(0.143, 0.058), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[26] = new("UICorner", I[25], "UICorner")
					I[27] = new("NumberValue", I[25], "timer", { Value = 90 })
					I[28] = new("TextLabel", I[25], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.1794872, 0), Size = UDim2.fromScale(4, 1), Text = "Trespassing - 90 seconds", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[29] = new("UITextSizeConstraint", I[28], "UITextSizeConstraint", { MaxTextSize = 38 })
					I[30] = new("UITextSizeConstraint", I[25], "UITextSizeConstraint", { MaxTextSize = 39 })
				I[31] = new("TextButton", I[6], "Firearm Trafficking", { BackgroundColor3 = Color3.fromRGB(117, 117, 117), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1125357, 0.4291902), Size = UDim2.fromScale(0.143, 0.058), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[32] = new("UICorner", I[31], "UICorner")
					I[33] = new("NumberValue", I[31], "timer", { Value = 140 })
					I[34] = new("TextLabel", I[31], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.1794872, 0), Size = UDim2.fromScale(4, 1), Text = "Firearm Trafficking - 140 seconds", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[35] = new("UITextSizeConstraint", I[34], "UITextSizeConstraint", { MaxTextSize = 38 })
					I[36] = new("UITextSizeConstraint", I[31], "UITextSizeConstraint", { MaxTextSize = 39 })
				I[37] = new("TextButton", I[6], "Attempted Murder", { BackgroundColor3 = Color3.fromRGB(117, 117, 117), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1125357, 0.5094668), Size = UDim2.fromScale(0.143, 0.058), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[38] = new("UICorner", I[37], "UICorner")
					I[39] = new("NumberValue", I[37], "timer", { Value = 190 })
					I[40] = new("TextLabel", I[37], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.1794872, 0), Size = UDim2.fromScale(4, 1), Text = "Attempted Murder - 190 seconds", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[41] = new("UITextSizeConstraint", I[40], "UITextSizeConstraint", { MaxTextSize = 38 })
					I[42] = new("UITextSizeConstraint", I[37], "UITextSizeConstraint", { MaxTextSize = 39 })
				I[43] = new("TextButton", I[6], "Murder", { BackgroundColor3 = Color3.fromRGB(117, 117, 117), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1125357, 0.5918211), Size = UDim2.fromScale(0.143, 0.058), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[44] = new("UICorner", I[43], "UICorner")
					I[45] = new("NumberValue", I[43], "timer", { Value = 320 })
					I[46] = new("TextLabel", I[43], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.1794872, 0), Size = UDim2.fromScale(4, 1), Text = "Murder - 320 seconds", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[47] = new("UITextSizeConstraint", I[46], "UITextSizeConstraint", { MaxTextSize = 20 })
					I[48] = new("UITextSizeConstraint", I[43], "UITextSizeConstraint", { MaxTextSize = 39 })
				I[49] = new("TextButton", I[6], "Kidnap", { BackgroundColor3 = Color3.fromRGB(117, 117, 117), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1125357, 0.6752284), Size = UDim2.fromScale(0.143, 0.058), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[50] = new("UICorner", I[49], "UICorner")
					I[51] = new("NumberValue", I[49], "timer", { Value = 180 })
					I[52] = new("TextLabel", I[49], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.1794872, 0), Size = UDim2.fromScale(4, 1), Text = "Kidnap - 180 seconds", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[53] = new("UITextSizeConstraint", I[52], "UITextSizeConstraint", { MaxTextSize = 20 })
					I[54] = new("UITextSizeConstraint", I[49], "UITextSizeConstraint", { MaxTextSize = 39 })
				I[55] = new("TextButton", I[6], "Robbery", { BackgroundColor3 = Color3.fromRGB(117, 117, 117), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1125357, 0.7553229), Size = UDim2.fromScale(0.143, 0.058), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[56] = new("UICorner", I[55], "UICorner")
					I[57] = new("NumberValue", I[55], "timer", { Value = 180 })
					I[58] = new("TextLabel", I[55], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.1794872, 0), Size = UDim2.fromScale(4, 1), Text = "Robbery - 180 seconds", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[59] = new("UITextSizeConstraint", I[58], "UITextSizeConstraint", { MaxTextSize = 20 })
					I[60] = new("UITextSizeConstraint", I[55], "UITextSizeConstraint", { MaxTextSize = 39 })
				I[61] = new("TextButton", I[6], "Mass Murder", { BackgroundColor3 = Color3.fromRGB(117, 117, 117), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1125357, 0.8338156), Size = UDim2.fromScale(0.143, 0.058), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[62] = new("UICorner", I[61], "UICorner")
					I[63] = new("NumberValue", I[61], "timer", { Value = 500 })
					I[64] = new("TextLabel", I[61], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.1794872, 0), Size = UDim2.fromScale(4, 1), Text = "Mass Murder - 500 seconds", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[65] = new("UITextSizeConstraint", I[64], "UITextSizeConstraint", { MaxTextSize = 20 })
					I[66] = new("UITextSizeConstraint", I[61], "UITextSizeConstraint", { MaxTextSize = 39 })
			I[67] = new("TextButton", I[2], "bookBtn", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1138237, 0.9182962), Size = UDim2.fromScale(0.345142, 0.0521979), Text = "BOOK", TextColor3 = Color3.fromRGB(244, 244, 244), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[68] = new("UICorner", I[67], "UICorner")
				I[69] = new("UITextSizeConstraint", I[67], "UITextSizeConstraint", { MaxTextSize = 27 })
			I[70] = new("TextButton", I[2], "detainBtn", { BackgroundColor3 = Color3.fromRGB(84, 84, 84), FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5324001, 0.9182962), Size = UDim2.fromScale(0.345142, 0.0521979), Text = "DETAIN", TextColor3 = Color3.fromRGB(244, 244, 244), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[71] = new("UICorner", I[70], "UICorner")
				I[72] = new("UITextSizeConstraint", I[70], "UITextSizeConstraint", { MaxTextSize = 27 })
		I[73] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.607232 })
	return I[1]
end

return build
