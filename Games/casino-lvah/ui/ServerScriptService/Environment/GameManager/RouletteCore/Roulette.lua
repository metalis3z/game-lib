-- Generated from ui/ServerScriptService/Environment/GameManager/RouletteCore/Roulette.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Roulette", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ObjectValue", I[1], "ActualTable")
		I[3] = new("Frame", I[1], "Backing", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.335, 0.263) })
			I[4] = new("Frame", I[3], "Barrier", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[5] = new("TextLabel", I[4], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.5), Text = "Waiting for round to finish...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[6] = new("TextBox", I[3], "BetBox", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255, 255, 255), PlaceholderText = "#", Position = UDim2.fromScale(0.726, 0.565), Size = UDim2.fromScale(0.4123711, 0.2369668), Text = "", TextColor3 = Color3.fromRGB(0, 255, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[7] = new("TextLabel", I[3], "Selected", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Roboto.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.265, 0.345), Selectable = true, Size = UDim2.fromScale(0.5880579, 0.3379243), Text = "", TextColor3 = Color3.fromRGB(0, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[8] = new("ImageButton", I[3], "AutoBet", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(1.1710106, 0.2235498), Size = UDim2.fromScale(0.0973492, 0.2369668) })
				I[9] = new("TextLabel", I[8], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "H", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[10] = new("TextLabel", I[3], "AutoTip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0400853, 0.0000001), Size = UDim2.fromScale(0.2652858, 0.1601942), Text = "Auto bet:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[11] = new("TextLabel", I[3], "BetTip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0092514, 0.6016272), Size = UDim2.fromScale(0.3222673, 0.3983727), Text = "Auto bet will refresh your bets once the round is over.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[12] = new("TextLabel", I[3], "Message", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.2), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
			I[13] = new("TextLabel", I[3], "CameraTip", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.04, 0), Size = UDim2.fromScale(0.2652858, 0.1601942), Text = "Camera:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[14] = new("TextLabel", I[3], "CameraTip2", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.009, 0.602), Size = UDim2.fromScale(0.3222673, 0.3983727), Text = "Switch between overhead and player camera angles.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[15] = new("ImageButton", I[3], "Camera", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13085201731"), Position = UDim2.fromScale(-0.171, 0.224), Size = UDim2.fromScale(0.0973492, 0.2369668) })
				I[16] = new("TextLabel", I[15], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "C", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[17] = new("TextButton", I[3], "Bet", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.73, 0.232), Size = UDim2.fromScale(0.412, 0.237), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 }, { ["TextSizeEnabled"] = true, ["TextSizeScale"] = 0.5, ["TextValue"] = "BUTTON", ["TextValueEnabled"] = false })
				I[18] = new("UICorner", I[17], "UICorner")
				I[19] = new("UIStroke", I[17], "UIStroke ", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[20] = new("Frame", I[17], "Hover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
					I[21] = new("UICorner", I[20], "UICorner")
				I[22] = new("Frame", I[17], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[23] = new("Frame", I[22], "Color", { BackgroundColor3 = Color3.fromRGB(0, 51, 236), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[24] = new("UICorner", I[23], "UICorner")
					I[25] = new("Frame", I[22], "Shadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.new(1, 0, 1, 5) })
						I[26] = new("UICorner", I[25], "UICorner")
					I[27] = new("Frame", I[22], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -5), ZIndex = 3 })
						I[28] = new("Frame", I[27], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.7) })
							I[29] = new("UICorner", I[28], "UICorner")
							I[30] = new("UIGradient", I[28], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 153, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 100, 255)) }), Rotation = 90 })
						I[31] = new("Frame", I[27], "Top", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(48, 172, 255), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.5), ZIndex = 2 })
							I[32] = new("UICorner", I[31], "UICorner")
				I[33] = new("Configuration", I[17], "Configuration")
					I[34] = new("ObjectValue", I[33], "ObjectTextLabel")
					I[35] = new("ObjectValue", I[33], "ObjectTextLabelStroke")
					I[36] = new("ObjectValue", I[33], "ObjectHover")
				I[37] = new("Folder", I[17], "Scripts")
				I[38] = new("Frame", I[17], "Text", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0.6, -5), ZIndex = 2 })
					I[39] = new("TextLabel", I[38], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "BET", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, ZIndex = 2 })
						I[40] = new("UIStroke", I[39], "UIStroke")
						I[41] = new("UITextSizeConstraint", I[39], "UITextSizeConstraint", { MinTextSize = 9 })
					I[42] = new("TextLabel", I[38], "TextLabel - Stroke", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.fromScale(1, 1), Text = "BET", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 25, TextWrapped = true })
						I[43] = new("UITextSizeConstraint", I[42], "UITextSizeConstraint", { MinTextSize = 9 })
				I[44] = new("TextLabel", I[17], "Keybind", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.6), Text = "T", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[45] = new("TextButton", I[3], "Cancel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.269, 0.565), Size = UDim2.fromScale(0.412, 0.237), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 }, { ["TextSizeEnabled"] = true, ["TextSizeScale"] = 0.5, ["TextValue"] = "BUTTON", ["TextValueEnabled"] = false })
				I[46] = new("UICorner", I[45], "UICorner")
				I[47] = new("UIStroke", I[45], "UIStroke ", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[48] = new("Frame", I[45], "Hover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
					I[49] = new("UICorner", I[48], "UICorner")
				I[50] = new("Frame", I[45], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[51] = new("Frame", I[50], "Color", { BackgroundColor3 = Color3.fromRGB(0, 51, 236), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[52] = new("UICorner", I[51], "UICorner")
					I[53] = new("Frame", I[50], "Shadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.new(1, 0, 1, 5) })
						I[54] = new("UICorner", I[53], "UICorner")
					I[55] = new("Frame", I[50], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -5), ZIndex = 3 })
						I[56] = new("Frame", I[55], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.7) })
							I[57] = new("UICorner", I[56], "UICorner")
							I[58] = new("UIGradient", I[56], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 153, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 100, 255)) }), Rotation = 90 })
						I[59] = new("Frame", I[55], "Top", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(48, 172, 255), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.5), ZIndex = 2 })
							I[60] = new("UICorner", I[59], "UICorner")
				I[61] = new("Configuration", I[45], "Configuration")
					I[62] = new("ObjectValue", I[61], "ObjectTextLabel")
					I[63] = new("ObjectValue", I[61], "ObjectTextLabelStroke")
					I[64] = new("ObjectValue", I[61], "ObjectHover")
				I[65] = new("Folder", I[45], "Scripts")
				I[66] = new("Frame", I[45], "Text", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0.6, -5), ZIndex = 2 })
					I[67] = new("TextLabel", I[66], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "CANCEL BET", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, ZIndex = 2 })
						I[68] = new("UIStroke", I[67], "UIStroke")
						I[69] = new("UITextSizeConstraint", I[67], "UITextSizeConstraint", { MinTextSize = 9 })
					I[70] = new("TextLabel", I[66], "TextLabel - Stroke", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.fromScale(1, 1), Text = "CANCEL BET", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 25, TextWrapped = true })
						I[71] = new("UITextSizeConstraint", I[70], "UITextSizeConstraint", { MinTextSize = 9 })
				I[72] = new("TextLabel", I[45], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "F", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
	I[34].Value = I[39]
	I[35].Value = I[42]
	I[36].Value = I[20]
	I[62].Value = I[67]
	I[63].Value = I[70]
	I[64].Value = I[48]
	return I[1]
end

return build
