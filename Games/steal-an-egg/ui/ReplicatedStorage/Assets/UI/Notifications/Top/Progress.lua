-- Generated from ui/ReplicatedStorage/Assets/UI/Notifications/Top/Progress.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Progress", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.2), Size = UDim2.fromScale(0.9999999, 1.0000001) })
		I[2] = new("Frame", I[1], "Tasks", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 1.35), Size = UDim2.new(1, 0, 0.7, -2) })
			I[3] = new("Frame", I[2], "Task", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.5) })
				I[4] = new("Frame", I[3], "Progress", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.9), Size = UDim2.fromScale(1, 0.2) })
					I[5] = new("UICorner", I[4], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
					I[6] = new("Frame", I[4], "Bar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(0.33, 1) })
						I[7] = new("UIStroke", I[6], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(17, 49, 58), Thickness = 2 })
						I[8] = new("UIGradient", I[6], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 21)), ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 255, 249)) }), Rotation = -90 })
						I[9] = new("UICorner", I[6], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[10] = new("TextLabel", I[3], "Label", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Size = UDim2.fromScale(0.65, 0.6), Text = "Kill 10k Gallombas", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 5 })
					I[11] = new("UIStroke", I[10], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
				I[12] = new("TextLabel", I[3], "Amount", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.35, 0.6), Text = "20/50", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 18, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 5 })
					I[13] = new("UIStroke", I[12], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2 })
				I[14] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0.02, 0), PaddingTop = UDim.new(0.02, 0) })
			I[15] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
		I[16] = new("Frame", I[1], "Message", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 0.6) })
			I[17] = new("Frame", I[16], "Text", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 2, Position = UDim2.fromScale(1, 0.5), Size = UDim2.fromScale(0.7, 1) })
				I[18] = new("TextLabel", I[17], "Title", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.25), Size = UDim2.fromScale(0.9999999, 0.6763576), Text = "Starter Quest!", TextColor3 = Color3.fromRGB(252, 252, 252), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, ZIndex = 7 })
					I[19] = new("UIStroke", I[18], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 2.5999999 }, { ["oldp_Thickness"] = 3 })
				I[20] = new("UIListLayout", I[17], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[21] = new("UIPadding", I[17], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.025, 0), PaddingRight = UDim.new(0.025, 0), PaddingTop = UDim.new(0.1, 0) })
			I[22] = new("ImageLabel", I[16], "SideIcon", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://77489632103398"), LayoutOrder = 1, Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), ZIndex = 5 })
				I[23] = new("UIAspectRatioConstraint", I[22], "UIAspectRatioConstraint")
			I[24] = new("UIListLayout", I[16], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[25] = new("UIPadding", I[16], "UIPadding", { PaddingTop = UDim.new(0.03, 0) })
		I[26] = new("Frame", I[1], "Background", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.12, 1.2), ZIndex = -1 })
			I[27] = new("UICorner", I[26], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[28] = new("UIStroke", I[26], "UIStroke", { Color = Color3.fromRGB(42, 43, 49), Thickness = 4.3000002 })
	return I[1]
end

return build
