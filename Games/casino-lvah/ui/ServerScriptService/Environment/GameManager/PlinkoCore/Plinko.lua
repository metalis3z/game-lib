-- Generated from ui/ServerScriptService/Environment/GameManager/PlinkoCore/Plinko.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Plinko", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["PlinkoMoveDirection"] = 0 })
		I[2] = new("ObjectValue", I[1], "ActualTable")
		I[3] = new("Frame", I[1], "Backing", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.3351762, 0.2630923) })
			I[4] = new("TextBox", I[3], "BetBox", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255, 255, 255), PlaceholderText = "#", Position = UDim2.fromScale(0.8, 0.579), Size = UDim2.fromScale(0.2577319, 0.2369668), Text = "", TextColor3 = Color3.fromRGB(0, 255, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[5] = new("Frame", I[3], "Barrier", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[6] = new("TextLabel", I[5], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.5), Text = "Waiting for round to finish...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[7] = new("ImageButton", I[3], "AutoBet", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(1.1724139, 0.1808549), Size = UDim2.fromScale(0.0973492, 0.2369668) })
				I[8] = new("TextLabel", I[7], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "H", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[9] = new("TextLabel", I[3], "BetTip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0106547, 0.5589323), Size = UDim2.fromScale(0.3222673, 0.3983727), Text = "Auto bet will refresh your bets once the round is over.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[10] = new("TextLabel", I[3], "AutoTip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0400853, 0.0000001), Size = UDim2.fromScale(0.2652858, 0.1601942), Text = "Auto bet:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[11] = new("TextLabel", I[3], "Message", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.2), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
			I[12] = new("ImageButton", I[3], "Camera", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13085201731"), Position = UDim2.fromScale(-0.172, 0.181), Size = UDim2.fromScale(0.0973492, 0.2369668) })
				I[13] = new("TextLabel", I[12], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "C", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[14] = new("TextLabel", I[3], "CameraTip", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.04, 0), Size = UDim2.fromScale(0.2652858, 0.1601942), Text = "Camera:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[15] = new("TextLabel", I[3], "CameraTip2", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.011, 0.559), Size = UDim2.fromScale(0.3222673, 0.3983727), Text = "Switch between board and character cameras.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[16] = new("TextButton", I[3], "Cancel", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8, 0.232), Size = UDim2.fromScale(0.258, 0.237), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 }, { ["TextSizeEnabled"] = true, ["TextSizeScale"] = 0.5, ["TextValue"] = "BUTTON", ["TextValueEnabled"] = false })
				I[17] = new("UICorner", I[16], "UICorner")
				I[18] = new("UIStroke", I[16], "UIStroke ", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[19] = new("Frame", I[16], "Hover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
					I[20] = new("UICorner", I[19], "UICorner")
				I[21] = new("Frame", I[16], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[22] = new("Frame", I[21], "Color", { BackgroundColor3 = Color3.fromRGB(0, 51, 236), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[23] = new("UICorner", I[22], "UICorner")
					I[24] = new("Frame", I[21], "Shadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.new(1, 0, 1, 5) })
						I[25] = new("UICorner", I[24], "UICorner")
					I[26] = new("Frame", I[21], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -5), ZIndex = 3 })
						I[27] = new("Frame", I[26], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.7) })
							I[28] = new("UICorner", I[27], "UICorner")
							I[29] = new("UIGradient", I[27], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 153, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 100, 255)) }), Rotation = 90 })
						I[30] = new("Frame", I[26], "Top", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(48, 172, 255), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.5), ZIndex = 2 })
							I[31] = new("UICorner", I[30], "UICorner")
				I[32] = new("Configuration", I[16], "Configuration")
					I[33] = new("ObjectValue", I[32], "ObjectTextLabel")
					I[34] = new("ObjectValue", I[32], "ObjectTextLabelStroke")
					I[35] = new("ObjectValue", I[32], "ObjectHover")
				I[36] = new("Folder", I[16], "Scripts")
				I[37] = new("Frame", I[16], "Text", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0.6, -5), ZIndex = 2 })
					I[38] = new("TextLabel", I[37], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "CANCEL", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, ZIndex = 2 })
						I[39] = new("UIStroke", I[38], "UIStroke")
						I[40] = new("UITextSizeConstraint", I[38], "UITextSizeConstraint", { MinTextSize = 9 })
					I[41] = new("TextLabel", I[37], "TextLabel - Stroke", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.fromScale(1, 1), Text = "CANCEL", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 25, TextWrapped = true })
						I[42] = new("UITextSizeConstraint", I[41], "UITextSizeConstraint", { MinTextSize = 9 })
				I[43] = new("TextLabel", I[16], "Keybind", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.6), Text = "Y", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[44] = new("TextButton", I[3], "MoveRight", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.232), Size = UDim2.fromScale(0.258, 0.237), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 }, { ["TextSizeEnabled"] = true, ["TextSizeScale"] = 0.5, ["TextValue"] = "BUTTON", ["TextValueEnabled"] = false })
				I[45] = new("UICorner", I[44], "UICorner")
				I[46] = new("UIStroke", I[44], "UIStroke ", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[47] = new("Frame", I[44], "Hover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
					I[48] = new("UICorner", I[47], "UICorner")
				I[49] = new("Frame", I[44], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[50] = new("Frame", I[49], "Color", { BackgroundColor3 = Color3.fromRGB(0, 51, 236), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[51] = new("UICorner", I[50], "UICorner")
					I[52] = new("Frame", I[49], "Shadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.new(1, 0, 1, 5) })
						I[53] = new("UICorner", I[52], "UICorner")
					I[54] = new("Frame", I[49], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -5), ZIndex = 3 })
						I[55] = new("Frame", I[54], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.7) })
							I[56] = new("UICorner", I[55], "UICorner")
							I[57] = new("UIGradient", I[55], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 153, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 100, 255)) }), Rotation = 90 })
						I[58] = new("Frame", I[54], "Top", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(48, 172, 255), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.5), ZIndex = 2 })
							I[59] = new("UICorner", I[58], "UICorner")
				I[60] = new("Configuration", I[44], "Configuration")
					I[61] = new("ObjectValue", I[60], "ObjectTextLabel")
					I[62] = new("ObjectValue", I[60], "ObjectTextLabelStroke")
					I[63] = new("ObjectValue", I[60], "ObjectHover")
				I[64] = new("Folder", I[44], "Scripts")
				I[65] = new("Frame", I[44], "Text", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0.6, -5), ZIndex = 2 })
					I[66] = new("TextLabel", I[65], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = ">>>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, ZIndex = 2 })
						I[67] = new("UIStroke", I[66], "UIStroke")
						I[68] = new("UITextSizeConstraint", I[66], "UITextSizeConstraint", { MinTextSize = 9 })
					I[69] = new("TextLabel", I[65], "TextLabel - Stroke", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.fromScale(1, 1), Text = ">>>", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 25, TextWrapped = true })
						I[70] = new("UITextSizeConstraint", I[69], "UITextSizeConstraint", { MinTextSize = 9 })
				I[71] = new("TextLabel", I[44], "Keybind", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.6), Text = "T", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[72] = new("TextButton", I[3], "MoveLeft", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, 0.232), Size = UDim2.fromScale(0.258, 0.237), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 }, { ["TextSizeEnabled"] = true, ["TextSizeScale"] = 0.5, ["TextValue"] = "BUTTON", ["TextValueEnabled"] = false })
				I[73] = new("UICorner", I[72], "UICorner")
				I[74] = new("UIStroke", I[72], "UIStroke ", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[75] = new("Frame", I[72], "Hover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
					I[76] = new("UICorner", I[75], "UICorner")
				I[77] = new("Frame", I[72], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[78] = new("Frame", I[77], "Color", { BackgroundColor3 = Color3.fromRGB(0, 51, 236), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[79] = new("UICorner", I[78], "UICorner")
					I[80] = new("Frame", I[77], "Shadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.new(1, 0, 1, 5) })
						I[81] = new("UICorner", I[80], "UICorner")
					I[82] = new("Frame", I[77], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -5), ZIndex = 3 })
						I[83] = new("Frame", I[82], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.7) })
							I[84] = new("UICorner", I[83], "UICorner")
							I[85] = new("UIGradient", I[83], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 153, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 100, 255)) }), Rotation = 90 })
						I[86] = new("Frame", I[82], "Top", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(48, 172, 255), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.5), ZIndex = 2 })
							I[87] = new("UICorner", I[86], "UICorner")
				I[88] = new("Configuration", I[72], "Configuration")
					I[89] = new("ObjectValue", I[88], "ObjectTextLabel")
					I[90] = new("ObjectValue", I[88], "ObjectTextLabelStroke")
					I[91] = new("ObjectValue", I[88], "ObjectHover")
				I[92] = new("Folder", I[72], "Scripts")
				I[93] = new("Frame", I[72], "Text", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0.6, -5), ZIndex = 2 })
					I[94] = new("TextLabel", I[93], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "<<<", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, ZIndex = 2 })
						I[95] = new("UIStroke", I[94], "UIStroke")
						I[96] = new("UITextSizeConstraint", I[94], "UITextSizeConstraint", { MinTextSize = 9 })
					I[97] = new("TextLabel", I[93], "TextLabel - Stroke", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.fromScale(1, 1), Text = "<<<", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 25, TextWrapped = true })
						I[98] = new("UITextSizeConstraint", I[97], "UITextSizeConstraint", { MinTextSize = 9 })
				I[99] = new("TextLabel", I[72], "Keybind", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.6), Text = "R", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[100] = new("TextButton", I[3], "Place", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.579), Size = UDim2.fromScale(0.258, 0.237), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 }, { ["TextSizeEnabled"] = true, ["TextSizeScale"] = 0.5, ["TextValue"] = "BUTTON", ["TextValueEnabled"] = false })
				I[101] = new("UICorner", I[100], "UICorner")
				I[102] = new("UIStroke", I[100], "UIStroke ", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[103] = new("Frame", I[100], "Hover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
					I[104] = new("UICorner", I[103], "UICorner")
				I[105] = new("Frame", I[100], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[106] = new("Frame", I[105], "Color", { BackgroundColor3 = Color3.fromRGB(0, 51, 236), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[107] = new("UICorner", I[106], "UICorner")
					I[108] = new("Frame", I[105], "Shadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.new(1, 0, 1, 5) })
						I[109] = new("UICorner", I[108], "UICorner")
					I[110] = new("Frame", I[105], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -5), ZIndex = 3 })
						I[111] = new("Frame", I[110], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.7) })
							I[112] = new("UICorner", I[111], "UICorner")
							I[113] = new("UIGradient", I[111], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 153, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 100, 255)) }), Rotation = 90 })
						I[114] = new("Frame", I[110], "Top", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(48, 172, 255), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.5), ZIndex = 2 })
							I[115] = new("UICorner", I[114], "UICorner")
				I[116] = new("Configuration", I[100], "Configuration")
					I[117] = new("ObjectValue", I[116], "ObjectTextLabel")
					I[118] = new("ObjectValue", I[116], "ObjectTextLabelStroke")
					I[119] = new("ObjectValue", I[116], "ObjectHover")
				I[120] = new("Folder", I[100], "Scripts")
				I[121] = new("Frame", I[100], "Text", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0.6, -5), ZIndex = 2 })
					I[122] = new("TextLabel", I[121], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "PLACE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, ZIndex = 2 })
						I[123] = new("UIStroke", I[122], "UIStroke")
						I[124] = new("UITextSizeConstraint", I[122], "UITextSizeConstraint", { MinTextSize = 9 })
					I[125] = new("TextLabel", I[121], "TextLabel - Stroke", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.fromScale(1, 1), Text = "PLACE", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 25, TextWrapped = true })
						I[126] = new("UITextSizeConstraint", I[125], "UITextSizeConstraint", { MinTextSize = 9 })
				I[127] = new("TextLabel", I[100], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "G", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
		I[128] = new("Part", I[1], "Ball", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-334.0982666, 22.9090157, -237.8569031, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, CollisionGroup = "PlinkoBall", Color = Color3.fromRGB(0, 255, 255), CustomPhysicalProperties = PhysicalProperties.new(1, 0, 0, 1, 1), Material = Enum.Material.Neon, Shape = Enum.PartType.Ball, Size = Vector3.new(1, 1, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
	I[33].Value = I[38]
	I[34].Value = I[41]
	I[35].Value = I[19]
	I[61].Value = I[66]
	I[62].Value = I[69]
	I[63].Value = I[47]
	I[89].Value = I[94]
	I[90].Value = I[97]
	I[91].Value = I[75]
	I[117].Value = I[122]
	I[118].Value = I[125]
	I[119].Value = I[103]
	return I[1]
end

return build
