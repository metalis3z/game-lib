-- Generated from ui/StarterGui/Auras.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Auras", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 47, 182), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.525), Visible = false })
			I[3] = new("ImageButton", I[2], "Auras", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://12489985753"), ImageTransparency = 1, Position = UDim2.fromScale(0.9823702, 0.0268938), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1000238, 0.1750417), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "UICloseButton" })
				I[4] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(-0.05, 0) })
				I[5] = new("UICorner", I[3], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[6] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.64, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(188, 4, 0)) }), Rotation = 90 })
				I[7] = new("UIStroke", I[3], "UIStroke", { Thickness = 3 })
				I[8] = new("ImageLabel", I[3], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13704067744"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55), ZIndex = 2 })
				I[9] = new("UIAspectRatioConstraint", I[3], "UIAspectRatioConstraint")
			I[10] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.9469727 })
			I[11] = new("ScrollingFrame", I[2], "Middle", { Active = true, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.fromScale(0, 0), Position = UDim2.fromScale(0.5, 0.5300712), ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.fromScale(0.95, 0.8398576) })
				I[12] = new("UIGridLayout", I[11], "UIGridLayout", { CellPadding = UDim2.fromScale(-0.025, 0.075), CellSize = UDim2.fromScale(0.25, 0.4), FillDirectionMaxCells = 7, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
				I[13] = new("Frame", I[11], "Fire", { BackgroundColor3 = Color3.fromRGB(14, 39, 105), Size = UDim2.fromOffset(100, 100) })
					I[14] = new("UIStroke", I[13], "UIStroke", { Thickness = 3 })
					I[15] = new("UICorner", I[13], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
					I[16] = new("UIScale", I[13], "UIScale", { Scale = 0.8 })
					I[17] = new("ImageButton", I[13], "EquipBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13804213417"), Position = UDim2.fromScale(0.4999996, 1.1128876), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.925, 0.4), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
						I[18] = new("TextLabel", I[17], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromScale(0.9, 0.8), Text = "EQUIP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
							I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 1.5 })
					I[20] = new("TextLabel", I[13], "Title", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.15), Size = UDim2.fromScale(1, 0.3), Text = "Fire", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[21] = new("UIStroke", I[20], "UIStroke", { Color = Color3.fromRGB(19, 19, 19), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
					I[22] = new("Frame", I[13], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.475, 0.675) })
						I[23] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[24] = new("UIStroke", I[22], "UIStroke", { Thickness = 3 })
						I[25] = new("UIGradient", I[22], "Fire", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.545, Color3.fromRGB(255, 107, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = -90 })
						I[26] = new("ImageLabel", I[22], "Lock", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13812164923"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
							I[27] = new("UIAspectRatioConstraint", I[26], "UIAspectRatioConstraint")
							I[28] = new("UIScale", I[26], "UIScale", { Scale = 0.75 })
				I[29] = new("Frame", I[11], "Electro", { BackgroundColor3 = Color3.fromRGB(14, 39, 105), Position = UDim2.fromScale(0.5125, 0.04), Size = UDim2.fromOffset(140, 101) })
					I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 3 })
					I[31] = new("UICorner", I[29], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
					I[32] = new("UIScale", I[29], "UIScale", { Scale = 0.8 })
					I[33] = new("ImageButton", I[29], "EquipBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13804213417"), Position = UDim2.fromScale(0.4999996, 1.1128876), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.925, 0.4), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
						I[34] = new("TextLabel", I[33], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromScale(0.9, 0.8), Text = "EQUIP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
							I[35] = new("UIStroke", I[34], "UIStroke", { Thickness = 1.5 })
					I[36] = new("TextLabel", I[29], "Title", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.15), Size = UDim2.fromScale(1, 0.3), Text = "Electro", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[37] = new("UIStroke", I[36], "UIStroke", { Color = Color3.fromRGB(19, 19, 19), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
					I[38] = new("Frame", I[29], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.475, 0.675) })
						I[39] = new("UICorner", I[38], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[40] = new("UIStroke", I[38], "UIStroke", { Thickness = 3 })
						I[41] = new("UIGradient", I[38], "Electro", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255)) }), Rotation = -90 })
						I[42] = new("ImageLabel", I[38], "Lock", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13812164923"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
							I[43] = new("UIAspectRatioConstraint", I[42], "UIAspectRatioConstraint")
							I[44] = new("UIScale", I[42], "UIScale", { Scale = 0.75 })
				I[45] = new("Frame", I[11], "Demon", { BackgroundColor3 = Color3.fromRGB(14, 39, 105), Position = UDim2.fromScale(0.5125, 0.04), Size = UDim2.fromOffset(140, 101) })
					I[46] = new("UIStroke", I[45], "UIStroke", { Thickness = 3 })
					I[47] = new("UICorner", I[45], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
					I[48] = new("UIScale", I[45], "UIScale", { Scale = 0.8 })
					I[49] = new("ImageButton", I[45], "EquipBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13804213417"), Position = UDim2.fromScale(0.4999996, 1.1128876), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.925, 0.4), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
						I[50] = new("TextLabel", I[49], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromScale(0.9, 0.8), Text = "EQUIP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
							I[51] = new("UIStroke", I[50], "UIStroke", { Thickness = 1.5 })
					I[52] = new("TextLabel", I[45], "Title", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.15), Size = UDim2.fromScale(1, 0.3), Text = "Demon", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[53] = new("UIStroke", I[52], "UIStroke", { Color = Color3.fromRGB(19, 19, 19), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
					I[54] = new("Frame", I[45], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.475, 0.675) })
						I[55] = new("UICorner", I[54], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[56] = new("UIStroke", I[54], "UIStroke", { Thickness = 3 })
						I[57] = new("UIGradient", I[54], "Electro", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(164, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) }), Rotation = -90 })
						I[58] = new("ImageLabel", I[54], "Lock", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13812164923"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
							I[59] = new("UIAspectRatioConstraint", I[58], "UIAspectRatioConstraint")
							I[60] = new("UIScale", I[58], "UIScale", { Scale = 0.75 })
				I[61] = new("Frame", I[11], "Emerald", { BackgroundColor3 = Color3.fromRGB(14, 39, 105), Position = UDim2.fromScale(0.5125, 0.04), Size = UDim2.fromOffset(140, 101) })
					I[62] = new("UIStroke", I[61], "UIStroke", { Thickness = 3 })
					I[63] = new("UICorner", I[61], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
					I[64] = new("UIScale", I[61], "UIScale", { Scale = 0.8 })
					I[65] = new("ImageButton", I[61], "EquipBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13804213417"), Position = UDim2.fromScale(0.4999996, 1.1128876), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.925, 0.4), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
						I[66] = new("TextLabel", I[65], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromScale(0.9, 0.8), Text = "EQUIP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
							I[67] = new("UIStroke", I[66], "UIStroke", { Thickness = 1.5 })
					I[68] = new("TextLabel", I[61], "Title", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.15), Size = UDim2.fromScale(1, 0.3), Text = "Emerald", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[69] = new("UIStroke", I[68], "UIStroke", { Color = Color3.fromRGB(19, 19, 19), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
					I[70] = new("Frame", I[61], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.475, 0.675) })
						I[71] = new("UICorner", I[70], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[72] = new("UIStroke", I[70], "UIStroke", { Thickness = 3 })
						I[73] = new("UIGradient", I[70], "Electro", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(4, 155, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(19, 255, 0)) }), Rotation = -90 })
						I[74] = new("ImageLabel", I[70], "Lock", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13812164923"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
							I[75] = new("UIAspectRatioConstraint", I[74], "UIAspectRatioConstraint")
							I[76] = new("UIScale", I[74], "UIScale", { Scale = 0.75 })
				I[77] = new("Frame", I[11], "Divine", { BackgroundColor3 = Color3.fromRGB(14, 39, 105), Position = UDim2.fromScale(0.5125, 0.04), Size = UDim2.fromOffset(140, 101) })
					I[78] = new("UIStroke", I[77], "UIStroke", { Thickness = 3 })
					I[79] = new("UICorner", I[77], "UICorner", { BottomLeftRadius = UDim.new(0.1, 0), BottomRightRadius = UDim.new(0.1, 0), TopLeftRadius = UDim.new(0.1, 0), TopRightRadius = UDim.new(0.1, 0) })
					I[80] = new("UIScale", I[77], "UIScale", { Scale = 0.8 })
					I[81] = new("ImageButton", I[77], "EquipBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13804213417"), Position = UDim2.fromScale(0.4999996, 1.1128876), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.925, 0.4), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
						I[82] = new("TextLabel", I[81], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromScale(0.9, 0.8), Text = "EQUIP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
							I[83] = new("UIStroke", I[82], "UIStroke", { Thickness = 1.5 })
					I[84] = new("TextLabel", I[77], "Title", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.15), Size = UDim2.fromScale(1, 0.3), Text = "Divine", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
						I[85] = new("UIStroke", I[84], "UIStroke", { Color = Color3.fromRGB(19, 19, 19), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
					I[86] = new("Frame", I[77], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.475, 0.675) })
						I[87] = new("UICorner", I[86], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[88] = new("UIStroke", I[86], "UIStroke", { Thickness = 3 })
						I[89] = new("UIGradient", I[86], "Electro", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 144)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = -90 })
						I[90] = new("ImageLabel", I[86], "Lock", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13812164923"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
							I[91] = new("UIAspectRatioConstraint", I[90], "UIAspectRatioConstraint")
							I[92] = new("UIScale", I[90], "UIScale", { Scale = 0.75 })
			I[93] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
	return I[1]
end

return build
