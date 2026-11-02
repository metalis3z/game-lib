-- Generated from ui/ReplicatedStorage/Data.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "Data", { Active = true, MaxDistance = 100, ResetOnSpawn = false, Size = UDim2.fromScale(15, 5) })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
		I[3] = new("Frame", I[1], "Mutations", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(1.2, 0.2), Visible = false })
			I[4] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[5] = new("TextLabel", I[1], "DisplayName", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.15), Text = "Bandito Bobritto", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true })
			I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 4, Transparency = 0.35 })
		I[7] = new("TextLabel", I[1], "PerSecond", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.15), Text = "$35/s", TextColor3 = Color3.fromRGB(255, 247, 0), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true })
			I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 4, Transparency = 0.35 })
		I[9] = new("TextLabel", I[1], "Price", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 4, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.15), Text = "$4.5K", TextColor3 = Color3.fromRGB(115, 255, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false }, { ["DefaultState"] = true })
			I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 4, Transparency = 0.35 })
		I[11] = new("TextLabel", I[1], "Rarity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.9367089), Size = UDim2.fromScale(1, 0.15), Text = "Rare", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true }, { ["DefaultState"] = true })
			I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 4, Transparency = 0.35 })
		I[13] = new("Frame", I[1], "CharTime", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -10, Size = UDim2.fromScale(1, 0.15), Visible = false })
			I[14] = new("UIListLayout", I[13], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[15] = new("ImageLabel", I[13], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://106073375809912"), Size = UDim2.fromScale(0.8, 0.8) })
				I[16] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint")
			I[17] = new("TextLabel", I[13], "CharTime", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LineHeight = 1.2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.1, 1), Text = "56s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
				I[18] = new("TextLabel", I[17], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, LineHeight = 1.2, Position = UDim2.fromScale(0.5, 0.55), Size = UDim2.fromScale(1, 1), Text = "$0", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 0 })
					I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 2 }, { ["ThicknessUDim"] = UDim.new(0, 1) })
				I[20] = new("UIGradient", I[17], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 102, 194)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 124, 133)) }), Rotation = 90 })
				I[21] = new("UIStroke", I[17], "UIStroke", { Thickness = 4, Transparency = 0.35 })
		I[22] = new("Frame", I[1], "Health", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), LayoutOrder = -90, Position = UDim2.fromScale(0.5, 0.65), Size = UDim2.new(0.4, 0, 0.075, 2), ZIndex = 2 }, { ["Hitted_Size"] = UDim2.fromScale(1.5, 1.5), ["Originale_Size"] = UDim2.fromScale(1, 1) })
			I[23] = new("Frame", I[22], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.65, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = -999999999 })
				I[24] = new("UICorner", I[23], "UICorner", { BottomLeftRadius = UDim.new(1000, 0), BottomRightRadius = UDim.new(1000, 0), TopLeftRadius = UDim.new(1000, 0), TopRightRadius = UDim.new(1000, 0) })
				I[25] = new("UIStroke", I[23], "UIStroke", { Enabled = false, Thickness = 3 }, { ["ThicknessUDim"] = UDim.new(0.1440821, 0) })
			I[26] = new("UICorner", I[22], "UICorner", { BottomLeftRadius = UDim.new(1000, 0), BottomRightRadius = UDim.new(1000, 0), TopLeftRadius = UDim.new(1000, 0), TopRightRadius = UDim.new(1000, 0) })
			I[27] = new("Frame", I[22], "Bar", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.4, 1.3), ZIndex = -888888888 }, { ["Updated"] = true })
				I[28] = new("UIGradient", I[27], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(13, 254, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 254, 8)) }), Rotation = 90 })
				I[29] = new("UIStroke", I[27], "UIStroke", { Thickness = 1.7 })
				I[30] = new("UICorner", I[27], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[31] = new("Frame", I[22], "Payload", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.02, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(0.7, 1), Visible = false, ZIndex = -999999999 })
				I[32] = new("UICorner", I[31], "UICorner", { BottomLeftRadius = UDim.new(1000, 0), BottomRightRadius = UDim.new(1000, 0), TopLeftRadius = UDim.new(1000, 0), TopRightRadius = UDim.new(1000, 0) })
			I[33] = new("Frame", I[22], "White", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 999999999 }, { ["Target_Transparency"] = 0 })
				I[34] = new("UICorner", I[33], "UICorner", { BottomLeftRadius = UDim.new(1000, 0), BottomRightRadius = UDim.new(1000, 0), TopLeftRadius = UDim.new(1000, 0), TopRightRadius = UDim.new(1000, 0) })
			I[35] = new("TextLabel", I[22], "Description", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11702779409", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 0.9, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 3), Text = "999k", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 60, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextStrokeTransparency = 0, TextWrapped = true, Visible = false, ZIndex = 5 })
				I[36] = new("UIScale", I[35], "UIScale")
				I[37] = new("UITextSizeConstraint", I[35], "UITextSizeConstraint", { MinTextSize = 40 })
				I[38] = new("UIStroke", I[35], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 3 })
			I[39] = new("UIScale", I[22], "Scaler", { Scale = 0.0000001 })
		I[40] = new("TextLabel", I[1], "EarnedOffline", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = -80, RichText = true, Size = UDim2.fromScale(1, 0.15), Text = "(Offline Cash: $700)", TextColor3 = Color3.fromRGB(156, 156, 156), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[41] = new("UIGradient", I[40], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(171, 171, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 90 })
			I[42] = new("UIStroke", I[40], "UIStroke", { Thickness = 3, Transparency = 0.36 })
		I[43] = new("TextLabel", I[1], "Money", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = -80, RichText = true, Size = UDim2.fromScale(1, 0.2), Text = "<font color=\"#73ff00\">$1.6K</font>", TextColor3 = Color3.fromRGB(202, 255, 201), TextScaled = true, TextSize = 14, TextWrapped = true })
			I[44] = new("UIGradient", I[43], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(171, 171, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 90 })
			I[45] = new("UIStroke", I[43], "UIStroke", { Thickness = 3, Transparency = 0.38 })
	return I[1]
end

return build
