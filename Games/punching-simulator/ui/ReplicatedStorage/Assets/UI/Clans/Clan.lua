-- Generated from ui/ReplicatedStorage/Assets/UI/Clans/Clan.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Clan", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(50, 50, 50), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.1204879), Size = UDim2.fromScale(1, 0.2409758) })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 240, 255), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.95, 0.9) })
			I[3] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 0), BottomRightRadius = UDim.new(0, 0), TopLeftRadius = UDim.new(0, 0), TopRightRadius = UDim.new(0, 0) })
			I[4] = new("ImageButton", I[2], "StateBtn", { Active = false, AnchorPoint = Vector2.new(0.5, 0.5), AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://13804213417"), Position = UDim2.fromScale(0.8942122, 0.4999998), ScaleType = Enum.ScaleType.Slice, Selectable = false, Size = UDim2.fromScale(0.1625894, 0.8565251), SliceCenter = Rect.new(15, 62, 40, 71), SliceScale = 2, ZIndex = 2 }, nil, { "PopButton" })
				I[5] = new("TextLabel", I[4], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.475), Size = UDim2.fromScale(0.8, 0.7), Text = "Join", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
					I[6] = new("UIStroke", I[5], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
					I[7] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 35 })
			I[8] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 237, 242)), ColorSequenceKeypoint.new(0.4966667, Color3.fromRGB(212, 221, 230)), ColorSequenceKeypoint.new(0.5133333, Color3.fromRGB(199, 205, 214)), ColorSequenceKeypoint.new(1, Color3.fromRGB(209, 218, 226)) }), Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0.15) }) })
			I[9] = new("UIStroke", I[2], "UIStroke", { LineJoinMode = Enum.LineJoinMode.Miter, Thickness = 3 })
			I[10] = new("TextLabel", I[2], "Members", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.725, 0.7), Size = UDim2.fromScale(0.1280519, 0.3321133), Text = "10/10", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, ZIndex = 4 })
				I[11] = new("UIStroke", I[10], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
				I[12] = new("UITextSizeConstraint", I[10], "UITextSizeConstraint", { MaxTextSize = 35 })
			I[13] = new("TextLabel", I[2], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.725, 0.35), Size = UDim2.fromScale(0.1341667, 0.3406632), Text = "Members", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextWrapped = true, ZIndex = 4 })
			I[14] = new("TextLabel", I[2], "Time", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.1035998, 0.3022492), Size = UDim2.fromScale(0.5411755, 0.4545002), Text = "", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 35, TextStrokeColor3 = Color3.fromRGB(72, 72, 72), TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 4 })
				I[15] = new("UIStroke", I[14], "UIStroke", { Color = Color3.fromRGB(23, 23, 29), Thickness = 2 })
				I[16] = new("UITextSizeConstraint", I[14], "UITextSizeConstraint", { MaxTextSize = 35 })
			I[17] = new("ImageLabel", I[2], "Emblem", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14342558028"), Position = UDim2.fromScale(0.0500757, 0.4741732), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.0624066, 0.7223433), SliceCenter = Rect.new(140, 30, 166, 32), ZIndex = 3 })
			I[18] = new("ImageLabel", I[2], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://14342545791"), Position = UDim2.fromScale(0.0500757, 0.511444), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.0720216, 0.8336359), SliceCenter = Rect.new(140, 30, 166, 32), ZIndex = 4 })
	return I[1]
end

return build
