-- Generated from ui/ReplicatedStorage/Assets/Extra/Data_old.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Data_old", { Active = true, MaxDistance = 100, ResetOnSpawn = false, Size = UDim2.fromScale(15, 6) })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
		I[3] = new("TextLabel", I[1], "DisplayName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1.0474006, 0.129771), Text = "Bandito Bobritto", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true })
			I[4] = new("UIStroke", I[3], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14, Transparency = 0.35 })
		I[5] = new("TextLabel", I[1], "PerSecond", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1.0474006, 0.129771), Text = "$35/s", TextColor3 = Color3.fromRGB(255, 247, 0), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true })
			I[6] = new("UIStroke", I[5], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14, Transparency = 0.35 })
		I[7] = new("TextLabel", I[1], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1.0474006, 0.129771), Text = "$4.5K", TextColor3 = Color3.fromRGB(115, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["DefaultState"] = true })
			I[8] = new("UIStroke", I[7], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14, Transparency = 0.35 })
		I[9] = new("TextLabel", I[1], "Rarity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1.0474006, 0.129771), Text = "Rare", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true })
			I[10] = new("UIStroke", I[9], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14, Transparency = 0.35 })
		I[11] = new("Frame", I[1], "OwnedBy", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -900, Size = UDim2.fromScale(1.0474006, 0.129771), Visible = false })
			I[12] = new("UIListLayout", I[11], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[13] = new("ImageLabel", I[11], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://90779819839379"), Size = UDim2.fromScale(0.9, 0.9) })
				I[14] = new("UIAspectRatioConstraint", I[13], "UIAspectRatioConstraint")
			I[15] = new("TextLabel", I[11], "Text", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LineHeight = 1.2, Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(0.4, 1), Text = "Owned by: Player", TextColor3 = Color3.fromRGB(59, 160, 215), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 1.5, Transparency = 0.35 })
		I[17] = new("Frame", I[1], "Health", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = -90, Position = UDim2.fromScale(0.5, 0.65), Size = UDim2.new(0.4, 0, 0.075, 2), Visible = false, ZIndex = 2 }, { ["Hitted_Size"] = UDim2.fromScale(1.5, 1.5), ["Originale_Size"] = UDim2.fromScale(1, 1) })
			I[18] = new("Frame", I[17], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -999999999 })
				I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(1000, 0), BottomRightRadius = UDim.new(1000, 0), TopLeftRadius = UDim.new(1000, 0), TopRightRadius = UDim.new(1000, 0) })
				I[20] = new("UIStroke", I[18], "UIStroke", { Enabled = false, Thickness = 3 }, { ["ThicknessUDim"] = UDim.new(0.1440821, 0) })
			I[21] = new("UICorner", I[17], "UICorner", { BottomLeftRadius = UDim.new(1000, 0), BottomRightRadius = UDim.new(1000, 0), TopLeftRadius = UDim.new(1000, 0), TopRightRadius = UDim.new(1000, 0) })
			I[22] = new("Frame", I[17], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.4, 1.3), ZIndex = -888888888 }, { ["Updated"] = true })
				I[23] = new("UIGradient", I[22], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(13, 254, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 254, 8)) }), Rotation = 90 })
				I[24] = new("UIStroke", I[22], "UIStroke", { Thickness = 1.1 })
				I[25] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[26] = new("Frame", I[17], "Payload", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.02, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.7, 1), Visible = false, ZIndex = -999999999 })
				I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(1000, 0), BottomRightRadius = UDim.new(1000, 0), TopLeftRadius = UDim.new(1000, 0), TopRightRadius = UDim.new(1000, 0) })
			I[28] = new("Frame", I[17], "White", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 999999999 }, { ["Target_Transparency"] = 0 })
				I[29] = new("UICorner", I[28], "UICorner", { BottomLeftRadius = UDim.new(1000, 0), BottomRightRadius = UDim.new(1000, 0), TopLeftRadius = UDim.new(1000, 0), TopRightRadius = UDim.new(1000, 0) })
			I[30] = new("TextLabel", I[17], "Description", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11702779409", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.9, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 3), Text = "999k", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 60, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextStrokeTransparency = 0, TextWrapped = true, Visible = false, ZIndex = 5 })
				I[31] = new("UIScale", I[30], "UIScale")
				I[32] = new("UITextSizeConstraint", I[30], "UITextSizeConstraint", { MinTextSize = 40 })
				I[33] = new("UIStroke", I[30], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[34] = new("UIScale", I[17], "Scaler", { Scale = 0.0000001 })
		I[35] = new("TextLabel", I[1], "Money", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = -79, RichText = true, Size = UDim2.fromScale(1.0474006, 0.1717557), Text = "<font color=\"#73ff00\">$1.6K</font>", TextColor3 = Color3.fromRGB(202, 255, 201), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
			I[36] = new("UIGradient", I[35], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(171, 171, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 90 })
			I[37] = new("UIStroke", I[35], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14, Transparency = 0.38 })
		I[38] = new("TextLabel", I[1], "EarnedOffline", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = -80, RichText = true, Size = UDim2.fromScale(1.0474006, 0.129771), Text = "(Offline Cash: $700)", TextColor3 = Color3.fromRGB(156, 156, 156), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
			I[39] = new("UIGradient", I[38], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(171, 171, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 90 })
			I[40] = new("UIStroke", I[38], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14, Transparency = 0.36 })
		I[41] = new("TextLabel", I[1], "Seen", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = -89, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1.0474006, 0.129771), Text = "Cannot catch!", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["DefaultState"] = true })
			I[42] = new("UIStroke", I[41], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14, Transparency = 0.35 })
		I[43] = new("TextLabel", I[1], "BaseMutation", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = -5, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1.0474006, 0.129771), Text = "Golden", TextColor3 = Color3.fromRGB(255, 200, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["DefaultState"] = true })
			I[44] = new("UIStroke", I[43], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14, Transparency = 0.35 })
		I[45] = new("Frame", I[1], "Mutations", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -91, Size = UDim2.fromScale(1.2568808, 0.1717557) })
			I[46] = new("UIListLayout", I[45], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[47] = new("ImageLabel", I[45], "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
		I[48] = new("Frame", I[1], "CharTime", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -10, Size = UDim2.fromScale(1.0474006, 0.129771), Visible = false })
			I[49] = new("UIListLayout", I[48], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[50] = new("ImageLabel", I[48], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106073375809912"), Size = UDim2.fromScale(0.8, 0.8) })
				I[51] = new("UIAspectRatioConstraint", I[50], "UIAspectRatioConstraint")
			I[52] = new("TextLabel", I[48], "CharTime", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LineHeight = 1.2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.1, 1), Text = "56s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[53] = new("TextLabel", I[52], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.2, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "$0", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 0 })
					I[54] = new("UIStroke", I[53], "UIStroke", { Thickness = 2.5 }, { ["ThicknessUDim"] = UDim.new(0, 1) })
				I[55] = new("UIGradient", I[52], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 102, 194)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 124, 133)) }), Rotation = 90 })
				I[56] = new("UIStroke", I[52], "UIStroke", { Thickness = 2.5, Transparency = 0.35 })
		I[57] = new("TextLabel", I[1], "LuckyBlockTimer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1.0474006, 0.129771), Text = "$35/s", TextColor3 = Color3.fromRGB(255, 247, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["DefaultState"] = true })
			I[58] = new("UIStroke", I[57], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14, Transparency = 0.35 })
		I[59] = new("TextLabel", I[1], "Stolen", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.15), Text = "STOLEN", TextColor3 = Color3.fromRGB(255, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["DefaultState"] = true })
			I[60] = new("UIStroke", I[59], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.14, Transparency = 0.35 })
	return I[1]
end

return build
