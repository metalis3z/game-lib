-- Generated from ui/ReplicatedStorage/Systems/Player/UI/Menus/Shop/Tabs/Robux/GiftingMenu.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "GiftingMenu", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(0.3, 100, 0.5, 100) })
		I[2] = new("ImageLabel", I[1], "MenuBackground", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81699914649761"), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(1, 1), SliceCenter = Rect.new(15, 15, 415, 380) })
		I[3] = new("ScrollingFrame", I[1], "Choices", { Active = true, AnchorPoint = Vector2.new(0.5, 1), AutomaticCanvasSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, BottomImageContent = Content.fromUri("rbxassetid://18912598903"), CanvasSize = UDim2.fromScale(0, 0), MidImageContent = Content.fromUri("rbxassetid://18912597717"), Position = UDim2.fromScale(0.5, 0.94), ScrollBarThickness = 22, ScrollingDirection = Enum.ScrollingDirection.Y, Size = UDim2.fromScale(0.88, 0.7), TopImageContent = Content.fromUri("rbxassetid://18912599863"), VerticalScrollBarInset = Enum.ScrollBarInset.Always, VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left, ZIndex = 3 })
			I[4] = new("UIListLayout", I[3], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder })
			I[5] = new("UIPadding", I[3], "UIPadding")
		I[6] = new("ImageLabel", I[1], "ListBackground", { AnchorPoint = Vector2.new(0.5, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://81699914649761"), Position = UDim2.fromScale(0.5, 0.975), ScaleType = Enum.ScaleType.Slice, Size = UDim2.fromScale(0.95, 0.775), SliceCenter = Rect.new(15, 15, 415, 380), ZIndex = 2 })
		I[7] = new("TextButton", I[1], "Cancel", { AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/AccanthisADFStd.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.12), RichText = true, Size = UDim2.fromScale(0.9, 0.15), Text = "Select a player to buy this product for\n<font color=\"rgb(125,125,125)\"><font size=\"22\">(Click on this message to cancel)</font></font>", TextColor3 = Color3.fromRGB(255, 255, 255), TextScaled = true, TextSize = 28, TextWrapped = true })
			I[8] = new("UIPadding", I[7], "UIPadding", { PaddingBottom = UDim.new(0, -2) })
	return I[1]
end

return build
