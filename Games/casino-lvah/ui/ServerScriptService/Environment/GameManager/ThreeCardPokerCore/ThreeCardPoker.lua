-- Generated from ui/ServerScriptService/Environment/GameManager/ThreeCardPokerCore/ThreeCardPoker.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "ThreeCardPoker", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("ObjectValue", I[1], "ActualTable")
		I[3] = new("Frame", I[1], "Backing", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.3351762, 0.2630923) })
			I[4] = new("TextLabel", I[3], "Timer", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.2), Text = "", TextColor3 = Color3.fromRGB(255, 162, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
			I[5] = new("TextBox", I[3], "BonusBox", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255, 255, 255), PlaceholderText = "#", Position = UDim2.fromScale(0.2092443, 0.2274881), Size = UDim2.fromScale(0.258, 0.237), Text = "", TextColor3 = Color3.fromRGB(0, 255, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[6] = new("TextLabel", I[5], "Tip", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.6), Text = "Bonus", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[7] = new("Frame", I[3], "BetBarrier", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.1, BorderSizePixel = 0, Size = UDim2.fromScale(0.65, 1), ZIndex = 2 })
				I[8] = new("TextLabel", I[7], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.5), Text = "No bets once round starts...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[9] = new("TextBox", I[3], "PairBox", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255, 255, 255), PlaceholderText = "#", Position = UDim2.fromScale(0.5, 0.227), Size = UDim2.fromScale(0.2577319, 0.237), Text = "", TextColor3 = Color3.fromRGB(0, 255, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[10] = new("TextLabel", I[9], "Tip", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.6), Text = "Pair Plus", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[11] = new("TextBox", I[3], "AnteBox", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255, 255, 255), PlaceholderText = "#", Position = UDim2.fromScale(0.2092443, 0.578199), Size = UDim2.fromScale(0.258, 0.237), Text = "", TextColor3 = Color3.fromRGB(0, 255, 0), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
				I[12] = new("TextLabel", I[11], "Tip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "Ante", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[13] = new("Frame", I[3], "TurnBarrier", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.1, BorderSizePixel = 0, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.35, 1), ZIndex = 2 })
				I[14] = new("TextLabel", I[13], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.75), Text = "Waiting on dealer...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[15] = new("TextLabel", I[3], "AutoTip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0400853, 0.0000001), Size = UDim2.fromScale(0.2652858, 0.1601942), Text = "Auto bet:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[16] = new("ImageButton", I[3], "AutoBet", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(1.1710106, 0.2235498), Size = UDim2.fromScale(0.0973492, 0.2369668) })
				I[17] = new("TextLabel", I[16], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "H", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[18] = new("TextLabel", I[3], "BetTip", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(1.0092514, 0.6016272), Size = UDim2.fromScale(0.3222673, 0.3983727), Text = "Auto bet will refresh your bets once the round is over.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[19] = new("TextLabel", I[3], "Message", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.2, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.2), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, Visible = false })
			I[20] = new("TextButton", I[3], "Play", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8, 0.232), Size = UDim2.fromScale(0.258, 0.237), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 }, { ["TextSizeEnabled"] = true, ["TextSizeScale"] = 0.5, ["TextValue"] = "BUTTON", ["TextValueEnabled"] = false })
				I[21] = new("UICorner", I[20], "UICorner")
				I[22] = new("UIStroke", I[20], "UIStroke ", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[23] = new("Frame", I[20], "Hover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
					I[24] = new("UICorner", I[23], "UICorner")
				I[25] = new("Frame", I[20], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[26] = new("Frame", I[25], "Color", { BackgroundColor3 = Color3.fromRGB(0, 51, 236), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[27] = new("UICorner", I[26], "UICorner")
					I[28] = new("Frame", I[25], "Shadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.new(1, 0, 1, 5) })
						I[29] = new("UICorner", I[28], "UICorner")
					I[30] = new("Frame", I[25], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -5), ZIndex = 3 })
						I[31] = new("Frame", I[30], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.7) })
							I[32] = new("UICorner", I[31], "UICorner")
							I[33] = new("UIGradient", I[31], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 153, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 100, 255)) }), Rotation = 90 })
						I[34] = new("Frame", I[30], "Top", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(48, 172, 255), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.5), ZIndex = 2 })
							I[35] = new("UICorner", I[34], "UICorner")
				I[36] = new("Configuration", I[20], "Configuration")
					I[37] = new("ObjectValue", I[36], "ObjectTextLabel")
					I[38] = new("ObjectValue", I[36], "ObjectTextLabelStroke")
					I[39] = new("ObjectValue", I[36], "ObjectHover")
				I[40] = new("Folder", I[20], "Scripts")
				I[41] = new("Frame", I[20], "Text", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0.6, -5), ZIndex = 2 })
					I[42] = new("TextLabel", I[41], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "PLAY", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, ZIndex = 2 })
						I[43] = new("UIStroke", I[42], "UIStroke")
						I[44] = new("UITextSizeConstraint", I[42], "UITextSizeConstraint", { MinTextSize = 9 })
					I[45] = new("TextLabel", I[41], "TextLabel - Stroke", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.fromScale(1, 1), Text = "PLAY", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 25, TextWrapped = true })
						I[46] = new("UITextSizeConstraint", I[45], "UITextSizeConstraint", { MinTextSize = 9 })
				I[47] = new("TextLabel", I[20], "Keybind", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.6), Text = "T", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[48] = new("TextButton", I[3], "Fold", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.8, 0.579), Size = UDim2.fromScale(0.258, 0.237), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 }, { ["TextSizeEnabled"] = true, ["TextSizeScale"] = 0.5, ["TextValue"] = "BUTTON", ["TextValueEnabled"] = false })
				I[49] = new("UICorner", I[48], "UICorner")
				I[50] = new("UIStroke", I[48], "UIStroke ", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[51] = new("Frame", I[48], "Hover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
					I[52] = new("UICorner", I[51], "UICorner")
				I[53] = new("Frame", I[48], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[54] = new("Frame", I[53], "Color", { BackgroundColor3 = Color3.fromRGB(0, 51, 236), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[55] = new("UICorner", I[54], "UICorner")
					I[56] = new("Frame", I[53], "Shadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.new(1, 0, 1, 5) })
						I[57] = new("UICorner", I[56], "UICorner")
					I[58] = new("Frame", I[53], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -5), ZIndex = 3 })
						I[59] = new("Frame", I[58], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.7) })
							I[60] = new("UICorner", I[59], "UICorner")
							I[61] = new("UIGradient", I[59], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 153, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 100, 255)) }), Rotation = 90 })
						I[62] = new("Frame", I[58], "Top", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(48, 172, 255), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.5), ZIndex = 2 })
							I[63] = new("UICorner", I[62], "UICorner")
				I[64] = new("Configuration", I[48], "Configuration")
					I[65] = new("ObjectValue", I[64], "ObjectTextLabel")
					I[66] = new("ObjectValue", I[64], "ObjectTextLabelStroke")
					I[67] = new("ObjectValue", I[64], "ObjectHover")
				I[68] = new("Folder", I[48], "Scripts")
				I[69] = new("Frame", I[48], "Text", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0.6, -5), ZIndex = 2 })
					I[70] = new("TextLabel", I[69], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "FOLD", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, ZIndex = 2 })
						I[71] = new("UIStroke", I[70], "UIStroke")
						I[72] = new("UITextSizeConstraint", I[70], "UITextSizeConstraint", { MinTextSize = 9 })
					I[73] = new("TextLabel", I[69], "TextLabel - Stroke", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.fromScale(1, 1), Text = "FOLD", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 25, TextWrapped = true })
						I[74] = new("UITextSizeConstraint", I[73], "UITextSizeConstraint", { MinTextSize = 9 })
				I[75] = new("TextLabel", I[48], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "G", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[76] = new("TextButton", I[3], "Bet", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.579), Size = UDim2.fromScale(0.258, 0.237), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 }, { ["TextSizeEnabled"] = true, ["TextSizeScale"] = 0.5, ["TextValue"] = "BUTTON", ["TextValueEnabled"] = false })
				I[77] = new("UICorner", I[76], "UICorner")
				I[78] = new("UIStroke", I[76], "UIStroke ", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[79] = new("Frame", I[76], "Hover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
					I[80] = new("UICorner", I[79], "UICorner")
				I[81] = new("Frame", I[76], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[82] = new("Frame", I[81], "Color", { BackgroundColor3 = Color3.fromRGB(0, 51, 236), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[83] = new("UICorner", I[82], "UICorner")
					I[84] = new("Frame", I[81], "Shadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.new(1, 0, 1, 5) })
						I[85] = new("UICorner", I[84], "UICorner")
					I[86] = new("Frame", I[81], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -5), ZIndex = 3 })
						I[87] = new("Frame", I[86], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.7) })
							I[88] = new("UICorner", I[87], "UICorner")
							I[89] = new("UIGradient", I[87], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 153, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 100, 255)) }), Rotation = 90 })
						I[90] = new("Frame", I[86], "Top", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(48, 172, 255), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.5), ZIndex = 2 })
							I[91] = new("UICorner", I[90], "UICorner")
				I[92] = new("Configuration", I[76], "Configuration")
					I[93] = new("ObjectValue", I[92], "ObjectTextLabel")
					I[94] = new("ObjectValue", I[92], "ObjectTextLabelStroke")
					I[95] = new("ObjectValue", I[92], "ObjectHover")
				I[96] = new("Folder", I[76], "Scripts")
				I[97] = new("Frame", I[76], "Text", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0.6, -5), ZIndex = 2 })
					I[98] = new("TextLabel", I[97], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "BET", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, ZIndex = 2 })
						I[99] = new("UIStroke", I[98], "UIStroke")
						I[100] = new("UITextSizeConstraint", I[98], "UITextSizeConstraint", { MinTextSize = 9 })
					I[101] = new("TextLabel", I[97], "TextLabel - Stroke", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.fromScale(1, 1), Text = "BET", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 25, TextWrapped = true })
						I[102] = new("UITextSizeConstraint", I[101], "UITextSizeConstraint", { MinTextSize = 9 })
				I[103] = new("TextLabel", I[76], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "F", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[104] = new("ImageButton", I[3], "Camera", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13085201731"), Position = UDim2.fromScale(-0.171, 0.224), Size = UDim2.fromScale(0.0973492, 0.2369668) })
				I[105] = new("TextLabel", I[104], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "C", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[106] = new("TextLabel", I[3], "CameraTip", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.04, 0), Size = UDim2.fromScale(0.2652858, 0.1601942), Text = "Camera:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[107] = new("TextLabel", I[3], "CameraTip2", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(-0.009, 0.602), Size = UDim2.fromScale(0.3222673, 0.3983727), Text = "Switch between player, dealer, and character cameras.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
	I[37].Value = I[42]
	I[38].Value = I[45]
	I[39].Value = I[23]
	I[65].Value = I[70]
	I[66].Value = I[73]
	I[67].Value = I[51]
	I[93].Value = I[98]
	I[94].Value = I[101]
	I[95].Value = I[79]
	return I[1]
end

return build
