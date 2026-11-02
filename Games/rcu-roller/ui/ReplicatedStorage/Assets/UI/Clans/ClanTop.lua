-- Generated from ui/ReplicatedStorage/Assets/UI/Clans/ClanTop.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "ClanTop", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(172, 172, 172), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 4, Size = UDim2.fromOffset(920, 141), ZIndex = 600 })
		I[2] = new("Frame", I[1], "Main", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 600 })
			I[3] = new("TextLabel", I[2], "ClanTag", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 8, Position = UDim2.fromScale(0.476, 0.31), Size = UDim2.fromScale(0.6134636, 0.3661972), Text = "[RAKI]", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 610 })
				I[4] = new("UIStroke", I[3], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[5] = new("UIGradient", I[3], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(217, 255, 251)) }), Rotation = 90 })
			I[6] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[7] = new("Frame", I[2], "ClanIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.077, 0.5), Size = UDim2.fromScale(0.1237785, 0.8028169), ZIndex = 610 })
				I[8] = new("UICorner", I[7], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
				I[9] = new("UIStroke", I[7], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5 })
				I[10] = new("ImageLabel", I[7], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://98772757979285"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 610 })
					I[11] = new("UICorner", I[10], "UICorner", { BottomLeftRadius = UDim.new(0.15, 0), BottomRightRadius = UDim.new(0.15, 0), TopLeftRadius = UDim.new(0.15, 0), TopRightRadius = UDim.new(0.15, 0) })
			I[12] = new("TextLabel", I[2], "ClanRank", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 8, Position = UDim2.fromScale(0.0682776, 0.8440002), Size = UDim2.fromScale(0.1157582, 0.2605634), Text = "#4", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 14, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 630 })
				I[13] = new("UIStroke", I[12], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4.5 })
			I[14] = new("UIGradient", I[2], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 252, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 255 })
			I[15] = new("UIStroke", I[2], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), Thickness = 5 })
				I[16] = new("UIGradient", I[15], "UIGradient", { Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(234, 252, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }), Rotation = 255 })
			I[17] = new("TextButton", I[2], "Click", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), Text = "", TextColor3 = Color3.fromRGB(0, 0, 0), TextScaled = true, TextSize = 14, TextWrapped = true, ZIndex = 900 })
				I[18] = new("UITextSizeConstraint", I[17], "UITextSizeConstraint", { MaxTextSize = 14 })
			I[19] = new("Frame", I[2], "ClanStats", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.191, 0.73), Size = UDim2.fromScale(0.0673181, 0.4366197), ZIndex = 600 })
				I[20] = new("UIListLayout", I[19], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[21] = new("ImageLabel", I[19], "LevelIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://97120977036321"), LayoutOrder = -100, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9032258, 0.9032258), ZIndex = 620 })
				I[22] = new("TextLabel", I[19], "LevelAmount", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = -99, Position = UDim2.fromScale(3.2137728, 0.4999998), Size = UDim2.fromScale(0.1, 0.81), Text = "Level 1", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 47, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 610 })
					I[23] = new("UIStroke", I[22], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
				I[24] = new("ImageLabel", I[19], "RebirthIcon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://94283057372807"), LayoutOrder = 99, Position = UDim2.fromScale(4.0108728, 0.5), Size = UDim2.fromScale(0.8357571, 0.8357571), ZIndex = 620 })
				I[25] = new("Frame", I[19], "NOTHING", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(3.2601023, 0.0560679), Size = UDim2.fromScale(0.22, 0.888) })
				I[26] = new("TextLabel", I[19], "RebirthAmount", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 100, Position = UDim2.fromScale(3.2137728, 0.4999998), Size = UDim2.fromScale(0.1, 0.81), Text = "131.9M", TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 47, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 610 })
					I[27] = new("UIStroke", I[26], "UIStroke", { Color = Color3.fromRGB(0, 32, 54), LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = 4 })
			I[28] = new("Frame", I[2], "ClanMembers", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.952, 0.75), Size = UDim2.fromScale(0.0640608, 0.415493), ZIndex = 600 })
				I[29] = new("UIListLayout", I[28], "UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0.06, 0), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
				I[30] = new("ImageLabel", I[28], "Icon", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageColor3 = Color3.fromRGB(0, 32, 54), ImageContent = Content.fromUri("rbxassetid://77364778428075"), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1), ZIndex = 620 })
				I[31] = new("TextLabel", I[28], "Amount", { AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), LayoutOrder = 8, Position = UDim2.fromScale(0.2023913, 0.5000002), Size = UDim2.fromScale(0.1, 0.9), Text = "1/10", TextColor3 = Color3.fromRGB(0, 32, 54), TextSize = 54, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 610 })
	return I[1]
end

return build
