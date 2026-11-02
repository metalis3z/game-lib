-- Generated from ui/ReplicatedStorage/Assets/UI/Clans/Member.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Member", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.4873636, 0.0875), Size = UDim2.fromScale(0.9747272, 0.2) })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.8) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 0), BottomRightRadius = UDim.new(0, 0), TopLeftRadius = UDim.new(0, 0), TopRightRadius = UDim.new(0, 0) })
			I[4] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[5] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(248, 250, 255)), ColorSequenceKeypoint.new(0.4966667, Color3.fromRGB(240, 247, 255)), ColorSequenceKeypoint.new(0.5133333, Color3.fromRGB(232, 236, 244)), ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 247, 255)) }), Rotation = 90 })
			I[6] = new("TextLabel", I[2], "Rank", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.025, 0.75), Size = UDim2.fromScale(0.4090339, 0.3453651), Text = "Owner", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
			I[7] = new("Frame", I[2], "Content", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Position = UDim2.fromScale(0.025, 0.312), Size = UDim2.fromScale(0.7846931, 0.4545002), ZIndex = 4 })
				I[8] = new("UIListLayout", I[7], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.025, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[9] = new("ImageLabel", I[7], "Owner", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14365282219"), Position = UDim2.fromScale(0.0556406, 0.3120681), ScaleType = Enum.ScaleType.Fit, SelectionGroup = true, Size = UDim2.fromScale(0.0982106, 1), ZIndex = 6 })
				I[10] = new("TextLabel", I[7], "Time", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.118445, 0.312), Size = UDim2.fromScale(0.6912481, 1), Text = "Hashbloxian", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
					I[11] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
					I[12] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 35 })
			I[13] = new("ImageButton", I[2], "KickBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 0, 0), ImageContent = Content.fromUri("rbxassetid://13810832668"), Position = UDim2.fromScale(0.915, 0.5), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.14, 0.9), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, Visible = false, ZIndex = 2 }, nil, { "PopButton" })
				I[14] = new("ImageLabel", I[13], "Owner", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14365967742"), Position = UDim2.fromScale(0.5, 0.475), Rotation = 12, ScaleType = Enum.ScaleType.Fit, SelectionGroup = true, Size = UDim2.fromScale(0.65, 0.65), ZIndex = 6 })
	return I[1]
end

return build
