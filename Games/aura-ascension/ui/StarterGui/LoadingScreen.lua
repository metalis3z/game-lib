-- Generated from ui/StarterGui/LoadingScreen.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "LoadingScreen", { DisplayOrder = 9999999, Enabled = false, ResetOnSpawn = false, SafeAreaCompatibility = Enum.SafeAreaCompatibility.None, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("CanvasGroup", I[1], "CanvasGroup", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "Colour", { BackgroundColor3 = Color3.fromRGB(18, 18, 18), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) })
				I[4] = new("ImageLabel", I[3], "Picture", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://126988749084454"), ImageTransparency = 0.9, ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1) })
			I[5] = new("Frame", I[2], "Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 999999997 })
				I[6] = new("ImageLabel", I[5], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://122879649945856"), Position = UDim2.fromScale(0.5, 0.4177636), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1594414, 0.407284) })
					I[7] = new("UIAspectRatioConstraint", I[6], "UIAspectRatioConstraint")
					I[8] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(0.05, 0), BottomRightRadius = UDim.new(0.05, 0), TopLeftRadius = UDim.new(0.05, 0), TopRightRadius = UDim.new(0.05, 0) })
					I[9] = new("UIStroke", I[6], "UIStroke", { Color = Color3.fromRGB(0, 170, 255), Thickness = 4.3000002 })
				I[10] = new("Frame", I[5], "Dots", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.7258332), Size = UDim2.fromScale(0.08, 0.5295048) })
					I[11] = new("Frame", I[10], "1", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromScale(1, 1) })
						I[12] = new("UIAspectRatioConstraint", I[11], "UIAspectRatioConstraint")
						I[13] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[14] = new("UIScale", I[11], "UIScale", { Scale = 0.7 })
					I[15] = new("Frame", I[10], "2", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
						I[16] = new("UIAspectRatioConstraint", I[15], "UIAspectRatioConstraint")
						I[17] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[18] = new("UIScale", I[15], "UIScale", { Scale = 0.7 })
					I[19] = new("Frame", I[10], "3", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
						I[20] = new("UIAspectRatioConstraint", I[19], "UIAspectRatioConstraint")
						I[21] = new("UICorner", I[19], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[22] = new("UIScale", I[19], "UIScale", { Scale = 0.7 })
					I[23] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint", { AspectRatio = 2.8 })
					I[24] = new("UIListLayout", I[10], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder })
					I[25] = new("Frame", I[10], "4", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
						I[26] = new("UIAspectRatioConstraint", I[25], "UIAspectRatioConstraint")
						I[27] = new("UICorner", I[25], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[28] = new("UIScale", I[25], "UIScale", { Scale = 0.7 })
					I[29] = new("Frame", I[10], "5", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(1, 1) })
						I[30] = new("UIAspectRatioConstraint", I[29], "UIAspectRatioConstraint")
						I[31] = new("UICorner", I[29], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
						I[32] = new("UIScale", I[29], "UIScale", { Scale = 0.7 })
		I[33] = new("Frame", I[1], "Update", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.423776, 0.6505099), Visible = false })
			I[34] = new("Frame", I[33], "MainBG", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 0 })
				I[35] = new("Frame", I[34], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.4531869, 0.0723222), Size = UDim2.fromScale(0.8055556, 0.1174143) })
					I[36] = new("TextLabel", I[35], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4414653, 0.546743), RichText = true, Size = UDim2.fromScale(0.9461071, 0.7752809), Text = "❄️ UPDATE #3: MAP EXPANSION", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[37] = new("UIStroke", I[36], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.057971 })
						I[38] = new("TextLabel", I[36], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4990608, 0.4565218), RichText = true, Size = UDim2.fromScale(0.9981215, 1), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
							I[39] = new("UIStroke", I[38], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.057971 })
							I[40] = new("UIPadding", I[38], "UIPadding")
						I[41] = new("UIPadding", I[36], "UIPadding")
				I[42] = new("ImageLabel", I[34], "Holder", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://132995007621877"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 0 })
					I[43] = new("TextLabel", I[42], "TextLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LineHeight = 1.03, Position = UDim2.fromScale(0.0233823, 0.5137491), Size = UDim2.fromScale(0.9542041, 0.4560809), Text = "👑 NEW Zones\n🕺 NEW Animations\n✈️ Fly Mode\n🔥 NEW Auras\n🗺️ MASSIVE Map Expansion\n✨ NEW Titles\n🔨 QoL Updates + Bug Fixes", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
						I[44] = new("UIStroke", I[43], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.08 })
				I[45] = new("ImageLabel", I[34], "UpdatePhoto", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://130228003508476"), Position = UDim2.fromScale(0.5019588, 0.3461689), Size = UDim2.fromScale(0.5358264, 0.3330108), ZIndex = 0 })
					I[46] = new("UIStroke", I[45], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.015 })
					I[47] = new("UIAspectRatioConstraint", I[45], "UIAspectRatioConstraint", { AspectRatio = 1.8 })
			I[48] = new("ImageButton", I[33], "CloseButton", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://135666196760587"), Position = UDim2.fromScale(0.9394444, 0.0778364), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.1233333, 0.1556728) })
				I[49] = new("TextLabel", I[48], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000002, 0.5), RichText = true, Size = UDim2.fromScale(0.7, 0.7), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
					I[50] = new("UIStroke", I[49], "UIStroke", { StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize, Thickness = 0.0772201 })
					I[51] = new("UIPadding", I[49], "UIPadding", { PaddingBottom = UDim.new(0.003632, 0), PaddingTop = UDim.new(0.003632, 0) })
			I[52] = new("UIAspectRatioConstraint", I[33], "UIAspectRatioConstraint", { AspectRatio = 1.1873351 })
			I[53] = new("UIScale", I[33], "UIScale")
	return I[1]
end

return build
