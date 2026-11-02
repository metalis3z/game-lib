-- Generated from ui/StarterGui/NotificaçãodeTrade.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ScreenGui", nil, "NotificaçãodeTrade", { DisplayOrder = 777, ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("Frame", I[1], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.03), Size = UDim2.fromScale(0.7, 0.3), Visible = false })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.2, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[4] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 3.8522012 })
			I[5] = new("Frame", I[2], "request_template", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.1828229), Size = UDim2.fromScale(0.32, 0.32), Visible = false })
				I[6] = new("UIAspectRatioConstraint", I[5], "UIAspectRatioConstraint", { AspectRatio = 4 })
				I[7] = new("Frame", I[5], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
					I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
					I[9] = new("Frame", I[7], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.988, 0.965) })
						I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
						I[11] = new("UIGradient", I[9], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 153, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 84, 236)) }), Rotation = 62 })
						I[12] = new("Frame", I[9], "Container", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.988, 0.955) })
							I[13] = new("UIGradient", I[12], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 10, 16)), ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 16, 27)) }) })
							I[14] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
							I[15] = new("CanvasGroup", I[12], "Profile", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.1521843, 0.2126802), Size = UDim2.fromScale(0.3035115, 1.5636951) })
								I[16] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0.12, 0), BottomRightRadius = UDim.new(0.12, 0), TopLeftRadius = UDim.new(0.12, 0), TopRightRadius = UDim.new(0.12, 0) })
								I[17] = new("UIGradient", I[15], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.8951342, 0), NumberSequenceKeypoint.new(1, 1) }) })
								I[18] = new("ImageLabel", I[15], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxthumb://type=AvatarBust&id=4386104527&w=420&h=420"), Position = UDim2.fromScale(0.3028449, 0.6820986), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.3267481, 1.3267483), ZIndex = 0 })
							I[19] = new("TextLabel", I[12], "SubTitle", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11702779409", Enum.FontWeight.Bold, Enum.FontStyle.Italic), LineHeight = 0.7, Position = UDim2.fromScale(0.24, 0.4), Size = UDim2.fromScale(0.74, 0.45), Text = "@Lisboa_Dev has invited you to Trade", TextColor3 = Color3.fromRGB(0, 170, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10 })
								I[20] = new("UIStroke", I[19], "UIStroke", { Thickness = 0.7532308 }, { ["Original"] = 2, ["origThickness"] = 2 }, { "UIStroke" })
							I[21] = new("TextLabel", I[12], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxassetid://11702779409", Enum.FontWeight.Heavy, Enum.FontStyle.Italic), Position = UDim2.fromScale(0.24, 0), Size = UDim2.fromScale(0.74, 0.5), Text = "TRADE REQUEST", TextColor3 = Color3.fromRGB(0, 170, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10 })
								I[22] = new("UIGradient", I[21], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.1992528, 0.2875), NumberSequenceKeypoint.new(0.4022416, 0.48125), NumberSequenceKeypoint.new(0.7, 0.75), NumberSequenceKeypoint.new(0.7993039, 1), NumberSequenceKeypoint.new(1, 1) }) })
								I[23] = new("UIStroke", I[21], "UIStroke", { Thickness = 0.7532308 }, { ["Original"] = 2, ["origThickness"] = 2 }, { "UIStroke" })
									I[24] = new("UIGradient", I[23], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.1992528, 0.2875), NumberSequenceKeypoint.new(0.4022416, 0.48125), NumberSequenceKeypoint.new(0.7, 0.75), NumberSequenceKeypoint.new(0.7993039, 1), NumberSequenceKeypoint.new(1, 1) }) })
							I[25] = new("Frame", I[12], "Bar", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.new(0.9, 12, 0.95, 0), Size = UDim2.fromScale(0.99, 0.1) })
								I[26] = new("Frame", I[25], "Slider", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(124, 207, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.0103739, 0.4999989), Size = UDim2.fromScale(0.0207477, 1.0000001) })
									I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(7, 0), BottomRightRadius = UDim.new(7, 0), TopLeftRadius = UDim.new(7, 0), TopRightRadius = UDim.new(7, 0) })
									I[28] = new("UIStroke", I[26], "UIStroke", { Thickness = 2 })
				I[29] = new("Frame", I[5], "Buttons", { AnchorPoint = Vector2.new(0.5, 1), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 1.4215339), Size = UDim2.fromScale(1.0000001, 0.384675) })
					I[30] = new("UIListLayout", I[29], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.02, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
					I[31] = new("Frame", I[29], "Refuse", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(1, 0.2), Size = UDim2.fromScale(1, 1) })
						I[32] = new("ImageButton", I[31], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://88052976879878"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
							I[33] = new("TextLabel", I[32], "Value", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(0.87, 0.57), Text = "Refuse", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
								I[34] = new("UIStroke", I[33], "UIStroke", { Thickness = 1.5 })
						I[35] = new("UIAspectRatioConstraint", I[31], "UIAspectRatioConstraint", { AspectRatio = 3.5857143 })
					I[36] = new("Frame", I[29], "Accept", { AnchorPoint = Vector2.new(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(1, 0.2), Size = UDim2.fromScale(1, 1) })
						I[37] = new("ImageButton", I[36], "Frame", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://73236058290291"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1) })
							I[38] = new("TextLabel", I[37], "Value", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.52), Size = UDim2.fromScale(0.87, 0.57), Text = "Accept", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true })
								I[39] = new("UIStroke", I[38], "UIStroke", { Thickness = 1.5 })
						I[40] = new("UIAspectRatioConstraint", I[36], "UIAspectRatioConstraint", { AspectRatio = 3.5857143 })
				I[41] = new("Frame", I[5], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.0140001, 1.08), ZIndex = -1 })
					I[42] = new("UICorner", I[41], "UICorner", { BottomLeftRadius = UDim.new(0.17, 0), BottomRightRadius = UDim.new(0.17, 0), TopLeftRadius = UDim.new(0.17, 0), TopRightRadius = UDim.new(0.17, 0) })
					I[43] = new("UIGradient", I[41], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }) })
	return I[1]
end

return build
