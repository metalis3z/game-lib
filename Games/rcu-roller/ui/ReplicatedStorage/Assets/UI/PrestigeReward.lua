-- Generated from ui/ReplicatedStorage/Assets/UI/PrestigeReward.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "PrestigeReward", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.fromOffset(486, 123), ZIndex = 507 })
		I[2] = new("UIStroke", I[1], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 6 })
		I[3] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.14, 0), BottomRightRadius = UDim.new(0.14, 0), TopLeftRadius = UDim.new(0.14, 0), TopRightRadius = UDim.new(0.14, 0) })
		I[4] = new("UIGradient", I[1], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(219, 255, 255)) }), Rotation = 70 })
		I[5] = new("Frame", I[1], "List", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.9599999, 0.51), Size = UDim2.fromScale(0.716873, 0.6337439), ZIndex = 510 })
			I[6] = new("UIGridLayout", I[5], "UIGridLayout", { CellPadding = UDim2.fromScale(0.025, 0.34), CellSize = UDim2.fromScale(0.145, 1), HorizontalAlignment = Enum.HorizontalAlignment.Right, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[7] = new("TextLabel", I[1], "PrestigeLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.1910058, 0.7017963), Size = UDim2.fromScale(0.1350168, 0.5235925), Text = "I", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 552 })
			I[8] = new("UIGradient", I[7], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(194, 255, 245)), ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 177, 255)) }), Rotation = 90 })
			I[9] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(34, 64, 102), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
		I[10] = new("ImageLabel", I[1], "TagIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://112137779812864"), Position = UDim2.fromScale(0.0975028, 0.5000002), Size = UDim2.fromScale(0.1769831, 1.0573099), ZIndex = 551 })
			I[11] = new("ImageLabel", I[10], "Shadow", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://112137779812864"), ImageTransparency = 0.9, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1.14, 1.14), ZIndex = 550 })
	return I[1]
end

return build
