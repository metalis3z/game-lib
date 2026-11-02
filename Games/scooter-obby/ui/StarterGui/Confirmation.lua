-- Generated from ui/StarterGui/Confirmation.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Confirmation", { Enabled = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "BoxConfirmation", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(118, 118, 118), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.375, 0.375), ZIndex = 2 })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 2 })
			I[4] = new("Frame", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
				I[5] = new("Frame", I[4], "Back2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 141, 212), Position = UDim2.fromScale(0.5, 0.5), Rotation = -3, Size = UDim2.fromScale(0.95, 0.95), ZIndex = 2 })
					I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(0.02, 0), BottomRightRadius = UDim.new(0.02, 0), TopLeftRadius = UDim.new(0.02, 0), TopRightRadius = UDim.new(0.02, 0) })
				I[7] = new("Frame", I[4], "Back1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 115, 172), Position = UDim2.fromScale(0.5, 0.5), Rotation = -5, Size = UDim2.fromScale(0.95, 0.95) })
					I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.02, 0), BottomRightRadius = UDim.new(0.02, 0), TopLeftRadius = UDim.new(0.02, 0), TopRightRadius = UDim.new(0.02, 0) })
				I[9] = new("Frame", I[4], "Inside", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.95), ZIndex = 3 })
					I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.02, 0), BottomRightRadius = UDim.new(0.02, 0), TopLeftRadius = UDim.new(0.02, 0), TopRightRadius = UDim.new(0.02, 0) })
					I[11] = new("UIStroke", I[9], "UIStroke", { Color = Color3.fromRGB(0, 141, 212), Thickness = 4 })
					I[12] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212)) }), Rotation = 90 })
					I[13] = new("Frame", I[9], "TileClip", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
						I[14] = new("ImageLabel", I[13], "Tile", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=4618197225"), ImageTransparency = 0.967, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(5, 5), SliceScale = 0, TileSize = UDim2.fromScale(0.125, 0.125) })
							I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
						I[16] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0, 15), BottomRightRadius = UDim.new(0, 15), TopLeftRadius = UDim.new(0, 15), TopRightRadius = UDim.new(0, 15) })
					I[17] = new("Frame", I[9], "Content", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
						I[18] = new("Frame", I[17], "Loading", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.4, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
							I[19] = new("TextButton", I[18], "AntiClick", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14 })
							I[20] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.02, 0), BottomRightRadius = UDim.new(0.02, 0), TopLeftRadius = UDim.new(0.02, 0), TopRightRadius = UDim.new(0.02, 0) })
							I[21] = new("ImageLabel", I[18], "LoadingSprite", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 170, 255), ImageContent = Content.fromUri("http://www.roblox.com/asset/?id=9552250311"), ImageRectSize = Vector2.new(100, 100), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.625, 0.625) })
								I[22] = new("UIAspectRatioConstraint", I[21], "UIAspectRatioConstraint")
						I[23] = new("Frame", I[17], "Yes", { AnchorPoint = Vector2.new(0, 0.8), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.1, 0.9), Size = UDim2.fromScale(0.375, 0.2) })
							I[24] = new("Frame", I[23], "Back", { BackgroundColor3 = Color3.fromRGB(54, 175, 35), Size = UDim2.fromScale(1, 1) })
								I[25] = new("UICorner", I[24], "UICorner")
								I[26] = new("Frame", I[24], "Top", { BackgroundColor3 = Color3.fromRGB(79, 255, 52), Size = UDim2.fromScale(1, 0.9) })
									I[27] = new("UICorner", I[26], "UICorner")
									I[28] = new("UIGradient", I[26], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.495, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.505, Color3.fromRGB(225, 225, 225)), ColorSequenceKeypoint.new(1, Color3.fromRGB(225, 225, 225)) }), Offset = Vector2.new(0, 0.1), Rotation = 75 })
									I[29] = new("TextLabel", I[26], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "Yes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
										I[30] = new("UIStroke", I[29], "UIStroke", { Color = Color3.fromRGB(54, 175, 35), Thickness = 2 })
									I[31] = new("Frame", I[26], "Highlight", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
										I[32] = new("UICorner", I[31], "UICorner")
									I[33] = new("UIStroke", I[26], "UIStroke", { Color = Color3.fromRGB(54, 175, 35), Thickness = 2 })
								I[34] = new("TextButton", I[24], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 2 })
						I[35] = new("Frame", I[17], "No", { AnchorPoint = Vector2.new(0, 0.8), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.55, 0.9), Size = UDim2.fromScale(0.375, 0.2) })
							I[36] = new("Frame", I[35], "Back", { BackgroundColor3 = Color3.fromRGB(153, 0, 0), Size = UDim2.fromScale(1, 1) })
								I[37] = new("UICorner", I[36], "UICorner")
								I[38] = new("Frame", I[36], "Top", { BackgroundColor3 = Color3.fromRGB(255, 25, 25), Size = UDim2.fromScale(1, 0.9) })
									I[39] = new("UICorner", I[38], "UICorner")
									I[40] = new("UIGradient", I[38], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.495, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.505, Color3.fromRGB(225, 225, 225)), ColorSequenceKeypoint.new(1, Color3.fromRGB(225, 225, 225)) }), Offset = Vector2.new(0, 0.1), Rotation = 75 })
									I[41] = new("TextLabel", I[38], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "No", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
										I[42] = new("UIStroke", I[41], "UIStroke", { Color = Color3.fromRGB(153, 0, 0), Thickness = 2 })
									I[43] = new("Frame", I[38], "Highlight", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
										I[44] = new("UICorner", I[43], "UICorner")
									I[45] = new("UIStroke", I[38], "UIStroke", { Color = Color3.fromRGB(153, 0, 0), Thickness = 2 })
								I[46] = new("TextButton", I[36], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 2 })
						I[47] = new("TextLabel", I[17], "Label", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4968973, 0.1380027), Size = UDim2.fromScale(0.8370825, 0.484359), Text = "Are you sure you want to buy this crate?", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
							I[48] = new("UIStroke", I[47], "UIStroke", { Color = Color3.fromRGB(0, 115, 172), Thickness = 2 })
					I[49] = new("Frame", I[9], "Close", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.945, -0.1), Rotation = -5, Size = UDim2.fromScale(0.125, 0.2), ZIndex = 4 })
						I[50] = new("Frame", I[49], "Back", { BackgroundColor3 = Color3.fromRGB(145, 33, 33), Size = UDim2.fromScale(1, 1) })
							I[51] = new("UICorner", I[50], "UICorner")
							I[52] = new("Frame", I[50], "Top", { BackgroundColor3 = Color3.fromRGB(255, 51, 51), Size = UDim2.fromScale(1, 0.9) })
								I[53] = new("UICorner", I[52], "UICorner")
								I[54] = new("UIGradient", I[52], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.495, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.505, Color3.fromRGB(225, 225, 225)), ColorSequenceKeypoint.new(1, Color3.fromRGB(225, 225, 225)) }), Offset = Vector2.new(0, 0.1), Rotation = 75 })
								I[55] = new("TextLabel", I[52], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
									I[56] = new("UIStroke", I[55], "UIStroke", { Color = Color3.fromRGB(156, 31, 31), Thickness = 2 })
								I[57] = new("Frame", I[52], "Highlight", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 2 })
									I[58] = new("UICorner", I[57], "UICorner")
							I[59] = new("TextButton", I[50], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 2 })
						I[60] = new("UIAspectRatioConstraint", I[49], "UIAspectRatioConstraint")
					I[61] = new("Frame", I[9], "Title", { BackgroundColor3 = Color3.fromRGB(118, 118, 118), BackgroundTransparency = 1, Position = UDim2.fromScale(-0.01, -0.125), Size = UDim2.fromScale(0.825, 0.2), ZIndex = 4 })
						I[62] = new("TextLabel", I[61], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5117488, 0.6174878), Size = UDim2.fromScale(1, 1), Text = "Confirm", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[63] = new("UIStroke", I[62], "UIStroke", { Color = Color3.fromRGB(0, 141, 212), Thickness = 3 })
						I[64] = new("UIAspectRatioConstraint", I[61], "UIAspectRatioConstraint", { AspectRatio = 10 })
		I[65] = new("Frame", I[1], "Black", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.5, -0.5), Size = UDim2.fromScale(2, 2) })
		I[66] = new("StringValue", I[1], "Decision")
	return I[1]
end

return build
