-- Generated from ui/ReplicatedStorage/Assets/UI/Trading/Chat/PlayerLine.rbxm by _tools/rbxm2lua.luau
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
	I[1] = new("Frame", nil, "PlayerLine", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 0), ZIndex = 3000 }, { ["Template"] = true })
		I[2] = new("Frame", I[1], "PlayerMessage", { AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderSizePixel = 0, Position = UDim2.fromScale(0.1, 0), Size = UDim2.fromScale(0.6, 0), ZIndex = 3000 })
			I[3] = new("TextLabel", I[2], "Label", { AnchorPoint = Vector2.new(0.5, 0.5), AutoLocalize = false, AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.9, 0), Text = "Hello how much for huge cat bruh I got a lot to say", TextColor3 = Color3.fromRGB(30, 30, 30), TextScaled = true, TextSize = 14, TextStrokeColor3 = Color3.fromRGB(17, 58, 72), TextWrapped = true, ZIndex = 3000 })
				I[4] = new("UITextSizeConstraint", I[3], "UITextSizeConstraint", { MaxTextSize = 42 })
			I[5] = new("Frame", I[2], "BottomPadding", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = 999, Size = UDim2.fromOffset(0, 8) })
			I[6] = new("Frame", I[2], "TopPadding", { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, LayoutOrder = -999, Size = UDim2.fromOffset(0, 8) })
			I[7] = new("UIListLayout", I[2], "UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center })
			I[8] = new("UICorner", I[2], "UICorner", { BottomLeftRadius = UDim.new(0, 20), BottomRightRadius = UDim.new(0, 20), TopLeftRadius = UDim.new(0, 20), TopRightRadius = UDim.new(0, 20) })
		I[9] = new("ImageLabel", I[1], "ImageLabel", { BackgroundColor3 = Color3.fromRGB(238, 237, 244), BackgroundTransparency = 0.2, BorderSizePixel = 0, ImageContent = Content.fromUri("rbxassetid://122819013203645"), ScaleType = Enum.ScaleType.Fit, Size = UDim2.new(0.085, 0, 1, 100), ZIndex = 3000 })
			I[10] = new("UICorner", I[9], "UICorner", { BottomLeftRadius = UDim.new(1, 0), BottomRightRadius = UDim.new(1, 0), TopLeftRadius = UDim.new(1, 0), TopRightRadius = UDim.new(1, 0) })
			I[11] = new("UIAspectRatioConstraint", I[9], "UIAspectRatioConstraint")
	return I[1]
end

return build
