-- Generated from ui/ReplicatedStorage/ReplicatedGui/StockMachine.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "StockMachine", { ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, nil, { "ScreenGui" })
		I[2] = new("Frame", I[1], "StockMachine", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(186, 178, 133), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.4792193, 0.6351967), Visible = false })
			I[3] = new("Frame", I[2], "Header", { BackgroundColor3 = Color3.fromRGB(224, 187, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(-0.0000001, 0), Size = UDim2.fromScale(1.0000002, 0.1544531) })
				I[4] = new("ImageButton", I[3], "Close", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, HoverImageContent = Content.fromUri("rbxassetid://137110183435251"), ImageContent = Content.fromUri("rbxassetid://105016554772347"), Position = UDim2.fromScale(0.9440019, 0.4566889), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0877465, 0.7905689) })
					I[5] = new("TextLabel", I[4], "X", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4918542, 0.4999999), Size = UDim2.fromScale(0.9171997, 0.56), Text = "X", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
						I[6] = new("UIStroke", I[5], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
						I[7] = new("UIPadding", I[5], "UIPadding", { PaddingLeft = UDim.new(0.01, 0), PaddingRight = UDim.new(-0.03, 0) })
				I[8] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.3639, 0.4916192), Size = UDim2.fromScale(0.6813304, 0.7207083), Text = "Limited Quantity Truck", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
					I[9] = new("UIStroke", I[8], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
			I[10] = new("Frame", I[2], "Content", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0032605, 0.1542887), Size = UDim2.fromScale(0.9966298, 0.845574) })
				I[11] = new("UIListLayout", I[10], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[12] = new("Frame", I[10], "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(39, 37, 28), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.2365217), Size = UDim2.fromScale(0.9153563, 0.4641415), Visible = false })
					I[13] = new("UIListLayout", I[12], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.04, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
					I[14] = new("Frame", I[12], "Output", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 5, Position = UDim2.fromScale(0.6133611, 0.5042961), Size = UDim2.fromScale(0.2035514, 0.9174385) })
						I[15] = new("ImageButton", I[14], "Spawn", { BackgroundColor3 = Color3.fromRGB(81, 158, 86), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, Position = UDim2.fromScale(0, 1.185758), Size = UDim2.fromScale(1, 0.2739441) })
							I[16] = new("UIStroke", I[15], "UIStroke", { Thickness = 2 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
							I[17] = new("TextLabel", I[15], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0.9), Text = "Spawn", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
								I[18] = new("UIStroke", I[17], "UIStroke", { Thickness = 2.5 }, { ["OriginalThickness"] = 2.5 }, { "ScreenStroke", "UIStroke" })
						I[19] = new("TextLabel", I[14], "Quantity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 1.085), Size = UDim2.fromScale(1.1582394, 0.1501555), Text = "5,000,000 Left", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 2 })
							I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 2 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
						I[21] = new("UIStroke", I[14], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Thickness = 2 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
						I[22] = new("TextLabel", I[14], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5100803, 0.1743485), Size = UDim2.fromScale(0.8798403, 0.2894168), Text = "Brainrot Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
							I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
						I[24] = new("ViewportFrame", I[14], "ViewportFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[25] = new("Frame", I[12], "Input", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.2841389, 0.1369203), Size = UDim2.fromScale(0.1867222, 0.8630795), Visible = false })
						I[26] = new("UIStroke", I[25], "UIStroke", { BorderStrokePosition = Enum.BorderStrokePosition.Inner, Thickness = 2 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
						I[27] = new("TextLabel", I[25], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.509531, 0.1743485), Size = UDim2.fromScale(0.8787413, 0.2894168), Text = "Brainrot Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
							I[28] = new("UIStroke", I[27], "UIStroke", { Thickness = 3 }, { ["OriginalThickness"] = 3 }, { "ScreenStroke", "UIStroke" })
						I[29] = new("ImageButton", I[25], "Return", { BackgroundColor3 = Color3.fromRGB(240, 198, 48), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageTransparency = 1, Position = UDim2.fromScale(0.0083674, 1.0851285), Size = UDim2.fromScale(0.9916336, 0.2728657) })
							I[30] = new("UIStroke", I[29], "UIStroke", { Thickness = 2 }, { ["OriginalThickness"] = 2 }, { "ScreenStroke", "UIStroke" })
							I[31] = new("TextLabel", I[29], "Txt", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "Return", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
								I[32] = new("UIStroke", I[31], "UIStroke", { Thickness = 2.5 }, { ["OriginalThickness"] = 2.5 }, { "ScreenStroke", "UIStroke" })
						I[33] = new("ViewportFrame", I[25], "ViewportFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[34] = new("UIPadding", I[12], "UIPadding", { PaddingBottom = UDim.new(0.32, 0) })
			I[35] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.3437191 })
	return I[1]
end

return build
