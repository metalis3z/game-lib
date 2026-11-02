-- Generated from ui/StarterGui/PodiumBillboard.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "PodiumBillboard", { Active = true, MaxDistance = 70, Size = UDim2.fromScale(10, 7), ZIndexBehavior = Enum.ZIndexBehavior.Sibling }, { ["BillboardCenteringApplied"] = true }, { "DistanceScaledStrokes" })
		I[2] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[3] = new("TextLabel", I[1], "Income", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 5, Position = UDim2.fromScale(0.0878769, 0.8674056), RichText = true, Selectable = true, Size = UDim2.fromScale(0.95, 0.25), Text = "$20/s", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 32, TextWrapped = true, ZIndex = 2 })
			I[4] = new("TextLabel", I[3], "Inner", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.45), RichText = true, Selectable = true, Size = UDim2.fromScale(1, 1), Text = "$20/s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextWrapped = true, ZIndex = 2 })
				I[5] = new("UIGradient", I[4], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(212, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(21, 255, 0)) }), Rotation = 90 })
				I[6] = new("UIStroke", I[4], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[7] = new("UIStroke", I[3], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
		I[8] = new("TextLabel", I[1], "Rarity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.1206958, 0.9324831), RichText = true, Selectable = true, Size = UDim2.fromScale(0.6, 0.13), Text = "Common", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 32, TextWrapped = true, ZIndex = 2 })
			I[9] = new("TextLabel", I[8], "Rarity", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.45), RichText = true, Selectable = true, Size = UDim2.fromScale(1, 1), Text = "Common", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextWrapped = true, ZIndex = 2 })
				I[10] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(221, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 162, 0)) }), Rotation = 90 })
				I[11] = new("UIStroke", I[9], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[12] = new("UIStroke", I[8], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
		I[13] = new("Frame", I[1], "TimerFrame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 6, Position = UDim2.fromScale(0.475, 0.115), Size = UDim2.fromScale(0.95, 0.23) })
			I[14] = new("TextLabel", I[13], "Timer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.0878769, 0.8674056), RichText = true, Selectable = true, Size = UDim2.fromScale(0.25, 1), Text = "20s", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 32, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
				I[15] = new("UIAspectRatioConstraint", I[14], "UIAspectRatioConstraint", { AspectRatio = 1.9791665 })
				I[16] = new("TextLabel", I[14], "Inner", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.45), RichText = true, Selectable = true, Size = UDim2.fromScale(1, 1), Text = "20s", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2 })
					I[17] = new("UIGradient", I[16], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 148, 150)), ColorSequenceKeypoint.new(1, Color3.fromRGB(231, 53, 85)) }), Rotation = 90 })
					I[18] = new("UIAspectRatioConstraint", I[16], "UIAspectRatioConstraint", { AspectRatio = 1.9791665 })
					I[19] = new("UIStroke", I[16], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
				I[20] = new("UIStroke", I[14], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[21] = new("UIListLayout", I[13], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[22] = new("ImageLabel", I[13], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://116160451346795"), Position = UDim2.fromScale(0.45, 0.45), Size = UDim2.fromScale(0.9, 0.9) })
				I[23] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint")
		I[24] = new("TextLabel", I[1], "Name", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.1206958, 0.9324831), RichText = true, Selectable = true, Size = UDim2.fromScale(1, 0.22), Text = "Golden", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 32, TextWrapped = true, ZIndex = 2 })
			I[25] = new("TextLabel", I[24], "Inner", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.45), RichText = true, Selectable = true, Size = UDim2.fromScale(1, 1), Text = "Golden", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextWrapped = true, ZIndex = 2 })
				I[26] = new("UIStroke", I[25], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[27] = new("UIStroke", I[24], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
		I[28] = new("UIAspectRatioConstraint", I[1], "UIAspectRatioConstraint", { AspectRatio = 1.429 })
		I[29] = new("TextLabel", I[1], "Type", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1206958, 0.9324831), RichText = true, Selectable = true, Size = UDim2.fromScale(0.6, 0.13), Text = "Common", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 32, TextWrapped = true, ZIndex = 2 })
			I[30] = new("TextLabel", I[29], "Type", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold, Enum.FontStyle.Normal), LayoutOrder = 3, Position = UDim2.fromScale(0.5, 0.45), RichText = true, Selectable = true, Size = UDim2.fromScale(1, 1), Text = "Common", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 32, TextWrapped = true, ZIndex = 2 })
				I[31] = new("UIGradient", I[30], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(221, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 162, 0)) }), Rotation = 90 })
				I[32] = new("UIStroke", I[30], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[33] = new("UIStroke", I[29], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
	return I[1]
end

return build
