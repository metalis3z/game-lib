-- Generated from ui/ServerStorage/Modules/GameFunctions/Slots.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Slots", { ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["PlinkoMoveDirection"] = 0 })
		I[2] = new("ObjectValue", I[1], "ActualTable")
		I[3] = new("Frame", I[1], "Backing", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.75), Size = UDim2.fromScale(0.3351762, 0.2630923) })
			I[4] = new("Frame", I[3], "Barrier", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.1, BorderSizePixel = 0, Position = UDim2.fromScale(0.3194568, 0), Size = UDim2.fromScale(0.3790061, 1), ZIndex = 2 })
				I[5] = new("TextLabel", I[4], "TextLabel", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 0.5), Text = "Waiting for spin to finish...", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[6] = new("ImageButton", I[3], "AutoBet", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, Position = UDim2.fromScale(0.15, 0.190759), Size = UDim2.fromScale(0.0973492, 0.2369668) })
				I[7] = new("TextLabel", I[6], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "H", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[8] = new("TextLabel", I[3], "AutoDescription", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.5688363), Size = UDim2.fromScale(0.3222673, 0.3983727), Text = "Auto spin will re-spin the slots when the round is over.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[9] = new("TextLabel", I[3], "AutoTitle", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.15, 0.0099042), Size = UDim2.fromScale(0.2652858, 0.1601942), Text = "Auto spin:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[10] = new("ImageButton", I[3], "Camera", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.6, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://13085201731"), Position = UDim2.fromScale(0.85, 0.2004404), Size = UDim2.fromScale(0.0973492, 0.2369668) })
				I[11] = new("TextLabel", I[10], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "C", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[12] = new("TextLabel", I[3], "CameraTitle", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.85, 0.0198083), Size = UDim2.fromScale(0.2652858, 0.1601942), Text = "Camera:", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[13] = new("TextLabel", I[3], "CameraDescription", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.85, 0.5785179), Size = UDim2.fromScale(0.3222673, 0.3983727), Text = "Switch between overhead and player camera angles.", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true })
			I[14] = new("TextButton", I[3], "Spin", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.199), Size = UDim2.fromScale(0.258, 0.237), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 }, { ["TextSizeEnabled"] = true, ["TextSizeScale"] = 0.5, ["TextValue"] = "BUTTON", ["TextValueEnabled"] = false })
				I[15] = new("UICorner", I[14], "UICorner")
				I[16] = new("UIStroke", I[14], "UIStroke ", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[17] = new("Frame", I[14], "Hover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
					I[18] = new("UICorner", I[17], "UICorner")
				I[19] = new("Frame", I[14], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[20] = new("Frame", I[19], "Color", { BackgroundColor3 = Color3.fromRGB(0, 51, 236), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[21] = new("UICorner", I[20], "UICorner")
					I[22] = new("Frame", I[19], "Shadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.new(1, 0, 1, 5) })
						I[23] = new("UICorner", I[22], "UICorner")
					I[24] = new("Frame", I[19], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -5), ZIndex = 3 })
						I[25] = new("Frame", I[24], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.7) })
							I[26] = new("UICorner", I[25], "UICorner")
							I[27] = new("UIGradient", I[25], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 153, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 100, 255)) }), Rotation = 90 })
						I[28] = new("Frame", I[24], "Top", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(48, 172, 255), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.5), ZIndex = 2 })
							I[29] = new("UICorner", I[28], "UICorner")
				I[30] = new("Configuration", I[14], "Configuration")
					I[31] = new("ObjectValue", I[30], "ObjectTextLabel")
					I[32] = new("ObjectValue", I[30], "ObjectTextLabelStroke")
					I[33] = new("ObjectValue", I[30], "ObjectHover")
				I[34] = new("Folder", I[14], "Scripts")
				I[35] = new("Frame", I[14], "Text", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0.6, -5), ZIndex = 2 })
					I[36] = new("TextLabel", I[35], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "SPIN", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, ZIndex = 2 })
						I[37] = new("UIStroke", I[36], "UIStroke")
						I[38] = new("UITextSizeConstraint", I[36], "UITextSizeConstraint", { MinTextSize = 9 })
					I[39] = new("TextLabel", I[35], "TextLabel - Stroke", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.fromScale(1, 1), Text = "SPIN", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 25, TextWrapped = true })
						I[40] = new("UITextSizeConstraint", I[39], "UITextSizeConstraint", { MinTextSize = 9 })
				I[41] = new("TextLabel", I[14], "Keybind", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.6), Text = "T", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
			I[42] = new("TextButton", I[3], "Cycle", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.506), Size = UDim2.fromScale(0.258, 0.237), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 14 }, { ["TextSizeEnabled"] = true, ["TextSizeScale"] = 0.5, ["TextValue"] = "BUTTON", ["TextValueEnabled"] = false })
				I[43] = new("UICorner", I[42], "UICorner")
				I[44] = new("UIStroke", I[42], "UIStroke ", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
				I[45] = new("Frame", I[42], "Hover", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 3 })
					I[46] = new("UICorner", I[45], "UICorner")
				I[47] = new("Frame", I[42], "Background", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[48] = new("Frame", I[47], "Color", { BackgroundColor3 = Color3.fromRGB(0, 51, 236), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[49] = new("UICorner", I[48], "UICorner")
					I[50] = new("Frame", I[47], "Shadow", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.8, Size = UDim2.new(1, 0, 1, 5) })
						I[51] = new("UICorner", I[50], "UICorner")
					I[52] = new("Frame", I[47], "Color", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, -5), ZIndex = 3 })
						I[53] = new("Frame", I[52], "Bottom", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.7) })
							I[54] = new("UICorner", I[53], "UICorner")
							I[55] = new("UIGradient", I[53], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 153, 247)), ColorSequenceKeypoint.new(1, Color3.fromRGB(28, 100, 255)) }), Rotation = 90 })
						I[56] = new("Frame", I[52], "Top", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(48, 172, 255), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.5), ZIndex = 2 })
							I[57] = new("UICorner", I[56], "UICorner")
				I[58] = new("Configuration", I[42], "Configuration")
					I[59] = new("ObjectValue", I[58], "ObjectTextLabel")
					I[60] = new("ObjectValue", I[58], "ObjectTextLabelStroke")
					I[61] = new("ObjectValue", I[58], "ObjectHover")
				I[62] = new("Folder", I[42], "Scripts")
				I[63] = new("Frame", I[42], "Text", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0.6, -5), ZIndex = 2 })
					I[64] = new("TextLabel", I[63], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "CYCLE", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 25, TextWrapped = true, ZIndex = 2 })
						I[65] = new("UIStroke", I[64], "UIStroke")
						I[66] = new("UITextSizeConstraint", I[64], "UITextSizeConstraint", { MinTextSize = 9 })
					I[67] = new("TextLabel", I[63], "TextLabel - Stroke", { AnchorPoint = Vector2.new(0.5, 0.45), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/LuckiestGuy.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 0, 0.5, 3), Size = UDim2.fromScale(1, 1), Text = "CYCLE", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 25, TextWrapped = true })
						I[68] = new("UITextSizeConstraint", I[67], "UITextSizeConstraint", { MinTextSize = 9 })
				I[69] = new("TextLabel", I[42], "Keybind", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 0.6), Text = "G", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextStrokeTransparency = 0, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Bottom })
		I[70] = new("Part", I[1], "Ball", { Anchored = true, BottomSurface = Enum.SurfaceType.Smooth, CFrame = CFrame.new(-334.0982666, 22.9090157, -237.8569031, 0, 0, 1, 0, 1, 0, -1, 0, 0), CanCollide = false, CollisionGroup = "PlinkoBall", Color = Color3.fromRGB(0, 255, 255), CustomPhysicalProperties = PhysicalProperties.new(1, 0, 0, 1, 1), Material = Enum.Material.Neon, Shape = Enum.PartType.Ball, Size = Vector3.new(1, 1, 1), TopSurface = Enum.SurfaceType.Smooth, Transparency = 1 })
	I[31].Value = I[36]
	I[32].Value = I[39]
	I[33].Value = I[17]
	I[59].Value = I[64]
	I[60].Value = I[67]
	I[61].Value = I[45]
	return I[1]
end

return build
