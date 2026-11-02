-- Generated from ui/ServerScriptService/Donation/Purchases/DonationTemplates/10k.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "10k", { BackgroundTransparency = 1, LayoutOrder = 1000, Size = UDim2.new(1, 0, 0, 110) })
		I[2] = new("Frame", I[1], "Reciever", { AutoLocalize = false, BackgroundTransparency = 1, LayoutOrder = 3, Position = UDim2.fromScale(0.625, 0), Size = UDim2.new(0.3333, 0, 0, 100) })
			I[3] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
			I[4] = new("TextLabel", I[2], "Username", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1.4, 0, 0, 20), Text = "@redfireeeeeeeeeee", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextStrokeTransparency = 0, TextTruncate = Enum.TextTruncate.AtEnd })
			I[5] = new("ImageLabel", I[2], "Icon", { BackgroundTransparency = 0.9, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=1310459676&w=150&h=150"), LayoutOrder = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(1, 0, 1, -20) })
				I[6] = new("UICorner", I[5], "P>�J���$�E����	�X\n�;����3f�b", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[7] = new("UIStroke", I[5], "��&�h�vE������ƕ���-��ҳ�\"O2����z�D\\@�*GAf9^�D(��:��sɆ��", { Color = Color3.fromRGB(85, 255, 255), Thickness = 3 })
				I[8] = new("UIAspectRatioConstraint", I[5], "z� |ߊ~��nyMZ'W�d@���9���%�-�DE�����mH��\"�\n")
		I[9] = new("Frame", I[1], "Duration", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 105), Size = UDim2.new(1, 0, 0, 5) })
			I[10] = new("Frame", I[9], "MainBar", { BackgroundColor3 = Color3.fromRGB(85, 255, 255), BorderSizePixel = 0, Size = UDim2.fromScale(0.99, 1) })
				I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
		I[12] = new("Frame", I[1], "Robux", { AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0), Size = UDim2.new(0.25, 0, 0, 100) })
			I[13] = new("TextLabel", I[12], "Donated", { AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0), Text = "donated to", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 24, TextStrokeTransparency = 0 })
			I[14] = new("Frame", I[12], "AmountFrame", { AnchorPoint = Vector2.new(0.5, 1), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 0) })
				I[15] = new("UIListLayout", I[14], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
				I[16] = new("TextLabel", I[14], "Amount", { AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Text = "10,000", TextColor3 = Color3.fromRGB(85, 255, 255), TextSize = 32, TextStrokeTransparency = 0, TextXAlignment = Enum.TextXAlignment.Left })
				I[17] = new("ImageLabel", I[14], "RobuxIcon", { BackgroundTransparency = 1, ImageColor3 = Color3.fromRGB(85, 255, 255), ImageContent = Content.fromUri("rbxasset://textures/ui/common/robux@3x.png"), Size = UDim2.fromOffset(32, 32) })
		I[18] = new("Frame", I[1], "Donator", { AnchorPoint = Vector2.new(1, 0), AutoLocalize = false, BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.375, 0), Size = UDim2.new(0.3333, 0, 0, 100) })
			I[19] = new("UIListLayout", I[18], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
			I[20] = new("TextLabel", I[18], "Username", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1.4, 0, 0, 20), Text = "@ean_roblox321", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextStrokeTransparency = 0, TextTruncate = Enum.TextTruncate.AtEnd })
			I[21] = new("ImageLabel", I[18], "Icon", { BackgroundTransparency = 0.9, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=1465230122&w=150&h=150"), LayoutOrder = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(1, 0, 1, -20) })
				I[22] = new("UICorner", I[21], "�L��$Z5FO��ާ��B��t����Ԯ�ʭu��+ݗw*��}3J�3Q�0\nي��7���x�N", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[23] = new("UIStroke", I[21], "�̡/�������~(p����ޤ��B��+���{�)��~(���\\��ܵ����Z9vKN����", { Color = Color3.fromRGB(85, 255, 255), Thickness = 3 })
				I[24] = new("UIAspectRatioConstraint", I[21], "���9�D[_�aH`@\"��P�VӚV#e&Pu�4<@�R{cܽF��H�x����u���Y�b�IRC")
	return I[1]
end

return build
