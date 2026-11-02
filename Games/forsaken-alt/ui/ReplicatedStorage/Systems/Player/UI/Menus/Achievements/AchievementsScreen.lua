-- Generated from ui/ReplicatedStorage/Systems/Player/UI/Menus/Achievements/AchievementsScreen.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "AchievementsScreen", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -20, 1, -20) })
		I[2] = new("ImageLabel", I[1], "AchievementsContainer", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://123911976725450"), LayoutOrder = 1, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.65, 1) })
			I[3] = new("Frame", I[2], "Tabs", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 1, Position = UDim2.fromScale(1, 0), Size = UDim2.fromScale(0.2, 1) })
				I[4] = new("UIListLayout", I[3], "UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, VerticalFlex = Enum.UIFlexAlignment.Fill })
			I[5] = new("ImageLabel", I[2], "MainTitle", { AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ClipsDescendants = true, ImageContent = Content.fromUri("rbxassetid://19000746528"), Position = UDim2.fromScale(0.525, 0.0325), Size = UDim2.fromScale(0.9, 0.07) })
				I[6] = new("TextLabel", I[5], "Title", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), RichText = true, Size = UDim2.fromScale(1, 0.65), Text = "Unlocked -- 0/0", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 36, TextWrapped = true })
			I[7] = new("UIAspectRatioConstraint", I[2], "UIAspectRatioConstraint", { AspectRatio = 1.2 })
			I[8] = new("ScrollingFrame", I[2], "Contents", { Active = true, AnchorPoint = Vector2.new(0.5, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxassetid://18912598903"), CanvasSize = UDim2.fromScale(0, 0), MidImageContent = Content.fromUri("rbxassetid://18912597717"), Position = UDim2.fromScale(0.5, 0.11), ScrollBarThickness = 22, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(0.95, 0.865), TopImageContent = Content.fromUri("rbxassetid://18912599863"), VerticalScrollBarInset = Enum.ScrollBarInset.Always, VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left })
				I[9] = new("UIPadding", I[8], "UIPadding", { PaddingLeft = UDim.new(0.025, 0) })
				I[10] = new("UIListLayout", I[8], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder })
	return I[1]
end

return build
