-- Generated from ui/ServerStorage/Removed_OldBasePanel/BasePanelGui.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "BasePanelGui", { DisplayOrder = 6, Enabled = false, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "PetRow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 0, 72) })
			I[3] = new("TextLabel", I[2], "PetName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, 74, 0.5, -15), Size = UDim2.new(1, -84, 0, 30), Text = "Demon", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[4] = new("UIStroke", I[3], "UIStroke", { Thickness = 2 })
			I[5] = new("TextLabel", I[2], "Level", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -66, 0, 4), Size = UDim2.fromOffset(58, 22), Text = "Lv.1", TextColor3 = Color3.fromRGB(255, 220, 80), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 2 })
			I[7] = new("Frame", I[2], "Bar", { BackgroundColor3 = Color3.fromRGB(92, 58, 30), Position = UDim2.fromOffset(74, 30), Size = UDim2.new(1, -82, 0, 16), Visible = false })
				I[8] = new("Frame", I[7], "Fill", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(0.5, 1) })
					I[9] = new("UICorner", I[8], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[10] = new("UIGradient", I[8], "FillGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(143, 232, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(79, 184, 240)) }), Rotation = 90 })
				I[11] = new("TextLabel", I[7], "Text", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "0/50 XP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 })
					I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 1.5 })
				I[13] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[14] = new("UIStroke", I[7], "UIStroke", { Thickness = 2 })
			I[15] = new("TextLabel", I[2], "Info", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(74, 50), Size = UDim2.new(1, -82, 0, 17), Text = "70 kg · $1K/s", TextColor3 = Color3.fromRGB(140, 255, 130), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
				I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 1.5 })
			I[17] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[18] = new("UIStroke", I[2], "UIStroke", { Thickness = 3 })
			I[19] = new("ViewportFrame", I[2], "View", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), LightColor = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(7, 7), Size = UDim2.fromOffset(58, 58) })
				I[20] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[21] = new("UIStroke", I[19], "UIStroke", { Thickness = 3 })
				I[22] = new("UIGradient", I[19], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 232, 244)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 252, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(238, 226, 200)) }) })
			I[23] = new("UIGradient", I[2], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 150, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 88, 14)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 168, 100)) }) })
			I[24] = new("ImageLabel", I[2], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
				I[25] = new("UIGradient", I[24], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 150, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 88, 14)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 168, 100)) }) })
				I[26] = new("UICorner", I[24], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
		I[27] = new("Frame", I[1], "TimerRow", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, 0, 0, 40) })
			I[28] = new("TextLabel", I[27], "Kind", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(8, 3), Size = UDim2.fromOffset(54, 14), Text = "Egg", TextColor3 = Color3.fromRGB(200, 190, 230), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Visible = false })
				I[29] = new("UIStroke", I[28], "UIStroke", { Thickness = 1.5 })
			I[30] = new("TextLabel", I[27], "ItemName", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(40, 0), Size = UDim2.new(1, -142, 1, 0), Text = "Secret Egg", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[31] = new("UIStroke", I[30], "UIStroke", { Thickness = 2 })
			I[32] = new("TextLabel", I[27], "Time", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(1, -98, 0, 8), Size = UDim2.fromOffset(90, 24), Text = "0:00", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
				I[33] = new("UIStroke", I[32], "UIStroke", { Thickness = 2 })
			I[34] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[35] = new("UIStroke", I[27], "UIStroke", { Thickness = 3 })
			I[36] = new("UIGradient", I[27], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 150, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 88, 14)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 168, 100)) }) })
			I[37] = new("ImageLabel", I[27], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(28, 28), ZIndex = 0 })
				I[38] = new("UIGradient", I[37], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 150, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 88, 14)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 160)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 168, 100)) }) })
				I[39] = new("UICorner", I[37], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[40] = new("ImageLabel", I[27], "EggIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://132030564859829"), Position = UDim2.new(0, 6, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(28, 28), ZIndex = 3 })
		I[41] = new("Frame", I[1], "Panel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.new(1, 330, 0.45, 0), Size = UDim2.fromOffset(330, 440) }, nil, { "AutoScale" })
			I[42] = new("ImageLabel", I[41], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(32, 32), ZIndex = 0 })
				I[43] = new("UIGradient", I[42], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 44, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 24, 58)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
				I[44] = new("UICorner", I[42], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[45] = new("Frame", I[41], "Header", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromOffset(8, 8), Size = UDim2.new(1, -16, 0, 44) })
				I[46] = new("ImageLabel", I[45], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(32, 32), ZIndex = 0 })
					I[47] = new("UIGradient", I[46], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 136, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(222, 88, 12)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 200, 90)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(190, 240, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 200, 90)) }) })
					I[48] = new("UICorner", I[46], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[49] = new("TextLabel", I[45], "Title", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(12, 7), Size = UDim2.new(1, -24, 1, -14), Text = "My Garden", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[50] = new("UIStroke", I[49], "UIStroke", { Thickness = 4.5 })
				I[51] = new("UIStroke", I[45], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[52] = new("CanvasGroup", I[45], "Shine", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
					I[53] = new("UICorner", I[52], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[54] = new("Frame", I[52], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.52, 0.5), Rotation = 28, Size = UDim2.new(0, 44, 2.5999999, 0) })
					I[55] = new("Frame", I[52], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.595, 0.5), Rotation = 28, Size = UDim2.new(0, 38, 2.5999999, 0) })
					I[56] = new("Frame", I[52], "Stripe", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.68, BorderSizePixel = 0, Position = UDim2.fromScale(0.67, 0.5), Rotation = 28, Size = UDim2.new(0, 32, 2.5999999, 0) })
				I[57] = new("UICorner", I[45], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[58] = new("UIStroke", I[45], "UIStroke", { Thickness = 3.5 })
				I[59] = new("UIGradient", I[45], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 136, 30)), ColorSequenceKeypoint.new(1, Color3.fromRGB(222, 88, 12)) }) }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 200, 90)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(190, 240, 60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 200, 90)) }) })
			I[60] = new("Frame", I[41], "Body", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 58), Size = UDim2.new(1, 0, 1, -58) })
				I[61] = new("Frame", I[60], "Tabs", { BackgroundTransparency = 1, Position = UDim2.fromOffset(8, 0), Size = UDim2.new(1, -16, 0, 36) })
					I[62] = new("TextButton", I[61], "PetsTab", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.new(0.5, -4, 1, 0), Text = "Pets", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true }, nil, { "UIButton" })
						I[63] = new("TextLabel", I[62], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(18, 0), Size = UDim2.new(1, -18, 1, 0), Text = "Pets", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
							I[64] = new("UIStroke", I[63], "TextStroke", { Thickness = 2.5 })
							I[65] = new("UIPadding", I[63], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), PaddingTop = UDim.new(0, 6) })
						I[66] = new("ImageLabel", I[62], "TabIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxthumb://type=Asset&id=128895446491384&w=150&h=150"), Position = UDim2.new(0, 8, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(28, 28), ZIndex = 3 })
						I[67] = new("ImageLabel", I[62], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
							I[68] = new("UICorner", I[67], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
							I[69] = new("UIGradient", I[67], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 190, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 124, 72)) }), Rotation = 90 })
						I[70] = new("UICorner", I[62], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[71] = new("UIStroke", I[62], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
						I[72] = new("UIGradient", I[62], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 190, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 124, 72)) }), Rotation = 90 })
					I[73] = new("TextButton", I[61], "TimersTab", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0.5, 4, 0, 0), Size = UDim2.new(0.5, -4, 1, 0), Text = "Egg Time", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true }, nil, { "UIButton" })
						I[74] = new("TextLabel", I[73], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromOffset(16, 0), Size = UDim2.new(1, -16, 1, 0), Text = "Egg Time", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
							I[75] = new("UIStroke", I[74], "TextStroke", { Thickness = 2.5 })
							I[76] = new("UIPadding", I[74], "UIPadding", { PaddingBottom = UDim.new(0, 7), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), PaddingTop = UDim.new(0, 6) })
						I[77] = new("ImageLabel", I[73], "EggIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://132030564859829"), Position = UDim2.new(0, 8, 0.5, 0), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(28, 28), ZIndex = 3 })
						I[78] = new("ImageLabel", I[73], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
							I[79] = new("UICorner", I[78], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
							I[80] = new("UIGradient", I[78], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 190, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 124, 72)) }), Rotation = 90 })
						I[81] = new("UICorner", I[73], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
						I[82] = new("UIStroke", I[73], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3.5 })
						I[83] = new("UIGradient", I[73], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 190, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(176, 124, 72)) }), Rotation = 90 })
				I[84] = new("ScrollingFrame", I[60], "List", { AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromOffset(8, 44), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), ScrollBarThickness = 5, Size = UDim2.new(1, -16, 1, -52) })
					I[85] = new("UIStroke", I[84], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
					I[86] = new("UICorner", I[84], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[87] = new("UIListLayout", I[84], "UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder })
					I[88] = new("UIPadding", I[84], "UIPadding", { PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 6) })
					I[89] = new("UIStroke", I[84], "UIStroke", { Thickness = 3 })
					I[90] = new("UIGradient", I[84], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 21, 46)), ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 13, 31)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(232, 233, 240)), ColorSequenceKeypoint.new(1, Color3.fromRGB(198, 200, 212)) }) })
				I[91] = new("TextLabel", I[60], "Empty", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.08, 0.45), Size = UDim2.new(0.84, 0, 0, 44), Text = "", TextColor3 = Color3.fromRGB(214, 208, 235), TextScaled = true, TextWrapped = true, Visible = false })
					I[92] = new("UIStroke", I[91], "UIStroke", { Thickness = 2 })
			I[93] = new("TextButton", I[41], "Arrow", { AnchorPoint = Vector2.new(1, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.new(0, -6, 0.5, 0), Size = UDim2.fromOffset(38, 84), Text = "<", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextTransparency = 1, TextWrapped = true })
				I[94] = new("TextLabel", I[93], "Label", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "<", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextWrapped = true, ZIndex = 2 }, { ["MirrorText"] = true })
					I[95] = new("UIStroke", I[94], "TextStroke", { Thickness = 2.5 })
					I[96] = new("UIPadding", I[94], "UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) })
				I[97] = new("ImageLabel", I[93], "Studs", { BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://7447638591"), ImageTransparency = 0.2, ScaleType = Enum.ScaleType.Tile, Size = UDim2.fromScale(1, 1), TileSize = UDim2.fromOffset(26, 26) })
					I[98] = new("UICorner", I[97], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
					I[99] = new("UIGradient", I[97], "Tint", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 150, 50)) }), Rotation = 90 })
				I[100] = new("UICorner", I[93], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
				I[101] = new("UIStroke", I[93], "Outline", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 3 })
				I[102] = new("UIGradient", I[93], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 214, 96)), ColorSequenceKeypoint.new(1, Color3.fromRGB(245, 150, 50)) }), Rotation = 90 })
			I[103] = new("UIStroke", I[41], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 4 })
			I[104] = new("UICorner", I[41], "UICorner", { BottomLeftRadius = UDim.new(0, 2), BottomRightRadius = UDim.new(0, 2), TopLeftRadius = UDim.new(0, 2), TopRightRadius = UDim.new(0, 2) })
			I[105] = new("UIStroke", I[41], "UIStroke", { Thickness = 4.5 })
			I[106] = new("UIGradient", I[41], "Shade", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 44, 100)), ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 24, 58)) }), Rotation = 90 }, { ["HW_Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(226, 228, 238)) }) })
	return I[1]
end

return build
