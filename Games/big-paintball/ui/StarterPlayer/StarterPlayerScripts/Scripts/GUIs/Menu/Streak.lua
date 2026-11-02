-- Generated from ui/StarterPlayer/StarterPlayerScripts/Scripts/GUIs/Menu/Streak.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("ImageButton", nil, "Streak", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://5431965152"), LayoutOrder = 2, Position = UDim2.fromScale(0.4, 1.1), ScaleType = Enum.ScaleType.Slice, Size = UDim2.new(1, 0, 0, 65), SliceCenter = Rect.new(20, 20, 80, 80) })
		I[2] = new("ImageLabel", I[1], "Thumbnail", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://4352589418"), Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.2, 1.35), ZIndex = 2 })
		I[3] = new("TextLabel", I[1], "Title", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, 0), Size = UDim2.fromScale(0.5, 0.5), Text = "Turret!", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
		I[4] = new("UIPadding", I[1], "UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingTop = UDim.new(0, 4) })
		I[5] = new("TextLabel", I[1], "Desc", { AnchorPoint = Vector2.new(0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.2, 1), Size = UDim2.fromScale(0.5, 0.5), Text = "Shoots players that walk past goes pew pew pew pew", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextTruncate = Enum.TextTruncate.AtEnd, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top })
			I[6] = new("UITextSizeConstraint", I[5], "UITextSizeConstraint", { MaxTextSize = 15 })
		I[7] = new("ImageButton", I[1], "Buy", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.852, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.265, 0.85), SliceCenter = Rect.new(20, 20, 80, 80) })
			I[8] = new("ImageLabel", I[7], "Icon", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 0, 0), ImageContent = Content.fromUri("rbxassetid://3701177967"), Position = UDim2.fromScale(0.5, 0.1), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.25, 0.5), SliceCenter = Rect.new(20, 20, 80, 80), ZIndex = 3 })
			I[9] = new("TextLabel", I[7], "Cost", { AnchorPoint = Vector2.new(0.5, 1), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.95), Size = UDim2.fromScale(0, 0.7), Text = "666k", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 30, TextWrapped = true, ZIndex = 3 })
			I[10] = new("UIListLayout", I[7], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.05, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
		I[11] = new("ImageButton", I[1], "Equip", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(62, 255, 139), ImageContent = Content.fromUri("rbxassetid://5431965152"), Position = UDim2.fromScale(0.852, 0.5), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.265, 0.85), SliceCenter = Rect.new(20, 20, 80, 80), Visible = false })
			I[12] = new("TextLabel", I[11], "TextLabel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), Text = "Switch", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true })
		I[13] = new("TextLabel", I[1], "EquippedNum", { AnchorPoint = Vector2.new(1, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.985, 0.5), Size = UDim2.fromScale(0.15, 0.7), Text = "#3", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Right, Visible = false })
	return I[1]
end

return build
