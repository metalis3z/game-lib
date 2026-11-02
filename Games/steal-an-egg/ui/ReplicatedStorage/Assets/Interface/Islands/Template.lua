-- Generated from ui/ReplicatedStorage/Assets/Interface/Islands/Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Template", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(66, 89, 102), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.4925912, 0.1784156), Size = UDim2.fromScale(0.9854817, 0.3564189) })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(66, 89, 102), BackgroundTransparency = 0.25, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
			I[3] = new("Frame", I[2], "Locked", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.3, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 2 })
				I[4] = new("Frame", I[3], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -2, Position = UDim2.fromScale(0.5, 0.2), Size = UDim2.fromScale(0.9, 0.3), ZIndex = 2 })
					I[5] = new("ImageLabel", I[4], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://111690388692805"), LayoutOrder = -1, Size = UDim2.fromScale(1, 1), ZIndex = 11 })
						I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint")
					I[7] = new("TextLabel", I[4], "Title", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.6717892, 1.0000001), Size = UDim2.fromScale(0.672516, 1.0000001), Text = "Desert Island", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 10 })
						I[8] = new("UIStroke", I[7], "UIStroke", { Thickness = 2 })
					I[9] = new("UIListLayout", I[4], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[10] = new("Frame", I[3], "SPACER", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -1, Size = UDim2.fromScale(1, 0.13) })
				I[11] = new("TextLabel", I[3], "Price", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5000001, 0.9700001), Size = UDim2.fromScale(0.8, 0.239), Text = "-", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 10 })
					I[12] = new("UIGradient", I[11], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(166, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 255, 0)) }), Rotation = 90 })
					I[13] = new("UIStroke", I[11], "UIStroke", { Thickness = 2 })
				I[14] = new("TextLabel", I[3], "Single", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 1), Size = UDim2.fromScale(1, 0.2), Text = "20/25 Brainrot Hatched!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false, ZIndex = 10 })
					I[15] = new("UIStroke", I[14], "UIStroke", { Thickness = 2 })
				I[16] = new("TextLabel", I[3], "Title", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5000001, 0.5946097), Size = UDim2.fromScale(1.0000005, 0.150672), Text = "Level 10 Required", TextColor3 = Color3.fromRGB(185, 185, 185), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 10 })
					I[17] = new("UIStroke", I[16], "UIStroke", { Thickness = 2 })
				I[18] = new("UIListLayout", I[3], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[19] = new("ImageLabel", I[2], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://134761102401088"), Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1) })
			I[20] = new("TextLabel", I[2], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.4999999, 0), Size = UDim2.fromScale(1.0000005, 0.2413108), Text = "Desert Island", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, Visible = false })
				I[21] = new("UIStroke", I[20], "UIStroke", { Thickness = 2 })
			I[22] = new("TextLabel", I[2], "Unlocked", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.7741956, 0.9800003), Size = UDim2.fromScale(0.3966089, 0.1795031), Text = "13/13 Unlocked", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
				I[23] = new("UIStroke", I[22], "UIStroke", { Thickness = 2 })
			I[24] = new("TextLabel", I[2], "ToCollect", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.01, 0.9800004), Size = UDim2.fromScale(0.5773114, 0.1860986), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
				I[25] = new("UIGradient", I[24], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(166, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 255, 0)) }), Rotation = 90 })
				I[26] = new("UIStroke", I[24], "UIStroke", { Thickness = 2 })
			I[27] = new("Frame", I[2], "BackFrame", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 1.0000001), Size = UDim2.fromScale(0.6349472, 0.22), Visible = false })
				I[28] = new("UIGradient", I[27], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.54375), NumberSequenceKeypoint.new(1, 1) }) })
			I[29] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
		I[30] = new("TextButton", I[1], "Button", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextSize = 14, ZIndex = 10 })
	return I[1]
end

return build
