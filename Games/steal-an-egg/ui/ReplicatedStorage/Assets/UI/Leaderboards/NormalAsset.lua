-- Generated from ui/ReplicatedStorage/Assets/UI/Leaderboards/NormalAsset.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "NormalAsset", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 100) })
		I[2] = new("Frame", I[1], "Player", { AnchorPoint = Vector2.new(1, 0), AutoLocalize = false, BackgroundTransparency = 1, LayoutOrder = 1, Position = UDim2.fromScale(0.375, 0), Size = UDim2.new(0.38, 0, 0, 100) })
			I[3] = new("UIListLayout", I[2], "List", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder })
			I[4] = new("TextLabel", I[2], "Username", { BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 2, Position = UDim2.fromScale(0, 1), Size = UDim2.new(1.4, 0, 0, 20), Text = "@MrBeast", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 20, TextStrokeTransparency = 0, TextTruncate = Enum.TextTruncate.AtEnd })
			I[5] = new("ImageLabel", I[2], "Avatar", { BackgroundTransparency = 0.9, ImageContent = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=1&w=150&h=150"), LayoutOrder = 1, ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(1, 0, 1, -20) })
				I[6] = new("UICorner", I[5], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
				I[7] = new("UIStroke", I[5], "Border", { Thickness = 3 })
				I[8] = new("UIAspectRatioConstraint", I[5], "Aspect")
		I[9] = new("Frame", I[1], "Data", { BackgroundTransparency = 1, LayoutOrder = 2, Position = UDim2.fromScale(0.37, 0), Size = UDim2.new(0.6, 0, 0, 100) })
			I[10] = new("TextLabel", I[9], "Label", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1, FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0, 1), Text = "toxic toxic toxic toxic toxic toxic toxi", TextColor3 = Color3.fromRGB(0, 255, 21), TextScaled = true, TextSize = 38, TextStrokeTransparency = 0, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left })
			I[11] = new("ImageLabel", I[9], "Icon", { AnchorPoint = Vector2.new(0, 0.5), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(165, 0, 3), BackgroundTransparency = 1, ImageContent = Content.fromUri("rbxassetid://131960175753245"), LayoutOrder = 2, Position = UDim2.fromScale(0, 0.5), ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.45, 0.8) })
	return I[1]
end

return build
