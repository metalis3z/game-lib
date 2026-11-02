-- Generated from ui/ReplicatedStorage/Assets/UI/Season/Cell.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Cell", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(0.2, 1) })
		I[2] = new("ImageLabel", I[1], "Number", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(93, 89, 134), ImageContent = Content.fromUri("rbxassetid://14291113184"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.45, 0.45), SliceCenter = Rect.new(100, 100, 100, 100), SliceScale = 2, ZIndex = 7 })
			I[3] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(-0.05, 0) })
			I[4] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint")
			I[5] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.575), Size = UDim2.fromScale(1, 0.6), Text = "2", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 8 })
				I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3.0999999 })
				I[7] = new("UIScale", I[5], "UIScale")
		I[8] = new("Frame", I[1], "Free", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.8), Size = UDim2.fromScale(1, 0.4) })
			I[9] = new("ImageLabel", I[8], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13802942209"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
				I[10] = new("TextLabel", I[9], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4999999, 0.7931742), Size = UDim2.fromScale(0.95, 0.2), Text = "+1,000 Gems", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 })
					I[11] = new("UIStroke", I[10], "UIStroke", { Thickness = 3.0999999 })
					I[12] = new("UIScale", I[10], "UIScale")
				I[13] = new("ImageLabel", I[9], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13784127821"), Position = UDim2.fromScale(0.5, 0.4), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5863485, 0.5863487), ZIndex = 2 })
					I[14] = new("UIScale", I[13], "UIScale")
				I[15] = new("TextLabel", I[9], "Quantity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.875, 0.05), Size = UDim2.fromScale(0.2122805, 0.2273883), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 })
					I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 3.0999999 })
					I[17] = new("UIScale", I[15], "UIScale")
				I[18] = new("Frame", I[9], "Locked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.98, 0.925), ZIndex = 4 })
					I[19] = new("UICorner", I[18], "UICorner", { BottomLeftRadius = UDim.new(0.12, 0), BottomRightRadius = UDim.new(0.12, 0), TopLeftRadius = UDim.new(0.12, 0), TopRightRadius = UDim.new(0.12, 0) })
					I[20] = new("ImageLabel", I[18], "Lock", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13812164923"), Position = UDim2.fromScale(0.5, 0.45), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.75, 0.75), ZIndex = 4 })
						I[21] = new("UIAspectRatioConstraint", I[20], "UIAspectRatioConstraint")
						I[22] = new("UIScale", I[20], "UIScale", { Scale = 0.75 })
					I[23] = new("ImageLabel", I[18], "Checkmark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://14292339333"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9, 0.9), ZIndex = 4 })
						I[24] = new("UIAspectRatioConstraint", I[23], "UIAspectRatioConstraint")
						I[25] = new("UIScale", I[23], "UIScale", { Scale = 0.75 })
			I[26] = new("UIScale", I[8], "UIScale", { Scale = 0.8 })
			I[27] = new("ImageButton", I[8], "Skip_Tier", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(51, 226, 0), ImageContent = Content.fromUri("rbxassetid://13651868063"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.8, 0.3), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, Visible = false, ZIndex = 4 }, nil, { "PopButton", "ProductButton" })
				I[28] = new("TextLabel", I[27], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5744875), Size = UDim2.fromScale(0.9, 0.5489789), Text = "SKIP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
					I[29] = new("UIStroke", I[28], "UIStroke", { Thickness = 1.5 })
			I[30] = new("ImageButton", I[8], "Claim", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(51, 226, 0), ImageContent = Content.fromUri("rbxassetid://13651868063"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.8, 0.3), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, Visible = false, ZIndex = 4 }, nil, { "PopButton", "ProductButton" })
				I[31] = new("TextLabel", I[30], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5744875), Size = UDim2.fromScale(0.9, 0.5489789), Text = "CLAIM", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
					I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 1.5 })
		I[33] = new("Frame", I[1], "Premium", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.5, 0.2), Size = UDim2.fromScale(1, 0.4) })
			I[34] = new("UIScale", I[33], "UIScale", { Scale = 0.8 })
			I[35] = new("UIScale", I[33], "UIScale", { Scale = 0.8 })
			I[36] = new("ImageLabel", I[33], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13802942209"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1) })
				I[37] = new("TextLabel", I[36], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4999999, 0.7931742), Size = UDim2.fromScale(0.95, 0.2), Text = "+1,000 Gems", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 })
					I[38] = new("UIStroke", I[37], "UIStroke", { Thickness = 3.0999999 })
					I[39] = new("UIScale", I[37], "UIScale")
				I[40] = new("ImageLabel", I[36], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13784127821"), Position = UDim2.fromScale(0.5, 0.4), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.5863485, 0.5863487), ZIndex = 2 })
					I[41] = new("UIScale", I[40], "UIScale")
				I[42] = new("TextLabel", I[36], "Quantity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.875, 0.05), Size = UDim2.fromScale(0.2122805, 0.2273883), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 4 })
					I[43] = new("UIStroke", I[42], "UIStroke", { Thickness = 3.0999999 })
					I[44] = new("UIScale", I[42], "UIScale")
				I[45] = new("Frame", I[36], "Locked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.98, 0.925), ZIndex = 4 })
					I[46] = new("UICorner", I[45], "UICorner", { BottomLeftRadius = UDim.new(0.12, 0), BottomRightRadius = UDim.new(0.12, 0), TopLeftRadius = UDim.new(0.12, 0), TopRightRadius = UDim.new(0.12, 0) })
					I[47] = new("ImageLabel", I[45], "Lock", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13812164923"), Position = UDim2.fromScale(0.5, 0.45), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.75, 0.75), ZIndex = 4 })
						I[48] = new("UIAspectRatioConstraint", I[47], "UIAspectRatioConstraint")
						I[49] = new("UIScale", I[47], "UIScale", { Scale = 0.75 })
					I[50] = new("ImageLabel", I[45], "Checkmark", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(0, 255, 0), ImageContent = Content.fromUri("rbxassetid://14292339333"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.9, 0.9), ZIndex = 4 })
						I[51] = new("UIAspectRatioConstraint", I[50], "UIAspectRatioConstraint")
						I[52] = new("UIScale", I[50], "UIScale", { Scale = 0.75 })
			I[53] = new("ImageButton", I[33], "Skip_Tier", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(51, 226, 0), ImageContent = Content.fromUri("rbxassetid://13651868063"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.8, 0.3), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, Visible = false, ZIndex = 4 }, nil, { "PopButton", "ProductButton" })
				I[54] = new("TextLabel", I[53], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5744875), Size = UDim2.fromScale(0.9, 0.5489789), Text = "SKIP", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
					I[55] = new("UIStroke", I[54], "UIStroke", { Thickness = 1.5 })
			I[56] = new("ImageButton", I[33], "Claim", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(51, 226, 0), ImageContent = Content.fromUri("rbxassetid://13651868063"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.8, 0.3), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, Visible = false, ZIndex = 4 }, nil, { "PopButton", "ProductButton" })
				I[57] = new("TextLabel", I[56], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxassetid://12187370000", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5744875), Size = UDim2.fromScale(0.9, 0.5489789), Text = "CLAIM", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
					I[58] = new("UIStroke", I[57], "UIStroke", { Thickness = 1.5 })
	return I[1]
end

return build
