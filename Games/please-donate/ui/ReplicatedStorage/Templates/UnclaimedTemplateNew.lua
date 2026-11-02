-- Generated from ui/ReplicatedStorage/Templates/UnclaimedTemplateNew.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("TextButton", nil, "UnclaimedTemplateNew", { AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(45, 207, 113), BorderSizePixel = 0, ClipsDescendants = true, Selectable = false, Size = UDim2.fromScale(1, 0.35), Text = "" })
		I[2] = new("UICorner", I[1], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
		I[3] = new("Frame", I[1], "Gift", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
			I[4] = new("Frame", I[3], "Info", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.fromScale(0.85, 1) })
				I[5] = new("TextLabel", I[4], "Username", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, RichText = true, Size = UDim2.fromScale(1, 0.24), Text = "hazem <font transparency=\"0.5\">@haz3mn</font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[6] = new("UIListLayout", I[4], "UIListLayout", { Padding = UDim.new(0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder })
				I[7] = new("TextLabel", I[4], "Amount", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, RichText = true, Size = UDim2.fromScale(1, 0.22), Text = "Gifted 1,000,000", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[8] = new("TextLabel", I[4], "Message", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.18), Text = "I hope you enjoy the gift, love your vids!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
				I[9] = new("TextLabel", I[4], "Time", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0.18), Text = "a minute ago", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 0.2, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[10] = new("ImageLabel", I[3], "Avatar", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.9, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=893247&w=420&h=420"), Size = UDim2.fromScale(0.65, 0.65) })
				I[11] = new("UIAspectRatioConstraint", I[10], "UIAspectRatioConstraint")
				I[12] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[13] = new("UIListLayout", I[3], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder })
			I[14] = new("UIPadding", I[3], "UIPadding", { PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.04, 0), PaddingRight = UDim.new(0.04, 0), PaddingTop = UDim.new(0.14, 0) })
		I[15] = new("Frame", I[1], "Hover", { BackgroundColor3 = Color3.fromRGB(0, 157, 255), BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.fromScale(1, 1) })
			I[16] = new("TextLabel", I[15], "Claim", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, RichText = true, Size = UDim2.fromScale(1, 0.28), Text = "CLAIM", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
			I[17] = new("UIListLayout", I[15], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.03, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[18] = new("TextLabel", I[15], "Tap", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, RichText = true, Size = UDim2.fromScale(1, 0.25), Text = "Tap to Claim", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right })
			I[19] = new("UIPadding", I[15], "UIPadding", { PaddingBottom = UDim.new(0.15, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0), PaddingTop = UDim.new(0.15, 0) })
			I[20] = new("UIGradient", I[15], "UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.578059), NumberSequenceKeypoint.new(1, 0.0375) }) })
			I[21] = new("UICorner", I[15], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
		I[22] = new("StringValue", I[1], "Username")
	return I[1]
end

return build
