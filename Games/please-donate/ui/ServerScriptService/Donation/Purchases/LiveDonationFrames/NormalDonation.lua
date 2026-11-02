-- Generated from ui/ServerScriptService/Donation/Purchases/LiveDonationFrames/NormalDonation.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "NormalDonation", { BackgroundTransparency = 1, LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 100) })
		I[2] = new("Frame", I[1], "Raiser", { AutoLocalize = false, BackgroundTransparency = 1, LayoutOrder = 3, Position = UDim2.fromScale(0.625, 0), Size = UDim2.new(0.3333, 0, 0, 100) })
			I[3] = new("UIListLayout", I[2], "List", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
			I[4] = new("TextLabel", I[2], "Username", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1.4, 0, 0, 20), Text = "@Async Softworks", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextStrokeTransparency = 0, TextTruncate = Enum.TextTruncate.AtEnd })
			I[5] = new("ImageLabel", I[2], "Avatar", { BackgroundTransparency = 0.9, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=1&w=150&h=150"), LayoutOrder = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(1, 0, 1, -20) })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[7] = new("UIStroke", I[5], "Border", { Thickness = 3 })
				I[8] = new("UIAspectRatioConstraint", I[5], "Aspect")
		I[9] = new("Frame", I[1], "Donator", { AnchorPoint = Vector2.new(1, 0), AutoLocalize = false, BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.375, 0), Size = UDim2.new(0.3333, 0, 0, 100) })
			I[10] = new("UIListLayout", I[9], "List", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
			I[11] = new("TextLabel", I[9], "Username", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1.4, 0, 0, 20), Text = "@Async Softworks", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextStrokeTransparency = 0, TextTruncate = Enum.TextTruncate.AtEnd })
			I[12] = new("ImageLabel", I[9], "Avatar", { BackgroundTransparency = 0.9, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=1&w=150&h=150"), LayoutOrder = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(1, 0, 1, -20) })
				I[13] = new("UICorner", I[12], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[14] = new("UIStroke", I[12], "Border", { Thickness = 3 })
				I[15] = new("UIAspectRatioConstraint", I[12], "Aspect")
		I[16] = new("Frame", I[1], "AmountFrame", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(0.25, 0, 0, 100) })
			I[17] = new("TextLabel", I[16], "Label", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0), Text = "donated to", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextStrokeTransparency = 0 })
			I[18] = new("Frame", I[16], "Main", { AnchorPoint = Vector2.new(0.5, 1), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0) })
				I[19] = new("UIListLayout", I[18], "List", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
				I[20] = new("TextLabel", I[18], "Amount", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Text = "0", TextColor3 = Color3.fromRGB(8, 255, 36), TextSize = 32, TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left })
				I[21] = new("ImageLabel", I[18], "RobuxIcon", { BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(8, 255, 36), ImageContent = Content.fromUri("rbxasset://textures/ui/common/robux@3x.png"), Size = UDim2.fromOffset(32, 32) })
	return I[1]
end

return build
