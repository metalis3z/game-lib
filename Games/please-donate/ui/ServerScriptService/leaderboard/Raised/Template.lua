-- Generated from ui/ServerScriptService/leaderboard/Raised/Template.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "Template", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(255, 255, 255), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 0, LayoutOrder = -2516634, Size = UDim2.new(1, 0, 0, 56) })
		I[2] = new("Frame", I[1], "Info", { AnchorPoint = Vector2.new(0, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(0.7, 0, 0, 42) })
			I[3] = new("UIPadding", I[2], "UIPadding", { PaddingBottom = UDim.new(0, 6), PaddingTop = UDim.new(0, 6) })
			I[4] = new("TextLabel", I[2], "Username", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Size = UDim2.fromScale(0, 0.65), Text = "@User", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[5] = new("UIStroke", I[4], "UIStroke", { Thickness = 1.5 })
				I[6] = new("UIGradient", I[4], "GoldGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 157, 0)), ColorSequenceKeypoint.new(0.474957, Color3.fromRGB(255, 205, 171)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 157, 0)) }), Enabled = false, Rotation = 40 })
				I[7] = new("UIGradient", I[4], "SilverGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.184801, Color3.fromRGB(173, 173, 173)), ColorSequenceKeypoint.new(0.390328, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.604491, Color3.fromRGB(170, 170, 170)), ColorSequenceKeypoint.new(0.813471, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 170, 170)) }), Enabled = false, Rotation = 40 })
				I[8] = new("UIGradient", I[4], "BronzeGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(216, 137, 110)), ColorSequenceKeypoint.new(0.290155, Color3.fromRGB(236, 182, 135)), ColorSequenceKeypoint.new(0.602763, Color3.fromRGB(229, 145, 117)), ColorSequenceKeypoint.new(0.882556, Color3.fromRGB(231, 171, 129)), ColorSequenceKeypoint.new(1, Color3.fromRGB(214, 132, 107)) }), Enabled = false, Rotation = 40 })
			I[9] = new("TextLabel", I[2], "Rank", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(0, 0.6), Text = "1", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[10] = new("UIStroke", I[9], "UIStroke", { Thickness = 1.5 })
			I[11] = new("ImageLabel", I[2], "Avatar", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9, BorderSizePixel = 0, LayoutOrder = 1, Size = UDim2.fromOffset(30, 30) })
				I[12] = new("UIStroke", I[11], "UIStroke", { Thickness = 2 })
				I[13] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[14] = new("UIListLayout", I[2], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 15), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[15] = new("Frame", I[1], "Stats", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromScale(1, 0.5), Size = UDim2.new(0.2, 0, 0, 42) })
			I[16] = new("UIListLayout", I[15], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[17] = new("UIPadding", I[15], "UIPadding", { PaddingBottom = UDim.new(0, 5), PaddingTop = UDim.new(0, 5) })
			I[18] = new("TextLabel", I[15], "Raised", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Size = UDim2.fromScale(1, 0.6), Text = "0", TextColor3 = Color3.fromRGB(8, 255, 36), TextScaled = true, TextSize = 20, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
				I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 1.5 })
	return I[1]
end

return build
