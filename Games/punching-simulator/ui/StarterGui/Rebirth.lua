-- Generated from ui/StarterGui/Rebirth.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "Rebirth", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 47, 182), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4573816, 0.4679729), Visible = false })
			I[3] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.75, DominantAxis = Enum.DominantAxis.Height })
			I[4] = new("ImageButton", I[2], "RebirthBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13712743741"), Position = UDim2.fromScale(0.4994343, 1.1150001), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.3168504, 0.165029), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
				I[5] = new("TextLabel", I[4], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromScale(0.9, 0.6), Text = "REBIRTH!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
			I[7] = new("ImageLabel", I[2], "ProgressBar", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12445578494"), Position = UDim2.fromScale(0.5, 0.875), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.655318, 0.1303837), SliceCenter = Rect.new(50, 47, 50, 47) })
				I[8] = new("ImageLabel", I[7], "Progress", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13549999963"), Position = UDim2.fromScale(0.0000001, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.1212446, 1), SliceCenter = Rect.new(50, 47, 50, 47) })
					I[9] = new("UIGradient", I[8], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0011601, 0), NumberSequenceKeypoint.new(0.0023202, 1), NumberSequenceKeypoint.new(0.4709977, 1), NumberSequenceKeypoint.new(1, 1) }) })
				I[10] = new("TextLabel", I[7], "ProgressText", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.6, 0.7), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
					I[11] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(40, 40, 40), Thickness = 2 })
					I[12] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 39 })
				I[13] = new("ImageLabel", I[7], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14263657723"), Position = UDim2.fromScale(0.0991578, 0.4991265), Size = UDim2.fromScale(0.1451899, 1.2681884) })
			I[14] = new("ImageButton", I[2], "Rebirth", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), ImageContent = Content.fromUri("rbxassetid://12489985753"), ImageTransparency = 1, Position = UDim2.fromScale(0.9823702, 0.0268938), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1000238, 0.1750417), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "UIToggleButton" })
				I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint")
				I[16] = new("UIPadding", I[14], "UIPadding", { PaddingBottom = UDim.new(-0.05, 0) })
				I[17] = new("UICorner", I[14], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[18] = new("UIGradient", I[14], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.64, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(188, 4, 0)) }), Rotation = 90 })
				I[19] = new("UIStroke", I[14], "UIStroke", { Thickness = 3 })
				I[20] = new("ImageLabel", I[14], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13704067744"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.55, 0.55), ZIndex = 2 })
			I[21] = new("ImageLabel", I[2], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13704206150"), Position = UDim2.fromScale(0.5534709, 0.2207899), Size = UDim2.fromScale(0.1371691, 0.2312599) })
			I[22] = new("Frame", I[2], "BeforeStrength", { BackgroundColor3 = Color3.fromRGB(8, 26, 100), Position = UDim2.fromScale(0.083834, 0.1547495), Size = UDim2.fromScale(0.2814206, 0.1329836) })
				I[23] = new("TextLabel", I[22], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5740196, 0.5), Size = UDim2.fromScale(0.5980393, 0.7500001), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[24] = new("UIStroke", I[23], "UIStroke", { Color = Color3.fromRGB(30, 30, 30), Thickness = 3 })
					I[25] = new("UITextSizeConstraint", I[23], "UITextSizeConstraint", { MaxTextSize = 49 })
					I[26] = new("UIGradient", I[23], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(65, 255, 0)) }), Rotation = 90 })
				I[27] = new("UIScale", I[22], "UIScale")
				I[28] = new("ImageLabel", I[22], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14263657723"), Position = UDim2.fromScale(0.2, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.375, 1.5) })
				I[29] = new("UICorner", I[22], "UICorner")
				I[30] = new("UIStroke", I[22], "UIStroke", { Thickness = 2.5 })
			I[31] = new("Frame", I[2], "AfterStrength", { BackgroundColor3 = Color3.fromRGB(8, 26, 100), Position = UDim2.fromScale(0.633834, 0.1546887), Size = UDim2.fromScale(0.2814206, 0.1329836) })
				I[32] = new("TextLabel", I[31], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5740196, 0.5), Size = UDim2.fromScale(0.5980393, 0.7500001), Text = "0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[33] = new("UIStroke", I[32], "UIStroke", { Color = Color3.fromRGB(30, 30, 30), Thickness = 3 })
					I[34] = new("UITextSizeConstraint", I[32], "UITextSizeConstraint", { MaxTextSize = 49 })
					I[35] = new("UIGradient", I[32], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(65, 255, 0)) }), Rotation = 90 })
				I[36] = new("UIScale", I[31], "UIScale")
				I[37] = new("ImageLabel", I[31], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14263657723"), Position = UDim2.fromScale(0.2, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.375, 1.5) })
				I[38] = new("UICorner", I[31], "UICorner")
				I[39] = new("UIStroke", I[31], "UIStroke", { Thickness = 2.5 })
			I[40] = new("ImageButton", I[2], "Skip_Rebirth", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13651868063"), Position = UDim2.fromScale(0.1880156, 1.115), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.2545124, 0.1325607), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "ProductButton" })
				I[41] = new("TextLabel", I[40], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromScale(0.9, 0.6), Text = "SKIP - 149", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[42] = new("UIStroke", I[41], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
				I[43] = new("UIGradient", I[40], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.3367876, Color3.fromRGB(255, 213, 0)), ColorSequenceKeypoint.new(0.5354059, Color3.fromRGB(136, 255, 0)), ColorSequenceKeypoint.new(0.6873921, Color3.fromRGB(0, 255, 200)), ColorSequenceKeypoint.new(0.8428324, Color3.fromRGB(0, 89, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(191, 0, 255)) }), Rotation = 30 })
			I[44] = new("ImageLabel", I[2], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13704206150"), Position = UDim2.fromScale(0.5534709, 0.433851), Size = UDim2.fromScale(0.1371691, 0.23126) })
			I[45] = new("Frame", I[2], "BeforeGems", { BackgroundColor3 = Color3.fromRGB(8, 26, 100), Position = UDim2.fromScale(0.083834, 0.3678107), Size = UDim2.fromScale(0.2814206, 0.1329836) })
				I[46] = new("TextLabel", I[45], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5740196, 0.5), Size = UDim2.fromScale(0.5980393, 0.7500001), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[47] = new("UITextSizeConstraint", I[46], "UITextSizeConstraint", { MaxTextSize = 49 })
					I[48] = new("UIStroke", I[46], "UIStroke", { Color = Color3.fromRGB(30, 30, 30), Thickness = 3 })
					I[49] = new("UIGradient", I[46], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 230, 250)), ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 53, 255)) }), Rotation = 90 })
				I[50] = new("UIScale", I[45], "UIScale")
				I[51] = new("ImageLabel", I[45], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13784127821"), Position = UDim2.fromScale(0.1720921, 0.4992377), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3418195, 1.2113152) })
				I[52] = new("UICorner", I[45], "UICorner")
				I[53] = new("UIStroke", I[45], "UIStroke", { Thickness = 2.5 })
			I[54] = new("Frame", I[2], "AfterGems", { BackgroundColor3 = Color3.fromRGB(8, 26, 100), Position = UDim2.fromScale(0.633834, 0.3677499), Size = UDim2.fromScale(0.2814206, 0.1329836) })
				I[55] = new("TextLabel", I[54], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5740196, 0.5), Size = UDim2.fromScale(0.5980393, 0.7500001), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[56] = new("UITextSizeConstraint", I[55], "UITextSizeConstraint", { MaxTextSize = 49 })
					I[57] = new("UIStroke", I[55], "UIStroke", { Color = Color3.fromRGB(30, 30, 30), Thickness = 3 })
					I[58] = new("UIGradient", I[55], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 230, 250)), ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 53, 255)) }), Rotation = 90 })
				I[59] = new("UIScale", I[54], "UIScale")
				I[60] = new("ImageLabel", I[54], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13784127821"), Position = UDim2.fromScale(0.1720921, 0.4992377), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3418195, 1.2113152) })
				I[61] = new("UICorner", I[54], "UICorner")
				I[62] = new("UIStroke", I[54], "UIStroke", { Thickness = 2.5 })
			I[63] = new("Frame", I[2], "BeforeBoost", { BackgroundColor3 = Color3.fromRGB(8, 26, 100), Position = UDim2.fromScale(0.083834, 0.5846438), Size = UDim2.fromScale(0.2814206, 0.1329836) })
				I[64] = new("TextLabel", I[63], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5740196, 0.5), Size = UDim2.fromScale(0.5980393, 0.7500001), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[65] = new("UITextSizeConstraint", I[64], "UITextSizeConstraint", { MaxTextSize = 49 })
					I[66] = new("UIStroke", I[64], "UIStroke", { Color = Color3.fromRGB(30, 30, 30), Thickness = 3 })
					I[67] = new("UIGradient", I[64], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 230, 250)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 72)) }), Rotation = 90 })
				I[68] = new("UIScale", I[63], "UIScale")
				I[69] = new("ImageLabel", I[63], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12515871969"), Position = UDim2.fromScale(0.1720921, 0.4992377), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3418195, 1.2113152) })
				I[70] = new("UICorner", I[63], "UICorner")
				I[71] = new("UIStroke", I[63], "UIStroke", { Thickness = 2.5 })
			I[72] = new("ImageLabel", I[2], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13704206150"), Position = UDim2.fromScale(0.5534709, 0.650684), Size = UDim2.fromScale(0.1371691, 0.2312599) })
			I[73] = new("Frame", I[2], "AfterBoost", { BackgroundColor3 = Color3.fromRGB(8, 26, 100), Position = UDim2.fromScale(0.633834, 0.584583), Size = UDim2.fromScale(0.2814206, 0.1329836) })
				I[74] = new("UIStroke", I[73], "UIStroke", { Thickness = 2.5 })
				I[75] = new("TextLabel", I[73], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5740196, 0.5), Size = UDim2.fromScale(0.5980393, 0.7500001), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[76] = new("UITextSizeConstraint", I[75], "UITextSizeConstraint", { MaxTextSize = 49 })
					I[77] = new("UIStroke", I[75], "UIStroke", { Color = Color3.fromRGB(30, 30, 30), Thickness = 3 })
					I[78] = new("UIGradient", I[75], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 230, 250)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 72)) }), Rotation = 90 })
				I[79] = new("UIScale", I[73], "UIScale")
				I[80] = new("ImageLabel", I[73], "ImageLabel", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://12515871969"), Position = UDim2.fromScale(0.1720921, 0.4992377), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3418195, 1.2113152) })
				I[81] = new("UICorner", I[73], "UICorner")
			I[82] = new("Frame", I[2], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), Position = UDim2.fromScale(0.5, 1.1078119), Size = UDim2.fromScale(1, 0.216), ZIndex = 0 })
				I[83] = new("UIStroke", I[82], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
				I[84] = new("UIGradient", I[82], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 248, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 144, 0)) }), Rotation = 90 })
			I[85] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 5 })
			I[86] = new("ImageButton", I[2], "x2_Rebirths", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13651868063"), Position = UDim2.fromScale(0.8093362, 1.115), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.2545125, 0.1325607), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton", "GamepassButton" })
				I[87] = new("TextLabel", I[86], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromScale(0.9, 0.6), Text = "x2 Rebirths", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[88] = new("UIStroke", I[87], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
				I[89] = new("UIGradient", I[86], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.3367876, Color3.fromRGB(255, 213, 0)), ColorSequenceKeypoint.new(0.5354059, Color3.fromRGB(136, 255, 0)), ColorSequenceKeypoint.new(0.6873921, Color3.fromRGB(0, 255, 200)), ColorSequenceKeypoint.new(0.8428324, Color3.fromRGB(0, 89, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(191, 0, 255)) }), Rotation = 30 })
	return I[1]
end

return build
