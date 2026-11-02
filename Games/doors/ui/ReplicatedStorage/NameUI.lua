-- Generated from ui/ReplicatedStorage/NameUI.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("BillboardGui", nil, "NameUI", { Active = true, Brightness = 1.7, MaxDistance = 100, Size = UDim2.fromOffset(600, 70), SizeOffset = Vector2.new(0, 0.5), ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
		I[2] = new("TextLabel", I[1], "Stuff", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromScale(2, 0), Text = "", TextColor3 = Color3.fromRGB(255, 222, 189), TextSize = 24, TextStrokeTransparency = 0.9 })
			I[3] = new("Frame", I[2], "Frame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(1, 1) })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[5] = new("UIPadding", I[3], "UIPadding", { PaddingLeft = UDim.new(0, 2) })
				I[6] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(30, 17, 16), Enabled = false, Thickness = 2 })
				I[7] = new("Frame", I[3], "SeparatorDeaths", { BackgroundColor3 = Color3.fromRGB(136, 116, 99), BorderSizePixel = 0, Size = UDim2.fromOffset(1, 28), Visible = false })
					I[8] = new("UIGradient", I[7], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.144654, 0.24375), NumberSequenceKeypoint.new(0.502358, 0), NumberSequenceKeypoint.new(0.856918, 0.26875), NumberSequenceKeypoint.new(1, 1) }) })
				I[9] = new("Frame", I[3], "SeparatorEscapes", { BackgroundColor3 = Color3.fromRGB(136, 116, 99), BorderSizePixel = 0, LayoutOrder = 2, Size = UDim2.fromOffset(1, 28), Visible = false })
					I[10] = new("UIGradient", I[9], "UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.144654, 0.24375), NumberSequenceKeypoint.new(0.502358, 0), NumberSequenceKeypoint.new(0.856918, 0.26875), NumberSequenceKeypoint.new(1, 1) }) })
				I[11] = new("ImageLabel", I[3], "IconBadge", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.5, ImageTransparency = 0.1, LayoutOrder = -2, Size = UDim2.fromScale(0.7, 0.7), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
					I[12] = new("UIStroke", I[11], "UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 2.5 })
					I[13] = new("UICorner", I[11], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[14] = new("ImageLabel", I[3], "IconDeathHolder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageTransparency = 1, LayoutOrder = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
					I[15] = new("ImageLabel", I[14], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(255, 151, 147), ImageContent = Content.fromUri("rbxassetid://10099875436"), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1, 1), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[16] = new("ImageLabel", I[3], "IconEscapesHolder", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageTransparency = 1, LayoutOrder = 4, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6), SizeConstraint = Enum.SizeConstraint.RelativeYY, Visible = false })
					I[17] = new("ImageLabel", I[16], "ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(170, 237, 255), ImageContent = Content.fromUri("rbxassetid://10100630346"), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(1.2, 1.2), SizeConstraint = Enum.SizeConstraint.RelativeYY })
				I[18] = new("TextLabel", I[3], "TextBadge", { AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = -1, Size = UDim2.fromOffset(0, 20), Text = "Badge Name", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, Visible = false })
					I[19] = new("UIStroke", I[18], "UIStroke", { Thickness = 2, Transparency = 0.75 })
				I[20] = new("TextLabel", I[3], "TextDeaths", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 2, Size = UDim2.fromOffset(0, 24), Text = "9,999", TextColor3 = Color3.fromRGB(255, 151, 147), TextSize = 24, Visible = false })
				I[21] = new("TextLabel", I[3], "TextEscapes", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 5, Size = UDim2.fromOffset(0, 24), Text = "999,999", TextColor3 = Color3.fromRGB(170, 237, 255), TextSize = 24, Visible = false })
		I[22] = new("TextLabel", I[1], "Username", { AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, RichText = true, Size = UDim2.fromOffset(0, 20), Text = "BobbyMcBobberson", TextColor3 = Color3.fromRGB(255, 222, 189), TextSize = 28, TextStrokeTransparency = 0.9 })
			I[23] = new("UIStroke", I[22], "UIStroke", { Color = Color3.fromRGB(30, 17, 16), Thickness = 2 })
		I[24] = new("UIListLayout", I[1], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom })
	return I[1]
end

return build
